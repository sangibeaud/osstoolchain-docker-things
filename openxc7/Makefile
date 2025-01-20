IMAGE_TAG=tests-openxc7:git
BASE=ubuntu:20.4

YOSYS_VERSION=0.41
NEXTPNR_XILINX_DIR=/nextpnr-xilinx/xilinx
CHIPDB=/work/chipdb

RUN_CMD=docker run --rm -v .:/work -e USER_ID=`id -u` -e GROUP_ID=`id -g`   -it ${IMAGE_TAG}


build:
	@echo "Build docker image"
	docker buildx build \
		--build-arg TZ=Europe/Paris \
		--build-arg base=${BASE} \
		--build-arg YOSYS_VERSION=${YOSYS_VERSION} \
		-f Dockerfile.openxc7 -t ${IMAGE_TAG} .	



push:
	@echo "Push to registry"


test: test-toolchain test-demo test-demo-projects

test-toolchain:
	@echo "test toolchain"
	@$(RUN_CMD) yosys --version | grep ${YOSYS_VERSION} 
	@$(RUN_CMD) nextpnr-xilinx --version | grep "(Version "

test-demo:
	make -C demo/ clean
	$(RUN_CMD) make -C /work/demo/ CHIPDB=${CHIPDB}
	if [ -e "demo/blinky.bit" ]; then \
		echo "File generated"; \
	else \
		echo "File NOT generated"; \
	fi

test-demo-projects:
	if [ ! -d "tests/demo-projects" ]; then git -C tests clone https://github.com/openXC7/demo-projects; fi
	make -C tests/demo-projects/blinky-digilent-arty clean
	$(RUN_CMD) make -C /work/tests/demo-projects/blinky-digilent-arty/ CHIPDB=${CHIPDB} NEXTPNR_XILINX_DIR=${NEXTPNR_XILINX_DIR}
	if [ -e "tests/demo-projects/blinky-digilent-arty/blinky.bit" ]; then \
		echo "File generated"; \
	else \
		echo "File NOT generated"; \
	fi

test-fail:
	echo "Always fails !!!"
	$(error "fails")


help:
	@echo "To be done"

