From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 18 Sep 2019 16:42:50 +0100
Subject: [cip-dev] [PATCH linux-4.19.y-cip] gitlab-ci: Always store job
	artifacts
Message-ID: <20190918154250.8205-1-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This means that we'll retain the Kernel configuration even if the build
fails. Useful for debugging.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0e5d70d0c7f5..ba8b75abaee7 100644
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
 
@@ -197,7 +197,7 @@ arm_shmobile_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -214,7 +214,7 @@ arm64_defconfig:
     - /opt/build_kernel.sh
   artifacts:
     name: "$CI_JOB_NAME"
-    when: on_success
+    when: always
     paths:
       - output
 
@@ -230,5 +230,6 @@ run_tests:
     - /opt/submit_tests.sh
   artifacts:
     name: "$CI_JOB_NAME"
+    when: always
     paths:
       - output
-- 
2.17.1
