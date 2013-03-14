module AutoFailover
  def initialize(options = {})
    # Frequency is specified in seconds

    unless(options && options[:elastic_ip] && options[:active_instance_id] && options[:passive_instance_ids] && options[:url] && options[:access_key_id] && options[:access_secret])
      raise ArgumentError
    end
    @frequency  = options[:frequency] || 30
    @elastic_ip = options[:elastic_ip]
    @active     = options[:active_instance_id]
    # accepts an array
    @passive    = options[:passive_instance_ids]
    @url        = options[:url]
    # support http and https only now
    @protocol   = options[:protocol] || "http"
    @access_key_id = options[:access_key_id]
    @access_secret = options[:access_secret]
    @app_name      = options[:name]
    @threshold     = options[:threshold] || 2
    @num_failuers  = 0
  end

  def start_monitoring
    EM.run {
      EM::PeriodicTimer.new(@frequency) {
         begin
         if ping_url
           @num_failuers = 0
         else
           @num_failuers += 1
           if @num_failuers == @threshold
             reassign_eip
             @num_failuers = 0
           end
         end
         rescue Exception => xcp
           puts xcp.inspect
           puts xcp.backtrace
           EM.stop
         end
      }
    }
  end
end
