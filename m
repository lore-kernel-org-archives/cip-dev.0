Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B2ED1713D
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 11:33:24 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.16201.1729596802883649897
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Oct 2024 04:33:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=JXPZX0xX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2024102211331804b34ae9556c290f8e-xqnpi_@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024102211331804b34ae9556c290f8e
        for <cip-dev@lists.cip-project.org>;
        Tue, 22 Oct 2024 13:33:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=vJoXCgYIQclSqCs54Z6bAQMrdP4lRxVYcqhzzVYq7do=;
 b=JXPZX0xX/oRBrQX7u9P5e6nU1rTFx1Y0Xzis94uFkc9gxnMHS/S09m0OliBpQADBDmvoFf
 TsOuVTFZh5koGtapTe5vT0hirxqmSAZWSBmBdoB1uw+vAHZG+E4P1Mv5+iakeJLqLKFh1KZR
 JdxwtWhma8b2HXzobtqAFobukOwmrQrSJy8++Q1dZvni1bgAXiVkU8kHZ6qj4Mbe0DWNE0nX
 nEITxSKHTjiOKklH91rvVGSJxG6pQh9B8cWpXZAY0bqXAOEt4nS5RdFdT5xIHP3bdh8lVv9p
 eIUZDGVc6jQtymz8rQzPyQY1/o4rHUUxSieBXorwp8yHyKVOv7WwlaTg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] efibootguard-boot.py: Add option to build without initrd
Date: Tue, 22 Oct 2024 13:20:07 +0200
Message-ID: <20241022113317.1493580-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Oct 2024 11:33:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17067

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Some devices have no initrd, due to space or other contstrains.
If the option `no_initrd=y` is set the boot partition
or unified kernel image[1] will not contain the optional initrd.

[1]: https://github.com/uapi-group/specifications/blob/main/specs/unified_kernel_image.md#uki-components

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 2b06fd1..221297e 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -60,10 +60,13 @@ class EfibootguardBootPlugin(SourcePlugin):
             kernel_image = "vmlinuz"
         boot_image = kernel_image
 
+        no_initrd = source_params.get("no_initrd")
         initrd_image = get_bitbake_var("INITRD_DEPLOY_FILE")
         if not initrd_image:
             msger.warning("INITRD_DEPLOY_FILE not set\n")
             initrd_image = "initrd.img"
+        if no_initrd:
+            initrd_image = None
         bootloader = creator.ks.bootloader
 
         dtb_files = (get_bitbake_var("DTB_FILES") or '').split()
@@ -179,15 +182,16 @@ class EfibootguardBootPlugin(SourcePlugin):
             .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
         kernel = "{deploy_dir}/{kernel_image}"\
             .format(deploy_dir=deploy_dir, kernel_image=kernel_image)
-        initrd = "{deploy_dir}/{initrd_image}"\
-            .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
         cmd = 'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_file} \
-            -c "{cmdline}" -i {initrd}'.format(
+            -c "{cmdline}"'.format(
                 cmdline=cmdline,
                 kernel=kernel,
-                initrd=initrd,
                 efistub=efistub,
                 uefi_kernel_file=uefi_kernel_file)
+        if initrd_image:
+            initrd = "{deploy_dir}/{initrd_image}"\
+                .format(deploy_dir=deploy_dir, initrd_image=initrd_image)
+            cmd += ' -i {initrd}'.format(initrd=initrd)
         if dtb_files:
             for dtb in dtb_files:
                 cmd += ' -d {deploy_dir}/{dtb_file}'.format(
-- 
2.45.2


