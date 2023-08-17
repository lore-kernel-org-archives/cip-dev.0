Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA70C2FC35
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 14:12:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.188715.1692281572996568637
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 07:12:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 37HECox71743075; Thu, 17 Aug 2023 23:12:51 +0900
X-Iguazu-Qid: 2yAbeDFf8z6OFrB7Jp
X-Iguazu-QSIG: v=2; s=0; t=1692281570; q=2yAbeDFf8z6OFrB7Jp; m=hLKi1/cShR1zYVUtm/AFCB1PshcXDqD7EywxuOvp1lg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 37HECmd0081208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 17 Aug 2023 23:12:50 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] scripts/*/efibootguard-*.py: Make FAT file system image create reproducibly
Date: Thu, 17 Aug 2023 19:42:46 +0530
X-TSB-HOP2: ON
Message-Id: <20230817141246.2503-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Aug 2023 14:12:47.0046 (UTC) FILETIME=[E5E19E60:01D9D114]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 14:12:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12768

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The EFI and BOOT file system images are created non-reproducibly because
when `mkdosfs` create FAT file system it uses random values for volume-id
and creation time, this can be fixed by passing additional option
`--invariant` to `mkdosfs` that uses fixed volume-id and creation time.

Fixes: #73

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
 scripts/lib/wic/plugins/source/efibootguard-efi.py  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 7435b22..490b19a 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -160,7 +160,7 @@ class EfibootguardBootPlugin(SourcePlugin):
         # dosfs image, created by mkdosfs
         bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
 
-        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d" % \
+        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d --invariant" % \
             (part.label.upper(), bootimg, blocks)
         exec_cmd(dosfs_cmd)
 
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index d6cdf0f..2c69609 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -105,7 +105,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
         # dosfs image, created by mkdosfs
         efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
 
-        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d" % \
+        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d --invariant" % \
             (part.label.upper(), efi_part_image, blocks)
         exec_cmd(dosfs_cmd)
 
-- 
2.20.1



