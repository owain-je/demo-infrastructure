
namespace = 'build'

helm_package "onzo-charts/sonarqube" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"build-sonar.yaml")
	release_name "build-sonar"
	version "0.1.2"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end

helm_package "onzo-charts/postgresql-nfs" do 
	values_files File.join(node[cookbook_name]['path'],namespace,"build-pg.yaml")
	release_name "build-pg"
	version "0.4.0"
	kube_context node[cookbook_name]['context']
	namespace namespace
	action [:upgrade]
end
  