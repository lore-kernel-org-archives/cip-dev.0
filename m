Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3974CC6FD18
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 10:29:39 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.34112.1681900170830785368
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Apr 2023 03:29:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=VTgTO+np;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2023041910292773fd8417fe0e47e5a1-doxa_b@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023041910292773fd8417fe0e47e5a1
        for <cip-dev@lists.cip-project.org>;
        Wed, 19 Apr 2023 12:29:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=OvXBq9BW/Z+WdagUSwHkR/V8YVuaTBrkgZLAilGuFBs=;
 b=VTgTO+npjBXWOu4Tm8h6vp8b3YOPbL+GrFu+ouBmWsdxs4gnMeELsVCRGu6uSTf50DP/vW
 UIxwcDPxdi/Eg1/GfXp6LMvptn8t5HjlkfTDB26G+8hUwYZgF9h2d4ZMugCtDjw8/9fEyjmK
 7JhX1kGYDnbaw2sU8yQTu5R28XYac=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] wic: Use INITRD_DEPLOY_FILE instead IMAGE_INITRD
Date: Wed, 19 Apr 2023 12:29:26 +0200
Message-Id: <20230419102926.1331225-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Apr 2023 10:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11230

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

With commit https://github.com/ilbers/isar/commit/f0608683fd18f96319332f2ea3827536bd2fd761 the variable
INITRD_DEPLOY_FILE should be used for creating the wic image,  see [1].

[1]: https://github.com/ilbers/isar/blob/master/RECIPE-API-CHANGELOG.md#working-with-a-custom-initramfs

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/efibootguard.inc                | 2 +-
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
index cdf5558..1de452a 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -12,5 +12,5 @@
 IMAGE_INSTALL:append = " efibootguard"
 WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
-WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
+WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
 IMAGE_FSTYPES += "wic"
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 0de28ca..7435b22 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -60,9 +60,9 @@ class EfibootguardBootPlugin(SourcePlugin):
             kernel_image = "vmlinuz"
         boot_image = kernel_image
 
-        initrd_image = get_bitbake_var("INITRD_IMAGE")
+        initrd_image = get_bitbake_var("INITRD_DEPLOY_FILE")
         if not initrd_image:
-            msger.warning("INITRD_IMAGE not set\n")
+            msger.warning("INITRD_DEPLOY_FILE not set\n")
             initrd_image = "initrd.img"
         bootloader = creator.ks.bootloader
 
-- 
2.39.2


