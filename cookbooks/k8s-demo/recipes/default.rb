remote_directory node[cookbook_name]['path'] do
  source 'values'
  action :create
end

helm_repo "je-charts" do 
	url "https://owain-je.github.io/charts/"
	kube_context node['k8s-demo']['context']
	action [:add]
end

helm_repo "stable" do 
	url "https://kubernetes-charts.storage.googleapis.com"
	kube_context node['k8s-demo']['context']
	action [:add]
end


include_recipe "#{cookbook_name}::dev"
include_recipe "#{cookbook_name}::kube-system"
include_recipe "#{cookbook_name}::infra"
include_recipe "#{cookbook_name}::prometheus"
include_recipe "#{cookbook_name}::prod"
#include_recipe "#{cookbook_name}::test"
#include_recipe "#{cookbook_name}::uat"


directory node[cookbook_name]['path'] do
  recursive  true
  action :delete
end

#Resource provider examples




