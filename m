From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 8 Jul 2019 13:31:04 +0000
Subject: [cip-dev] [PATCH v3 4.4.y-cip] Add gitlab-ci.yaml
In-Reply-To: <20190708131603.17134-1-chris.paterson2@renesas.com>
References: <20190702105133.23765-1-chris.paterson2@renesas.com>
	<20190708131603.17134-1-chris.paterson2@renesas.com>
Message-ID: <TYAPR01MB22850207B425C1A5E6324082B7F60@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello all,

> From: Chris Paterson <chris.paterson2@renesas.com>
> Sent: 08 July 2019 14:16
> 
> This is configured to build and test the following configurations:
> 
> * BUILD_ARCH: arm
> * CONFIG: renesas_shmobile_defconfig
> * CONFIG_LOC: cip-kernel-config
> * DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
> * DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-
> ca.dtb
> 
> * BUILD_ARCH: arm
> * CONFIG: shmobile_defconfig
> * CONFIG_LOC: intree
> * DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
> * DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-
> ca.dtb
> 
> Over time support will be added for all CIP supported architectures and
> configurations.
> 
> At the moment only simple boot tests are run. Real tests will be added in
> the future
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
> 
> v2->v3: Updated to use linux-cip-ci version: ad4a6589 (docker tag "v1")

I meant to provide some examples of the below patch in use, but obviously forgot.

This .gitlab-ci.yml file is based on taf 'v1' of Docker images built by linux-cip-ci [1].

Specifically, the below patch has been tested in linux-cip in the chris/linux-4.4.y-cip-ci-test branch [1] as can be seen in the below GitLab CI pipeline:
https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/69891645

Physical board boot tests that were run can be found here:
https://lava.ciplatform.org/scheduler/job/1768
https://lava.ciplatform.org/scheduler/job/1769
https://lava.ciplatform.org/scheduler/job/1770
https://lava.ciplatform.org/scheduler/job/1771


[1] https://gitlab.com/cip-playground/linux-cip-ci
[2] https://gitlab.com/cip-project/cip-kernel/linux-cip/commit/0a231b59ce50c72175f09c776a79ebe6da8eff53

Let me know if you have any questions.

Kind regards, Chris

> 
> v1->v2: Updated to use latest linux-cip-ci version: 9d56f41a
> 
>  .gitlab-ci.yml | 51
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 .gitlab-ci.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> new file mode 100644
> index 000000000000..421d971908a6
> --- /dev/null
> +++ b/.gitlab-ci.yml
> @@ -0,0 +1,51 @@
> +variables:
> +  GIT_STRATEGY: clone
> +  GIT_DEPTH: 10
> +  DOCKER_DRIVER: overlay2
> +
> +build_arm_renesas_shmobile_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: renesas_shmobile_defconfig
> +    CONFIG_LOC: cip-kernel-config
> +    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
> +    DTBS: arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
> arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +build_arm_shmobile_defconfig:
> +  stage: build
> +  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
> +  variables:
> +    BUILD_ARCH: arm
> +    CONFIG: shmobile_defconfig
> +    CONFIG_LOC: intree
> +    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
> +    DTBS: arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
> arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
> +  script:
> +    - /opt/build_kernel.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: on_success
> +    paths:
> +      - output
> +
> +run_tests:
> +  stage: test
> +  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-v1
> +  when: always
> +  variables:
> +    GIT_STRATEGY: none
> +  script:
> +    - /opt/submit_tests.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    paths:
> +      - output
> --
> 2.17.1
