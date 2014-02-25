#!/usr/bin/perl -w
use strict;
use lib '/Users/mfeenstra/tmp/JSON-2.90/lib';
use JSON;

#curl -XGET 'http://paz02app8825:9200/_cluster/state
# my $json_text = `cat curl.out`;

#my $json_text = `curl -XGET 'http://paz02app8814:9200/_cluster/nodes/stats'`;

my $json_text = `curl -XGET 'http://paz02app8824:9200/_cluster/state' 2>/dev/null`;

my $json = JSON->new;
my $data = $json->decode($json_text);

#foreach( keys (%$data) ) {
#	print "$_\n";
#}

print "---\nroot =>\n";
#blocks => HASH(0x7fb20983c350)
#allocations => ARRAY(0x7fb2098dba20)
#master_node => gQNc0C8GQ2KM7WRfiZvYvQ
#cluster_name => rdcsrdev
#routing_table => HASH(0x7fb209843800)
#routing_nodes => HASH(0x7fb209831f28)
#nodes => HASH(0x7fb20983c368)
#metadata => HASH(0x7fb209833a90)
#while( my($key,$value) = each(%$data) ) {
#	print "$key => $value\n";
#}


my (@nodes, @nodecrypt, @isprimary);
@nodecrypt = keys(%{$data->{'nodes'}});

#print "\nkeys of nodes:\n";
#foreach(@nodecrypt) { print "$_\n"; }




print "---\nroot -> nodes \n";
#AXvkQcA8RxWjACtaIjSNhw => HASH(0x7f8ccb0343c8)
#pKTodWr8RnWuhj5Yq3m0HQ => HASH(0x7f8ccb033f78)
#while( my($key, $value) = each(%{$data->{'nodes'} } ) ) {
#	print "$key => $value\n";
#}

#print "---\nroot->nodes->NameRefs\n";

foreach(@nodecrypt) {
	push(@nodes, $data->{'nodes'}->{$_}->{'name'});
#	my $nameref = $_;
#	while( my($key, $value) = each(%{$data->{'nodes'}->{$nameref} } ) ) {
#		print "$key => $value\n";
#	}
}

my $count = @nodes;
print "found $count nodes\n";
foreach(@nodes) { print "found node name: $_\n"; }


#for(my $i = 0; $i < $count; $i++) {
#	print "node $nodes[$i] is $nodecrypt[$i]\n";

#

#print "---\nroot->nodes->nameref1\n";
#my $nameref = $nodecrypt[0];
#print "*** nameref = $nameref\n";
#while( my($key, $value) = each(%{$data->{'nodes'}->{$nameref} } ) ) {
#	print "$key => $value\n";
#}






#foreach(@nodecrypt) { 

#	$nodename = $data->{'nodes'}->{'$_'}->{'name'};
#	print "\tnodename $_: $nodename\n";
#	push(@nodes, $nodename); 

#}

#foreach(@nodes) { print "\t$_\n"; }

#print "---\nrouting_nodes -> nodes =>\n";

while( my($key,$value) = each(%{ $data->{'routing_nodes'}->{'nodes'} } ) ) {
	
	print "$key => $value\n";

	foreach(@$value) {
		my $hashref = $_;
		print "$hashref\n";


		while( my($key, $value) = each(%{$hashref})) {
			
			if(defined($key) && defined($value)) {
				print "\t$key => $value\n";
			}

			
			for(my $i = 0; $i < $count; $i++) {

				if (defined($value) && ($value eq $nodecrypt[$i]) ) {

					while( my($key, $value) = each(%{$hashref})) {
						if($key eq "primary") { 

							$isprimary[$i] = 1; 
							last;
						}
						
					}


				}
				last;
			}



			#if($key eq "primary") { print "\t\tisprimary?: $value\n"}

		}


	}

}

#	my @elements = @$value;

#	foreach(@elements) {

#		my $tmp_nodecrypt = $_;

#		my $primary = $data->{'routing_nodes'}->{'nodes'}->{$tmp_nodecrypt}->{'primary'};
#		print "\t$tmp_nodecrypt primary ? $primary\n";

#		for(my $i = 0; $i < $count; $i++) {
#			if($nodecrypt[$i] == $tmp_nodecrypt) {
#				$isprimary[$i] = 1;
#			}
#			else {
#				$isprimary[$i] = 0;
#			}
#		}


#	}

	
#	foreach(@elements) {
#		
#		print "\t1:\t$_\n";

#		my %hash = %$_;
#		my $hashref = \%hash;

#		print "\t\t\t\t$hashref->{'primary'}\n";
		
		

#	}
#}


for(my $i = 0; $i < $count; $i++) {
	print "my es host: $nodes[$i] has cryptic name $nodecrypt[$i] and isprimary? $isprimary[$i]\n";
}