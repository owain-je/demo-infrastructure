namespace = 'infra'

helm_package "je-charts/cp-nginx-ingress" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"#{namespace}-ingress.yaml")
	release_name "#{namespace}-nginx-ingress"
	version "0.3.4"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end


helm_package "je-charts/je-ingress" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"#{namespace}-ingress-rules.yaml")
	release_name "#{namespace}-ingress-rules"
	version "0.1.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "stable/grafana" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"#{namespace}-grafana.yaml")
	release_name "#{namespace}-grafana"
	version "0.3.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "je-charts/elasticsearch" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"#{namespace}-es.yaml")
	release_name "#{namespace}-es1"
	version "0.1.5"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "je-charts/kibana" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"#{namespace}-kibana.yaml")
	release_name "#{namespace}-kibana"
	version "0.1.3"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "stable/kube-ops-view" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"#{namespace}-kube-ops-view.yaml")
	release_name "#{namespace}-kube-ops-view"
	version "0.3.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "je-charts/logstash-internal" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"#{namespace}-ls.yaml")
	release_name "#{namespace}-ls"
	version "0.1.1"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end 