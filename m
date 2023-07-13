Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC0EB64DD
	for <webhook@archiver.kernel.org>; Thu, 13 Jul 2023 08:51:22 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.4097.1689238271741177397
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jul 2023 01:51:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=IQOLTbDB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20230713085109ceb184d79551b16b55-orjno2@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230713085109ceb184d79551b16b55
        for <cip-dev@lists.cip-project.org>;
        Thu, 13 Jul 2023 10:51:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hYUMI+rZ6neIwQBPsxoq/+Dnjig+8wJHYm3OjRFvJRo=;
 b=IQOLTbDB8LlWUxcTZRY8BdOWxal6wmutwHdN2YxrZaVJS3iafFaqdzax9cvSqBbRwqanp8
 Oy4F5MFHPfMpdOexF8goxlac4xUOCE/OYW4/bFKgegQTfHFUMOOUqvxaADRC65c49OfrJJ9f
 NO/HYE4fpgiG5j+TpT6mcq9qg1mpI=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC 3/3] swupdate: Enable signed updates
Date: Thu, 13 Jul 2023 10:51:06 +0200
Message-Id: <20230713085106.2062587-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230713085106.2062587-1-Quirin.Gylstorff@siemens.com>
References: <20230713085106.2062587-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jul 2023 08:51:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12333

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

With this change SWUpdate requires signed binaries to update
the system. An update without the correct signature will lead to the
following error message:
```
Error: SWUpdate is built for signed images, provide a public key file.
```

If unsigned binaries are wanted readd the Build option
```
DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
```
to a swupdate_%.bbappend recipe

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-common.inc                | 1 +
 kas/opt/swupdate.yml                           | 2 ++
 recipes-core/customizations/files/swupdate.cfg | 1 +
 recipes-core/images/swupdate.inc               | 4 ++++
 recipes-core/swupdate/swupdate_2023.05.bb      | 3 +--
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 5d3ce10..a3d959f 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -14,3 +14,4 @@ KERNEL_NAME ?= "cip"
 WKS_FILE ?= "${MACHINE}.wks"
 
 CIP_IMAGE_OPTIONS ?= ""
+
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index b0293ce..0e30e89 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -28,3 +28,5 @@ local_conf_header:
     INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
     ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
+    PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
+    PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
diff --git a/recipes-core/customizations/files/swupdate.cfg b/recipes-core/customizations/files/swupdate.cfg
index 9ee47c7..3e2b45c 100644
--- a/recipes-core/customizations/files/swupdate.cfg
+++ b/recipes-core/customizations/files/swupdate.cfg
@@ -1,4 +1,5 @@
 globals :
 {
     bootloader = "ebg";
+    public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
 };
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 6a01abb..6b7da60 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -12,6 +12,10 @@
 inherit image_uuid
 inherit read-only-rootfs
 
+SWU_SIGNED = "1"
+SWU_SIGNATURE_TYPE = "cms"
+IMAGE_INSTALL += " swupdate-certificates"
+
 IMAGE_INSTALL += " swupdate"
 
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
index 26c0e67..d744173 100644
--- a/recipes-core/swupdate/swupdate_2023.05.bb
+++ b/recipes-core/swupdate/swupdate_2023.05.bb
@@ -31,8 +31,7 @@ SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
             file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
             file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
 
-# deactivate signing and hardware compability for simple a/b rootfs update
-DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
+# deactivate hardware compability for simple a/b rootfs update
 DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
 
 # suricatta wfx requires suricatta lua and the dependency
-- 
2.40.1


