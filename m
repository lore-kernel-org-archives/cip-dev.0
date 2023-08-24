Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254FAC27C40
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 10:41:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.7809.1692873685299408115
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Aug 2023 03:41:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 37OAfM2q1262621; Thu, 24 Aug 2023 19:41:23 +0900
X-Iguazu-Qid: 2yAaOS3aEZX8JdtA8G
X-Iguazu-QSIG: v=2; s=0; t=1692873682; q=2yAaOS3aEZX8JdtA8G; m=6YzCSrN0FO2eYsojeqGZFsmT+5gi9utcETzziOgco4M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 37OAfL4I2476339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Aug 2023 19:41:22 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 1/2] ebg-sysparts: Add filesystem UUID to fat images
Date: Thu, 24 Aug 2023 16:11:18 +0530
X-TSB-HOP2: ON
Message-Id: <20230824104119.5464-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <177DF6549CC2A4D6.6662@lists.cip-project.org>
References: <177DF6549CC2A4D6.6662@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Aug 2023 10:41:19.0585 (UTC) FILETIME=[8474F510:01D9D677]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Aug 2023 10:41:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12844

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The EFI and BOOT file system images are not reproducible because it is
created with random volume-id's generated in `mkdosfs`.

To fix this assign fixed filesystem UUID to the partitions and pass it
to the `mkdosfs`.

Partially-fixes: #73

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 4 ++--
 scripts/lib/wic/plugins/source/efibootguard-efi.py  | 4 ++--
 wic/ebg-sysparts.inc                                | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 7435b22..9892572 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -160,8 +160,8 @@ class EfibootguardBootPlugin(SourcePlugin):
         # dosfs image, created by mkdosfs
         bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
 
-        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d" % \
-            (part.label.upper(), bootimg, blocks)
+        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d -i %s" % \
+            (part.label.upper(), bootimg, blocks, part.fsuuid)
         exec_cmd(dosfs_cmd)
 
         mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % (bootimg, part_rootfs_dir)
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index d6cdf0f..86a22e0 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -105,8 +105,8 @@ class EfibootguardEFIPlugin(SourcePlugin):
         # dosfs image, created by mkdosfs
         efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
 
-        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d" % \
-            (part.label.upper(), efi_part_image, blocks)
+        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d -i %s" % \
+            (part.label.upper(), efi_part_image, blocks, part.fsuuid)
         exec_cmd(dosfs_cmd)
 
         # mtools for buster have problems with resursive mcopy.
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index 9b2c879..976735d 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -1,8 +1,8 @@
 # default partition layout EFI Boot Guard usage
 
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active
+part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --fsuuid "0x4321dcba"
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2"
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1"
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2" --fsuuid "0x4321dcbb"
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1" --fsuuid "0x4321dcbc"
-- 
2.20.1



