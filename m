Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F7ECD98B
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 09:59:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8203.1770371983216520240
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Feb 2026 01:59:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6169xfsa188199; Fri, 6 Feb 2026 18:59:41 +0900
X-Iguazu-Qid: 2yAbkFyyItgEvMdBU9
X-Iguazu-QSIG: v=2; s=0; t=1770371981; q=2yAbkFyyItgEvMdBU9; m=TFuDOZRwht3FXqB59zh/QZc6p21FBw7b1PExJkoLFdA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4f6qM11s18zyPZ; Fri,  6 Feb 2026 18:59:41 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        koshiro.onuki.h55@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba,
        quirin.gylstorff@siemens.com
Subject: [isar-cip-core][PATCH v3] doc/README.factory-reset.md: Minor corrections, verification steps and what to look for during factory reset
Date: Fri,  6 Feb 2026 05:15:04 -0500
X-TSB-HOP2: ON
Message-Id: <20260206101504.239074-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Feb 2026 09:59:38.0942 (UTC) FILETIME=[4E7EDDE0:01DC974F]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Feb 2026 09:59:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21845

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.factory-reset.md | 40 +++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
index 729912b..aa8dd1c 100644
--- a/doc/README.factory-reset.md
+++ b/doc/README.factory-reset.md
@@ -1,18 +1,18 @@
 # Enable Factory-reset
 
 To enable the factory-reset functionality the following two elements need to be installed:
- - initramfs-factory-reset-hook which executes the factory-reset
-  ```
-  INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
-  ```
+- initramfs-factory-reset-hook which executes the factory-reset
+```
+INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
+```
 - factory-reset-helper which provides the helper scripts to set the factory-reset marker
-  ```
-  IMAGE_INSTALL += "factory-reset-helper"
-  ```
+```
+IMAGE_INSTALL += "factory-reset-helper"
+```
 
 ## Technical details
 
-The by executing `set-factory-reset.sh --create` a marker is stored as a EFI variable or on disk (default `/dev/disk/by-partlabel/efi`).
+By executing `set-factory-reset.sh --create`, a marker is stored as an EFI variable or on disk (default `/dev/disk/by-partlabel/var`).
 The marker on disk is intended for devices which do not provide the facilities to set EFI variables.
 The initramfs reads this marker and formats the hard-drives provided by the variable `INITRAMFS_FACTORY_RESET_DEVICES`.
 The initramfs-hook will try to detect the previous used file system and will format the partition with the detected type.
@@ -27,3 +27,27 @@ The removal of the TPM keys can be deactivated by setting the variable `INITRAMF
 As the factory-reset is executed before the disks are unlocked in the initramfs, the file system type must be provided with the
 variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of encrypted partition is not supported with the file based
 marker.
+
+## Verification
+
+- Create a test file in a target partition (ex: `/var`)
+```
+root@demo:~# touch /var/to-be-deleted
+```
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
+- Factory reset runs during the initramfs. The reset scripts format the target partition with the required filesystem. If disk encryption is enabled, the initramfs scripts also encrypts the target partitions. Both of which can be observed in the boot logs.
+
+- After the reboot, confirm that the test file created in step 1 is deleted.
+```
+root@demo:~# find /var -name "to-be-deleted"
+```
-- 
2.39.5



