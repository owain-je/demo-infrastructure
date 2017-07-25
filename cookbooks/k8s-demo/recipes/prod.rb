namespace = 'prod'

#helm_package "onzo-charts/cp-nginx-ingress" do 
#	values_files File.join(node[cookbook_name]['path'],namespace,"prod-ingress.yaml")
#	release_name "prod-ingress"
#	version "0.3.3"
#	kube_context node[cookbook_name]['context']
#	namespace namespace
#	action [:upgrade]
#end
