From: chris.paterson2@renesas.com (Chris Paterson)
Date: Sun, 13 Oct 2019 22:19:19 +0100
Subject: [cip-dev] [PATCH linux-4.4.y-cip-rt 2/3] gitlab-ci: Remove
	unofficial build configurations
In-Reply-To: <20191013211920.9370-1-chris.paterson2@renesas.com>
References: <20191013211920.9370-1-chris.paterson2@renesas.com>
Message-ID: <20191013211920.9370-11-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

We should concentrate our testing on the offical configurations.
We're essentially testing shmobile_defconfig anyway.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fcbfdd0b2197..bb7af78a5978 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -297,38 +297,3 @@ build:rt_x86_siemens_i386-rt.config:
     when: always
     paths:
       - output
-
-########################
-# Extra configurations #
-########################
-build:arm_shmobile_defconfig:
-  stage: build
-  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
-  variables:
-    BUILD_ARCH: arm
-    CONFIG: shmobile_defconfig
-    CONFIG_LOC: intree
-    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm r8a77470-iwg23s-sbc
-    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb r8a77470-iwg23s-sbc.dtb
-  script:
-    - /opt/build_kernel.sh
-  artifacts:
-    name: "$CI_JOB_NAME"
-    when: always
-    paths:
-      - output
-
-test:arm_shmobile_defconfig:
-  stage: test
-  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
-  when: always
-  variables:
-    GIT_STRATEGY: none
-    TEST_TIMEOUT: 60
-  script:
-    - /opt/submit_tests.sh
-  artifacts:
-    name: "$CI_JOB_NAME"
-    when: always
-    paths:
-      - output
-- 
2.17.1
