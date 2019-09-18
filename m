From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 18 Sep 2019 16:43:06 +0100
Subject: [cip-dev] [PATCH linux-4.19.y-cip-rt] gitlab-ci: Always store job
	artifacts
Message-ID: <20190918154306.8254-1-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This means that we'll retain the Kernel configuration even if the build
fails. Useful for debugging.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 11318a444ad4..52f084fe37b5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -17,7 +17,7 @@ arm_hitachi_cyclonev_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -33,7 +33,7 @@ arm_hitachi_omap_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -49,7 +49,7 @@ arm_moxa_mxc_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -66,7 +66,7 @@ arm_renesas_shmobile_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -82,7 +82,7 @@ arm_siemens_imx6.config:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -98,7 +98,7 @@ arm64_moxa_eds_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -115,7 +115,7 @@ arm64_renesas_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -131,7 +131,7 @@ x86_plathome_obsvx2.config:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -147,7 +147,7 @@ x86_siemens_iot2000.config:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -163,7 +163,7 @@ x86_siemens_server_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -179,7 +179,7 @@ x86_toshiba_atom_baytrail_cip.config:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -196,7 +196,7 @@ rt_arm_socfpga_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -212,7 +212,7 @@ rt_x86_siemens_i386-rt.config:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -230,7 +230,7 @@ arm_shmobile_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -247,7 +247,7 @@ arm64_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -263,5 +263,6 @@ run_tests:
     - /opt/submit_tests.sh
   artifacts:
     name: "$CI_JOB_NAME"
+    when: always
     paths:
       - output
-- 
2.17.1
