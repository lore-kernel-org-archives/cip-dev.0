From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu, 27 Jun 2019 14:12:49 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip] Add gitlab-ci.yaml
Message-ID: <20190627131250.7932-1-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This is configured to build and test for the following configurations:

1. ARCH: arm
   CONFIGS: shmobile_defconfig
   BOARDS: r8a7743-iwg20d

2. ARCH: arm64
   CONFIGS: defconfig
   BOARDS: r8a774c0-ek874

Build/test Docker containers and scripts are created by the
https://gitlab.com/cip-playground/linux-cip-ci repository.

Over time support will be added for all CIP supported architectures and
configurations. At the moment only simple boot tests are run. Real tests
will be added in the future. These changes should all all be handled in
the linux-cip-ci repository.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---

In theory this file is only required in our GitLab repository. However if
we add it there the automatic mirroring from the kernel.org repository
will be broken.

I also tried the GitLab option to create a new repository for CI/CD
'only'. However this also has the exact same problem.

This means that the best/easiest approach will be to just add the
.gitlab-ci.yml file directly to the kernel.org repository. Most people can
ignore it.

There may well be some chrun in this file as linux-cip-ci improves, but
this is a good starting point.

 .gitlab-ci.yml | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 .gitlab-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 000000000000..d619ef0c1969
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,39 @@
+variables:
+  GIT_STRATEGY: none
+  DOCKER_DRIVER: overlay2
+
+before_script:
+  - cd /opt/linux
+  - git fetch origin
+  - git checkout $CI_COMMIT_SHA
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
+build_arm64_defconfig:
+  stage: build
+  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-latest
+  script:
+    - /opt/build_kernel.sh arm64 defconfig
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
+
-- 
2.17.1
