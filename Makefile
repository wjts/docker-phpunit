.PHONY: build test-date custom-entrypoint

TAG=latest
build:
	docker image build -t stjw/phpunit:$(TAG) .

run:
	docker container run --rm stjw/phpunit:$(TAG)

custom-entrypoint:
	docker container run -it --rm --entrypoint=/bin/sh stjw/phpunit:$(TAG)

