From: chris.paterson2@renesas.com (Chris Paterson)
Date: Mon, 14 Oct 2019 08:49:06 +0100
Subject: [cip-dev] [PATCH linux-4.4.y-cip v2 1/3] gitlab-ci: Split tests
	into separate jobs
Message-ID: <20191014074911.11161-1-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This will allow tests to run as soon as the corresponding build job is
complete.

This will help spread the load on the test infrastructure and save time.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---

v1 -> v2
* Added missing 'needs' entries

 .gitlab-ci.yml | 62 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e33099ea6594..ad8ec722b717 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -4,8 +4,10 @@ variables:
   DOCKER_DRIVER: overlay2
   DOCKER_IMAGE_TAG: v2
 
-# Building
-arm_hitachi_omap_defconfig:
+###############################
+# Standard CIP configurations #
+###############################
+build:arm_hitachi_omap_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -21,7 +23,7 @@ arm_hitachi_omap_defconfig:
     paths:
       - output
 
-arm_moxa_mxc_defconfig:
+build:arm_moxa_mxc_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -37,7 +39,7 @@ arm_moxa_mxc_defconfig:
     paths:
       - output
 
-arm_renesas_shmobile_defconfig:
+build:arm_renesas_shmobile_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -54,7 +56,23 @@ arm_renesas_shmobile_defconfig:
     paths:
       - output
 
-arm_siemens_am335x-axm2_defconfig:
+test:arm_renesas_shmobile_defconfig:
+  stage: test
+  needs: ["build:arm_renesas_shmobile_defconfig"]
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
+  when: always
+  variables:
+    GIT_STRATEGY: none
+    TEST_TIMEOUT: 60
+  script:
+    - /opt/submit_tests.sh
+  artifacts:
+    name: "$CI_JOB_NAME"
+    when: always
+    paths:
+      - output
+
+build:arm_siemens_am335x-axm2_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -70,7 +88,7 @@ arm_siemens_am335x-axm2_defconfig:
     paths:
       - output
 
-arm_siemens_am335x-draco_defconfig:
+build:arm_siemens_am335x-draco_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -86,7 +104,7 @@ arm_siemens_am335x-draco_defconfig:
     paths:
       - output
 
-arm_siemens_am335x-dxr2_defconfig:
+build:arm_siemens_am335x-dxr2_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -102,7 +120,7 @@ arm_siemens_am335x-dxr2_defconfig:
     paths:
       - output
 
-arm_siemens_am335x-etamin_defconfig:
+build:arm_siemens_am335x-etamin_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -118,7 +136,7 @@ arm_siemens_am335x-etamin_defconfig:
     paths:
       - output
 
-arm_siemens_am57xx-pxm3.config:
+build:arm_siemens_am57xx-pxm3.config:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -134,7 +152,7 @@ arm_siemens_am57xx-pxm3.config:
     paths:
       - output
 
-arm_siemens_dcu2.config:
+build:arm_siemens_dcu2.config:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -150,7 +168,7 @@ arm_siemens_dcu2.config:
     paths:
       - output
 
-arm_siemens_imx6_defconfig:
+build:arm_siemens_imx6_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -166,7 +184,7 @@ arm_siemens_imx6_defconfig:
     paths:
       - output
 
-arm_toshiba_tegra_defconfig:
+build:arm_toshiba_tegra_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -182,7 +200,7 @@ arm_toshiba_tegra_defconfig:
     paths:
       - output
 
-arm_toshiba_zynq_defconfig:
+build:arm_toshiba_zynq_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -198,7 +216,7 @@ arm_toshiba_zynq_defconfig:
     paths:
       - output
 
-x86_plathome_obsvx1.config:
+build:x86_plathome_obsvx1.config:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -214,7 +232,7 @@ x86_plathome_obsvx1.config:
     paths:
       - output
 
-x86_siemens_iot2000.config:
+build:x86_siemens_iot2000.config:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -230,7 +248,7 @@ x86_siemens_iot2000.config:
     paths:
       - output
 
-x86_siemens_server_defconfig:
+build:x86_siemens_server_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -246,7 +264,7 @@ x86_siemens_server_defconfig:
     paths:
       - output
 
-x86_toshiba_defconfig:
+build:x86_toshiba_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -262,8 +280,10 @@ x86_toshiba_defconfig:
     paths:
       - output
 
-# Extra build configurations
-arm_shmobile_defconfig:
+########################
+# Extra configurations #
+########################
+build:arm_shmobile_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -280,9 +300,9 @@ arm_shmobile_defconfig:
     paths:
       - output
 
-# Testing
-run_tests:
+test:arm_shmobile_defconfig:
   stage: test
+  needs: ["build:arm_shmobile_defconfig"]
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
   when: always
   variables:
-- 
2.17.1
