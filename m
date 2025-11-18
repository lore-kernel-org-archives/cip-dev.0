Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B975CED243
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 06:09:17 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6497.1763446148728309047
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 22:09:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=VAjEYWzY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20251118060905652fb2267f000207c0-fssj1f@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251118060905652fb2267f000207c0
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 07:09:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Ce9siaELJpjEH+x/xjLRNbtYwJBxVirkOChzB/1HWWM=;
 b=VAjEYWzY5gxW8x+VnppZ0Rg/+h5ETgnxAX9BB9oVzl4X0XNzLYm7xzkPu/Uh8udlH55HUr
 Y1K5fcvoHZRWvQcWmuyancTigPDdWwreeZK+jsu4twBc2gPSsLWinTLCHCQFPgABeEAZ+v+3
 CG5dnCcGrAXaSEKwch4pkgxDD0eEFppqCTVuN/FBc3p+ADdFKo9AzJ+JF7ZvWQCSxDOKulfC
 ANwGXgkhZ9ntVbpmymvpCnVViptlSJM0lCdmTG4PfIuxwlyLd4ejIYntGGYI2o+8iGSPziY7
 SKJVmUNaLad8eBVb8vdyVWf9ifUanxI1TC9ZksSj8myLoCJALAO7p8yQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/4] kas: Hook up DE0-Nano-SoC board
Date: Tue, 18 Nov 2025 07:09:03 +0100
Message-ID: <3b314d8653f91508c10df8150ada0f95a338582f.1763446144.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763446144.git.jan.kiszka@siemens.com>
References: <cover.1763446144.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 06:09:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20606

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                    |  8 +++++++-
 kas/board/de0-nano-soc.yml | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 kas/board/de0-nano-soc.yml

diff --git a/Kconfig b/Kconfig
index 9f5f312f..deb6044d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2024
+# Copyright (c) Siemens AG, 2021-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -91,6 +91,11 @@ config TARGET_BBB
 	select ARCH_ARM
 	select HAS_SWUPDATE
 
+config TARGET_DE0_NANO_SOC
+	bool "DE0-Nano-SoC"
+	select ARCH_ARM
+	select HAS_SWUPDATE
+
 config TARGET_IWG20D
 	bool "iWave Systems RainboW-G20D-Qseven"
 	select ARCH_ARM
@@ -119,6 +124,7 @@ config KAS_INCLUDE_BOARD
 	default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
 	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
 	default "kas/board/bbb.yml" if TARGET_BBB
+	default "kas/board/de0-nano-soc.yml" if TARGET_DE0_NANO_SOC
 	default "kas/board/iwg20m.yml" if TARGET_IWG20D
 	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
 	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
diff --git a/kas/board/de0-nano-soc.yml b/kas/board/de0-nano-soc.yml
new file mode 100644
index 00000000..2d1d2426
--- /dev/null
+++ b/kas/board/de0-nano-soc.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+machine: de0-nano-soc
-- 
2.51.0


