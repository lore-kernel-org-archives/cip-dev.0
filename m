Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E99CAC5B7
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 11:53:42 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.14949.1758628411447981139
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 04:53:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=jFiIeXZ1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2025092311532979260369b200020766-6heer6@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025092311532979260369b200020766
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Sep 2025 13:53:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=v86S5Wmot/lLDeEK2Fc0jOAX0Tiome8Dk05ZmXzu4ao=;
 b=jFiIeXZ1wJfe95hKJZVxcxE7EyLEYJcy/XJI+AnTJDt5i/2h/aPWjF36bV/ycLuaiBAIP3
 pOTzKt//Uzv1ORz2Ti+qslI70MdqqUfo9xhpBFcMlr3Wj99/PVIm3NfvhovtJBQ02lW7ags9
 rccZu1dnrGwAOTXHma9mKEF5oOqbTX6GmPLYVhf6blZVOUtWJLKwWNOAI/eMh4Sd01a3D5po
 6rakvIXSFxTLSwiWLH5R90ZDgXQbr4LRfkgRi4S36jTmak5sABkTdacSLxAvOMCak5ZkwjwM
 CrEK8/rLB0s0VXMGQwyac+H64g1Z7/ic+dRSbx4YJAdci81yX4Jf01xw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v7 7/7] Kconfig: add option for factory-reset
Date: Tue, 23 Sep 2025 13:52:58 +0200
Message-ID: <20250923115319.335608-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
References: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 11:53:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20113

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

A full disk image is necessary to provide the necessary infrastructure
(bootloader or boot partition) to execute a factory-reset. In isar-cip-core
this is only possible with the efibootguard based images.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                                         | 16 ++++++++++++++++
 kas/opt/factory-reset.yml                       | 17 +++++++++++++++++
 recipes-core/images/cip-core-image.bb           |  2 ++
 .../cip-core-initramfs/cip-core-initramfs.bb    |  3 ++-
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 kas/opt/factory-reset.yml

diff --git a/Kconfig b/Kconfig
index 3ba6131..e7d8bd5 100644
--- a/Kconfig
+++ b/Kconfig
@@ -34,6 +34,9 @@ config ARCH_RISCV64
 config HAS_SWUPDATE
 	bool
 
+config HAS_EFIVARS
+	bool
+
 choice
 	prompt "Target board"
 	default TARGET_QEMU_AMD64
@@ -42,11 +45,13 @@ config TARGET_QEMU_AMD64
 	bool "QEMU AMD64 (x86-64)"
 	select ARCH_AMD64
 	select HAS_SWUPDATE
+	select HAS_EFIVARS
 
 config TARGET_X86_UEFI
 	bool "Generic x86 machine booting via UEFI"
 	select ARCH_AMD64
 	select HAS_SWUPDATE
+	select HAS_EFIVARS
 
 config TARGET_QEMU_ARM64
 	bool "QEMU ARM64 (aarch64)"
@@ -281,6 +286,13 @@ config SEPARATE_HOME_PARTITION
 	  This adds a separate home partition to the build image instead of moving
 	  home to the var partition.
 
+config FACTORY_RESET
+	bool "Enable factory reset"
+	depends on IMAGE_SWUPDATE && (HAS_EFIVARS || !(IMAGE_FULL_ENCRYPTION || IMAGE_DATA_ENCRYPTION))
+	help
+	  This adds the necessary packages to request and execute a factory
+	  reset of the persistent partition. See also ./doc/README.factory-reset.md.
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
@@ -293,6 +305,10 @@ config KAS_INCLUDE_SEPARATE_HOME_PARTITION
 	string
 	default "kas/opt/separate-home-partition.yml" if SEPARATE_HOME_PARTITION
 
+config KAS_INCLUDE_FACTORY_RESET
+	string
+	default "kas/opt/factory-reset.yml" if FACTORY_RESET
+
 config WDOG_TIMEOUT
 	int "EFI Boot Guard watchdog timeout in seconds"
 	default 60
diff --git a/kas/opt/factory-reset.yml b/kas/opt/factory-reset.yml
new file mode 100644
index 0000000..1ea11db
--- /dev/null
+++ b/kas/opt/factory-reset.yml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  factory-reset: |
+    OVERRIDES .= ":factory-reset"
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 4a9cea9..52dd180 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -15,5 +15,7 @@ DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
 
+IMAGE_INSTALL:append:factory-reset = "factory-reset-helper"
+
 CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 0e4cf74..4fe7ee1 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021 - 2023
+# Copyright (c) Siemens AG, 2021 - 2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -16,3 +16,4 @@ INITRAMFS_INSTALL += " \
     "
 
 INITRAMFS_INSTALL:append:encrypt-partitions = " initramfs-crypt-hook"
+INITRAMFS_INSTALL:append:factory-reset = " initramfs-factory-reset-hook"
-- 
2.50.1


