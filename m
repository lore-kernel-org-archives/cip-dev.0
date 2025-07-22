Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CF5C83F25
	for <webhook@archiver.kernel.org>; Tue, 22 Jul 2025 10:16:12 +0000 (UTC)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 by mx.groups.io with SMTP id smtpd.web11.9057.1753179364072773613
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Jul 2025 03:16:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=eZX8O6Oi;
 spf=pass (domain: ti.com, ip: 198.47.23.234, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56MAG3X41024218;
	Tue, 22 Jul 2025 05:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753179363;
	bh=oUDJlFgTILcVfc4bA9JQZtOid4oc9/EKJATvRwv9OgI=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=eZX8O6OiUHcG/nCtCL/Yt9A30bZzesVUI3MOIx638uaQivHQNX2aZ9csdMA0ADbGm
	 /BIuDl7k5J2yDO45yanyrGYvHVCrBAo0rD3Vym1Hhod44K1DBgW+yhQfnEnw1b1Ejt
	 Dwvjo6O1YO3h35rkk+FcFKKOYyECsc5rgypnYP8g=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56MAG3Yv4025622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 22 Jul 2025 05:16:03 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 05:16:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 05:16:03 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56MAFuXX868688;
	Tue, 22 Jul 2025 05:16:02 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
        <jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 3/4] ti-am62px-sk: Add support for secureboot
Date: Tue, 22 Jul 2025 15:45:50 +0530
Message-ID: <20250722101551.1727649-4-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722101551.1727649-1-s-adivi@ti.com>
References: <20250722101551.1727649-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Jul 2025 10:16:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19574

- Update u-boot rules to prepare secureboot vars
- Add new wks file for use with secureboot
- Update Kconfig file to enable secureboot for TI AM62Px SK

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                                       |  2 +-
 recipes-bsp/u-boot/files/rules-ti-am62px-sk   | 16 ++++++++++++++++
 ...i-am62px-sk-efibootguard-secureboot.wks.in | 19 +++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in

diff --git a/Kconfig b/Kconfig
index 07111e3..68c4309 100644
--- a/Kconfig
+++ b/Kconfig
@@ -247,7 +247,7 @@ config KAS_INCLUDE_EROFS
 
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
+	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
 
 config KAS_INCLUDE_SWUPDATE_SECBOOT
 	string
diff --git a/recipes-bsp/u-boot/files/rules-ti-am62px-sk b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
index dc53b07..ab8b813 100644
--- a/recipes-bsp/u-boot/files/rules-ti-am62px-sk
+++ b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
@@ -12,6 +12,22 @@ SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
 endif
 
 override_dh_auto_build:
+	if [ -e /usr/share/secure-boot-secrets/secure-boot.pem ]; then \
+		openssl x509 -in /usr/share/secure-boot-secrets/secure-boot.pem -out secure-boot.der -outform der; \
+		rm -f secure-boot.esl; \
+		\
+		if [ -x /usr/bin/efisecdb ]; then \
+			efisecdb -g 32db313c-f7d4-42a6-9a49-e32870001c63 -a -c secure-boot.der -o secure-boot.esl; \
+		else \
+			efisiglist -a -c secure-boot.der -o secure-boot.esl; \
+		fi; \
+		\
+		rm -f ubootefi.var; \
+		tools/efivar.py set -i ubootefi.var -n PK -d secure-boot.esl -t file; \
+		tools/efivar.py set -i ubootefi.var -n KEK -d secure-boot.esl -t file; \
+		tools/efivar.py set -i ubootefi.var -n db -d secure-boot.esl -t file; \
+	fi
+
 	$(MAKE) $(PARALLEL_MAKE) ARCH=arm am62px_evm_r5_defconfig
 	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
 
diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
new file mode 100644
index 0000000..29373de
--- /dev/null
+++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
@@ -0,0 +1,19 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# SPDX-License-Identifier: MIT
+
+# Boot partition containing Bootloader binaries
+part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
+
+include ebg-signed-sysparts.inc
+
+# ABROOTFS partitions
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+
+# var and optional home are extra partitions
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
+${WIC_HOME_PARTITION}
+
+bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
-- 
2.34.1


