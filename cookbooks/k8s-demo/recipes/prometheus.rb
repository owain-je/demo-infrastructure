namespace = "infra"

#helm_package "je-charts/prometheus-operator" do 
#	values_files File.join(node[cookbook_name]['path'],namespace,"infra-promop.yaml")
#	release_name "infra-promop"
#	version "0.0.1"
#	kube_context node[cookbook_name]['context']
#	namespace namespace
#	action [:upgrade]
#end

# might need to run this manually it is not very consistent
#
# helm upgrade prometheus-op ./kube-prometheus --install --namespace=infra -f k8s-infrastructure/cookbooks/k8s-venus/files/default/values/infra/prometheus-op.yaml --debug

helm_package "je-charts/kube-prometheus" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"prometheus-op.yaml")
	release_name "prometheus-op"
	version "0.2.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end
 
helm_package "je-charts/prometheus-servicemonitor" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"prometheus-servicemonitor.yaml")
	release_name "prometheus-sm"
	version "0.1.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end 