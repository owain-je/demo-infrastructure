#require 'chef/resource'
require_relative 'helm'

class Chef
  class Resource
    class  HelmPackage < Chef::Resource
              
      def initialize(name, run_context=nil)
        super
        @resource_name = :helm_package         
        @provider = Chef::Provider::HelmPackage
        @action = :upgrade                      
        @allowed_actions = [:install, :delete, :upgrade]
        @namespace = 'default'
        @dryrun = false
        @debug = false
        @wait = true
        @timeout = 300
        @name = name 
      end

      def dryrun(arg=nil)
        set_or_return(:dryrun, arg, :kind_of => [TrueClass, FalseClass], :required => false)
      end

      def debug(arg=nil)
        set_or_return(:debug, arg, :kind_of => [TrueClass, FalseClass], :required => false)
      end

      def wait(arg=nil)
        set_or_return(:wait, arg, :kind_of => [TrueClass, FalseClass], :required => false)
      end

      def purge(arg=nil)
        set_or_return(:purge, arg, :kind_of => [TrueClass, FalseClass], :required => false)
      end

      def values_files(arg=nil)
        set_or_return(:values_files, arg, :kind_of => String, :required => false)
      end

      def set(arg=nil)
        set_or_return(:set, arg, :kind_of => String, :required => false)
      end
	       
      def timeout(arg=nil)
        set_or_return(:timeout, arg, :kind_of => Integer, :required => false)
      end

      def release_name(arg=nil)
        set_or_return(:release_name, arg, :kind_of => String, :required => false)
      end

      def kube_context(arg=nil)
        set_or_return(:kube_context, arg, :kind_of => String, :required => false)
      end

      def name(arg=nil)
        set_or_return(:name, arg, :kind_of => String, :required => true)
      end

      def namespace(arg=nil)
        set_or_return(:namespace, arg, :kind_of => String, :required => false)
      end

      def version(arg=nil)
        set_or_return(:version, arg, :kind_of => String, :required => false)
      end

      def recreate_pods(arg=nil)
        set_or_return(:recreate_pods, arg, :kind_of => [TrueClass, FalseClass], :required => false)
      end

      def reset_values(arg=nil)
        set_or_return(:reset_values, arg, :kind_of => [TrueClass, FalseClass], :required => false)
      end

    end
  end
end

class Chef
  class Provider
    class HelmPackage < Chef::Provider

      	def load_current_resource
        	@current_resource ||= Chef::Resource::HelmPackage.new(new_resource.name)
        	@current_resource.dryrun(new_resource.dryrun)
        	@current_resource.debug(new_resource.debug)
        	@current_resource.wait(new_resource.wait)
          @current_resource.values_files(new_resource.values_files)
          @current_resource.set(new_resource.set)
          @current_resource.timeout(new_resource.timeout)
          @current_resource.release_name(new_resource.release_name)
          @current_resource.name(new_resource.name)
          @current_resource.kube_context(new_resource.kube_context) 
          @current_resource.namespace(new_resource.namespace) 
          @current_resource.version(new_resource.version) 
          @current_resource.purge(new_resource.purge) 
          @current_resource.reset_values(new_resource.reset_values) 
          @current_resource.recreate_pods(new_resource.recreate_pods)     

        end

      	def action_install
          begin            
            Chef::Log.info "Helm package install #{@current_resource.name}" 
            options = {
              :dryrun => @current_resource.dryrun,
              :debug => @current_resource.debug,
              :wait => @current_resource.wait,
              :values_files => @current_resource.values_files,
              :set => @current_resource.set,
              :timeout => @current_resource.timeout,
              :release_name => @current_resource.release_name,
              :name => @current_resource.name,
              :version => @current_resource.version,
              :namespace => @current_resource.namespace,
              :kube_context => @current_resource.kube_context,
            }
            helm = Helm.new(options)
            helm.install()
          rescue Exception => e
             Chef::Log.error("#{@current_resource.name} #{e.class} #{e.message}")
            raise
          end        
      	end

        def action_upgrade
          begin
            Chef::Log.info "Helm package upgrade #{@current_resource.name}"
            options = {
              :dryrun => @current_resource.dryrun,
              :debug => @current_resource.debug,
              :wait => @current_resource.wait,
              :values_files => @current_resource.values_files,
              :set => @current_resource.set,
              :timeout => @current_resource.timeout,
              :release_name => @current_resource.release_name,
              :name => @current_resource.name,
              :version => @current_resource.version,
              :namespace => @current_resource.namespace,
              :kube_context => @current_resource.kube_context,
              :reset_values => @current_resource.reset_values,
              :recreate_pods => @current_resource.recreate_pods
            }
            helm = Helm.new(options)
            helm.upgrade()
            sleep_time = rand(1..9)
            Chef::Log.info "Sleeping for #{sleep_time}s to take it easy on the API"
            sleep(sleep_time)
          rescue Exception => e
             Chef::Log.error("#{@current_resource.name} #{e.class} #{e.message}")
            raise
          end
        end

        def action_delete         
          begin
            Chef::Log.info "Helm package delete #{@current_resource.name}" 
            options = {
              :dryrun => @current_resource.dryrun,
              :debug => @current_resource.debug,
              :purge => @current_resource.purge,
              :timeout => @current_resource.timeout,
              :release_name => @current_resource.release_name,
              :name => @current_resource.name,              
              :kube_context => @current_resource.kube_context,
            }
            helm = Helm.new(options)
            helm.delete()
          rescue Exception => e
             Chef::Log.error("#{@current_resource.name} #{e.class} #{e.message}")
            raise
          end
        end
    end
  end
end