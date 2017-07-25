require 'open3'
require 'chef/resource'
require_relative 'helm'

class Chef
  class Resource
    class  HelmRepo < Chef::Resource
              
      def initialize(name, run_context=nil)
        super
        @resource_name = :helm_repo         
        @provider = Chef::Provider::HelmRepo
        @action = :add                      
        @allowed_actions = [:add]
        @name = name 
      end

      def url(arg=nil)
        set_or_return(:url, arg, :kind_of => String, :required => true)
      end

      def kube_context(arg=nil)
        set_or_return(:kube_context, arg, :kind_of => String, :required => false)
      end

      def name(arg=nil)
        set_or_return(:name, arg, :kind_of => String, :required => true)
      end

    end
  end
end

class Chef
  class Provider
    class HelmRepo < Chef::Provider

      	def load_current_resource
          @current_resource ||= Chef::Resource::HelmRepo.new(new_resource.name)
          @current_resource.url(new_resource.url)
          @current_resource.name(new_resource.name)
          @current_resource.kube_context(new_resource.kube_context) 
      	end

      	def execute_cmd(cmd)
			output, err, s = Open3.capture3(cmd)
			Chef::Log.info(output)
			Chef::Log.info(err)
			if s.success? == false
  				raise ("Failed to execute #{cmd}")
			end
		end

      	def action_add
          begin            
            Chef::Log.info "Helm repo add #{@current_resource.name}" 
            execute_cmd("helm init --client-only")
            execute_cmd("helm repo add #{@current_resource.name} #{@current_resource.url} ")
            execute_cmd("helm repo update")
          rescue Exception => e
             Chef::Log.error("#{@current_resource.name} #{e.class} #{e.message}")
            raise
          end        
      	end
    end
  end
end
