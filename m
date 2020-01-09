From: Quirin.Gylstorff@siemens.com (Q. Gylstorff)
Date: Thu,  9 Jan 2020 09:52:38 +0100
Subject: [cip-dev] [isar-cip-core PATCH v2 1/5] recipes-kernel/linux: allow
	the usage of the cip-kernel-config
In-Reply-To: <20200108143358.26177-1-Quirin.Gylstorff@siemens.com>
References: <20200108143358.26177-1-Quirin.Gylstorff@siemens.com>
Message-ID: <20200109085242.4466-2-Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To avoid the duplication of the linux cip kernel configuration
add the option USE_CIP_KERNEL_CONFIG. If this option is set to 1
the KERNEL_DEFCONFIG from the cip project is used. The KERNEL_DEFCONFIG
is contains the explicit path to the defconfig in
gitlab.com/cip-project/cip-kernel-config.git.

SRCREV_cip-kernel-config sets the commit sha for checkout.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/hihope-rzg2m.conf            |  1 -
 kas.yml                                   |  4 ++--
 recipes-kernel/linux/linux-cip-common.inc | 18 +++++++++++++++---
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index 8b8849f..863e20d 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -13,6 +13,5 @@ DISTRO_ARCH = "arm64"
 
 IMAGE_TYPE ?= "wic-img"
 
-KERNEL_DEFCONFIG = "https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/raw/693be1bfb92e6c0ef813cf29431ac49eab0e15be/4.19.y-cip/arm64/renesas_defconfig"
 DTB_FILE = "r8a774a1-hihope-rzg2m-ex.dtb"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILE}"
diff --git a/kas.yml b/kas.yml
index aa7ddda..3eb6f03 100644
--- a/kas.yml
+++ b/kas.yml
@@ -18,8 +18,8 @@ repos:
   cip-core:
 
   isar:
-    url: https://github.com/ilbers/isar
-    refspec: 20a5e368021d988d8f0dcd1951b395d194a37ebb
+    url: https://github.com/ilbers/isar.git
+    refspec: 619d6d88ac8c745282fd16773d50a466567615b6
     layers:
       meta:
 
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index d65cfa3..f8cbf50 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -9,10 +9,22 @@
 # SPDX-License-Identifier: MIT
 #
 
-require recipes-kernel/linux/linux-custom.inc
+KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
+
+def conditional(variable, checkvalue, truevalue, falsevalue, d):
+    if d.getVar(variable) == checkvalue:
+        return truevalue
+    else:
+        return falsevalue
 
-KERNEL_DEFCONFIG = "${MACHINE}_defconfig"
+require recipes-kernel/linux/linux-custom.inc
 
 SRC_URI += " \
     https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-${PV}.tar.gz \
-    file://${KERNEL_DEFCONFIG}"
+"
+
+SRC_URI_append = "${@conditional("USE_CIP_KERNEL_CONFIG","1", \
+" git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config" \
+," file://${KERNEL_DEFCONFIG}",d)}"
+SRCREV_cip-kernel-config ?= "f88ee1e75253104f975263cf4d0bddd557388197"
+
-- 
2.20.1
