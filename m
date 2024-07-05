Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29322C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 07:16:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.12068.1720163811478232886
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 00:16:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4657GnDV2158416; Fri, 5 Jul 2024 16:16:50 +0900
X-Iguazu-Qid: 2yAamb6APOugf15sBx
X-Iguazu-QSIG: v=2; s=0; t=1720163809; q=2yAamb6APOugf15sBx; m=/PSqt+xpjAmiwKOpKp2vGcKwqkkl55Qg8EjXLn9O/QM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 4657Gmg91574893
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 16:16:49 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 1/2] doc/REAME.secureboot.md: Add steps to inject UEFI keys from KeyTool.efi
Date: Fri,  5 Jul 2024 12:41:28 +0530
X-TSB-HOP2: ON
Message-Id: <20240705071129.1374609-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705071129.1374609-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20240705071129.1374609-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2024 07:16:46.0172 (UTC) FILETIME=[4B77C1C0:01DACEAB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 07:16:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16381

From: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>

Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.secureboot.md | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 3ae4154..337ece0 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -322,7 +322,28 @@ The following keys need to be enrolled onto the device:
 
 The enrollment can typically be achieved with the help of
 [efi-updatevar](https://manpages.debian.org/bookworm/efitools/efi-updatevar.1.en.html)
-on the device. Otherwise, consult the manual of the specific UEFI Firmware.
+on the device.
+
+If the device supports built in EFI shell then the enrollment of keys can also be done by KeyTool.efi tool like below:
+
+Format the USB memory stick
+
+```
+host$ sudo mkfs.vfat <usb device>
+host$ sudo mount -t vfat /dev/<usb device> /mnt/
+```
+
+Copy the KeyTool.efi binary and self signed Secure Boot keys to USB stick
+
+Here the folder "keys" contains Secure Boot keys(DB, KEK and PK).
+```
+host$ sudo apt install efitools
+host$ sudo mkdir -p /mnt/efi/boot
+host$ sudo cp /usr/lib/efitools/x86_64-linux-gnu/KeyTool.efi /mnt/efi/boot/KeyTool.efi
+host$ sudo cp -r keys /mnt/
+host$ sudo umount /mnt
+```
+Launch KeyTool.efi binary from the built in EFI shell and follow step-4 from the section [Add Keys to OVMF](#add-keys-to-ovmf) to inject Secure Boot keys. Otherwise, consult the manual of the specific UEFI Firmware.
 
 Use the recipes [secure-boot-key](###secure-boot-key) to provided the keys
 to the signing script contained in
-- 
2.39.2



