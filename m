From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Wed,  8 Jan 2020 15:33:55 +0100
Subject: [cip-dev] [isar-cip-core PATCH 2/5] Use renesas-config for
	hihope-rzg2m
In-Reply-To: <20200108143358.26177-1-Quirin.Gylstorff@siemens.com>
References: <20200108143358.26177-1-Quirin.Gylstorff@siemens.com>
Message-ID: <20200108143358.26177-3-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/hihope-rzg2m.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index 863e20d..8278205 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -13,5 +13,7 @@ DISTRO_ARCH = "arm64"
 
 IMAGE_TYPE ?= "wic-img"
 
+KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
+USE_CIP_KERNEL_CONFIG = "1"
 DTB_FILE = "r8a774a1-hihope-rzg2m-ex.dtb"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILE}"
-- 
2.20.1
