#!/usr/bin/ruby -w

require "rubygems"
require "json"
require "socket"

#curl -XGET 'http://paz02app8824:9200/_cluster/state
@file = open("curl.out")
@json = @file.read
@parsed = JSON.parse(@json)


def get_hostnames
	nodeshost = @parsed["nodes"]
	return nodeshost
end

def get_isprimary
	nodesprimary = @parsed["routing_nodes"]["nodes"]
	return nodesprimary
end

# new hash looks like
#                    array
# encrypted name -> |-- hostname (string)
#                -> |-- isPrimaryNode? (0/1) (boolean)

hosts = Hash.new

somenewvar = get_hostnames
somenewvar.each do |key,value|
	hosts[key] = Array.new
	hosts[key][0] = somenewvar[key]["name"]
end


othernewvar = get_isprimary
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

#puts "---final arry---\n"
hosts.each do |key,value|
	puts "----#{key}\n"
	puts "\t#{value}\n"
end

myhostname = Socket.gethostbyname(Socket.gethostname).first
puts myhostname + "\n"

hosts.each do |key,value|
	if hosts[key][0] =~ /^#{myhostname}/
		print "**" + hosts[key][0] + " matches #{myhostname} !!\n"
		print "**\tisprimary? " + hosts[key][1] + "\n"
	else
		print "***" + hosts[key][0] + " does not match #{myhostname}\n"
	end
end
