Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2372ACCF9F6
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.26397.1761549712393480804
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=GStuEuOZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20251027072149112c009a5700020774-majmgb@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251027072149112c009a5700020774
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=d7L8e1CDzWi64AQDJMvPwoF3VDDekySdmCXJlMhPSpA=;
 b=GStuEuOZDZVvnSl5vaajASMkXL4cgpvSaNVAPUgWo9OI0IPufjmga/jm8YZOjEQvEHFaql
 GlDOnVWFA+PHVRv7CibmXraGG6lGSU4eFSzuYCGEWAIyIeP40w8s5vSdc7lva3bhQSfNh/xv
 pO1vDJE+K3C0QSYNxiuhNzmY2tI+RCJEsmT9u+cdnHJzrLnOONHvGgtRvxmRlL5Oq/0N4g5T
 EhxOGzu04ZavG1wAXdJypOk/ZKWeE3bJSMVw+mNBxLeYRKELLOQyMCg3sFN2+FlvX1GlFaCB
 Jn5HPaiwSS+svJVpH9HChUGKnIJH4YwGp/TaoBRBxqInauL26ms8HfCA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 06/19] u-boot: Add patch to fix sporadic build failures
Date: Mon, 27 Oct 2025 08:21:35 +0100
Message-ID: <3b23fd63dddcdda47d0609e2e1f0d88b5ef2b747.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20233

From: Jan Kiszka <jan.kiszka@siemens.com>

Merge upstream, will appear in v2026.01.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...ot-generate-logo-when-cross-building.patch | 33 +++++++++++++++++++
 recipes-bsp/u-boot/u-boot-common-2025.07.inc  |  1 +
 2 files changed, 34 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch

diff --git a/recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch b/recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch
new file mode 100644
index 00000000..16b219f5
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch
@@ -0,0 +1,33 @@
+From 371a76e845504c9ba7ca216b6edfb4ae4ec14e56 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Sat, 23 Aug 2025 17:21:09 +0200
+Subject: [PATCH] tools: Do not generate logo when cross-building
+
+This cannot work (unless qemu-user is registered in binfmt_misc) as the
+tools will be for a different architecture.
+
+Fixes "make cross_tools" in case CONFIG_VIDEO_LOGO is enabled.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+Reviewed-by: Tom Rini <trini@konsulko.com>
+---
+ tools/Makefile | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/tools/Makefile b/tools/Makefile
+index 7eb17f92116..ae6a3052646 100644
+--- a/tools/Makefile
++++ b/tools/Makefile
+@@ -333,7 +333,9 @@ HOST_EXTRACFLAGS += -include $(srctree)/include/compiler.h \
+ 		-D__KERNEL_STRICT_NAMES \
+ 		-D_GNU_SOURCE
+ 
++ifeq ($(CROSS_BUILD_TOOLS),)
+ __build:	$(LOGO-y)
++endif
+ 
+ $(LOGO_H):	$(obj)/bmp_logo $(LOGO_BMP)
+ 	$(obj)/bmp_logo --gen-info $(LOGO_BMP) > $@
+-- 
+2.51.0
+
diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
index 93678cbf..b5ecb31a 100644
--- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
@@ -15,6 +15,7 @@ FILESPATH:append := ":${FILE_DIRNAME}/files"
 
 SRC_URI += " \
     https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
+    file://0001-tools-Do-not-generate-logo-when-cross-building.patch \
     file://rules.tmpl;subdir=debian"
 SRC_URI[sha256sum] = "0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7"
 
-- 
2.51.0


