From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 31 Jul 2019 23:02:43 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip-rt] Update CI to use the latest
	linux-cip-ci containers
In-Reply-To: <20190731220244.20321-1-chris.paterson2@renesas.com>
References: <20190731220244.20321-1-chris.paterson2@renesas.com>
Message-ID: <20190731220244.20321-3-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The main aim of this update is to add support for more build
architectures.

In addition, we need to include a fix so that builds using Kernel
configs from cip-kernel-config will work again, after changes to the
directory structure caused us problems.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 421d971908a6..874601a94983 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -2,16 +2,17 @@ variables:
   GIT_STRATEGY: clone
   GIT_DEPTH: 10
   DOCKER_DRIVER: overlay2
+  DOCKER_IMAGE_TAG: v2
 
-build_arm_renesas_shmobile_defconfig:
+arm_renesas_shmobile_defconfig:
   stage: build
-  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
+  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
     BUILD_ARCH: arm
     CONFIG: renesas_shmobile_defconfig
     CONFIG_LOC: cip-kernel-config
     DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
-    DTBS: arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
+    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb
   script:
     - /opt/build_kernel.sh
   artifacts:
@@ -20,15 +21,15 @@ build_arm_renesas_shmobile_defconfig:
     paths:
       - output
 
-build_arm_shmobile_defconfig:
+arm_shmobile_defconfig:
   stage: build
-  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
+  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
     BUILD_ARCH: arm
     CONFIG: shmobile_defconfig
     CONFIG_LOC: intree
     DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
-    DTBS: arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
+    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb
   script:
     - /opt/build_kernel.sh
   artifacts:
@@ -39,10 +40,11 @@ build_arm_shmobile_defconfig:
 
 run_tests:
   stage: test
-  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-v1
+  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-$DOCKER_IMAGE_TAG
   when: always
   variables:
     GIT_STRATEGY: none
+    TEST_TIMEOUT: 30
   script:
     - /opt/submit_tests.sh
   artifacts:
-- 
2.17.1
