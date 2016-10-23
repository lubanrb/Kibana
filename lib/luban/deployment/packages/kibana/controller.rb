module Luban
  module Deployment
    module Packages
      class Kibana
        class Controller < Luban::Deployment::Service::Controller
          module Commands
            def self.included(base)
              base.define_executable 'kibana'
            end

            def process_pattern
              @process_pattern ||= "#{control_file_path}$"
            end

            def start_command
              @start_command ||= shell_command("#{kibana_executable} -c #{control_file_path}", output: nil) + ' &'
            end

            def stop_command
              @stop_command ||= shell_command("kill $(cat #{pid_file_path} 2>/dev/null)")
            end
          end

          include Paths
          include Commands
        end
      end
    end
  end
end
