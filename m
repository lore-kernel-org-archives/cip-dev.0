From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu,  5 Sep 2019 17:22:52 +0100
Subject: [cip-dev] [PATCH linux-4.19.y-cip-rt] gitlab-ci: Start testing RT
	configs
In-Reply-To: <20190905162254.24424-1-chris.paterson2@renesas.com>
References: <20190905162254.24424-1-chris.paterson2@renesas.com>
Message-ID: <20190905162254.24424-2-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

arm: socfpga_defconfig
x86: siemens_i386-rt.config

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>
---
 .gitlab-ci.yml | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 62562c8b6fbb..78748f84ada5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -183,6 +183,39 @@ x86_toshiba_atom_baytrail_cip.config:
     paths:
       - output
 
+# RT build configurations
+rt_arm_socfpga_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: arm
+    CONFIG: socfpga_defconfig
+    CONFIG_LOC: cip-kernel-config
+    BUILD_ONLY: "true"
+  script:
+    - /opt/build_kernel.sh
+  artifacts:
+    name: "$CI_JOB_NAME"
+    when: on_success
+    paths:
+      - output
+
+rt_x86_siemens_i386-rt.config:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: x86
+    CONFIG: siemens_i386-rt.config
+    CONFIG_LOC: cip-kernel-config
+    BUILD_ONLY: "true"
+  script:
+    - /opt/build_kernel.sh
+  artifacts:
+    name: "$CI_JOB_NAME"
+    when: on_success
+    paths:
+      - output
+
 # Extra build configurations
 arm_shmobile_defconfig:
   stage: build
-- 
2.17.1
