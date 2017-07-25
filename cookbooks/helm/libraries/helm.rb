require 'open3'

class Helm 

	def initialize(options)		
		@options = options	
	end

	def init()
		helm_initialise()
		@installed_packages = get_list_of_all_packages
		@release_name_installed = is_release_name_installed?
		if(@release_name_installed == true)
			@release_details = @installed_packages[@options[:release_name]]
		end	
		@same_version_installed = is_same_version_installed?		
	end

	def is_same_version_installed?
		if(@release_name_installed == true)
			return @release_details[:chart_version] == @options[:version]
		end
		return false
	end

	def back_ticks(cmd)
		Chef::Log.info("running #{cmd}")
		return `#{cmd}`
	end

	def get_list_of_all_packages
		result = {}
		pkgs = back_ticks("helm list #{cli_kube_context} --all").split("\n")
		pkgs.each do |line| 
			parts = line.split("\t")			
			result[parts[0].rstrip] = {
				:revision => parts[1].rstrip,
				:updated => parts[2],
				:status => parts[3].rstrip,
				:chart_name => parts[4].rstrip.rpartition('-').first,
				:chart_version => parts[4].rstrip.rpartition('-').last,
				:namespace => parts[5].rstrip,
				}
		end
		#puts("===")
		#result.each do |i|
		#	puts(i)
		#end
		return result
	end

	def is_release_name_installed?
		return @installed_packages.key?(@options[:release_name])
	end

	def cli_debug
		if(@options[:debug])
			return "--debug"
		end
		return ""
	end

	def cli_dryrun
		if(@options[:dryrun])
			return "--dry-run"
		end
		return ""
	end

	def cli_wait
		if(@options[:wait])
			return "--wait"
		end
		return ""
	end

	def cli_purge
		if(@options[:purge])
			return "--purge"
		end
		return ""
	end

	def cli_recreate_pods
		if(@options[:recreate_pods])
			return "--recreate-pods"
		end
		return ""
	end

	def cli_reset_values
		if(@options[:reset_values])
			return "--reset-values"
		end
		return ""
	end

	def cli_values_files
		if(@options[:values_files].to_s != '')
			return "-f #{@options[:values_files]}"
		end
		return ""
	end

	def cli_set
		if(@options[:set].to_s != '')
			return "--set #{@options[:set]}"
		end
		return ""
	end

	def cli_timeout
		if(@options[:timeout].to_s != '')
			return "--timeout #{@options[:timeout]}"
		end
		return ""
	end

	def cli_release_name
		if(@options[:release_name].to_s != '')
			return "--name #{@options[:release_name]}"
		end
		return ""		
	end

	def cli_release_name_only
		if(@options[:release_name].to_s != '')
			return "#{@options[:release_name]}"
		end
		return ""		
	end

	def cli_chart_name
		if(@options[:name].to_s != '')
			return "#{@options[:name]}"
		end
		return ""		
	end

	def cli_namespace
		if(@options[:namespace].to_s != '')
			return "--namespace #{@options[:namespace]}"
		end
		return ""		
	end

	def cli_version
		if(@options[:version].to_s != '')
			return "--version #{@options[:version]}"
		end
		return ""		
	end	

	def cli_kube_context
		if(@options[:kube_context].to_s != '')
			return "--kube-context #{@options[:kube_context]}"
		end
		return ""		
	end	

	def execute_cmd(cmd)
		
		Chef::Log.info("")
		Chef::Log.info(cmd)
		Chef::Log.info("")

		output, err, s = Open3.capture3(cmd,:chdir=>ENV['PWD'])
		Chef::Log.info(output)
		if s.success? == false
			Chef::Log.error("Helm error message:")
			Chef::Log.error("")
			Chef::Log.error(err)
			Chef::Log.error("")
			Chef::Log.error("")
  			raise ("#{err}")
		end
	end

	def install_package
		cmd_line = "helm install #{cli_chart_name} #{cli_release_name} #{cli_kube_context} #{cli_version} #{cli_namespace}  #{cli_timeout} #{cli_set} #{cli_values_files} #{cli_wait} #{cli_dryrun} #{cli_debug}"
		execute_cmd(cmd_line)
	end

	def delete_package
		cmd_line = "helm delete #{cli_release_name_only} #{cli_kube_context} #{cli_timeout} #{cli_purge} #{cli_wait} #{cli_dryrun} #{cli_debug}"
		execute_cmd(cmd_line)
	end

	def upgrade_package
		Chef::Log.info("Running upgrade")
		install = ''
		if(@release_name_installed == false)
			install = "--install"
		end
		cmd_line = "helm upgrade #{install} #{cli_kube_context} #{cli_version} #{cli_namespace} #{cli_timeout} #{cli_set} #{cli_values_files} #{cli_wait} #{cli_reset_values} #{cli_recreate_pods} #{cli_dryrun} #{cli_release_name_only} \"#{cli_chart_name}\" "
		execute_cmd(cmd_line)
	end

	def install()
		Chef::Log.debug(@options)
		init()
		Chef::Log.info("release_name #{@options[:release_name]} installed : #{@release_name_installed}")
		Chef::Log.info("release_version #{@options[:version]} same version : #{@same_version_installed}")
		if(@release_name_installed)
			Chef::Log.info("release is already installed will not change anything , use upgrade to modify")
		else
			install_package()
		end
	end

	def delete()
		Chef::Log.debug(@options)
		init()
		Chef::Log.info("release_name #{@options[:release_name]} installed : #{@release_name_installed}")		
		if(@release_name_installed)
			Chef::Log.info("release is installed deleting")
			delete_package()
		else
			Chef::Log.info("")
		end
	end

	def upgrade()
		Chef::Log.debug(@options)
		init()
		Chef::Log.info("release_name #{@options[:release_name]} installed : #{@release_name_installed}")		
		upgrade_package()
	end

	def helm_initialise()
		execute_cmd("helm init --client-only")
		execute_cmd("helm repo update")
	end


end
