helm_package "onzo-charts/cp-nginx-ingress" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"infra-ingress.yaml")
	release_name "infra-ingress"
	version "0.3.3"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end



helm_package "onzo-charts/logstash-internal" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"infra-ls.yaml")
	release_name "infra-ls"
	version "0.1.1"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end 

# upgrade the helm package to 1.6
helm_package "onzo-charts/elasticsearch" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"infra-asl-es.yaml")
	release_name "infra-asl-es"
	version "0.1.5"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "onzo-charts/kibana" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"infra-asl-kibana.yaml")
	release_name "infra-asl-kibana"
	version "0.1.3"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "onzo-charts/atlas-sensor-logstash" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"infra-asl.yaml")
	release_name "infra-asl"
	version "0.0.1"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end


helm_package "onzo-charts/kibana" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"infra-kibana.yaml")
	release_name "infra-kibana"
	version "0.1.2"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "onzo-charts/kube-ops-view" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"kube-ops-view.yaml")
	release_name "kube-ops-view"
	version "0.1.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "onzo-charts/mobz-elasticsearch-head" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"infra-es-head.yaml")
	release_name "infra-es-head"
	version "0.1.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "stable/grafana" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"infra-grafana.yaml")
	release_name "infra-grafana"
	version "0.3.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "onzo-charts/elasticsearch" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"infra-es.yaml")
	release_name "infra-es1"
	version "0.1.5"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end


## 1.6
#helm_package "onzo-charts/prometheus-operator" do 
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

# helm_package "onzo-charts/kube-prometheus" do 
#	values_files File.join(node[cookbook_name]['path'],namespace,"prometheus-op.yaml")
#	release_name "prometheus-op"
#	version "0.2.0"
#	kube_context node[cookbook_name]['context']
#	namespace namespace
#	action [:upgrade]
# end
 
helm_package "onzo-charts/prometheus-servicemonitor" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"prometheus-servicemonitor.yaml")
	release_name "prometheus-sm"
	version "0.1.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end 