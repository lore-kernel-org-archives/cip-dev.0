From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Thu,  7 Nov 2019 17:39:39 +0100
Subject: [cip-dev] [isar-cip-core PATCH v2 1/4] kas: Increase Isar version
In-Reply-To: <TYAPR01MB2285BB4C180DBB805DC1C079B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285BB4C180DBB805DC1C079B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20191107163942.23513-2-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add fix for manifest generation to avoid errors during build.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas.yml b/kas.yml
index 4904715..aa7ddda 100644
--- a/kas.yml
+++ b/kas.yml
@@ -19,7 +19,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar
-    refspec: c1bae4c7ae9dee4d2cf5fd77d0c5560d9e52d5e1
+    refspec: 20a5e368021d988d8f0dcd1951b395d194a37ebb
     layers:
       meta:
 
-- 
2.20.1
