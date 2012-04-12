#!/usr/bin/ruby -w

require 'dbi'

begin
  #connect
  dbh = DBI.connect("DBI:Mysql:TESTDB:localhost", "testuser", "test123")
  
  #display server version
  row = dbh.select_one("SELECT VERSION()")
  puts "Server Version: " + row[0]
rescue DBI::DatabaseError => e
  puts "An error occurred"
  puts "Error code: #{e.err}"
  puts "Error message: #{errstr}"
ensure
  #disconnect
  dbh.disconnect if dbh
end
