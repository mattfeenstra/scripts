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

	print "for host: $_\n";




	#my $cmd = "curl -XGET 'http://$_:9200/_cluster/nodes/stats?pretty=true'";
	#my @status_out = `$cmd`;

	my @status_out = `cat curl.out`;

	foreach(@status_out) {

		if($_ =~ /(.*)/) {

			print "$1\n";
		}
		#print "$_";
	}

}


# my @status_out = `curl -XGET 'http://paz02app8814:9200/_cluster/nodes/stats?pretty=true'`;
