#!/usr/bin/perl -w 
use strict;
use JSON;




my @hosts = ( "paz02app8814",
			  "paz02app8815",
			  "paz02app8816",
			  "paz02app8824",
			  "paz02app8825",
			  "paz02app8826" );


foreach(@hosts) {

	print "for host: $_\n";




	my $cmd = "curl -XGET 'http://$_:9200/_cluster/nodes/stats?pretty=true'";
	my @status_out = `$cmd`;

	foreach(@status_out) {
		print "$_";
	}

}


# my @status_out = `curl -XGET 'http://paz02app8814:9200/_cluster/nodes/stats?pretty=true'`;
