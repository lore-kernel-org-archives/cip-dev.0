Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C33C3065C
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 09:23:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.6449.1720085004205244463
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 02:23:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4649NLZB3676520; Thu, 4 Jul 2024 18:23:22 +0900
X-Iguazu-Qid: 2yAag3vsnzUcyBgeGY
X-Iguazu-QSIG: v=2; s=0; t=1720085001; q=2yAag3vsnzUcyBgeGY; m=2ohgts1VZNSp+jnNAlrgzi+BpDO9uo8APaQ1FyjHOOg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 4649NKtF2594638
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 18:23:21 +0900
From: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] Kconfig: Refactor Kconfig options
Date: Thu,  4 Jul 2024 14:48:03 +0530
X-TSB-HOP2: ON
Message-Id: <20240704091803.3250609-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Jul 2024 09:23:18.0663 (UTC) FILETIME=[CE883170:01DACDF3]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jul 2024 09:23:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16370

The security target should include both SWUpdate and Secure boot options
by default, so add the missing secure boot dependency in the security
option. Also enable kas-container menu in such way that user can select
individual features without security option.

Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
---
 Kconfig | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Kconfig b/Kconfig
index 96f590a..f73c8f2 100644
--- a/Kconfig
+++ b/Kconfig
@@ -163,11 +163,25 @@ if !KERNEL_4_4 && !KERNEL_4_19
 config IMAGE_SECURITY
 	bool "Security extensions"
 	select IMAGE_SWUPDATE
+	select IMAGE_SECURE_BOOT
 	select IMAGE_DATA_ENCRYPTION
 	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
 	help
 	  This enables security, encryption, secureboot and swupdate for IEC 62443-4-2.
 
+config KAS_INCLUDE_SWUPDATE
+	string
+	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE
+
+config KAS_INCLUDE_SECURE_BOOT
+        string
+        default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
+
+config IMAGE_SECURE_BOOT
+        bool "Secure boot support"
+	select IMAGE_SWUPDATE
+        depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
+
 config KAS_INCLUDE_SECURITY
 	string
 	default "kas/opt/security.yml" if IMAGE_SECURITY
@@ -189,15 +203,6 @@ config IMAGE_DELTA_SWUPDATE
 
 endchoice
 
-config IMAGE_SECURE_BOOT
-	bool "Secure boot support"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
-
-config KAS_INCLUDE_SWUPDATE_SECBOOT
-	string
-	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
-	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
-
 config KAS_INCLUDE_DELTA_UPDATE
 	string
 	default "kas/opt/delta-update.yml" if IMAGE_DELTA_SWUPDATE
-- 
2.39.2



