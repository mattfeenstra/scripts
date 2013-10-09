#!/usr/bin/perl -w
use strict;

my $cmd = "wget http://qaz02htp1802/php_info.php -O /dev/null";

while(1) {
	sleep 1;
	system($cmd);
}
