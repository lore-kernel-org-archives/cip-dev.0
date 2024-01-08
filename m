Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0F4C4725D
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 10:26:54 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.3846.1704709602894275047
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jan 2024 02:26:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Ni8vURLX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2024010810263918045fc181f574927c-8liwaq@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024010810263918045fc181f574927c
        for <cip-dev@lists.cip-project.org>;
        Mon, 08 Jan 2024 11:26:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=BjnKiiQn3LKRIRzxBB/vJ22B9eSnVspjECyOSqgoOUM=;
 b=Ni8vURLXkjcwUzcqz0jR3g8+Vs4Jz/UjDLV4sHGC+GtMyyXCyVd2VDZJeSGJzCWEX4UIyA
 pG1T005MHEftYx3RaQH/BS4hCUH6rOMWacAbLFd+UFXXnll47umwcXe9uOTVUj0eXxY6+gDX
 MeGMOcXo3FmwkSh1+lCOGE3nsBcW0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 1/6] Move efibootguard specific settings from include to class file
Date: Mon,  8 Jan 2024 11:25:49 +0100
Message-ID: <20240108102638.2966221-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240108102638.2966221-1-Quirin.Gylstorff@siemens.com>
References: <20240108102638.2966221-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 10:26:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14273

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is done in preparations to reduce similar code.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/efibootguard.bbclass         | 17 +++++++++++++++++
 recipes-core/images/efibootguard.inc |  9 ++-------
 2 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 classes/efibootguard.bbclass

diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
new file mode 100644
index 0000000..bc99d3a
--- /dev/null
+++ b/classes/efibootguard.bbclass
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+IMAGE_INSTALL:append = " efibootguard libebgenv0"
+IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH}"
+WDOG_TIMEOUT ?= "60"
+WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH"
+IMAGE_TYPEDEP:swu:append = " wic"
+
diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
index 0f26b7d..f512b3c 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020, 2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -9,9 +9,4 @@
 # SPDX-License-Identifier: MIT
 #
 
-IMAGE_INSTALL:append = " efibootguard libebgenv0"
-IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH}"
-WDOG_TIMEOUT ?= "60"
-WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
-IMAGE_FSTYPES:append = " wic"
-IMAGE_TYPEDEP:swu:append = " wic"
+inherit efibootguard
-- 
2.43.0


