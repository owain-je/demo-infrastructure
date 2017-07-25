
#should be able to derive this. 
cookbook_name = 'k8s-demo'

if ENV['GO_PIPELINE_LABEL'].nil?
	default[cookbook_name]['context'] = "1a.k8sdemo.iplops.je-labs.com"
else
	default[cookbook_name]['context'] = "1a.k8sdemo.iplops.je-labs.com"
end

default[cookbook_name]['path'] = File.join('/tmp',cookbook_name,'values')
