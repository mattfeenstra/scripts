#!/usr/bin/ruby 

require "rubygems"
require "json"
require "socket"


# This script is to be ran on an Elastic Search server and returns 1 or 0 depending on
# if the system is the current primary for a cluster.
# Matt Feenstra 11/25/13

#@file = open("curl.out")
#@json = @file.read

# @json = `curl -XGET http://#{myhostname}:9200/_cluster/state`;
# myhostname = "paz02app8825"


# get my local hostname
myhostname = Socket.gethostbyname(Socket.gethostname).first
# get JSON output from ES server
@json = `curl -XGET http://#{myhostname}:9200/_cluster/state 2>/dev/null`;
# parse it into ruby hashes
@parsed = JSON.parse(@json)
retcode = 0


# return the nodes hash element
def get_hostnames
	nodeshost = @parsed["nodes"]
	return nodeshost
end

# return the routing_nodes->nodes hash element
def get_isprimary
	nodesprimary = @parsed["routing_nodes"]["nodes"]
	return nodesprimary
end

# construct new hash (hosts) to link the data elements from the 
# previous 2 hashes together
#
# new hash looks like
#                    array
# encrypted name -> |-- hostname (string)
#                -> |-- isPrimaryNode? (0/1) (boolean)

hosts = Hash.new


# somenewvar is the "nodes" hash element from the original JSON
somenewvar = get_hostnames
# search through and grab the hostname
somenewvar.each do |key,value|
	hosts[key] = Array.new
	hosts[key][0] = somenewvar[key]["name"]
end

# othernewvar is the "routing_nodes->nodes" hash element from original JSOn
othernewvar = get_isprimary
# search through and get the is "primary" value (yes/no)
othernewvar.each do |key,value|
	othernewvar[key].each do |key2, value2|
		if key2["primary"] 
			hosts[key][1] = 1
			next
		else
			hosts[key][1] = 0
			next
		end
	end
end

# Print out new hash created
# puts "---final arry---\n"
# hosts.each do |key,value|
#	puts "----#{key}\n"
#	puts "\t#{value}\n"
# end


# Check if my host is listed as primary in the new hash
hosts.each do |key,value|
		# is primary?
	if hosts[key][0] =~ /^#{myhostname}/ && hosts[key][1].to_int
		print "I am Primary. (#{hosts[key][0]})\n"
		retcode = 1
		next

	elseif hosts[key][1].to_int
		print "#{hosts[key][0]} is Primary."

	else
		print "#{hosts[key][0]} not Primary.\n"
		#print "***" + hosts[key][0] + " does not match #{myhostname}\n"
		
	end
end

# 1 == I'm primary, 0 == seondary
print "#{retcode}\n"
retcode
