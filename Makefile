build:
	docker build -t chaoticroman/clang-format --build-arg=ALPINE_TAG=latest --build-arg=VERSION=19 .

run: build
	docker run -it chaoticroman/clang-format sh

push: build
	docker push chaoticroman/clang-format:latest
