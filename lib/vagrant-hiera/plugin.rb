begin
  require 'vagrant'
rescue LoadError
  abort 'vagrant-hiera must be loaded in a Vagrant environment.'
end

module VagrantPlugins
  module Hiera
    class Plugin < Vagrant.plugin('2')
      name 'hiera'

      description <<-DESC
A Vagrant plugin to load Puppet Hiera data
      DESC

      config 'hiera' do
        require_relative 'config'
        Config
      end

      action_hook 'hiera' do |hook|
        require_relative 'action/prepare'
        require_relative 'action/setup'
        hook.after VagrantPlugins::ProviderVirtualBox::Action::ShareFolders, Action::Prepare
        hook.append Action::Setup
      end
    end
  end
end

