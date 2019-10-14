From: pavel@denx.de (Pavel Machek)
Date: Mon, 14 Oct 2019 09:33:39 +0200
Subject: [cip-dev] Rethinking .yml files in the repositories was Re: [PATCH
 linux-4.19.y-cip 1/3] gitlab-ci: Split tests into separate jobs
In-Reply-To: <20191013211920.9370-1-chris.paterson2@renesas.com>
References: <20191013211920.9370-1-chris.paterson2@renesas.com>
Message-ID: <20191014073339.GA22886@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> This will allow tests to run as soon as the corresponding build job is
> complete.
> 
> This will help spread the load on the test infrastructure and save
> time.

When we agreed to merge .yml files into the git, I was assuming they
would be kind of static... but apparently that was wrong assumption.

It seems the .yml needs to change as boards are added/removed and as
our test infrastructure changes.

There are complications we did not foresee: these updates are made in
parallel to -cip and -cip-rt trees. That unfortunately means, that
when I'm updating -cip-rt tree, each of them tends to show up as a
conflict. And then, when updating -cip-rt-rebase, I get to solve them
again.

Which is not fun and it makes history more complex than it should have
been. Jan already expressed concerns about too much churn.

So... there was proposal with separate repository for testing. I
believe we need to explore that.

Best regards,
								Pavel


> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .gitlab-ci.yml | 84 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 18 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ba8b75abaee7..b72f0325435a 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -4,8 +4,10 @@ variables:
>    DOCKER_DRIVER: overlay2
>    DOCKER_IMAGE_TAG: v2
>  
> -# Building
> -arm_hitachi_cyclonev_defconfig:
> +###############################
> +# Standard CIP configurations #
> +###############################
> +build:arm_hitachi_cyclonev_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -21,7 +23,7 @@ arm_hitachi_cyclonev_defconfig:
>      paths:
>        - output
>  
> -arm_hitachi_omap_defconfig:
> +build:arm_hitachi_omap_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -37,7 +39,7 @@ arm_hitachi_omap_defconfig:
>      paths:
>        - output
>  
> -arm_moxa_mxc_defconfig:
> +build:arm_moxa_mxc_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -53,7 +55,7 @@ arm_moxa_mxc_defconfig:
>      paths:
>        - output
>  
> -arm_renesas_shmobile_defconfig:
> +build:arm_renesas_shmobile_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -70,7 +72,22 @@ arm_renesas_shmobile_defconfig:
>      paths:
>        - output
>  
> -arm_siemens_imx6.config:
> +test:arm_renesas_shmobile_defconfig:
> +  stage: test
> +  needs: ["build:arm_renesas_shmobile_defconfig"]
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
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
> +build:arm_siemens_imx6.config:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -86,7 +103,7 @@ arm_siemens_imx6.config:
>      paths:
>        - output
>  
> -arm64_moxa_eds_defconfig:
> +build:arm64_moxa_eds_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -102,7 +119,7 @@ arm64_moxa_eds_defconfig:
>      paths:
>        - output
>  
> -arm64_renesas_defconfig:
> +build:arm64_renesas_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -119,7 +136,22 @@ arm64_renesas_defconfig:
>      paths:
>        - output
>  
> -x86_plathome_obsvx2.config:
> +test:arm64_renesas_defconfig:
> +  stage: test
> +  needs: ["build:arm64_renesas_defconfig"]
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
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
> +build:x86_plathome_obsvx2.config:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -135,7 +167,7 @@ x86_plathome_obsvx2.config:
>      paths:
>        - output
>  
> -x86_siemens_iot2000.config:
> +build:x86_siemens_iot2000.config:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -151,7 +183,7 @@ x86_siemens_iot2000.config:
>      paths:
>        - output
>  
> -x86_siemens_server_defconfig:
> +build:x86_siemens_server_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -167,7 +199,7 @@ x86_siemens_server_defconfig:
>      paths:
>        - output
>  
> -x86_toshiba_atom_baytrail_cip.config:
> +build:x86_toshiba_atom_baytrail_cip.config:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -183,8 +215,10 @@ x86_toshiba_atom_baytrail_cip.config:
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
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -201,7 +235,22 @@ arm_shmobile_defconfig:
>      paths:
>        - output
>  
> -arm64_defconfig:
> +test:arm_shmobile_defconfig:
> +  stage: test
> +  needs: ["build:arm_shmobile_defconfig"]
> +  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
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
> +build:arm64_defconfig:
>    stage: build
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
>    variables:
> @@ -218,11 +267,10 @@ arm64_defconfig:
>      paths:
>        - output
>  
> -# Testing
> -run_tests:
> +test:arm64_defconfig:
>    stage: test
> +  needs: ["build:arm64_defconfig"]
>    image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
> -  when: always
>    variables:
>      GIT_STRATEGY: none
>      TEST_TIMEOUT: 60

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191014/1ec88db6/attachment.sig>
