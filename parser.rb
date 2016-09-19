require 'nmap/xml'
require 'sqlite3'
require 'time'
require_relative "data_base"
require_relative "functions.rb"
include Parser_nmap_function

Nmap::XML.new(ARGV.last.to_s) do |x|

    #insert data to SCAN table
    insert_into_scan_table x

  x.each_host do |x|

    #insert data into hosts table
    insert_into_hosts_table x


    #insert data into ports table
    insert_into_ports_table x

    #insert data into OS table
    insert_into_os_table x

  end
    #there is nothing to put in here yet
    $db.execute "insert into SERVICEVERSION values(?,?,?,?,?)"
end
