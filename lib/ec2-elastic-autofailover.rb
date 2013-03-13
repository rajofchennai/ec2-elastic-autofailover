require "ec2-elastic-autofailover/version"
require "AWS"
require 'daemons'

module Ec2
  module Elastic
    class Autofailover
      # Your code goes here...
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
      end

      def start_monitoring
        Daemons.daemonize(:app_name => @app_name)
        EM::PeriodicTime.new(@frequency) {
          reassign_eip unless ping_url
        }
      end

      private
      def reassign_eip
        disassociate_eip @active, @elastic_ip
        new_active = select_passive(@protocol)
        until associate_eip(new_active, @elastic_ip)
          new_active = select_passive(@protocol)
        end
        @active = new_active
      end

      def ping_url
        begin
          RestClient.get(url)
        rescue Exception
          nil
        end
      end

      def url
        "#{@protocol}://#{@url}"
      end

      def disassociate_eip(instance, eip)
        ec2.disassociate_address(:instance_id => instance, :public_ip => eip)
      end

      def associate_eip(instance, eip)
        ec2.associate_address(:instance_id => instance, :public_ip => eip)
      end

      def ec2
        @ec2 ||= AWS::EC2::Base.new(:access_key_id => @access_key_id, :secret_access_key => @access_secret)
      end

      def select_passive
        new_active = @passive_instance_ids.sample
        @passive_instance_ids.delete new_active
        @passive_instance_ids
      end
    end
  end
end
