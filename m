From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu,  5 Sep 2019 17:22:54 +0100
Subject: [cip-dev] [PATCH linux-4.4.y-cip-rt] gitlab-ci: Start testing RT
	configs
In-Reply-To: <20190905162254.24424-1-chris.paterson2@renesas.com>
References: <20190905162254.24424-1-chris.paterson2@renesas.com>
Message-ID: <20190905162254.24424-4-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

x86: siemens_i386-rt.config

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>
---
 .gitlab-ci.yml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6348d1c47f6e..d4cd0c9bd2f3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -262,6 +262,23 @@ x86_toshiba_defconfig:
     paths:
       - output
 
+# RT build configurations
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
