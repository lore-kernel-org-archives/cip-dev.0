Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA37CC369D3
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 14:51:06 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.41950.1745333458533267985
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 07:50:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=GjdYYJSL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202504221450557c55076f12d670e386-vzpjwf@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202504221450557c55076f12d670e386
        for <cip-dev@lists.cip-project.org>;
        Tue, 22 Apr 2025 16:50:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Npw4ZvZmOfU/FVv+PCU6kfAqZt2gUHBtgTxTZq/i4lE=;
 b=GjdYYJSLOFEiJDyb1ZwIr9M7DaRTdrrlNwyptmczJrFMPb3QNeZOt3nz2kPrC2w0upkPcM
 Q7YFy4sNmaLmbywQJdq7CDyfg6B9i9lqQJbkN0LUkkahYyBbr9TFYqzds306s3dHJ3N7JP8t
 LEgZjWbZDubk5XLuuIJkxJa05T/ZKOAKgoITCnHdy0vlXHUvLpVYQDOZYvWP37OnJtX3z1ko
 xB6u/hmcubV2bhM3xQU+TuCiMfdPUsJPmfxIZEM4ArjpvijrUZitxTbVSLPJiVjZq7ZVJBsp
 ALHRH8q+Kzngo/XBvXbQeF2to4U7Gxzd1ChtSemgZmd+J5pF3jADoRmQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 1/5] wic(ebg): add support to add verity env to cmdline
Date: Tue, 22 Apr 2025 16:35:22 +0200
Message-ID: <20250422145055.1095348-2-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18558

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
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../wic/plugins/source/efibootguard-boot.py   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 8b1097f..aa093e2 100644
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
@@ -143,6 +147,31 @@ class EfibootguardBootPlugin(SourcePlugin):
         cls._create_img(part_rootfs_dir, part, cr_workdir,
                         native_sysroot, oe_builddir)
 
+    @classmethod
+    def _get_verity_opts(cls):
+        verity_sd_keys = ["data-block-size", "hash-block-size", "data-blocks",
+                          "hash-offset", "salt", "uuid", "hash"]
+        opts = {}
+        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
+        verityenv = None
+        for file in os.listdir(deploy_dir):
+            if fnmatch.fnmatch(file, '*.verity.env'):
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


