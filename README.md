
#Layout 

the chef recipes can be found under the cookbooks folder 
the helm folder is the chef resource provider for helm 

the k8s clusters will be in the other cookbooks look in the recipes folder for all the resource configuration e.g. 

cookbooks\k8s-venus

There is a recipe for each namespace e.g. 

cookbooks\k8s-venus\receipes\dev.rb

The values files are found under the files\default\values folder 
each namespace has a folder, and the values yamls are stored under here. 

The convention is to have the release name of the chart and values file to be the same , this should keep it simple to see the relationships e.g. 

files\default\values\dev\ingress.yaml

#debuging 

There is a debug.sh which will launch a chef client docker , just run it 
which will drop you into a bash prompt and then cd to /chef 

to do a chef run , just execute 

```bash
./run-chef-zero.sh 
```


#helm_repo resource provider 

add a helm repository 
(other methods not implemented)

```ruby 
helm_repo "onzo-charts" do 
    url "https://onzo-com.github.io/onzo-charts/"
    action [:add]
end

```

#helm_package resource provider 

There are 3 actions on the helm package resource provider 
install, upgrade and delete 

Use upgrade most of the time as it will install if the package is not installed. 

```ruby
helm_package "stable/redis" do 
    dryrun true
    debug true
    wait true 
    values_files "somefile.yaml"
    set "x=y"
    timeout 100
    release_name "vigilant-lynx-nf"
    version "0.4.6"
    kube_context "dave"
    namespace "dev"
    action [:install]
end
```

```ruby
helm_package "stable/redis" do 
    dryrun true
    debug true
    wait true       
    purge true
    timeout 100
    release_name "vigilant-lynx-nf"
    action [:delete]
end
```

```ruby
helm_package "stable/redis" do 
    dryrun true
    debug true
    wait true 
    values_files "somefile.yaml"
    set "x=y"
    timeout 100
    release_name "vigilant-lynx-nf"
    version "0.4.6"
    kube_context "dave"
    reset_values true
    recreate_pods true
    namespace "dev"
    action [:upgrade]
end
```
