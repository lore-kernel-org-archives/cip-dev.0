From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 5 Aug 2019 15:50:23 +0000
Subject: [cip-dev] [PATCH linux-4.4.y-cip] Update to run all CIP arm and
	x86 configs
In-Reply-To: <20190805153452.5870-2-chris.paterson2@renesas.com>
References: <20190805153452.5870-1-chris.paterson2@renesas.com>
	<20190805153452.5870-2-chris.paterson2@renesas.com>
Message-ID: <TYAPR01MB228532F160477E6CB98BFD35B7DA0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> From: Chris Paterson <chris.paterson2@renesas.com>
> Sent: 05 August 2019 16:35
> 
> Also update to use new linux-cip-ci repository location.
> 
> Support for powerpc and real-time will be added later.

FYI you can see a completed run using this gitlab-ci.yml file here:
https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/74765720

Kind regards, Chris

> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
> 
> Today the linux-cip-ci project moved to the offical cip-project/cip-testing
> namespace. Until this patch is accepted CI won't work on this branch of the
> linux-cip project.
> 
>  .gitlab-ci.yml | 249
> ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 246 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 874601a94983..6348d1c47f6e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -4,9 +4,42 @@ variables:
>    DOCKER_DRIVER: overlay2
>    DOCKER_IMAGE_TAG: v2
> 
> +# Building
> +arm_hitachi_omap_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: hitachi_omap_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +arm_moxa_mxc_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: moxa_mxc_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
>  arm_renesas_shmobile_defconfig:
>    stage: build
> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
>      BUILD_ARCH: arm
>      CONFIG: renesas_shmobile_defconfig
> @@ -21,9 +54,218 @@ arm_renesas_shmobile_defconfig:
>      paths:
>        - output
> 
> +arm_siemens_am335x-axm2_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: siemens_am335x-axm2_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +arm_siemens_am335x-draco_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: siemens_am335x-draco_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +arm_siemens_am335x-dxr2_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: siemens_am335x-dxr2_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +arm_siemens_am335x-etamin_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: siemens_am335x-etamin_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +arm_siemens_am57xx-pxm3.config:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: siemens_am57xx-pxm3.config
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +arm_siemens_dcu2.config:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: siemens_dcu2.config
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +arm_siemens_imx6_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: siemens_imx6_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +arm_toshiba_tegra_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: toshiba_tegra_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +arm_toshiba_zynq_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: toshiba_zynq_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +x86_plathome_obsvx1.config:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: x86
> +    CONFIG: plathome_obsvx1.config
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +x86_siemens_iot2000.config:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: x86
> +    CONFIG: siemens_iot2000.config
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +x86_siemens_server_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: x86
> +    CONFIG: siemens_server_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +x86_toshiba_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  variables:
> +    BUILD_ARCH: x86
> +    CONFIG: toshiba_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    BUILD_ONLY: "true"
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +# Extra build configurations
>  arm_shmobile_defconfig:
>    stage: build
> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
>      BUILD_ARCH: arm
>      CONFIG: shmobile_defconfig
> @@ -38,9 +280,10 @@ arm_shmobile_defconfig:
>      paths:
>        - output
> 
> +# Testing
>  run_tests:
>    stage: test
> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-
> $DOCKER_IMAGE_TAG
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-
> $DOCKER_IMAGE_TAG
>    when: always
>    variables:
>      GIT_STRATEGY: none
> --
> 2.17.1
