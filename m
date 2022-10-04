Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71D0C07E9D
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.13100.1664902102505467263
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=d4HKWZeo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-2022100416481910d6e4863266921598-lsctdj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 2022100416481910d6e4863266921598
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=nO7NyqL1DCTXSgp19Ge/Wc+IvMXIAT6y1BfQY/mm/9k=;
 b=d4HKWZeoZrkf+wp54xN21l1v/zbAGjouApyhaRJP/vGcmx2zythVoCaW6EqXzt/GATtbiW
 sYDduZxu4FUQs/ad3pEourazpf2weZpwuiJNjNu9pjI/IrhsLTPrmSVJgP7WlzBCfOMMUyPM
 quD5doeEr8IrfuUc2MGqCWPBJr/Jw=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 02/12] Kconfig: Introduce hidden ARCH configs
Date: Tue,  4 Oct 2022 18:48:08 +0200
Message-Id: 
 <07ca042a6ed268bd2b6b139f6e4533f0ac19a876.1664902098.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1664902098.git.jan.kiszka@siemens.com>
References: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9628

From: Jan Kiszka <jan.kiszka@siemens.com>

Those will allow to model architecture dependencies. No functional
changes yet.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Kconfig b/Kconfig
index d87e0a6d..561bd9a8 100644
--- a/Kconfig
+++ b/Kconfig
@@ -1,3 +1,14 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021-2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
 mainmenu "Isar core layer of the Civil Infrastructure Platform project"
 
 config KAS_INCLUDE_MAIN
@@ -8,30 +19,49 @@ config KAS_BUILD_SYSTEM
 	string
 	default "isar"
 
+config ARCH_AMD64
+	bool
+
+config ARCH_ARM64
+	bool
+
+config ARCH_ARM
+	bool
+
+config ARCH_RISCV64
+	bool
+
 choice
 	prompt "Target board"
 	default TARGET_QEMU_AMD64
 
 config TARGET_QEMU_AMD64
 	bool "QEMU AMD64 (x86-64)"
+	select ARCH_AMD64
 
 config TARGET_SIMATIC_IPC227E
 	bool "Siemens SIMATIC IPC227E"
+	select ARCH_AMD64
 
 config TARGET_QEMU_ARM64
 	bool "QEMU ARM64 (aarch64)"
+	select ARCH_ARM64
 
 config TARGET_HIHOPE_RZG2M
 	bool "HopeRun HiHope-RZ/G2M"
+	select ARCH_ARM64
 
 config TARGET_QEMU_ARM
 	bool "QEMU ARM (armhf)"
+	select ARCH_ARM
 
 config TARGET_BBB
 	bool "BeagleBone Black"
+	select ARCH_ARM
 
 config TARGET_IWG20D
 	bool "iWave Systems RainboW-G20D-Qseven"
+	select ARCH_ARM
 
 endchoice
 
-- 
2.35.3


