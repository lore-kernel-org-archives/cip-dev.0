From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 01 Aug 2019 19:32:01 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip-rt] Update CI to use the latest
 linux-cip-ci containers
In-Reply-To: <20190731220244.20321-1-chris.paterson2@renesas.com>
References: <20190731220244.20321-1-chris.paterson2@renesas.com>
Message-ID: <e1da51399df977629aa4256a6e10c2566428a4e4.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2019-07-31 at 23:02 +0100, Chris Paterson wrote:
> The main aim of this update is to add support for more build
> architectures.
> 
> In addition, we need to include a fix so that builds using Kernel
> configs from cip-kernel-config will work again, after changes to the
> directory structure caused us problems.

Sorry about the lack of notice for that.

I started out working alone on the kernel-config and kernel-sec
repositories, so didn't have anyone to review the changes, so I got in
the habit of simply pushing my changes.

Since that's no longer the case I will try to stick to merge requests
that can be reviewed before I make breaking changes.  (That doesn't
mean there won't be any breaking changes in future, but it's more
likely that there will be advance warning.)

Ben.

> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .gitlab-ci.yml | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 96eed0e0c81a..fb775f4950b1 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -2,16 +2,17 @@ variables:
>    GIT_STRATEGY: clone
>    GIT_DEPTH: 10
>    DOCKER_DRIVER: overlay2
> +  DOCKER_IMAGE_TAG: v2
>  
> -build_arm_renesas_shmobile_defconfig:
> +arm_renesas_shmobile_defconfig:
>    stage: build
> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
> +  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
>      BUILD_ARCH: arm
>      CONFIG: renesas_shmobile_defconfig
>      CONFIG_LOC: cip-kernel-config
>      DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
> -    DTBS: arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
> +    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb
>    script:
>      - /opt/build_kernel.sh
>    artifacts:
> @@ -20,15 +21,15 @@ build_arm_renesas_shmobile_defconfig:
>      paths:
>        - output
>  
> -build_arm64_renesas_defconfig:
> +arm64_renesas_defconfig:
>    stage: build
> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
> +  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
>      BUILD_ARCH: arm64
>      CONFIG: renesas_defconfig
>      CONFIG_LOC: cip-kernel-config
>      DEVICES: r8a774c0-ek874
> -    DTBS: arch/arm64/boot/dts/renesas/r8a774c0-ek874.dtb
> +    DTBS: r8a774c0-ek874.dtb
>    script:
>      - /opt/build_kernel.sh
>    artifacts:
> @@ -37,15 +38,15 @@ build_arm64_renesas_defconfig:
>      paths:
>        - output
>  
> -build_arm_shmobile_defconfig:
> +arm_shmobile_defconfig:
>    stage: build
> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
> +  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
>      BUILD_ARCH: arm
>      CONFIG: shmobile_defconfig
>      CONFIG_LOC: intree
>      DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
> -    DTBS: arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
> +    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb
>    script:
>      - /opt/build_kernel.sh
>    artifacts:
> @@ -56,10 +57,11 @@ build_arm_shmobile_defconfig:
>  
>  run_tests:
>    stage: test
> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-v1
> +  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-$DOCKER_IMAGE_TAG
>    when: always
>    variables:
>      GIT_STRATEGY: none
> +    TEST_TIMEOUT: 30
>    script:
>      - /opt/submit_tests.sh
>    artifacts:
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
