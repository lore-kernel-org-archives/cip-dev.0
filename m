From: chris.paterson2@renesas.com (Chris Paterson)
Date: Mon, 14 Oct 2019 08:49:08 +0100
Subject: [cip-dev] [PATCH linux-4.4.y-cip v2 3/3] gitlab-ci: Remove test
	timeout
In-Reply-To: <20191014074911.11161-1-chris.paterson2@renesas.com>
References: <20191014074911.11161-1-chris.paterson2@renesas.com>
Message-ID: <20191014074911.11161-3-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Setting a relevant test timeout is hard as we've no idea how many other
test jobs are running.

We have another two timeouts already:
  1) The CI job timeut setting in the GitLab runner
  2) The LAVA test job timeout

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---

v1 -> v2
* No change

 .gitlab-ci.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 86ba8f31aafb..bbcb22168e7a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -63,7 +63,6 @@ test:arm_renesas_shmobile_defconfig:
   when: always
   variables:
     GIT_STRATEGY: none
-    TEST_TIMEOUT: 60
   script:
     - /opt/submit_tests.sh
   artifacts:
-- 
2.17.1
