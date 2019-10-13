From: chris.paterson2@renesas.com (Chris Paterson)
Date: Sun, 13 Oct 2019 22:19:12 +0100
Subject: [cip-dev] [PATCH linux-4.19.y-cip-rt 1/3] gitlab-ci: Split tests
	into separate jobs
In-Reply-To: <20191013211920.9370-1-chris.paterson2@renesas.com>
References: <20191013211920.9370-1-chris.paterson2@renesas.com>
Message-ID: <20191013211920.9370-4-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This will allow tests to run as soon as the corresponding build job is
complete.

This will help spread the load on the test infrastructure and save time.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 92 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 21 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 52f084fe37b5..b5a225c96f90 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -4,8 +4,10 @@ variables:
   DOCKER_DRIVER: overlay2
   DOCKER_IMAGE_TAG: v2
 
-# Building
-arm_hitachi_cyclonev_defconfig:
+###############################
+# Standard CIP configurations #
+###############################
+build:arm_hitachi_cyclonev_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -21,7 +23,7 @@ arm_hitachi_cyclonev_defconfig:
     paths:
       - output
 
-arm_hitachi_omap_defconfig:
+build:arm_hitachi_omap_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -37,7 +39,7 @@ arm_hitachi_omap_defconfig:
     paths:
       - output
 
-arm_moxa_mxc_defconfig:
+build:arm_moxa_mxc_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -53,7 +55,7 @@ arm_moxa_mxc_defconfig:
     paths:
       - output
 
-arm_renesas_shmobile_defconfig:
+build:arm_renesas_shmobile_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -70,7 +72,22 @@ arm_renesas_shmobile_defconfig:
     paths:
       - output
 
-arm_siemens_imx6.config:
+test:arm_renesas_shmobile_defconfig:
+  stage: test
+  needs: ["build:arm_renesas_shmobile_defconfig"]
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
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
+build:arm_siemens_imx6.config:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -86,7 +103,7 @@ arm_siemens_imx6.config:
     paths:
       - output
 
-arm64_moxa_eds_defconfig:
+build:arm64_moxa_eds_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -102,7 +119,7 @@ arm64_moxa_eds_defconfig:
     paths:
       - output
 
-arm64_renesas_defconfig:
+build:arm64_renesas_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -119,7 +136,22 @@ arm64_renesas_defconfig:
     paths:
       - output
 
-x86_plathome_obsvx2.config:
+test:arm64_renesas_defconfig:
+  stage: test
+  needs: ["build:arm64_renesas_defconfig"]
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
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
+build:x86_plathome_obsvx2.config:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -135,7 +167,7 @@ x86_plathome_obsvx2.config:
     paths:
       - output
 
-x86_siemens_iot2000.config:
+build:x86_siemens_iot2000.config:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -151,7 +183,7 @@ x86_siemens_iot2000.config:
     paths:
       - output
 
-x86_siemens_server_defconfig:
+build:x86_siemens_server_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -167,7 +199,7 @@ x86_siemens_server_defconfig:
     paths:
       - output
 
-x86_toshiba_atom_baytrail_cip.config:
+build:x86_toshiba_atom_baytrail_cip.config:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -183,8 +215,10 @@ x86_toshiba_atom_baytrail_cip.config:
     paths:
       - output
 
-# RT build configurations
-rt_arm_socfpga_defconfig:
+#########################
+# RT CIP configurations #
+#########################
+build:rt_arm_socfpga_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -200,7 +234,7 @@ rt_arm_socfpga_defconfig:
     paths:
       - output
 
-rt_x86_siemens_i386-rt.config:
+build:rt_x86_siemens_i386-rt.config:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -216,8 +250,10 @@ rt_x86_siemens_i386-rt.config:
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
@@ -234,7 +270,22 @@ arm_shmobile_defconfig:
     paths:
       - output
 
-arm64_defconfig:
+test:arm_shmobile_defconfig:
+  stage: test
+  needs: ["build:arm_shmobile_defconfig"]
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
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
+build:arm64_defconfig:
   stage: build
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
@@ -251,11 +302,10 @@ arm64_defconfig:
     paths:
       - output
 
-# Testing
-run_tests:
+test:arm64_defconfig:
   stage: test
+  needs: ["build:arm64_defconfig"]
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
-  when: always
   variables:
     GIT_STRATEGY: none
     TEST_TIMEOUT: 60
-- 
2.17.1
