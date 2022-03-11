Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20CBC433F5
	for <webhook@archiver.kernel.org>; Fri, 11 Mar 2022 14:57:10 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web09.6087.1647010629001140430
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Mar 2022 06:57:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=EcX6IIN4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-51332-20220311145705106df82b5bcb9a9add-fzz_ob@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220311145705106df82b5bcb9a9add
        for <cip-dev@lists.cip-project.org>;
        Fri, 11 Mar 2022 15:57:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=YKQXyYak8rR73azW3q+sq5mJQzw6MSlrOLgHbzXDW4w=;
 b=EcX6IIN4opILf+hBTjPDFue5rKcJl/JWrRejGox5yuJbep39UySwr4iCroBrlYSPQABTnD
 YJ+MfWp2D9VtNZrwgC9p58q/BgamZS9ajl2ApEyTIiL1GuU2TqPVWC5mKXvRMp6fLlnY4nsW
 Gv/DXkEGFqTLc4pnks5P/DMMkXxEs=;
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] efibootguard: Architecture
 independent installation
Date: Fri, 11 Mar 2022 15:57:04 +0100
Message-Id: <20220311145704.2436726-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <Jan.kiszka@siemens.com>
References: <Jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Mar 2022 14:57:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7695

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add globbing to install the efibootguard binary architecture independent.

Also adapt the wic plugin to use the build output.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-bsp/efibootguard/files/debian/efibootguard.install | 2 +-
 recipes-bsp/efibootguard/files/debian/efibootguard.links   | 1 -
 scripts/lib/wic/plugins/source/efibootguard-efi.py         | 6 ++++--
 3 files changed, 5 insertions(+), 4 deletions(-)
 delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.links

diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
index 0239953..462fc1d 100644
--- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
+++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
@@ -1,3 +1,3 @@
 bg_setenv usr/bin
 bg_printenv usr/bin
-efibootguardx64.efi usr/share/efibootguard
+efibootguard*.efi usr/share/efibootguard
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.links b/recipes-bsp/efibootguard/files/debian/efibootguard.links
deleted file mode 100644
index 97bab21..0000000
--- a/recipes-bsp/efibootguard/files/debian/efibootguard.links
+++ /dev/null
@@ -1 +0,0 @@
-usr/share/efibootguard/efibootguardx64.efi usr/share/efibootguard/bootx64.efi
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 858fcbf..9e6febe 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -59,7 +59,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
         }
 
         distro_arch = get_bitbake_var("DISTRO_ARCH")
-        bootloader = "/usr/share/efibootguard/boot{}.efi".format(
+        bootloader = "/usr/share/efibootguard/efibootguard{}.efi".format(
             distro_to_efi_arch[distro_arch])
         part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
                                              part.label,
@@ -67,7 +67,9 @@ class EfibootguardEFIPlugin(SourcePlugin):
         create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
         exec_cmd(create_dir_cmd)
 
-        name = os.path.basename(bootloader)
+        name = "boot{}.efi".format(
+            distro_to_efi_arch[distro_arch])
+
         signed_bootloader = cls._sign_file(name,
                                            bootloader,
                                            cr_workdir,
-- 
2.35.1


