.PHONY: test spec
test: spec
spec: lib/missinglisp.rb spec.rb
	ruby spec.rb

