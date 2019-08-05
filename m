From: chris.paterson2@renesas.com (Chris Paterson)
Date: Mon,  5 Aug 2019 16:35:58 +0100
Subject: [cip-dev] [PATCH linux-4.19.y-cip] Update to run all CIP arm,
	arm64 and x86 configs
In-Reply-To: <20190805153558.5926-1-chris.paterson2@renesas.com>
References: <20190805153558.5926-1-chris.paterson2@renesas.com>
Message-ID: <20190805153558.5926-2-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Also update to use new linux-cip-ci repository location.

Support for real-time will be added later.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---

Today the linux-cip-ci project moved to the offical cip-project/cip-testing
namespace. Until this patch is accepted CI won't work on this branch of the
linux-cip project.

 .gitlab-ci.yml | 172 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 168 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fb775f4950b1..62562c8b6fbb 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -4,9 +4,58 @@ variables:
   DOCKER_DRIVER: overlay2
   DOCKER_IMAGE_TAG: v2
 
+# Building
+arm_hitachi_cyclonev_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: arm
+    CONFIG: hitachi_cyclonev_defconfig
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
+arm_hitachi_omap_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: arm
+    CONFIG: hitachi_omap_defconfig
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
+arm_moxa_mxc_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: arm
+    CONFIG: moxa_mxc_defconfig
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
 arm_renesas_shmobile_defconfig:
   stage: build
-  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
     BUILD_ARCH: arm
     CONFIG: renesas_shmobile_defconfig
@@ -21,9 +70,41 @@ arm_renesas_shmobile_defconfig:
     paths:
       - output
 
+arm_siemens_imx6.config:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: arm
+    CONFIG: siemens_imx6.config
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
+arm64_moxa_eds_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: arm64
+    CONFIG: moxa_eds_defconfig
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
 arm64_renesas_defconfig:
   stage: build
-  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
     BUILD_ARCH: arm64
     CONFIG: renesas_defconfig
@@ -38,9 +119,74 @@ arm64_renesas_defconfig:
     paths:
       - output
 
+x86_plathome_obsvx2.config:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: x86
+    CONFIG: plathome_obsvx2.config
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
+x86_siemens_iot2000.config:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: x86
+    CONFIG: siemens_iot2000.config
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
+x86_siemens_server_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: x86
+    CONFIG: siemens_server_defconfig
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
+x86_toshiba_atom_baytrail_cip.config:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: x86
+    CONFIG: toshiba_atom_baytrail_cip.config
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
+# Extra build configurations
 arm_shmobile_defconfig:
   stage: build
-  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
   variables:
     BUILD_ARCH: arm
     CONFIG: shmobile_defconfig
@@ -55,9 +201,27 @@ arm_shmobile_defconfig:
     paths:
       - output
 
+arm64_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:build-$DOCKER_IMAGE_TAG
+  variables:
+    BUILD_ARCH: arm64
+    CONFIG: defconfig
+    CONFIG_LOC: intree
+    DEVICES: r8a774c0-ek874
+    DTBS: r8a774c0-ek874.dtb
+  script:
+    - /opt/build_kernel.sh
+  artifacts:
+    name: "$CI_JOB_NAME"
+    when: on_success
+    paths:
+      - output
+
+# Testing
 run_tests:
   stage: test
-  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-$DOCKER_IMAGE_TAG
+  image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
   when: always
   variables:
     GIT_STRATEGY: none
-- 
2.17.1
