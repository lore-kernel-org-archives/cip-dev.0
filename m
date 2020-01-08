From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Wed,  8 Jan 2020 15:33:57 +0100
Subject: [cip-dev] [isar-cip-core PATCH 4/5] Use siemens_ipc227e_defconfig
	for simatic-ipc227e
In-Reply-To: <20200108143358.26177-1-Quirin.Gylstorff@siemens.com>
References: <20200108143358.26177-1-Quirin.Gylstorff@siemens.com>
Message-ID: <20200108143358.26177-5-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/simatic-ipc227e.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
index 473e6c5..3c9638f 100644
--- a/conf/machine/simatic-ipc227e.conf
+++ b/conf/machine/simatic-ipc227e.conf
@@ -10,3 +10,5 @@ DISTRO_ARCH = "amd64"
 
 IMAGE_TYPE ?= "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
+USE_CIP_KERNEL_CONFIG = "1"
+KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/siemens_ipc227e_defconfig"
-- 
2.20.1
