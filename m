From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Thu,  9 Jan 2020 15:30:43 +0100
Subject: [cip-dev] [isar-cip-core PATCH] classes/wic-targz-img: add
	dependency between targz-img and wic-img
Message-ID: <20200109143043.7675-1-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add a dependency between targz_image and wic_image to avoid
an error during the generation of the targz image as wic modifies
the rootfs.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/wic-targz-img.bbclass | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/classes/wic-targz-img.bbclass b/classes/wic-targz-img.bbclass
index 4e9f89d..1327840 100644
--- a/classes/wic-targz-img.bbclass
+++ b/classes/wic-targz-img.bbclass
@@ -11,3 +11,5 @@
 
 inherit wic-img
 inherit targz-img
+
+addtask do_targz_image after do_wic_image
-- 
2.20.1
