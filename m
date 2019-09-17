From: chris.paterson2@renesas.com (Chris Paterson)
Date: Tue, 17 Sep 2019 15:02:11 +0100
Subject: [cip-dev] [PATCH linux-4.4.y-cip-rt] gitlab-ci: Increase test
	timeout to 60 minutes
In-Reply-To: <20190917140211.3993-1-chris.paterson2@renesas.com>
References: <20190917140211.3993-1-chris.paterson2@renesas.com>
Message-ID: <20190917140211.3993-4-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Due to the number of jobs we're running we're beginning to see a backlog of
tests in the LAVA lab. Increasing the timeout to handle this delay.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6348d1c47f6e..55202f5e2ced 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -287,7 +287,7 @@ run_tests:
   when: always
   variables:
     GIT_STRATEGY: none
-    TEST_TIMEOUT: 30
+    TEST_TIMEOUT: 60
   script:
     - /opt/submit_tests.sh
   artifacts:
-- 
2.17.1
