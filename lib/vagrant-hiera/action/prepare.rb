module VagrantPlugins
  module Hiera
    module Action
      class Prepare
        def initialize(app, env)
          @app = app
          @env = env
        end

        def call(env)
          @env = env
          if @env[:global_config].hiera.set?
            create_shared_folders
          end
          @app.call(env)
        end

        def create_shared_folders
          @env[:ui].info I18n.t('vagrant.plugins.hiera.middleware.prepare.shared_folders')
          folders = [{:name => 'vagrant-hiera-config', :hostpath => @env[:global_config].hiera.config_path},
                     {:name => 'vagrant-hiera-data', :hostpath => @env[:global_config].hiera.data_path}]
          @env[:vm].driver.share_folders(folders)
        end

      end
    end
  end
end
