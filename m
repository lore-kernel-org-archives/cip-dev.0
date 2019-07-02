From: chris.paterson2@renesas.com (Chris Paterson)
Date: Tue,  2 Jul 2019 11:51:33 +0100
Subject: [cip-dev] [PATCH v2 4.4.y-cip] Add gitlab-ci.yaml
In-Reply-To: <20190627131250.7932-2-chris.paterson2@renesas.com>
References: <20190627131250.7932-2-chris.paterson2@renesas.com>
Message-ID: <20190702105133.23765-1-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This is configured to build and test for the following configurations:

1.
ARCH: arm
CONFIGS: shmobile_defconfig
BOARDS: r8a7743-iwg20d, r8a7745-iwg22d

Over time support will be added for all CIP supported architectures and
configurations.

At the moment only simple boot tests are run. Real tests will be added in
the future.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---

v1->v2: Updated to use latest linux-cip-ci version: 9d56f41a

I still prefer to have these .gitlab-ci.yml files in the main cip repo,
rather then split them off into their own repo and trigger them with
hooks. Any opinions Kernel maintainers?

 .gitlab-ci.yml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 .gitlab-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 000000000000..aec787a353bc
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,23 @@
+variables:
+  GIT_STRATEGY: clone
+  GIT_DEPTH: "10"
+  DOCKER_DRIVER: overlay2
+
+build_arm_shmobile_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-latest
+  script:
+    - /opt/build_kernel.sh arm shmobile_defconfig
+  artifacts:
+    name: "$CI_JOB_NAME"
+    when: on_success
+    paths:
+      - output
+
+run_tests:
+  stage: test
+  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-latest
+  when: always
+  before_script: []
+  script:
+    - /opt/submit_tests.sh
-- 
2.17.1
