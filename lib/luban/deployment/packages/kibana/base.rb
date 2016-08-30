module Luban
  module Deployment
    module Packages
      class Kibana < Luban::Deployment::Service::Base
        module Paths
          def control_file_name
            @control_file_name ||= "#{service_name}.yml"
          end
        end

        module Parameters
          extend Luban::Deployment::Parameters::Base

          DefaultPort = 5601
          parameter :port

          protected

          def set_default_kibana_parameters
            set_default :port, DefaultPort
          end
        end

        include Parameters

        protected

        def set_default_parameters
          super
          set_default_kibana_parameters
        end

        def include_default_templates_path
          default_templates_paths.unshift(base_templates_path(__FILE__))
        end

        def setup_install_tasks
          super
          commands[:install].option :dist, "Binary distribution"
        end
      end
    end
  end
end
