module Luban
  module Deployment
    module Packages
      class Kibana < Luban::Deployment::Service::Base
        module Paths
          def control_file_name
            @control_file_name ||= "#{service_name}.yml"
          end
        end

        DefaultPort = 5601
        DefaultNetworkHost = '0.0.0.0'
        
        parameter :port, default: DefaultPort
        parameter :network_host, default: DefaultNetworkHost

        protected

        def include_default_templates_path
          default_templates_paths.unshift(base_templates_path(__FILE__))
        end

        def setup_provision_tasks
          super
          provision_tasks[:install].option :dist, "Binary distribution"
        end
      end
    end
  end
end
