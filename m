From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 18 Sep 2019 16:43:36 +0100
Subject: [cip-dev] [PATCH linux-4.4.y-cip 1/2] gitlab-ci: Always store job
	artifacts
Message-ID: <20190918154337.8305-1-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This means that we'll retain the Kernel configuration even if the build
fails. Useful for debugging.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 55202f5e2ced..3a927f07cb3f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -17,7 +17,7 @@ arm_hitachi_omap_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -33,7 +33,7 @@ arm_moxa_mxc_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -50,7 +50,7 @@ arm_renesas_shmobile_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -66,7 +66,7 @@ arm_siemens_am335x-axm2_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -82,7 +82,7 @@ arm_siemens_am335x-draco_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -98,7 +98,7 @@ arm_siemens_am335x-dxr2_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -114,7 +114,7 @@ arm_siemens_am335x-etamin_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -130,7 +130,7 @@ arm_siemens_am57xx-pxm3.config:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -146,7 +146,7 @@ arm_siemens_dcu2.config:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -162,7 +162,7 @@ arm_siemens_imx6_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -178,7 +178,7 @@ arm_toshiba_tegra_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -194,7 +194,7 @@ arm_toshiba_zynq_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -210,7 +210,7 @@ x86_plathome_obsvx1.config:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -226,7 +226,7 @@ x86_siemens_iot2000.config:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -242,7 +242,7 @@ x86_siemens_server_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -258,7 +258,7 @@ x86_toshiba_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -276,7 +276,7 @@ arm_shmobile_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -292,5 +292,6 @@ run_tests:
     - /opt/submit_tests.sh
   artifacts:
     name: "$CI_JOB_NAME"
+    when: always
     paths:
       - output
-- 
2.17.1
