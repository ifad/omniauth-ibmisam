require 'omniauth'

module OmniAuth
  module Strategies
    class Ibmisam
      include OmniAuth::Strategy

      option :header_type, 'identity'
      option :name, 'ibmisam'

      LOGOUT_PATH = '/pkmslogout'

      HEADER_NAMES = { identity: 'iv-user', eai: 'am-eai-user-id' }

      def request_phase
        if uid
          redirect callback_path
        else
          [401, {}, ["Unauthorized (Missing external authentication)"]]
        end
      end

      uid do
        HEADER_NAMES.keys.include?(header_type) ? request.env[rack_header] : nil
      end

      class ConfigurationError < StandardError; end

      def self.validate_options(options)
        if options.has_key?(:header_type) && !HEADER_NAMES.keys.include?(options[:header_type].to_sym)
          raise(ConfigurationError, "Invalid option: #{options[:header_type]} for IBMISAM header_type. Use one of: #{HEADER_NAMES.keys.join(', ')}")
        end
      end

      private
        def header_type
          options.header_type.to_sym
        end

        def rack_header
          header = HEADER_NAMES[header_type]
          @rack_header ||= "HTTP_#{header.gsub('-','_')}".upcase
        end

    end
  end
end
