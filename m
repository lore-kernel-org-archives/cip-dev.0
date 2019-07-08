From: chris.paterson2@renesas.com (Chris Paterson)
Date: Mon,  8 Jul 2019 14:16:03 +0100
Subject: [cip-dev] [PATCH v3 4.4.y-cip] Add gitlab-ci.yaml
In-Reply-To: <20190702105133.23765-1-chris.paterson2@renesas.com>
References: <20190702105133.23765-1-chris.paterson2@renesas.com>
Message-ID: <20190708131603.17134-1-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This is configured to build and test the following configurations:

* BUILD_ARCH: arm
* CONFIG: renesas_shmobile_defconfig
* CONFIG_LOC: cip-kernel-config
* DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
* DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb

* BUILD_ARCH: arm
* CONFIG: shmobile_defconfig
* CONFIG_LOC: intree
* DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
* DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb

Over time support will be added for all CIP supported architectures and
configurations.

At the moment only simple boot tests are run. Real tests will be added in
the future

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---

v2->v3: Updated to use linux-cip-ci version: ad4a6589 (docker tag "v1")

v1->v2: Updated to use latest linux-cip-ci version: 9d56f41a

 .gitlab-ci.yml | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 .gitlab-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 000000000000..421d971908a6
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,51 @@
+variables:
+  GIT_STRATEGY: clone
+  GIT_DEPTH: 10
+  DOCKER_DRIVER: overlay2
+
+build_arm_renesas_shmobile_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
+  variables:
+    BUILD_ARCH: arm
+    CONFIG: renesas_shmobile_defconfig
+    CONFIG_LOC: cip-kernel-config
+    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
+    DTBS: arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
+  script:
+    - /opt/build_kernel.sh
+  artifacts:
+    name: "$CI_JOB_NAME"
+    when: on_success
+    paths:
+      - output
+
+build_arm_shmobile_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
+  variables:
+    BUILD_ARCH: arm
+    CONFIG: shmobile_defconfig
+    CONFIG_LOC: intree
+    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
+    DTBS: arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
+  script:
+    - /opt/build_kernel.sh
+  artifacts:
+    name: "$CI_JOB_NAME"
+    when: on_success
+    paths:
+      - output
+
+run_tests:
+  stage: test
+  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-v1
+  when: always
+  variables:
+    GIT_STRATEGY: none
+  script:
+    - /opt/submit_tests.sh
+  artifacts:
+    name: "$CI_JOB_NAME"
+    paths:
+      - output
-- 
2.17.1
