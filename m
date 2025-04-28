Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DB7C369D8
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 11:33:38 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.45920.1745840009954601119
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 04:33:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=DGZ9y0E8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20250428113327d0d80c35213f7d9da6-jf_ta5@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250428113327d0d80c35213f7d9da6
        for <cip-dev@lists.cip-project.org>;
        Mon, 28 Apr 2025 13:33:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=i/+c5so7t6aNHsD+W6Ys9tBXQA8gDyI/1wJ4t3v1fsY=;
 b=DGZ9y0E8YKN+uqlrKYFsblhXyyr/55X8OxFc6NuBAx5JucYneL2jDKaUQlwo98IaPqRTrM
 64NbIE93RGSZmAYqB5irIbqH9CEGYqlLdFW4GUPKdUnvrp+RFQ63mIcffZfUPfDB5FtoLrl3
 Vkj6/HvtudfuclvPwImqRYYnbGJh3TBZnNIVlu61u/zZ3oME95n6JrPFrpNL0hAlZiOPGEd2
 axkhezrSJ7NPx2o+9kXNIXWfxv/wEci9b6BKPilTbZ4DmZS/eSYmoW+YREIvgLyt1WGwXnWx
 SgTdvGJfBqdP5vIlIRmrZkREBUd9UrVGPlItX00D/S7644L0TQRMowEg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 3/4] wic(ebg): add support to abrootfs env to cmdline
Date: Mon, 28 Apr 2025 13:32:45 +0200
Message-ID: <20250428113325.3208873-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250428113325.3208873-1-Quirin.Gylstorff@siemens.com>
References: <20250428113325.3208873-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 11:33:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18697

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds support similar to the verity environment.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../wic/plugins/source/efibootguard-boot.py   | 53 +++++++++++++------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 5e8c98a..8dcb9a9 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -91,6 +91,9 @@ class EfibootguardBootPlugin(SourcePlugin):
         if source_params.get("verity_root") == 'y':
             cmdline += " cip.verity_root_options=panic-on-corruption,%s" \
                 % cls._get_verity_opts()
+        if source_params.get("abrootfs_root") == 'y':
+            cmdline += " cip.abrootfs_root_options=%s" \
+                % cls._get_abrootfs_opts()
         if unified_kernel == 'y':
             boot_image = cls._create_unified_kernel_image(rootfs_dir,
                                                           cr_workdir,
@@ -148,30 +151,48 @@ class EfibootguardBootPlugin(SourcePlugin):
                         native_sysroot, oe_builddir)
 
     @classmethod
-    def _get_verity_opts(cls):
-        verity_sd_keys = ["data-block-size", "hash-block-size", "data-blocks",
-                          "hash-offset", "salt", "uuid", "hash"]
+    def _generate_kernel_opts_from_file(cls, filename, keys):
+        env_file = None
         opts = {}
-        image_basename = get_bitbake_var("IMAGE_BASENAME")
         deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
-        verityenv = None
         for file in os.listdir(deploy_dir):
-            if fnmatch.fnmatch(file, f'{image_basename}*.verity.env'):
-                verityenv = os.path.join(deploy_dir, file)
+            if fnmatch.fnmatch(file, filename):
+                env_file = os.path.join(deploy_dir, file)
                 break
-        if not verityenv:
-            msger.error("No verity env file found in directory %s", deploy_dir)
+        if not env_file:
+            msger.error("File '%s' not found in directory %s", filename, deploy_dir)
             exit(1)
-        with open(verityenv, "r") as venv:
+        with open(env_file, "r") as venv:
             for line in venv:
                 k, v = line.strip().split("=")
-                if k == "ROOT_HASH":
-                    sd_key = "hash"
-                else:
-                    sd_key = k.replace("_", "-").lower()
+                sd_key = k.replace("_", "-").lower()
                 opts[sd_key] = v
-        sd_opts = {k: v for k, v in opts.items() if k in verity_sd_keys}
-        return ",".join(["%s=%s" % (k, v) for k, v in sd_opts.items()])
+        return {k: v for k, v in opts.items() if k in keys}
+
+    @classmethod
+    def _get_verity_opts(cls):
+        verity_sd_keys = ["data-block-size", "hash-block-size", "data-blocks",
+                          "hash-offset", "salt", "uuid", "root-hash"]
+        image_basename = get_bitbake_var("IMAGE_BASENAME")
+        opts = cls._generate_kernel_opts_from_file(f'{image_basename}*.verity.env',
+                                               verity_sd_keys)
+        cmdline=[]
+        # fixup for root-hash to avoid an error in the initramfs search for the
+        # root option in the kernel cmdline
+        for k,v in opts.items():
+            if k == 'root-hash':
+                cmdline.append(f'hash={v}')
+            else:
+                cmdline.append(f'{k}={v}')
+        return ",".join(cmdline)
+
+    @classmethod
+    def _get_abrootfs_opts(cls):
+        abrootfs_sd_keys = ["target-image-uuid"]
+        image_basename = get_bitbake_var("IMAGE_BASENAME")
+        opts = cls._generate_kernel_opts_from_file(f'{image_basename}*.uuid.env',
+                                                   abrootfs_sd_keys)
+        return ",".join(["%s=%s" % (k, v) for k, v in opts.items()])
 
     @classmethod
     def _create_img(cls, part_rootfs_dir, part, cr_workdir,
-- 
2.47.0


