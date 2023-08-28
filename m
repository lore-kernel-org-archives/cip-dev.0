Return-Path: <tho1.nguyendat@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5A7C83F17
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 10:43:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.10517.1693219420482386177
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Aug 2023 03:43:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: tho1.nguyendat@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 37SAhc643199682; Mon, 28 Aug 2023 19:43:38 +0900
X-Iguazu-Qid: 2yAb0Rwz50wvvLQ4Lx
X-Iguazu-QSIG: v=2; s=0; t=1693219418; q=2yAb0Rwz50wvvLQ4Lx; m=+CcSbILDLSUGFqyS70/oHQSS4lZZZAUMikR5rtbhJqo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 37SAhbqH4192517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Aug 2023 19:43:37 +0900
From: tho1.nguyendat@toshiba.co.jp
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: tho1.nguyendat@toshiba.co.jp, kazuhiro3.hayashi@toshiba.co.jp
Subject: [PATCH 2/3] bbb: Enable secured boot
Date: Mon, 28 Aug 2023 17:43:14 +0700
X-TSB-HOP2: ON
Message-Id: <20230828104315.466393-3-tho1.nguyendat@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828104315.466393-1-tho1.nguyendat@toshiba.co.jp>
References: <20230828104315.466393-1-tho1.nguyendat@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 10:43:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12882

From: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>

Signed-off-by: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
---
 Kconfig                                |  2 +-
 wic/bbb-efibootguard-secureboot.wks.in | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 wic/bbb-efibootguard-secureboot.wks.in

diff --git a/Kconfig b/Kconfig
index ec49631..3bbb5e3 100644
--- a/Kconfig
+++ b/Kconfig
@@ -190,7 +190,7 @@ config IMAGE_SWUPDATE
 
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB
 	select IMAGE_SWUPDATE
 
 config KAS_INCLUDE_SWUPDATE_SECBOOT
diff --git a/wic/bbb-efibootguard-secureboot.wks.in b/wic/bbb-efibootguard-secureboot.wks.in
new file mode 100644
index 0000000..504e2d8
--- /dev/null
+++ b/wic/bbb-efibootguard-secureboot.wks.in
@@ -0,0 +1,13 @@
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
+
+include ebg-signed-sysparts.inc
+
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
+
+# home and var are extra partitions
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
+part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G
+
+bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
-- 
2.39.2



