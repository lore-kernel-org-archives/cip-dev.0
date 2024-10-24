Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7900BCE8E8C
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 15:43:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.17786.1729784598012311223
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Oct 2024 08:43:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=NIe8Kevv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20241024154314a750196605a5033ad6-mpzzqj@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241024154314a750196605a5033ad6
        for <cip-dev@lists.cip-project.org>;
        Thu, 24 Oct 2024 17:43:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=PeRYQGXhly4upoZD2ynB1OR/IgY6lx1ylqagjX4M1Xc=;
 b=NIe8KevvCD2XebTM1Ss2injOKYecFcmScillDSwIZj6tBVbeQhsDYhPXGNWAm0fdNwPsbu
 LL8MU2T2nELSFLjTHERtQRGTXw/c9iTI1IkovAoxR8EC597pTLbvIi7quTfcwm3GoridMOkT
 QixA6UCpcKki+1itOqIUtM4ZSERhm8r/SpEwmUeVSsUJ2XV0R61d223Fr3zoKwqxoKMxAv/I
 AB4GiSMsARj1YvT4XYMHEd51DAQEraZirGIcT5nSQIXFtyLls8g30FhTcN1LsS/NI/fvIzAb
 kMxU9Gr7RikgUeeB5mwmCOIy4Mosp75e5jixtZN3gVf1w41zkke0j2iw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] efibootguard-boot.py: Add option to build without initrd
Date: Thu, 24 Oct 2024 17:42:55 +0200
Message-ID: <20241024154313.2597583-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Oct 2024 15:43:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17078

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Some devices have no initrd, due to space or other constrains.
If the option `no_initrd=y` is set the boot partition
or unified kernel image[1] will not contain the optional initrd.

[1]: https://github.com/uapi-group/specifications/blob/main/specs/unified_kernel_image.md#uki-components

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - fix typo in commit message
 - check value of no_initrd instead of not None.
 - do not evaluate bitbake variable INITRD_DEPLOY_FILE if no_initrd is
   set to 'y'
 .../wic/plugins/source/efibootguard-boot.py   | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 2b06fd1..8b1097f 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -60,10 +60,14 @@ class EfibootguardBootPlugin(SourcePlugin):
             kernel_image = "vmlinuz"
         boot_image = kernel_image
 
-        initrd_image = get_bitbake_var("INITRD_DEPLOY_FILE")
-        if not initrd_image:
-            msger.warning("INITRD_DEPLOY_FILE not set\n")
-            initrd_image = "initrd.img"
+        no_initrd = source_params.get("no_initrd") or 'n'
+        if no_initrd == 'y':
+            initrd_image = None
+        else:
+            initrd_image = get_bitbake_var("INITRD_DEPLOY_FILE")
+            if not initrd_image:
+                msger.warning("INITRD_DEPLOY_FILE not set\n")
+                initrd_image = "initrd.img"
         bootloader = creator.ks.bootloader
 
         dtb_files = (get_bitbake_var("DTB_FILES") or '').split()
@@ -179,15 +183,16 @@ class EfibootguardBootPlugin(SourcePlugin):
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


