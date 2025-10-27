Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A95CCF9E0
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:01 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.26594.1761549713051645955
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=f/XBe6Ra;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20251027072151951c11f4f300020741-2ktdrr@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251027072151951c11f4f300020741
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=gXEc/30aZQmkyJiwdH0tJSzDirzjZFveVi75qyIFkGg=;
 b=f/XBe6RafapX3okUC8CRRJ54y+bGF+0XX/YM0+6y/QEO9X+8VXg1PbPSAJI1Ctdq+JN/i+
 /H1ZcnF5q7GS2H7D2UiNjPhuRtMd347SF6MDJa40bLPKVhiT3wtmfq18xghERTz4n1rEJjzh
 liPCwsVTMaEViMUGW4S4D7sdvfbx8eRH5wrIdYRUNWp1Jt4FC8ModPRP/nqCcdoj0eOnGAwA
 3zo5S674BxjkwYan+hcn5OaakL6vMfMZSmHn0oHz5V2SNCIKBw1xYJixU6S2zlbStrnpS9u9
 909uYXUboZk+ALdsfrCKrpdUlg08yMhJwpWy8E9zL9imLNCq9siOvU3A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 15/19] kas: Add option for fTPM/StMM firmware mode
Date: Mon, 27 Oct 2025 08:21:44 +0100
Message-ID: <8d513d187be84fb6f1b0cba6631858b0e95b05d2.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20221

From: Jan Kiszka <jan.kiszka@siemens.com>

This switches the qemu-arm64 target to TF-A, OP-TEE, fTPM and StMM
based firmware. We only support this with kernel 6.12 due to features
only available from that version onward. Furthermore the toolchain of
buster is not supported by optee-ftpm, so exclude this variant.

As this feature currently requires a custom QEMU build, do not turn it
on by default.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig               | 19 +++++++++++++++++++
 kas/opt/ftpm-stmm.yml | 16 ++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 kas/opt/ftpm-stmm.yml

diff --git a/Kconfig b/Kconfig
index e7d8bd5e..71649f6c 100644
--- a/Kconfig
+++ b/Kconfig
@@ -37,6 +37,9 @@ config HAS_SWUPDATE
 config HAS_EFIVARS
 	bool
 
+config HAS_OPTEE
+	bool
+
 choice
 	prompt "Target board"
 	default TARGET_QEMU_AMD64
@@ -57,6 +60,7 @@ config TARGET_QEMU_ARM64
 	bool "QEMU ARM64 (aarch64)"
 	select ARCH_ARM64
 	select HAS_SWUPDATE
+	select HAS_OPTEE if KERNEL_6_12
 
 config TARGET_HIHOPE_RZG2M
 	bool "HopeRun HiHope-RZ/G2M"
@@ -157,6 +161,21 @@ config KAS_INCLUDE_KERNEL_RT
 	default "kas/opt/rt.yml"
 	depends on KERNEL_RT
 
+if HAS_OPTEE
+
+comment "Firmware options"
+
+config FTPM_STMM
+	bool "Use Firmware TPM and rewritable UEFI key storage"
+	depends on !DEBIAN_BUSTER
+
+config KAS_INCLUDE_FTPM_STMM
+	string
+	default "kas/opt/ftpm-stmm.yml"
+	depends on FTPM_STMM
+
+endif
+
 comment "Debian distribution options"
 
 choice
diff --git a/kas/opt/ftpm-stmm.yml b/kas/opt/ftpm-stmm.yml
new file mode 100644
index 00000000..06f645d7
--- /dev/null
+++ b/kas/opt/ftpm-stmm.yml
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+header:
+  version: 14
+
+local_conf_header:
+  ftpm-stmm: |
+    OVERRIDES .= ":ftpm-stmm"
-- 
2.51.0


