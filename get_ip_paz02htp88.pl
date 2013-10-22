#!/usr/bin/perl -w
use strict;

# mfeenstra 10/21/13
#

my $prefix = "paz02htp88";

for(my $i = 0; $i < 100; $i++) {

	my ($cmd, $hostname);

	if($i < 10) {
		$hostname = "$prefix" . "0" . "$i";
		$cmd = "ping -c 1 $hostname";
	}

	if($i >= 10 && $i < 100) {
		$hostname = "$prefix" . "$i";
		$cmd = "ping -c 1 $hostname";
	}

	my $out = `$cmd 2>&1`;

	if($out =~ /.*cannot.*/) {
		print "AVAIL ->\t$hostname\n";
	}
	else {
		print "taken ->\t\t$hostname\n";
	}
}

