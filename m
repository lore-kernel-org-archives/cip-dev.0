Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40CCC87FD3
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 08:24:38 +0000 (UTC)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 by mx.groups.io with SMTP id smtpd.web11.56734.1753950273848713207
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 01:24:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=kwhiuGqf;
 spf=pass (domain: ti.com, ip: 198.47.23.235, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V8OXkT3445657;
	Thu, 31 Jul 2025 03:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753950273;
	bh=+cXN0KHu8MBm7aXLhNiOnEM3Tu/fGNr2qBOSV08OcP0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kwhiuGqfFH3D/4ZW3Q2y9awGP75EY07Tz+yq40EZVdQ5doNaLNF4fwsusaJhc9sHj
	 6qLOOBlDqeY5g88yV/I/VRJsMDULyZfm8pD2lo04Plj8Co++4XPZ+hBAMWPyoryex6
	 XAFysX2hWOAnruHhIXJEUyoI89iPRs0o/PC6IwDg=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V8OXcH4085653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 31 Jul 2025 03:24:33 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:24:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:24:32 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V8OQxb2604023;
	Thu, 31 Jul 2025 03:24:31 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <dinesh.kumar@toshiba-tsip.com>
CC: <vigneshr@ti.com>
Subject: [cip-dev][isar-cip-core][PATCH v2 2/4] ti-am62px-sk: Enable SWUpdate support
Date: Thu, 31 Jul 2025 13:54:19 +0530
Message-ID: <20250731082421.292376-3-s-adivi@ti.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19635

- Update Kconfig file to enable SWUpdate for TI AM62Px SK platform
- Add new wks file for use with SWUpdate

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                              |  1 +
 wic/ti-am62px-sk-efibootguard.wks.in | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 wic/ti-am62px-sk-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index 1b7e428..07111e3 100644
--- a/Kconfig
+++ b/Kconfig
@@ -80,6 +80,7 @@ config TARGET_QEMU_RISCV64
 config TARGET_TI_AM62PX_SK
 	bool "Texas Instruments AM62Px SK"
 	select ARCH_ARM64
+	select HAS_SWUPDATE
 
 endchoice
 
diff --git a/wic/ti-am62px-sk-efibootguard.wks.in b/wic/ti-am62px-sk-efibootguard.wks.in
new file mode 100644
index 0000000..8763cc1
--- /dev/null
+++ b/wic/ti-am62px-sk-efibootguard.wks.in
@@ -0,0 +1,19 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# SPDX-License-Identifier: MIT
+
+# Boot partition containing Bootloader binaries
+part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
+
+include ebg-sysparts.inc
+
+# ABROOTFS partitions
+part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
+
+# var and optional home are extra partitions
+part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9 --exclude-path boot/
+${WIC_HOME_PARTITION}
+
+bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
-- 
2.34.1


