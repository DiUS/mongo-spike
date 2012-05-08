require 'mongo/repl_set_connection'
include Mongo

MongoMapper.connection = ReplSetConnection.new(
                                       ['192.168.0.212:27017'],
                                       ['192.168.0.212:27018'],
                                       ['192.168.0.212:27019'],
                                       ['192.168.0.60:270178'],
                                       ['192.168.0.60:270178'],
                                       ['192.168.0.60:270179'],
                                       :rs_name => 'spike',
                                        :refresh_mode => :sync)
MongoMapper.database = "#myapp-#{Rails.env}"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end