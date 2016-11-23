module Luban
  module Deployment
    module Packages
      class Kibana
        class Installer < Luban::Deployment::Service::Installer
          include Paths

          define_executable 'kibana'

          def package_dist; task.opts.dist; end
          def package_full_name; "#{super}-#{package_dist}"; end

          def source_repo
            @source_repo ||= 'https://download.elastic.co'
          end

          def source_url_root
            @source_url_root ||= "kibana/kibana"
          end

          def installed?
            file?(kibana_executable)
          end

          protected

          def build_package
            info "Building #{package_full_name}"
            within install_path do
              execute(:mv, build_path.join('*'), '.', ">> #{install_log_file_path} 2>&1")
            end
          end
        end
      end
    end
  end
end

