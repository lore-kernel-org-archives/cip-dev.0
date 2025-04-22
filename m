Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1750C369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 14:51:06 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.41948.1745333458245814875
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 07:50:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=L6gfMjIF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2025042214505691f2cbec611d9de142-zekd_j@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025042214505691f2cbec611d9de142
        for <cip-dev@lists.cip-project.org>;
        Tue, 22 Apr 2025 16:50:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=PHld9uSID4e3BCNZfvLVwLcal47ZxFIYQ8hQ7R8RXuY=;
 b=L6gfMjIF4jvzNJZ6djlu7jyvgH59jhSG+foT4Q1tCEhdL3zSTfSDh+OdryH7Oci8X33MoS
 pGbfDa2uAHfA34xDYnjnJfqNwoNzrCSzj+5ct1HUDjG8aiKWNCv6jZwhY7XUYnKuKVBYp5zX
 KLUZM4P4QgJ2TEG6tA2Z748CsbwLUEmVpEf63w1X7ETmPfwI7ggR4ekp+OLATFwp4p9ePs1y
 v/OeHRfi/b9diDMO1JgE9UQ6eBT40ZmKgTyikFi5tad8LwVy+a9g6IFlLK9W2+AEIjgcKZ2J
 pnCDGlmHJZATJtXltd0EQA1SWVCsYr+f6XEPBLcAPbGGTTHOP0C8rxRQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 3/5] wic(ebg): add support to abrootfs env to cmdline
Date: Tue, 22 Apr 2025 16:35:24 +0200
Message-ID: <20250422145055.1095348-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
References: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 14:51:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18561

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This adds support similar to the verity environment

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../wic/plugins/source/efibootguard-boot.py   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index aa093e2..941634a 100644
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
@@ -172,6 +175,28 @@ class EfibootguardBootPlugin(SourcePlugin):
         sd_opts = {k: v for k, v in opts.items() if k in verity_sd_keys}
         return ",".join(["%s=%s" % (k, v) for k, v in sd_opts.items()])
 
+    @classmethod
+    def _get_abrootfs_opts(cls):
+        abrootfs_sd_keys = ["target-image-uuid"]
+        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
+        image_basename = get_bitbake_var("IMAGE_BASENAME")
+        abrootfsenv = None
+        opts = {}
+        for file in os.listdir(deploy_dir):
+            if fnmatch.fnmatch(file, f'{image_basename}*.uuid.env'):
+                abrootfsenv = os.path.join(deploy_dir, file)
+                break
+        if not abrootfsenv:
+            msger.error("abrootfs env file '%s.uuid.env' not found  in directory %s", image_basename, deploy_dir)
+            exit(1)
+        with open(abrootfsenv, "r") as venv:
+            for line in venv:
+                k, v = line.strip().split("=")
+                sd_key = k.replace("_", "-").lower()
+                opts[sd_key] = v
+        sd_opts = {k: v for k, v in opts.items() if k in abrootfs_sd_keys}
+        return ",".join(["%s=%s" % (k, v) for k, v in sd_opts.items()])
+
     @classmethod
     def _create_img(cls, part_rootfs_dir, part, cr_workdir,
                     native_sysroot, oe_builddir):
-- 
2.47.0


