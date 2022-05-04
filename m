Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF46C4321E
	for <webhook@archiver.kernel.org>; Wed,  4 May 2022 19:46:09 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web12.2023.1651693566802373541
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 May 2022 12:46:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Uj2sLAIr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227,
 mailfrom: fm-294854-202205041946044bf71131ee6c35bd03-a3cm_s@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202205041946044bf71131ee6c35bd03
        for <cip-dev@lists.cip-project.org>;
        Wed, 04 May 2022 21:46:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Os7DwWJ48PSv/+q6Mdp3FPbrrSioPLM9dM0Bi/18Eyg=;
 b=Uj2sLAIr9QsTkD77T+jnWrk3hqfYr59PY6AI+ahWuigqrlQuJlEZx+dz5NidylIorHdyuk
 D3Akkyg5FELZkIkaMT+JYuF0hTV/72ccwnHBhPXuuhvypntYS4kH2ydLagV4Yd8/0thiJj/9
 tFNAguNoQv7qLF6PVpkltjh5g7WQ8=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 09/12] efibootguard: Add support for embedding
 DTBs into unified kernel images
Date: Wed,  4 May 2022 21:45:57 +0200
Message-Id: 
 <8cbe5c3d5cef17b4f1c062ade722003413250617.1651693560.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1651693560.git.jan.kiszka@siemens.com>
References: <cover.1651693560.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 May 2022 19:46:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8245

From: Jan Kiszka <jan.kiszka@siemens.com>

Pick up the DTBs specified via DTB_FILES and embed them into the unified
kernel image that the wic plugin can generate. This does not work for
normal kernels, so bail out if DTB_FILES is set in that mode.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/efibootguard.yml                          |  2 +-
 .../lib/wic/plugins/source/efibootguard-boot.py   | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index 2d84427..c71cdb3 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -23,7 +23,7 @@ local_conf_header:
   efibootguard-wic: |
     WIC_IMAGER_INSTALL_append = " efibootguard"
     WDOG_TIMEOUT ?= "60"
-    WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE"
+    WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
     IMAGE_FSTYPES ?= "wic-img"
     WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
 
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index f71dbb0..f0a21a2 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -66,10 +66,12 @@ class EfibootguardBootPlugin(SourcePlugin):
             initrd_image = "initrd.img"
         bootloader = creator.ks.bootloader
 
+        dtb_files = (get_bitbake_var("DTB_FILES") or '').split()
+
         deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
         if not deploy_dir:
             msger.error("DEPLOY_DIR_IMAGE not set, exiting\n")
-            sys.exit(1)
+            exit(1)
         creator.deploy_dir = deploy_dir
 
         wdog_timeout = get_bitbake_var("WDOG_TIMEOUT")
@@ -88,9 +90,13 @@ class EfibootguardBootPlugin(SourcePlugin):
                                                           deploy_dir,
                                                           kernel_image,
                                                           initrd_image,
+                                                          dtb_files,
                                                           source_params)
             boot_files.append(boot_image)
         else:
+            if dtb_files:
+                msger.error("DTB_FILES specified while unified kernel is disabled\n")
+                exit(1)
             root_dev = source_params.get("root", None)
             if not root_dev:
                 msger.error("Specify root in source params")
@@ -173,7 +179,7 @@ class EfibootguardBootPlugin(SourcePlugin):
     @classmethod
     def _create_unified_kernel_image(cls, rootfs_dir, cr_workdir, cmdline,
                                      deploy_dir, kernel_image, initrd_image,
-                                     source_params):
+                                     dtb_files, source_params):
         # we need to map the distro_arch to uefi values
         distro_to_efi_arch = {
             "amd64": "x64",
@@ -198,6 +204,11 @@ class EfibootguardBootPlugin(SourcePlugin):
                 initrd=initrd,
                 efistub=efistub,
                 uefi_kernel_file=uefi_kernel_file)
+        if dtb_files:
+            for dtb in dtb_files:
+                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
+                    deploy_dir=deploy_dir,
+                    dtb_file=os.path.basename(dtb))
         exec_cmd(cmd, as_shell=True)
 
         cls._sign_file(signee=uefi_kernel_file, source_params=source_params)
-- 
2.34.1


