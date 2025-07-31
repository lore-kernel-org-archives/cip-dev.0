Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79CBC87FCC
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 08:24:38 +0000 (UTC)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 by mx.groups.io with SMTP id smtpd.web10.56836.1753950275654688682
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 01:24:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Hj38A2Rn;
 spf=pass (domain: ti.com, ip: 198.47.23.235, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V8OZLh3445785;
	Thu, 31 Jul 2025 03:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753950275;
	bh=p/1WnU9RpItRYQ8GwJd5BIJHMk/9coGvo921l5MhwjQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Hj38A2RnrqU5euc33Nc6YZiMSoLc5C0JeEoF1ivEjrYI+eI7syqvcPoKRgLQFaqSa
	 6220lT6U8f8BnlqNf0e/+eHiAFj8ph0YMmNHW9UyeEgPtr9J4XrUK8kYBJPMb3UYrN
	 O3/JllOMrkyHdHLPPpRQeIfpZE5cokWdPXUWzCL0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V8OZNa4085679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 31 Jul 2025 03:24:35 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:24:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:24:34 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V8OQxc2604023;
	Thu, 31 Jul 2025 03:24:33 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <dinesh.kumar@toshiba-tsip.com>
CC: <vigneshr@ti.com>
Subject: [cip-dev][isar-cip-core][PATCH v2 3/4] ti-am62px-sk: Add support for secureboot
Date: Thu, 31 Jul 2025 13:54:20 +0530
Message-ID: <20250731082421.292376-4-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731082421.292376-1-s-adivi@ti.com>
References: <20250731082421.292376-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 08:24:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19636

- Update u-boot rules to prepare secureboot vars
- Add new wks file for use with secureboot
- Update Kconfig file to enable secureboot for TI AM62Px SK

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                                       |  2 +-
 recipes-bsp/u-boot/files/rules-ti.tmpl        | 16 ++++++++++++++++
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
diff --git a/recipes-bsp/u-boot/files/rules-ti.tmpl b/recipes-bsp/u-boot/files/rules-ti.tmpl
index 8f41300..77840e2 100755
--- a/recipes-bsp/u-boot/files/rules-ti.tmpl
+++ b/recipes-bsp/u-boot/files/rules-ti.tmpl
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
 	$(MAKE) $(PARALLEL_MAKE) ARCH=arm ${U_BOOT_R5_CONFIG}
 	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- BINMAN_INDIRS=${BINMAN_INDIRS}
 
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


