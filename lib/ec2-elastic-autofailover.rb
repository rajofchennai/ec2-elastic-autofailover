require "ec2-elastic-autofailover/version"
require "AWS"
require 'daemons'
require 'eventmachine'
require 'rest-client'
require "ec2-elastic-autofailover/monitor"
require "ec2-elastic-autofailover/master_selection"
require "ec2-elastic-autofailover/ping"
require "ec2-elastic-autofailover/ec2_eip"

class Monitor
  include AutoFailover
  def monitor_instance
    unless fork
      Daemons.daemonize(:app_name => @app_name, :backtrace =>  true, :log_output => true)
      start_monitoring
    end
  end
end


