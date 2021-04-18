%: docker/%
	docker build . --file $</Dockerfile --tag $(shell basename $(shell pwd))-$*

python: base

cpp: python

intel-hpc: cpp

nvidia-hpc: cpp
