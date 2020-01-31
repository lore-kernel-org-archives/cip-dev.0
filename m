From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 31 Jan 2020 14:02:08 +0100
Subject: [cip-dev] [PATCH linux-4.19.y-cip] gitlab-ci: Use external
 linux-cip-pipelines repository to define CI
In-Reply-To: <20191121160008.4886-1-chris.paterson2@renesas.com>
References: <20191121160008.4886-1-chris.paterson2@renesas.com>
Message-ID: <a373951f-a300-d2c0-2fa2-e45e269d6600@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 21.11.19 17:00, Chris Paterson wrote:
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>   .gitlab-ci.yml | 217 +------------------------------------------------
>   1 file changed, 3 insertions(+), 214 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 3e6d493bbc89..9630992fe864 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,214 +1,3 @@
> -variables:
> -  GIT_STRATEGY: clone
> -  GIT_DEPTH: 10
> -  DOCKER_DRIVER: overlay2
> -  DOCKER_IMAGE_TAG: v2
> -
> -###############################
> -# Standard CIP configurations #
> -###############################
> -build:arm_hitachi_cyclonev_defconfig:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: arm
> -    CONFIG: hitachi_cyclonev_defconfig
> -    CONFIG_LOC: cip-kernel-config
> -    BUILD_ONLY: "true"
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -build:arm_hitachi_omap_defconfig:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: arm
> -    CONFIG: hitachi_omap_defconfig
> -    CONFIG_LOC: cip-kernel-config
> -    BUILD_ONLY: "true"
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -build:arm_moxa_mxc_defconfig:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: arm
> -    CONFIG: moxa_mxc_defconfig
> -    CONFIG_LOC: cip-kernel-config
> -    BUILD_ONLY: "true"
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -build:arm_renesas_shmobile_defconfig:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: arm
> -    CONFIG: renesas_shmobile_defconfig
> -    CONFIG_LOC: cip-kernel-config
> -    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
> -    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -test:arm_renesas_shmobile_defconfig:
> -  stage: test
> -  needs: ["build:arm_renesas_shmobile_defconfig"]
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
> -  variables:
> -    GIT_STRATEGY: none
> -  script:
> -    - /opt/submit_tests.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -build:arm_siemens_imx6.config:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: arm
> -    CONFIG: siemens_imx6.config
> -    CONFIG_LOC: cip-kernel-config
> -    BUILD_ONLY: "true"
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -build:arm64_moxa_eds_defconfig:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: arm64
> -    CONFIG: moxa_eds_defconfig
> -    CONFIG_LOC: cip-kernel-config
> -    BUILD_ONLY: "true"
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -build:arm64_renesas_defconfig:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: arm64
> -    CONFIG: renesas_defconfig
> -    CONFIG_LOC: cip-kernel-config
> -    DEVICES: r8a774c0-ek874 r8a774a1-hihope-rzg2m-ex
> -    DTBS: r8a774c0-ek874.dtb r8a774a1-hihope-rzg2m-ex.dtb
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -test:arm64_renesas_defconfig:
> -  stage: test
> -  needs: ["build:arm64_renesas_defconfig"]
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
> -  variables:
> -    GIT_STRATEGY: none
> -  script:
> -    - /opt/submit_tests.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -build:x86_plathome_obsvx2.config:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: x86
> -    CONFIG: plathome_obsvx2.config
> -    CONFIG_LOC: cip-kernel-config
> -    BUILD_ONLY: "true"
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -build:x86_siemens_iot2000.config:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: x86
> -    CONFIG: siemens_iot2000.config
> -    CONFIG_LOC: cip-kernel-config
> -    BUILD_ONLY: "true"
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -build:x86_siemens_server_defconfig:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: x86
> -    CONFIG: siemens_server_defconfig
> -    CONFIG_LOC: cip-kernel-config
> -    BUILD_ONLY: "true"
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> -
> -build:x86_toshiba_atom_baytrail_cip.config:
> -  stage: build
> -  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
> -  variables:
> -    BUILD_ARCH: x86
> -    CONFIG: toshiba_atom_baytrail_cip.config
> -    CONFIG_LOC: cip-kernel-config
> -    BUILD_ONLY: "true"
> -  script:
> -    - /opt/build_kernel.sh
> -  artifacts:
> -    name: "$CI_JOB_NAME"
> -    when: always
> -    paths:
> -      - output
> +include:
> +  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/master/linux-cip-pipeline.yml
> +  - https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/master/trees/linux-4.19.y-cip.yml
> 

This causes an interesting error scenario for gitlabs on private networks:

"This GitLab CI configuration is invalid: Resolving config took longer 
than expected"

The reason is that gitlab tries to process any found .gitlab-ci.yml 
file, in our case by fetching the includes. But when the gitlab instance 
is isolated from public networks, the above will happen, and the user 
will receive a notice about a failed pipeline on each update.

The user can likely work around this by setting an invalid CI file for 
such projects (we are validating this ATM), but I wonder if we should 
rather set our .gitlab-ci.yml to a non-standard name. Or are there 
sufficient scenarios where a user != us can make use of the CI file?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
