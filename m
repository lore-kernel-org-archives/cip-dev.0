Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C08EC25B75
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 09:14:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.7203.1715073260058806568
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 May 2024 02:14:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4479EIQi3577598; Tue, 7 May 2024 18:14:18 +0900
X-Iguazu-Qid: 2rWhclmqRFz3t1kaA5
X-Iguazu-QSIG: v=2; s=0; t=1715073258; q=2rWhclmqRFz3t1kaA5; m=NZRt/HJKmPP5OV/tQsF3G+EdGqx5DiPy/Sx/qNMy9/Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 4479EHru3521523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 7 May 2024 18:14:18 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v6 4/4] Kconfig: Add delta update option
Date: Tue,  7 May 2024 14:44:32 +0530
X-TSB-HOP2: ON
Message-Id: <20240507091432.895626-5-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507091432.895626-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240507091432.895626-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 May 2024 09:14:11.0374 (UTC) FILETIME=[EC5D04E0:01DAA05E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 May 2024 09:14:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15854

This change adds a delta update option for swupdate in kas menu

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Kconfig b/Kconfig
index 7c19640..3964098 100644
--- a/Kconfig
+++ b/Kconfig
@@ -192,6 +192,18 @@ config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
 	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
 
+choice
+	prompt "Update type"
+	depends on IMAGE_SWUPDATE
+
+config IMAGE_COMPLETE_SWUPDATE
+	bool "Complete Update"
+
+config IMAGE_DELTA_SWUPDATE
+	bool "Delta Update"
+
+endchoice
+
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
 	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
@@ -202,6 +214,10 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
 	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
 	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
 
+config KAS_INCLUDE_DELTA_UPDATE
+	string
+	default "kas/opt/delta-update.yml" if IMAGE_DELTA_SWUPDATE
+
 config IMAGE_DATA_ENCRYPTION
 	bool "Encrypt data partitions on first boot"
 	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
-- 
2.39.2



