Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64359C369D5
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 12:41:39 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.47169.1745844091130443970
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 05:41:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=fpkGoSp3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20250428124128810c4cb930d2960807-zizxqd@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250428124128810c4cb930d2960807
        for <cip-dev@lists.cip-project.org>;
        Mon, 28 Apr 2025 14:41:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=uXUKn8yWiwfAp5wjsUrZoI/2OhEncfnGVODCgsRFJsk=;
 b=fpkGoSp3qYdPgZ+bu/CoGOuJYRFZFmubsfkhuXP3+/hnjkCSW4SgBFI/vcIH+RuAaYpsVl
 Z+mVP+Zi6qF7HbEEjcuNRTM0yqpXWVhl0XZ2qbUQNDwXUXL3Wxbm9M9nJqUWKJVFJ9ifHG67
 WSr5AkS/BvvZFakpxAmDdc5SfNET8eSEXDNNtI9S88RI+u51T5GtOaa8FKLhvJtY7d+HSqbO
 vvzf0ojZGFaiw6QhJzM/xRXJUSOmZ7jtEti+C9xBovDpHkHCf+jzlZ5hwE6ckjuG/ALnF8nt
 ILd64rRIjeXRG+b4df40zpkYGMSqHwi7xX0VGLw+aSr8SAg+UxUYa2gg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] wic: Add the variable `UKI_FILENAME` to change the UKI name.
Date: Mon, 28 Apr 2025 14:41:14 +0200
Message-ID: <20250428124127.3228991-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 12:41:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18702

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows in case of a unified kernel(UKI) image based installer
to differ between the installer UKI and the target UKI.

It also allows the build of multiple images for the same target
architecture or update file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v2:
 - Change subject
 - Rename variable to `UKI_FILENAME` same as used in poky uki.bbclass
   https://git.yoctoproject.org/poky/tree/meta/classes-recipe/uki.bbclass
 - Add missing WICVARS

 classes/efibootguard.bbclass                        | 2 +-
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
index b130968..422d427 100644
--- a/classes/efibootguard.bbclass
+++ b/classes/efibootguard.bbclass
@@ -12,7 +12,7 @@
 IMAGE_INSTALL:append = " efibootguard libebgenv0"
 IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
-WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH"
+WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
 IMAGE_TYPEDEP:swu:append = " wic"
 
 def distro_to_efi_arch(d):
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 8b1097f..aeb9328 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -178,7 +178,7 @@ class EfibootguardBootPlugin(SourcePlugin):
             .format(rootfs_path=rootfs_path,
                     libpath=libarch,
                     efiarch=efiarch)
-        uefi_kernel_name = "linux.efi"
+        uefi_kernel_name = get_bitbake_var('UKI_FILENAME') or 'linux.efi'
         uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
             .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
         kernel = "{deploy_dir}/{kernel_image}"\
-- 
2.47.0


