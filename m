Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A7AC04A68
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 08:39:42 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web08.5738.1659083976669804665
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 01:39:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=PZM8FBPi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-51332-202207290839348bd8f338d6e5150f93-skl_rx@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202207290839348bd8f338d6e5150f93
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Jul 2022 10:39:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=otTTPYyAYnc7KthM/ZTNSUVGdQePuM5JNzlHwINIRMg=;
 b=PZM8FBPi/WEQYzLuZTQR28RJFn5oA1Hi88bQwitbizcyVucbI4mYnuZ1qc9I12wSasTLVR
 UAo/j8dtnxjfZgZuOUrzegemiAw643FHkXwBwlyjtfnSCVMKWvDldiBSuH/rR1sNhuVkFR22
 v0tLR89X2xpKZcmhJvx6oBCts35hw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 4/4] kas-cip: Add patch for linux-cip
 with CONFIG_MODULES=n
Date: Fri, 29 Jul 2022 10:39:31 +0200
Message-Id: <20220729083931.419731-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
References: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 08:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8973

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes an error during the kernel build with sbuild if
Modules.symvers doesn't exist as find returns 1 if a name
could not be found.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ...ernel-Check-if-CONFIG_MODULES-is-set.patch | 33 +++++++++++++++++++
 kas-cip.yml                                   |  4 +++
 2 files changed, 37 insertions(+)
 create mode 100644 isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch

diff --git a/isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch b/isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
new file mode 100644
index 0000000..d07c36d
--- /dev/null
+++ b/isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
@@ -0,0 +1,33 @@
+From 6ad8f9bb92d3722ff5eb60f09e5ef75ba5febcbd Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Thu, 28 Jul 2022 16:24:16 +0200
+Subject: [PATCH] recipes-kernel: Check if CONFIG_MODULES is set
+
+This fixes an error during the kernel build with sbuild if
+Modules.symvers doesn't exist as find returns 1 if a name
+could not be found.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ meta/recipes-kernel/linux/files/debian/isar/install.tmpl | 5 ++++-
+ 1 file changed, 4 insertions(+), 1 deletion(-)
+
+diff --git a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
+index c6b5059..909b01b 100644
+--- a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
++++ b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
+@@ -173,7 +173,10 @@ kernel_headers() {
+     (cd ${S}; find arch/${ARCH} -name module.lds -o -name Kbuild.platforms -o -name Platform) >>${src_hdr_files}
+     (cd ${S}; find $(find arch/${ARCH} -name include -o -name scripts -type d) -type f) >>${src_hdr_files}
+ 
+-    (cd ${O}; find arch/${ARCH}/include Module.symvers include scripts -type f) >>${obj_hdr_files}
++    if [ -n "${CONFIG_MODULES}" ]; then
++        echo Module.symvers >> ${obj_hdr_files}
++    fi
++    (cd ${O}; find arch/${ARCH}/include include scripts -type f) >>${obj_hdr_files}
+     if [ -n "${CONFIG_STACK_VALIDATION}" ]; then
+         (cd ${O}; find tools/objtool -type f -executable) >>${obj_hdr_files}
+     fi
+-- 
+2.35.1
+
diff --git a/kas-cip.yml b/kas-cip.yml
index a39820f..5a43cd1 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -25,6 +25,10 @@ repos:
     refspec: 64c755053d1252d183757b294cf9849fced64799
     layers:
       meta:
+    patches:
+      fix-hihope-kernel-build:
+        repo: cip-core
+        path: isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
 
 bblayers_conf_header:
   standard: |
-- 
2.35.1


