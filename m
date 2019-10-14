From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 14 Oct 2019 05:54:35 +0000
Subject: [cip-dev] [PATCH linux-4.4.y-cip 1/3] gitlab-ci: Split tests
 into separate jobs
In-Reply-To: <20191013211920.9370-7-chris.paterson2@renesas.com>
References: <20191013211920.9370-1-chris.paterson2@renesas.com>
	<20191013211920.9370-7-chris.paterson2@renesas.com>
Message-ID: <TYAPR01MB228559F4AFAAE7825F562188B7900@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> From: Chris Paterson <chris.paterson2@renesas.com>
> Sent: 13 October 2019 22:19
> 
> This will allow tests to run as soon as the corresponding build job is
> complete.
> 
> This will help spread the load on the test infrastructure and save time.
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .gitlab-ci.yml | 60 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 21 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e33099ea6594..73cea6bbce89 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -4,8 +4,10 @@ variables:
>    DOCKER_DRIVER: overlay2
>    DOCKER_IMAGE_TAG: v2
> 
> -# Building
> -arm_hitachi_omap_defconfig:
> +###############################
> +# Standard CIP configurations #
> +###############################
> +build:arm_hitachi_omap_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -21,7 +23,7 @@ arm_hitachi_omap_defconfig:
>      paths:
>        - output
> 
> -arm_moxa_mxc_defconfig:
> +build:arm_moxa_mxc_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -37,7 +39,7 @@ arm_moxa_mxc_defconfig:
>      paths:
>        - output
> 
> -arm_renesas_shmobile_defconfig:
> +build:arm_renesas_shmobile_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -54,7 +56,22 @@ arm_renesas_shmobile_defconfig:
>      paths:
>        - output
> 
> -arm_siemens_am335x-axm2_defconfig:
> +test:arm_renesas_shmobile_defconfig:
> +  stage: test

Missing:
needs: ["build:arm_renesas_shmobile_defconfig"]

> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-
> $DOCKER_IMAGE_TAG
> +  when: always
> +  variables:
> +    GIT_STRATEGY: none
> +    TEST_TIMEOUT: 60
> +  script:
> +    - /opt/submit_tests.sh
> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: always
> +    paths:
> +      - output
> +
> +build:arm_siemens_am335x-axm2_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -70,7 +87,7 @@ arm_siemens_am335x-axm2_defconfig:
>      paths:
>        - output
> 
> -arm_siemens_am335x-draco_defconfig:
> +build:arm_siemens_am335x-draco_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -86,7 +103,7 @@ arm_siemens_am335x-draco_defconfig:
>      paths:
>        - output
> 
> -arm_siemens_am335x-dxr2_defconfig:
> +build:arm_siemens_am335x-dxr2_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -102,7 +119,7 @@ arm_siemens_am335x-dxr2_defconfig:
>      paths:
>        - output
> 
> -arm_siemens_am335x-etamin_defconfig:
> +build:arm_siemens_am335x-etamin_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -118,7 +135,7 @@ arm_siemens_am335x-etamin_defconfig:
>      paths:
>        - output
> 
> -arm_siemens_am57xx-pxm3.config:
> +build:arm_siemens_am57xx-pxm3.config:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -134,7 +151,7 @@ arm_siemens_am57xx-pxm3.config:
>      paths:
>        - output
> 
> -arm_siemens_dcu2.config:
> +build:arm_siemens_dcu2.config:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -150,7 +167,7 @@ arm_siemens_dcu2.config:
>      paths:
>        - output
> 
> -arm_siemens_imx6_defconfig:
> +build:arm_siemens_imx6_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -166,7 +183,7 @@ arm_siemens_imx6_defconfig:
>      paths:
>        - output
> 
> -arm_toshiba_tegra_defconfig:
> +build:arm_toshiba_tegra_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -182,7 +199,7 @@ arm_toshiba_tegra_defconfig:
>      paths:
>        - output
> 
> -arm_toshiba_zynq_defconfig:
> +build:arm_toshiba_zynq_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -198,7 +215,7 @@ arm_toshiba_zynq_defconfig:
>      paths:
>        - output
> 
> -x86_plathome_obsvx1.config:
> +build:x86_plathome_obsvx1.config:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -214,7 +231,7 @@ x86_plathome_obsvx1.config:
>      paths:
>        - output
> 
> -x86_siemens_iot2000.config:
> +build:x86_siemens_iot2000.config:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -230,7 +247,7 @@ x86_siemens_iot2000.config:
>      paths:
>        - output
> 
> -x86_siemens_server_defconfig:
> +build:x86_siemens_server_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -246,7 +263,7 @@ x86_siemens_server_defconfig:
>      paths:
>        - output
> 
> -x86_toshiba_defconfig:
> +build:x86_toshiba_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -262,8 +279,10 @@ x86_toshiba_defconfig:
>      paths:
>        - output
> 
> -# Extra build configurations
> -arm_shmobile_defconfig:
> +########################
> +# Extra configurations #
> +########################
> +build:arm_shmobile_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-
> $DOCKER_IMAGE_TAG
>    variables:
> @@ -280,8 +299,7 @@ arm_shmobile_defconfig:
>      paths:
>        - output
> 
> -# Testing
> -run_tests:
> +test:arm_shmobile_defconfig:
>    stage: test

Missing:
needs: ["build:arm_shmobile_defconfig"]

I'll send a v2 for the series.

Chris

>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-
> $DOCKER_IMAGE_TAG
>    when: always
> --
> 2.17.1
