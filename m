From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Thu,  7 Nov 2019 17:39:42 +0100
Subject: [cip-dev] [isar-cip-core PATCH v2 4/4] ci: add hihope-rzg2m to ci
	chain
In-Reply-To: <TYAPR01MB2285BB4C180DBB805DC1C079B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285BB4C180DBB805DC1C079B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20191107163942.23513-5-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 36c152a..319c5a2 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -23,3 +23,7 @@ all:
     - sudo rm -rf build/tmp
     - kas build kas.yml:board-iwg20m.yml:opt-rt.yml
     - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb
+
+    - sudo rm -rf build/tmp
+    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml
+    - scripts/deploy-cip-core.sh buster hihope-rz2gm r8a774a1-hihope-rzg2m-ex.dtb
-- 
2.20.1
