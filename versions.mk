# Copyright (c) 2022, NVIDIA CORPORATION.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DRIVER_NAME := k8s-device-plugin
MODULE := github.com/NVIDIA/$(DRIVER_NAME)

REGISTRY ?= ghcr.io/enes-yildirim08
VERSION ?= v0.17.3-custom

# vVERSION represents the version with a guaranteed v-prefix
vVERSION := v$(VERSION:v%=%)

GOLANG_VERSION := $(shell ./hack/golang-version.sh)

BUILDIMAGE_TAG ?= devel-go$(GOLANG_VERSION)
BUILDIMAGE ?=  $(DRIVER_NAME):$(BUILDIMAGE_TAG)

GIT_COMMIT ?= $(shell git describe --match="" --dirty --long --always --abbrev=40 2> /dev/null || echo "")
