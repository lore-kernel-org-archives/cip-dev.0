Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FE5C369DC
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 11:33:38 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.45921.1745840010191341318
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 04:33:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=K6/dLCKh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2025042811332755fbda1525ff1eb363-io1x_d@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025042811332755fbda1525ff1eb363
        for <cip-dev@lists.cip-project.org>;
        Mon, 28 Apr 2025 13:33:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=QD6TqumoRvbQINXamXkpcNNvTAZpMP8YzopaxY3Y0uU=;
 b=K6/dLCKhGZjD0aHt79dsmvuFMCSdCToRQv3sTRw06s1k1II/HWH7ym1EaFxZllI24RWprn
 TULMriemjun9CQEuFadJgZByNyUJwx+L3AYH7IVHwt5w+XZV1rqeJLHSHcFLT6vVpVNk0Xwm
 Da4qcyGBfAI3+0xf1vViJd3CdaFB2yAcnFmM2uInLlpdDlyDBVDVn4PZGIS8rOpe7YUZGxG7
 p3Q+c3MaI6P4fi6chYjwN0NGosD0qvEnlFnv6BMyJtuAfjNqul15vy0JMezH2tnbxI+0s0mN
 O9wIlX8SPoi7zHcH0WfKhFxnYg/RO4FMefe2pnjQy7raPB6LmMibm3eQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 1/4] wic(ebg): add support to add verity env to cmdline
Date: Mon, 28 Apr 2025 13:32:43 +0200
Message-ID: <20250428113325.3208873-2-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18696

From: Felix Moessbauer <felix.moessbauer@siemens.com>

Passing the verity data via the initrd has proven problematic, as this
requires to rebuild the initrd on each (bitwise) change of the verity
container. For use cases with not bit-by-bit reproducible rootfs this
can lead to verity hash inconsistencies as the bitbake state diverges
from the file state in case some task artifacts are taken from the
SState cache. Further, the build time is prolonged as on every rootfs
change also the initfs needs to be rebuild (also polluting the SState
cache with not-reusable entries).

We now change this by adding the verity data to the kernel cmdline
(similar to how systemd envisions this). The ebg-boot wic plugin
already adds information about the imaged partitions to the kernel
cmdline of the UKI (or config). We now add support to add the verity
environment by setting the source parameter "verity_root=y". The
environment is read from the images *.verity.env file, converted
into the systemd-veritysetup-generator syntax and added to the
command line. As we currently do not use the systemd integration, we
use the parameter "cip.verity_root_options" instead. Later on this
can be replaced by "systemd.verity_root_options".

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
[Quirin: add IMAGE_BASENAME to search for correct verity.env ]
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../wic/plugins/source/efibootguard-boot.py   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 8b1097f..5e8c98a 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -87,6 +87,10 @@ class EfibootguardBootPlugin(SourcePlugin):
         boot_files = source_params.get("files", "").split(' ')
         unified_kernel = source_params.get("unified-kernel") or 'y'
         cmdline = bootloader.append or ''
+        # the verity cmdline format is identical to systemd.verity_root_options
+        if source_params.get("verity_root") == 'y':
+            cmdline += " cip.verity_root_options=panic-on-corruption,%s" \
+                % cls._get_verity_opts()
         if unified_kernel == 'y':
             boot_image = cls._create_unified_kernel_image(rootfs_dir,
                                                           cr_workdir,
@@ -143,6 +147,32 @@ class EfibootguardBootPlugin(SourcePlugin):
         cls._create_img(part_rootfs_dir, part, cr_workdir,
                         native_sysroot, oe_builddir)
 
+    @classmethod
+    def _get_verity_opts(cls):
+        verity_sd_keys = ["data-block-size", "hash-block-size", "data-blocks",
+                          "hash-offset", "salt", "uuid", "hash"]
+        opts = {}
+        image_basename = get_bitbake_var("IMAGE_BASENAME")
+        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
+        verityenv = None
+        for file in os.listdir(deploy_dir):
+            if fnmatch.fnmatch(file, f'{image_basename}*.verity.env'):
+                verityenv = os.path.join(deploy_dir, file)
+                break
+        if not verityenv:
+            msger.error("No verity env file found in directory %s", deploy_dir)
+            exit(1)
+        with open(verityenv, "r") as venv:
+            for line in venv:
+                k, v = line.strip().split("=")
+                if k == "ROOT_HASH":
+                    sd_key = "hash"
+                else:
+                    sd_key = k.replace("_", "-").lower()
+                opts[sd_key] = v
+        sd_opts = {k: v for k, v in opts.items() if k in verity_sd_keys}
+        return ",".join(["%s=%s" % (k, v) for k, v in sd_opts.items()])
+
     @classmethod
     def _create_img(cls, part_rootfs_dir, part, cr_workdir,
                     native_sysroot, oe_builddir):
-- 
2.47.0


