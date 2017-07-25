namespace = 'kube-system'

helm_package "je-charts/filebeat" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"filebeat.yaml")
	release_name "filebeat"
	version "0.1.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "stable/aws-cluster-autoscaler" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"aws-autoscaler.yaml")
	release_name "aws-autoscaler"
	version "0.2.2"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "stable/heapster" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"heapster.yaml")
	release_name "heapster"
	version "0.1.1"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end


# heapster 
# grafana 
# elastic search 
# autoscaling 
# filebeat 
