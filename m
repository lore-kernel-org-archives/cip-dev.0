Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F63C35295
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.3488.1649834202281066312
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=EOGFK/rn;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20220413071640b78ba512f07487a7a8-2ahpfq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20220413071640b78ba512f07487a7a8
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=z9vykiiqCX8cdOtZPQpLGv/qrK03N21sWGHgkGf2JDI=;
 b=EOGFK/rnrJ513xNJZq7GhcRPrFMnCUkbpTNRd1F2b2QxgvhpU0V/x0tqooHpiHGcTF7yph
 bm/YHiULR2i4DpmjeSYvRiB+j/jUN8BKe//20QxZyOrckdqUptzwlElcx2ICMv1yHwdOtChF
 hTX2NujuuZ1kOQ1HJtIaB5B/+vuU8=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 09/19] efibootguard: Avoid rename linux.efi
 when signing it
Date: Wed, 13 Apr 2022 09:16:26 +0200
Message-Id: 
 <49780064267568514aa991e83602edc83ca2dbeb.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8058

From: Jan Kiszka <jan.kiszka@siemens.com>

This will simplify handling of secure vs. non-secure configurations.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/secure-boot/sw-description.tmpl     |  4 ++--
 recipes-core/images/secureboot.inc            |  2 +-
 .../swupdate.handler.efibootguard.ini         |  2 +-
 .../wic/plugins/source/efibootguard-boot.py   | 20 +++++++++----------
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/recipes-core/images/files/secure-boot/sw-description.tmpl b/recipes-core/images/files/secure-boot/sw-description.tmpl
index f8e5375..7dc070a 100644
--- a/recipes-core/images/files/secure-boot/sw-description.tmpl
+++ b/recipes-core/images/files/secure-boot/sw-description.tmpl
@@ -23,8 +23,8 @@ software =
             };
     });
     files: ({
-            filename = "linux.signed.efi";
-            path = "linux.signed.efi";
+            filename = "linux.efi";
+            path = "linux.efi";
             type = "roundrobin";
             device = "sda4->BOOT0,sda5->BOOT1";
             filesystem = "vfat";
diff --git a/recipes-core/images/secureboot.inc b/recipes-core/images/secureboot.inc
index e01c834..6182080 100644
--- a/recipes-core/images/secureboot.inc
+++ b/recipes-core/images/secureboot.inc
@@ -18,4 +18,4 @@ TEMPLATE_FILES += "sw-description.tmpl"
 
 TEMPLATE_VARS += "ROOTFS_PARTITION_NAME"
 
-SWU_ADDITIONAL_FILES += "linux.signed.efi ${ROOTFS_PARTITION_NAME}"
+SWU_ADDITIONAL_FILES += "linux.efi ${ROOTFS_PARTITION_NAME}"
diff --git a/recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini
index 4a109b7..b5e8070 100644
--- a/recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini
+++ b/recipes-core/swupdate-handler-roundrobin/files/secureboot/swupdate.handler.efibootguard.ini
@@ -13,4 +13,4 @@ method=getroot_rrmap
 key=root
 
 [kernel.bootenv]
-kernelfile=C:BOOT${rrindex}:linux.signed.efi
+kernelfile=C:BOOT${rrindex}:linux.efi
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 4291dc2..909e629 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -215,23 +215,21 @@ class EfibootguardBootPlugin(SourcePlugin):
                 uefi_kernel_file=uefi_kernel_file)
         exec_cmd(objcopy_cmd)
 
-        return cls._sign_file(name=uefi_kernel_name,
-                              signee=uefi_kernel_file,
-                              deploy_dir=deploy_dir,
-                              source_params=source_params)
+        cls._sign_file(signee=uefi_kernel_file, source_params=source_params)
+
+        return uefi_kernel_name
 
     @classmethod
-    def _sign_file(cls, name, signee, deploy_dir, source_params):
+    def _sign_file(cls, signee, source_params):
         sign_script = source_params.get("signwith")
         if sign_script and os.path.exists(sign_script):
             msger.info("sign with script %s", sign_script)
-            name = name.replace(".efi", ".signed.efi")
-            sign_cmd = "{sign_script} {signee} {deploy_dir}/{name}"\
-                .format(sign_script=sign_script, signee=signee,
-                        deploy_dir=deploy_dir, name=name)
+            orig_signee = signee + ".unsigned"
+            os.rename(signee, orig_signee)
+            sign_cmd = "{sign_script} {orig_signee} {signee}"\
+                .format(sign_script=sign_script, orig_signee=orig_signee,
+                        signee=signee)
             exec_cmd(sign_cmd)
         elif sign_script and not os.path.exists(sign_script):
             msger.error("Could not find script %s", sign_script)
             exit(1)
-
-        return name
-- 
2.34.1


