namespace = 'prod'

helm_package "je-charts/cp-nginx-ingress" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"#{namespace}-nginx-ingress.yaml")
	release_name "#{namespace}-nginx-ingress"
	version "0.3.4"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "je-charts/mysql" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"#{namespace}-mysql.yaml")
	release_name "#{namespace}-mysql"
	version "0.2.6"
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

