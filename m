From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Wed,  8 Jan 2020 15:33:56 +0100
Subject: [cip-dev] [isar-cip-core PATCH 3/5] Use renesas_shmobile_defconfig
	for iwg20m
In-Reply-To: <20200108143358.26177-1-Quirin.Gylstorff@siemens.com>
References: <20200108143358.26177-1-Quirin.Gylstorff@siemens.com>
Message-ID: <20200108143358.26177-4-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/iwg20m.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index 6c1a227..37f98fa 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -17,6 +17,8 @@ BAUDRATE_TTY = "115200"
 # kernel version
 PREFERRED_VERSION_linux-cip ?= "4.4.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.4.%"
+USE_CIP_KERNEL_CONFIG = "1"
+KERNEL_DEFCONFIG = "cip-kernel-config/4.4.y-cip/arm/renesas_shmobile_defconfig"
 
 # Boot partition files
 DTB_FILE = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
-- 
2.20.1
