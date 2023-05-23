Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B5C77B75
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 08:30:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.16610.1684830624614964297
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 May 2023 01:30:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: hung.tran.jy@renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,185,1681138800"; 
   d="scan'208";a="160423854"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 May 2023 17:30:23 +0900
Received: from s-VirtualBox.rvc.renesas.com (unknown [172.29.171.145])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BDCFD4007F2B;
	Tue, 23 May 2023 17:30:22 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Hung Tran <hung.tran.jy@renesas.com>
Subject: [isar-cip-core][PATCH] swupdate: Enable SWUpdate for RZG2M
Date: Tue, 23 May 2023 15:29:47 +0700
Message-Id: <20230523082947.5774-1-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 08:30:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11611

SWUpdate will be available for target device HiHope RZ/G2M after
this change.

Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
---
 Kconfig                              |  2 +-
 wic/hihope-rzg2m-efibootguard.wks.in | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 wic/hihope-rzg2m-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index e1e187f..74fbc76 100644
--- a/Kconfig
+++ b/Kconfig
@@ -181,7 +181,7 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
-	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1_MAINLINE )
+	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1_MAINLINE ) || TARGET_HIHOPE_RZG2M
 
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
new file mode 100644
index 0000000..dc32729
--- /dev/null
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -0,0 +1,14 @@
+# short-description: RZ/G2M image with EFI Boot Guard and SWUpdate
+# long-description: Disk image for HiHope RZ/G2M board with EFI Boot Guard and SWUpdate
+
+include ebg-sysparts.inc
+
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
+
+# home and var are extra partitions
+
+part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M
+part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M
+
+bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
-- 
2.17.1


