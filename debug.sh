#!/bin/bash
docker run -ti -v $(pwd):/chef:Z -v $HOME/.kube:/root/.kube:Z -v $HOME/.helm:/root/.helm:Z 505016431031.dkr.ecr.eu-west-1.amazonaws.com/onzocom/gocd-agent-python27:16.12.11  bash
