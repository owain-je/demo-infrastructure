#!/bin/bash
chef-client -z -o "recipe[k8s-demo::default]"
