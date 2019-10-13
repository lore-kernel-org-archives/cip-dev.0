From: chris.paterson2@renesas.com (Chris Paterson)
Date: Sun, 13 Oct 2019 22:19:11 +0100
Subject: [cip-dev] [PATCH linux-4.19.y-cip 3/3] gitlab-ci: Remove test
	timeout
In-Reply-To: <20191013211920.9370-1-chris.paterson2@renesas.com>
References: <20191013211920.9370-1-chris.paterson2@renesas.com>
Message-ID: <20191013211920.9370-3-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Setting a relevant test timeout is hard as we've no idea how many other
test jobs are running.

We have another two timeouts already:
  1) The CI job timeut setting in the GitLab runner
  2) The LAVA test job timeout

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d297f3deaced..3e6d493bbc89 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -78,7 +78,6 @@ test:arm_renesas_shmobile_defconfig:
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
   variables:
     GIT_STRATEGY: none
-    TEST_TIMEOUT: 60
   script:
     - /opt/submit_tests.sh
   artifacts:
@@ -142,7 +141,6 @@ test:arm64_renesas_defconfig:
   image: registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-$DOCKER_IMAGE_TAG
   variables:
     GIT_STRATEGY: none
-    TEST_TIMEOUT: 60
   script:
     - /opt/submit_tests.sh
   artifacts:
-- 
2.17.1
