From: chris.paterson2@renesas.com (Chris Paterson)
Date: Sun, 13 Oct 2019 22:19:20 +0100
Subject: [cip-dev] [PATCH linux-4.4.y-cip-rt 3/3] gitlab-ci: Remove test
	timeout
In-Reply-To: <20191013211920.9370-1-chris.paterson2@renesas.com>
References: <20191013211920.9370-1-chris.paterson2@renesas.com>
Message-ID: <20191013211920.9370-12-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Setting a relevant test timeout is hard as we've no idea how many other
test jobs are running.

We have another two timeouts already:
  1) The CI job timeut setting in the GitLab runner
  2) The LAVA test job timeout

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bb7af78a5978..6ff8f4e516c1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -62,7 +62,6 @@ test:arm_renesas_shmobile_defconfig:
   when: always
   variables:
     GIT_STRATEGY: none
-    TEST_TIMEOUT: 60
   script:
     - /opt/submit_tests.sh
   artifacts:
-- 
2.17.1
