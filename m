Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16D0C47DA6
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 20:00:26 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.2404.1705003220422330717
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 12:00:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=qGjV3d86;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240111200016f106d0cfe0c71488d4-1kv_4l@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240111200016f106d0cfe0c71488d4
        for <cip-dev@lists.cip-project.org>;
        Thu, 11 Jan 2024 21:00:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Z38sXGYXGCfIlsFGoLgdZwE1tPRfwqYXFN6IdUB+/2A=;
 b=qGjV3d8664BJ7s2ztCsDpPwz9q67yYHwSijkZSm44ljyTQfipLGpcZlVyxOslE3g60kP8i
 u0kBJArC8/2+/SPuqLQRVLar5Wf/Dc5pR7zxep44NuzamQ7EUjGqVQ6cfwLsrREwRRjl+lfN
 YYS0+tCu/uDJ493iLCoMcLxmIeuT4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 1/7] Move efibootguard specific settings from include to class file
Date: Thu, 11 Jan 2024 20:59:45 +0100
Message-ID: <20240111200015.190376-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
References: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 20:00:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14340

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is done in preparations to reduce similar code.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/efibootguard.bbclass         | 16 ++++++++++++++++
 recipes-core/images/efibootguard.inc |  9 ++-------
 2 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 classes/efibootguard.bbclass

diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
new file mode 100644
index 0000000..5a8a39b
--- /dev/null
+++ b/classes/efibootguard.bbclass
@@ -0,0 +1,16 @@
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
+WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
+IMAGE_TYPEDEP:swu:append = " wic"
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


