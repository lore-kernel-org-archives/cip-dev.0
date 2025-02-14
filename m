Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC030C021A0
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 05:09:07 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.19840.1739535838958496051
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 04:24:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=PXtJ09d9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1321639-202502141223559bcf15612a9f828968-xy5sek@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202502141223559bcf15612a9f828968
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Feb 2025 13:23:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=tiRfon7EM1VUfNSIaFztYCV15xfDS/HqIE8LgRHG76U=;
 b=PXtJ09d9DYBH0tLONBo2LFBgUlil+uuGwyo2guOfHsv6sjWY90vjeJxkjzzleUWg8fEX87
 na+XkjIjyWVI03u2gBCqsCg6eLFNe6aYlOATsaFQ+FhLdiWT1Pjb4aMv+XmyKmdaigfgyIW7
 ERP4HNhPastj0rUtGWDaEPuSbmFXOiVjxf9I6Ym5khG6OtRicE/jeV/jcXXWJnTSVAAczlMU
 oHOqS1b5VVXQu0MUy9AryhlRaApekjZLpKc4kFNw1SIWfSu4H+UMcpyycL1ScD1idOjLAqak
 OVNwXAJA7wc//1WFGFgqdzyoq4A5suPmefd5kWcSlb+4AYjBdmCpKFGA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC 1/2] wic(ebg): add support to add verity env to cmdline
Date: Fri, 14 Feb 2025 13:23:28 +0100
Message-ID: <20250214122329.2766449-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Feb 2025 05:09:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17848

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
2.47.2


