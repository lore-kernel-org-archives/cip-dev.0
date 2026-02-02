Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D785EE7316C
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 12:57:57 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51894.1770037072080020916
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 04:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=SZwOCvQg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20260202125749db1f9fceb00002076f-z0hskx@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260202125749db1f9fceb00002076f
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Feb 2026 13:57:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=U6VE6WJXu3Uq/DRB9DM9+a+tq5450mrtJkIdUfc34Xs=;
 b=SZwOCvQglNv9IU3q7OM6ItQA57mhWcYJCrk6OQB3tR/WUwf7cHJceceg2aKQGdggvE3rxr
 J60iFcYzU0mKZ8eFaTYnToK++19BQQ5gyZP1CkFwHwPqkxG8N3QOsY9NIaa+OZMIOmk4eY/B
 m9rTh2UiTtIyDlF1MpNTvUr9oDsqfxOUDtFd1/ulEYeOFLPZ7X+MisI93l/O2lic3InYsluT
 rtczRuBz0K++YzO3bNVxEER++kho2h/7H827c/uds6NSqcF2E6Mzm5A7i1/G+So5FEYKr8FG
 wE0dySbFDd5wDF9QLk68RrvvWqEIWwhRBpUjAfZni6csyNbhOyCyMijw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/9] Kconfig: Sort boards by architecture
Date: Mon,  2 Feb 2026 13:57:40 +0100
Message-ID: <d963107856ab3bf5c69394b6fdd008147933f2b5.1770037068.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1770037068.git.jan.kiszka@siemens.com>
References: <cover.1770037068.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 12:57:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21805

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Kconfig b/Kconfig
index bb27f94b..b60e29df 100644
--- a/Kconfig
+++ b/Kconfig
@@ -79,6 +79,15 @@ config TARGET_HIHOPE_RZG2M
 	select ARCH_ARM64
 	select HAS_SWUPDATE
 
+config TARGET_TI_AM62PX_SK
+	bool "Texas Instruments AM62Px SK"
+	select ARCH_ARM64
+	select HAS_SWUPDATE
+	select HAS_SECURE_BOOT
+	select HAS_DISK_ENCRYPTION
+	select HAS_OPTEE
+	select FTPM_STMM
+
 config TARGET_QEMU_ARM
 	bool "QEMU ARM (armhf)"
 	select ARCH_ARM
@@ -105,15 +114,6 @@ config TARGET_QEMU_RISCV64
 	select ARCH_RISCV64
 	select HAS_SWUPDATE if KERNEL_6_1 || KERNEL_6_12
 
-config TARGET_TI_AM62PX_SK
-	bool "Texas Instruments AM62Px SK"
-	select ARCH_ARM64
-	select HAS_SWUPDATE
-	select HAS_SECURE_BOOT
-	select HAS_DISK_ENCRYPTION
-	select HAS_OPTEE
-	select FTPM_STMM
-
 endchoice
 
 config KAS_INCLUDE_BOARD
@@ -122,12 +122,12 @@ config KAS_INCLUDE_BOARD
 	default "kas/board/x86-uefi.yml" if TARGET_X86_UEFI
 	default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
 	default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
+	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
 	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
 	default "kas/board/bbb.yml" if TARGET_BBB
 	default "kas/board/de0-nano-soc.yml" if TARGET_DE0_NANO_SOC
 	default "kas/board/iwg20m.yml" if TARGET_IWG20D
 	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
-	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
 
 comment "Kernel options"
 
-- 
2.51.0


