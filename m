Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8113C47DA9
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 20:00:26 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.2405.1705003220451501479
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 12:00:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=h5sklNxT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240111200017b9d68edccb10b591c4-kx_pvr@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240111200017b9d68edccb10b591c4
        for <cip-dev@lists.cip-project.org>;
        Thu, 11 Jan 2024 21:00:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=TZc2OSnj7nlDmj8kT/le4UtKgcgOM83kTxJO/e8gVwc=;
 b=h5sklNxT9UOTwQ3DsxcpvYsklCVqVaDf0tB6Pt5eGkhCGuDdg1F1NIW61eGZgXlsRfW8qS
 iYGxElKpTLFrq/+2ObiGix569yf/+fTSiI+HPVoZFv9AF45ul+rZD0H3Xrc2Sr8VIAvFlkO6
 cMZjdwfYlO3xcYPyKiTUu6nAxqcS8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 2/7] efibootguard.bbclass: Add functions to generate the EFI_ARCH and EFI_LIB_ARCH
Date: Thu, 11 Jan 2024 20:59:46 +0100
Message-ID: <20240111200015.190376-3-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14341

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This reduces duplicated code.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/efibootguard.bbclass                  | 28 ++++++++++++-
 .../wic/plugins/source/efibootguard-boot.py   | 29 +++++---------
 .../wic/plugins/source/efibootguard-efi.py    | 40 +++++++++----------
 3 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
index 5a8a39b..26291b7 100644
--- a/classes/efibootguard.bbclass
+++ b/classes/efibootguard.bbclass
@@ -12,5 +12,31 @@
 IMAGE_INSTALL:append = " efibootguard libebgenv0"
 IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
-WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
+WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH"
 IMAGE_TYPEDEP:swu:append = " wic"
+
+def distro_to_efi_arch(d):
+    DISTRO_TO_EFI_ARCH = {
+        "amd64": "x64",
+        "arm64": "aa64",
+        "armhf": "arm",
+        "i386": "ia32",
+        "riscv64": "riscv64"
+    }
+    distro_arch = d.getVar('DISTRO_ARCH')
+    return DISTRO_TO_EFI_ARCH[distro_arch]
+
+EFI_ARCH := "${@distro_to_efi_arch(d)}"
+
+def distro_to_lib_arch(d):
+    DISTRO_TO_LIB_ARCH = {
+        "amd64": "x86_64-linux-gnu",
+        "arm64": "aarch64-linux-gnu",
+        "armhf": "arm-linux-gnueabihf",
+        "i386": "i386-linux-gnu",
+        "riscv64": "riscv64-linux-gnu",
+    }
+    distro_arch = d.getVar('DISTRO_ARCH')
+    return DISTRO_TO_LIB_ARCH[distro_arch]
+
+EFI_LIB_ARCH := "${@distro_to_lib_arch(d)}"
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 9892572..4e3aefb 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -180,27 +180,20 @@ class EfibootguardBootPlugin(SourcePlugin):
     def _create_unified_kernel_image(cls, rootfs_dir, cr_workdir, cmdline,
                                      deploy_dir, kernel_image, initrd_image,
                                      dtb_files, source_params):
-        # we need to map the distro_arch to uefi values
-        distro_to_efi_arch = {
-            "amd64": "x64",
-            "arm64": "aa64",
-            "armhf": "arm",
-            "i386": "ia32",
-            "riscv64" : "riscv64"
-        }
-        distro_to_lib_arch = {
-            "amd64": "x86_64-linux-gnu",
-            "arm64": "aarch64-linux-gnu",
-            "armhf": "arm-linux-gnueabihf",
-            "i386": "i386-linux-gnu",
-            "riscv64": "riscv64-linux-gnu",
-        }
         rootfs_path = rootfs_dir.get('ROOTFS_DIR')
-        distro_arch = get_bitbake_var("DISTRO_ARCH")
+        efiarch = get_bitbake_var("EFI_ARCH")
+        if not efiarch:
+            msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
+            exit(1)
+        libarch = get_bitbake_var("EFI_LIB_ARCH")
+        if not libarch:
+            msger.error("Bitbake variable 'EFI_LIB_ARCH' not set, exiting\n")
+            exit(1)
+
         efistub = "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
             .format(rootfs_path=rootfs_path,
-                    libpath=distro_to_lib_arch[distro_arch],
-                    efiarch=distro_to_efi_arch[distro_arch])
+                    libpath=libarch,
+                    efiarch=efiarch)
         uefi_kernel_name = "linux.efi"
         uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
             .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 86a22e0..9bb6347 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -51,35 +51,31 @@ class EfibootguardEFIPlugin(SourcePlugin):
         populate an EFI boot partition containing the EFI Boot Guard
         bootloader binary.
         """
-        # we need to map the distro_arch to uefi values
-        distro_to_efi_arch = {
-            "amd64": "x64",
-            "arm64": "aa64",
-            "armhf": "arm",
-            "i386": "ia32",
-            "riscv64" : "riscv64"
-        }
-
-        distro_to_lib_arch = {
-            "amd64": "x86_64-linux-gnu",
-            "arm64": "aarch64-linux-gnu",
-            "armhf": "arm-linux-gnueabihf",
-            "i386": "i386-linux-gnu",
-            "riscv64": "riscv64-linux-gnu",
-        }
-
-        distro_arch = get_bitbake_var("DISTRO_ARCH")
+        efiarch = get_bitbake_var("EFI_ARCH")
+        if not efiarch:
+            msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
+            exit(1)
+        libarch = get_bitbake_var("EFI_LIB_ARCH")
+        if not libarch:
+            msger.error("Bitbake variable 'EFI_LIB_ARCH' not set, exiting\n")
+            exit(1)
+
+        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
+        if not deploy_dir:
+            msger.error("DEPLOY_DIR_IMAGE not set, exiting\n")
+            exit(1)
+        creator.deploy_dir = deploy_dir
+
         bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
-            libpath=distro_to_lib_arch[distro_arch],
-            efiarch=distro_to_efi_arch[distro_arch])
+                        libpath=libarch,
+                        efiarch=efiarch)
         part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
                                              part.label,
                                              part.lineno)
         create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
         exec_cmd(create_dir_cmd)
 
-        name = "boot{}.efi".format(
-            distro_to_efi_arch[distro_arch])
+        name = "boot{}.efi".format(efiarch)
 
         signed_bootloader = cls._sign_file(name,
                                            bootloader,
-- 
2.43.0


