module Luban
  module Deployment
    module Packages
      class Kibana
        class Controller < Luban::Deployment::Service::Controller
          module Commands
            def self.included(base)
              base.define_executable 'kibana'
            end

            def compose_command(cmd)
              "#{shell_setup_commands.join('; ')}; #{cmd}"
            end

            def process_pattern
              @process_pattern ||= "#{control_file_path}$"
            end

            def start_command
              @start_command ||= "#{kibana_executable} -c #{control_file_path} >/dev/null 2>&1 &"
            end

            def stop_command
              @stop_command ||= "kill $(cat #{pid_file_path} 2>/dev/null) 2>&1"
            end
          end

          include Paths
          include Parameters
          include Commands
        end
      end
    end
  end
end
