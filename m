Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DC1CAC5B3
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:07:50 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.13257.1758622066887274375
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 03:07:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=MaqQdjBL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20250923100744e0ea9304af000207dd-mh0r9g@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250923100744e0ea9304af000207dd
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Sep 2025 12:07:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=IJ0RPPwi93TvJY1QSDe08K12DpxQYsSBNKmFv8yEl08=;
 b=MaqQdjBL/FBCmVRDyvZ6KJEDUzCSJQ9iZAsvcSzeMg+PQ3AxsG6P1QolBJWOSN5OPmlwek
 tYEDm0MKpYKDEGWeLMVJrQMAg2bFYa/FWGn9JD46PgX9vKCEVb6QzFhCVEI/7a/gCHFoEKKh
 lkR2dE4QWjy8kOpIfitHAAEbHWCdTKyi9WOYm0W2x7B2cW59quf6N1QOdqRHP7JNY0DdCkyB
 ejWfPV2wt4cGJgvHoYJXHrQxYAYzGW72Fck8qaE4RCOHPtZqfC5/YeTaf4eBNTkqwyUtaH1X
 96Q2JSVb+XWeuDQXmai0flcrfMDXrk0rUzSeKAhPDs+rebgcggzn6MFw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v6 5/7] Kconfig: add option for factory-reset
Date: Tue, 23 Sep 2025 12:02:39 +0200
Message-ID: <20250923100734.319688-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
References: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 10:07:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20099

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

A full disk image is necessary to provide the necessary infrastructure
(bootloader or boot partition) to execute a factory-reset. In isar-cip-core
this is only possible with the efibootguard based images.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                                         | 11 +++++++++++
 kas/opt/factory-reset.yml                       | 17 +++++++++++++++++
 recipes-core/images/cip-core-image.bb           |  2 ++
 .../cip-core-initramfs/cip-core-initramfs.bb    |  3 ++-
 4 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 kas/opt/factory-reset.yml

diff --git a/Kconfig b/Kconfig
index 3ba6131..c18acec 100644
--- a/Kconfig
+++ b/Kconfig
@@ -281,6 +281,13 @@ config SEPARATE_HOME_PARTITION
 	  This adds a separate home partition to the build image instead of moving
 	  home to the var partition.
 
+config FACTORY_RESET
+	bool "Enable factory reset"
+	depends on IMAGE_SWUPDATE
+	help
+	  This adds the necessary packages to execute a factory reset of the persistent
+	  partition.
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
@@ -293,6 +300,10 @@ config KAS_INCLUDE_SEPARATE_HOME_PARTITION
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


