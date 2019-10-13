From: chris.paterson2@renesas.com (Chris Paterson)
Date: Sun, 13 Oct 2019 22:19:10 +0100
Subject: [cip-dev] [PATCH linux-4.19.y-cip 2/3] gitlab-ci: Remove unofficial
	build configurations
In-Reply-To: <20191013211920.9370-1-chris.paterson2@renesas.com>
References: <20191013211920.9370-1-chris.paterson2@renesas.com>
Message-ID: <20191013211920.9370-2-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The Arm64 defconfig creates a huge image and an even larger modules
archive.

Both the build and test takes a long time, and CIP don't officially
support this configuration.

Also remove shmobile_defconfig as we're essentially building/testing the
same already.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 67 --------------------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b72f0325435a..d297f3deaced 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -214,70 +214,3 @@ build:x86_toshiba_atom_baytrail_cip.config:
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
-    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
-    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb
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
-  needs: ["build:arm_shmobile_defconfig"]
-  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
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
-
-build:arm64_defconfig:
-  stage: build
-  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
-  variables:
-    BUILD_ARCH: arm64
-    CONFIG: defconfig
-    CONFIG_LOC: intree
-    DEVICES: r8a774c0-ek874 r8a774a1-hihope-rzg2m-ex
-    DTBS: r8a774c0-ek874.dtb r8a774a1-hihope-rzg2m-ex.dtb
-  script:
-    - /opt/build_kernel.sh
-  artifacts:
-    name: "$CI_JOB_NAME"
-    when: always
-    paths:
-      - output
-
-test:arm64_defconfig:
-  stage: test
-  needs: ["build:arm64_defconfig"]
-  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
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
