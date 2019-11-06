From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Wed,  6 Nov 2019 13:44:39 +0100
Subject: [cip-dev] [isar-cip-core PATCH 4/4] ci: add hihope-rzg2m to ci chain
In-Reply-To: <20191106124439.10532-1-Quirin.Gylstorff@siemens.com>
References: <20191106124439.10532-1-Quirin.Gylstorff@siemens.com>
Message-ID: <20191106124439.10532-5-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 36c152a..991862b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -23,3 +23,7 @@ all:
     - sudo rm -rf build/tmp
     - kas build kas.yml:board-iwg20m.yml:opt-rt.yml
     - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb
+
+    - sudo rm -rf build/tmp
+    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml
+    - scripts/deploy-cip-core.sh buster hihope-rz2gm r8a774a1-hihope-rzg2m.dtb
-- 
2.20.1
