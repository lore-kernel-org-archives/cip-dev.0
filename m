Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC327C3DA6B
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 07:31:29 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web08.22386.1661931086169712338
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 00:31:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=VrGfh1aW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-294854-20220831073123f1fefb9610d34d77ad-rtt2z1@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20220831073123f1fefb9610d34d77ad
        for <cip-dev@lists.cip-project.org>;
        Wed, 31 Aug 2022 09:31:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pbsDyylxiwUUOLcjESPePXN4PQNfWQZo8lqvXIDlP74=;
 b=VrGfh1aWz4vM+8hlPmhpU76y10RN5X3lIatsOERlDTlRWtGjNPitTi4vL36uE1MysKWtLX
 SSiD06wJ9ggSUI3UFmX6FKvPsqDtwftShgMc7l2kbrXNYrIkPN3n4HmAYhidoClRhmFPA9HA
 S29qu5MFPvUlUFU6B7CDunAYuYnUQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/6] Update Isar revision
Date: Wed, 31 Aug 2022 09:31:17 +0200
Message-Id: 
 <a7fe971511362cf3b7b0b5206b277f843784346e.1661931081.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1661931081.git.jan.kiszka@siemens.com>
References: <cover.1661931081.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 07:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9328

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop the meanwhile merged kernel recipe patch.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...ernel-Check-if-CONFIG_MODULES-is-set.patch | 33 -------------------
 kas-cip.yml                                   |  6 +---
 2 files changed, 1 insertion(+), 38 deletions(-)
 delete mode 100644 isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch

diff --git a/isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch b/isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
deleted file mode 100644
index d07c36d..0000000
--- a/isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
+++ /dev/null
@@ -1,33 +0,0 @@
-From 6ad8f9bb92d3722ff5eb60f09e5ef75ba5febcbd Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Thu, 28 Jul 2022 16:24:16 +0200
-Subject: [PATCH] recipes-kernel: Check if CONFIG_MODULES is set
-
-This fixes an error during the kernel build with sbuild if
-Modules.symvers doesn't exist as find returns 1 if a name
-could not be found.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- meta/recipes-kernel/linux/files/debian/isar/install.tmpl | 5 ++++-
- 1 file changed, 4 insertions(+), 1 deletion(-)
-
-diff --git a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
-index c6b5059..909b01b 100644
---- a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
-+++ b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
-@@ -173,7 +173,10 @@ kernel_headers() {
-     (cd ${S}; find arch/${ARCH} -name module.lds -o -name Kbuild.platforms -o -name Platform) >>${src_hdr_files}
-     (cd ${S}; find $(find arch/${ARCH} -name include -o -name scripts -type d) -type f) >>${src_hdr_files}
- 
--    (cd ${O}; find arch/${ARCH}/include Module.symvers include scripts -type f) >>${obj_hdr_files}
-+    if [ -n "${CONFIG_MODULES}" ]; then
-+        echo Module.symvers >> ${obj_hdr_files}
-+    fi
-+    (cd ${O}; find arch/${ARCH}/include include scripts -type f) >>${obj_hdr_files}
-     if [ -n "${CONFIG_STACK_VALIDATION}" ]; then
-         (cd ${O}; find tools/objtool -type f -executable) >>${obj_hdr_files}
-     fi
--- 
-2.35.1
-
diff --git a/kas-cip.yml b/kas-cip.yml
index 5a43cd1..d005b81 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,13 +22,9 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 64c755053d1252d183757b294cf9849fced64799
+    refspec: 8dfa97cf6e25a7adec2e02c50c5ef6329f31931b
     layers:
       meta:
-    patches:
-      fix-hihope-kernel-build:
-        repo: cip-core
-        path: isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
 
 bblayers_conf_header:
   standard: |
-- 
2.35.3


