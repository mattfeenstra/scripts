#!/usr/bin/perl -w 
use strict;
use lib '/Users/mfeenstra/tmp/JSON-2.90/lib';
use JSON;



my @hosts = ( "paz02app8814",
			  "paz02app8815",
			  "paz02app8816",
			  "paz02app8824",
			  "paz02app8825",
			  "paz02app8826" );


foreach(@hosts) {


	my $json_text = `curl -XGET 'http://$_:9200/_cluster/nodes/stats'`;
	my $json = JSON->new;
	my $data = $json->decode($json_text);
	my $nodes = $data->{ 'nodes' };

	my @nodehash_refs;
	while( my($key,$value) = each(%$nodes) ) {
   	    print "$key => $value\n";
		push(@nodehash_refs, $value);
	}

	foreach(@nodehash_refs) {
		my $ref = $_;
		while( my($key, $value) = each(%$ref) ) {
			print "For " . $ref->{'name'} . ":\n";
			my $attributes_ref = $ref->{'attributes'};
			while( my($key, $value) = each(%$attributes_ref) ) {
				print "\t$key => $value\n";
			}
		}
	}

}