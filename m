From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue,  4 Jun 2019 15:13:31 +0900
Subject: [cip-dev] [isar-cip-core] gitignore: add kas-docker
Message-ID: <20190604061331.8800-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add kas-docker to .gitignore so it does not show in git status

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index fd87a39..bfedb76 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,2 +1,3 @@
 build/
 isar/
+kas-docker
\ No newline at end of file
-- 
2.17.1
