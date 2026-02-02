Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E797CE7316F
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 12:57:57 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51896.1770037072080415336
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 04:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=bHk8xR1R;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20260202125749cb6f6f771700020726-edfkfw@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260202125749cb6f6f771700020726
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Feb 2026 13:57:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=877foC88Q0gkKI2Q6YxsCXzdz+Z8JyixSjfDT7q25HE=;
 b=bHk8xR1RhnkPAy7jZflw7WXQ3DvZZRRkkjYY1e5ZiGl4zveQ+s6mADurkdCW6y69PfzLQl
 /uNFQc3u6b+IrMTT5jRi5VvOWXHKXqs43gPqEOhGl3tQfVpfjEtAjAt2Zt/tyoLIvZoCrvDL
 l5higmiDs8Ur5L4ddVCuPh/lopJMEjG4i2z0XNBRiLsxkcQavwADQX28dDmaZG7iVY5S2HG/
 qVMLPy/5BB/q/yyfxemwJb+Ct4bVlnyW0xs8TebFLTGNBnI5CphacnMIlVfB2b5sfss3dsqi
 xB2Ny3sIKrlkvet5wSvBAnoI4cY2oDI3z9Mr+12s0L7+ySqjvHsDO2vQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 8/9] kas: Add BeagleV-Fire target
Date: Mon,  2 Feb 2026 13:57:47 +0100
Message-ID: <81cf00e680d702854a7026951489a8927d3fe402.1770037068.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21803

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                    | 10 ++++++++--
 kas/board/beaglev-fire.yml | 12 ++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 kas/board/beaglev-fire.yml

diff --git a/Kconfig b/Kconfig
index b60e29df..772b8cda 100644
--- a/Kconfig
+++ b/Kconfig
@@ -114,6 +114,11 @@ config TARGET_QEMU_RISCV64
 	select ARCH_RISCV64
 	select HAS_SWUPDATE if KERNEL_6_1 || KERNEL_6_12
 
+config TARGET_BEAGLEV_FIRE
+	bool "BeagleV-Fire (riscv64)"
+	select ARCH_RISCV64
+	select HAS_SWUPDATE
+
 endchoice
 
 config KAS_INCLUDE_BOARD
@@ -128,6 +133,7 @@ config KAS_INCLUDE_BOARD
 	default "kas/board/de0-nano-soc.yml" if TARGET_DE0_NANO_SOC
 	default "kas/board/iwg20m.yml" if TARGET_IWG20D
 	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
+	default "kas/board/beaglev-fire.yml" if TARGET_BEAGLEV_FIRE
 
 comment "Kernel options"
 
@@ -148,11 +154,11 @@ config KERNEL_4_19
 
 config KERNEL_5_10
 	bool "Kernel 5.10.x-cip"
-	depends on !TARGET_TI_AM62PX_SK
+	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
 
 config KERNEL_6_1
 	bool "Kernel 6.1.x-cip"
-	depends on !TARGET_TI_AM62PX_SK
+	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
 
 config KERNEL_6_12
 	bool "Kernel 6.12.x-cip"
diff --git a/kas/board/beaglev-fire.yml b/kas/board/beaglev-fire.yml
new file mode 100644
index 00000000..07345f14
--- /dev/null
+++ b/kas/board/beaglev-fire.yml
@@ -0,0 +1,12 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+machine: beaglev-fire
-- 
2.51.0


