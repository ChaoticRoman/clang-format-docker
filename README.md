# Clang-format Docker Image

Alpine image containing clang-format binary, git and clang-format-diff Python 3 script.

## Building the image

To build the container image locally, you have to specify which version of alpine
base image and which version of clang to use, e.g. for latest alpine and clang 19:

```
make build
```

## Run the image locally

```
make run
```

## Pushing the image to Docker hub

```
make push
```
