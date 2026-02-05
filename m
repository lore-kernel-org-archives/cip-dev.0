Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89802EA7967
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 04:31:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13641.1770265877202348010
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Feb 2026 20:31:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6154VE4o1456478; Thu, 5 Feb 2026 13:31:14 +0900
X-Iguazu-Qid: 2rWhTylF79Yy5bitac
X-Iguazu-QSIG: v=2; s=0; t=1770265873; q=2rWhTylF79Yy5bitac; m=E7VEcV+6+W9nJ4vO9O9vN0ZBMHPfmyK0EBqM7o+RGyQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f646T50R2z4vys; Thu,  5 Feb 2026 13:31:13 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        koshiro.onuki.h55@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba
Subject: [isar-cip-core][PATCH v1] doc/README.factory-reset.md: Minor corrections, verification steps and what to look for during factory reset
Date: Wed,  4 Feb 2026 23:46:37 -0500
X-TSB-HOP2: ON
Message-Id: <20260205044638.14716-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Feb 2026 04:31:11.0171 (UTC) FILETIME=[4155E930:01DC9658]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 04:31:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21830

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.factory-reset.md | 44 ++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
index 729912b..ef35225 100644
--- a/doc/README.factory-reset.md
+++ b/doc/README.factory-reset.md
@@ -1,18 +1,18 @@
 # Enable Factory-reset
 
 To enable the factory-reset functionality the following two elements need to be installed:
- - initramfs-factory-reset-hook which executes the factory-reset
+  - initramfs-factory-reset-hook which executes the factory-reset
   ```
   INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
   ```
-- factory-reset-helper which provides the helper scripts to set the factory-reset marker
+  - factory-reset-helper which provides the helper scripts to set the factory-reset marker
   ```
   IMAGE_INSTALL += "factory-reset-helper"
   ```
 
 ## Technical details
 
-The by executing `set-factory-reset.sh --create` a marker is stored as a EFI variable or on disk (default `/dev/disk/by-partlabel/efi`).
+The by executing `set-factory-reset.sh --create` a marker is stored as a EFI variable or on disk (default `/dev/disk/by-partlabel/var`).
 The marker on disk is intended for devices which do not provide the facilities to set EFI variables.
 The initramfs reads this marker and formats the hard-drives provided by the variable `INITRAMFS_FACTORY_RESET_DEVICES`.
 The initramfs-hook will try to detect the previous used file system and will format the partition with the detected type.
@@ -27,3 +27,41 @@ The removal of the TPM keys can be deactivated by setting the variable `INITRAMF
 As the factory-reset is executed before the disks are unlocked in the initramfs, the file system type must be provided with the
 variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of encrypted partition is not supported with the file based
 marker.
+
+## Verification
+
+- Set the factory-reset marker with the below command:
+```
+root@demo:~# set-factory-reset.sh --create
+```
+
+- Trigger a reboot as factory-reset happens in the initramfs step:
+```
+root@demo:~# reboot
+```
+
+- Factory reset runs during the initramfs. The reset scripts format the target partition with the required filesystem. This can be observed in the boot logs similar to the example below:
+```
+.
+.
+Begin: Factory Reset ... Begin: Reset device: /dev/disk/by-partlabel/var ... [    5.834137] random: crng init done
+mke2fs 1.47.2 (1-Jan-2025)
+Discarding device blocks: done
+Creating filesystem with 131072 4k blocks and 32768 inodes
+Filesystem UUID: d4ec21bc-988b-41f8-8e71-4d2b24cb7074
+.
+.
+```
+
+- If disk encryption is enabled, apart from the formatting of the target partition as stated above, the initramfs scripts also encrypts the target partitions. This too can be observed in the boot logs similar to the example below:
+```
+.
+.
+Device /dev/sda6 is not a valid LUKS device.
+[    8.375556] tpm2_policypcr (224) used greatest stack depth: 11736 bytes left
+persistent-handle: 0x81080001
+action: persisted
+Begin: Encryption of /dev/sda6 ... var: 12/32768 files (0.0% non-contiguous), 6385/131072 blocks
+.
+.
+```
-- 
2.39.5



