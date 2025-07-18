Return-Path: <hirotaka.motai@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6ECC83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 10:10:42 +0000 (UTC)
Received: from smtp.priv.miraclelinux.com (smtp.priv.miraclelinux.com [202.210.215.66])
 by mx.groups.io with SMTP id smtpd.web11.17735.1752833431788091925
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 03:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: miraclelinux.com, ip: 202.210.215.66, mailfrom: hirotaka.motai@miraclelinux.com)
Received: from 120i.miraclelinux.com (21A0120i.priv.miraclelinux.com [10.2.0.233])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 68E6A140107;
	Fri, 18 Jul 2025 19:10:30 +0900 (JST)
From: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
Subject: [cip-dev][isar-cip-core][PATCH 4/5] zynqmp-zcu102: add kas yml
Date: Fri, 18 Jul 2025 19:09:07 +0900
Message-ID: <20250718100926.3151777-5-hirotaka.motai@miraclelinux.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
References: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 10:10:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19562

Signed-off-by: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
---
 Kconfig                     |  5 +++++
 kas/board/zynqmp-zcu102.yml | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 kas/board/zynqmp-zcu102.yml

diff --git a/Kconfig b/Kconfig
index e0788926cf12..5c9ded15136e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -57,8 +57,12 @@ config TARGET_HIHOPE_RZG2M
 	bool "HopeRun HiHope-RZ/G2M"
 	select ARCH_ARM64
 	select HAS_SWUPDATE
=20
+config TARGET_ZYNQMP_ZCU102
+	bool "Zynq UltraScale+ MPSoC ZCU102"
+	select ARCH_ARM64
+
 config TARGET_QEMU_ARM
 	bool "QEMU ARM (armhf)"
 	select ARCH_ARM
 	select HAS_SWUPDATE
@@ -84,8 +88,9 @@ config KAS_INCLUDE_BOARD
 	default "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64
 	default "kas/board/x86-uefi.yml" if TARGET_X86_UEFI
 	default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
 	default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
+	default "kas/board/zynqmp-zcu102.yml" if TARGET_ZYNQMP_ZCU102
 	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
 	default "kas/board/bbb.yml" if TARGET_BBB
 	default "kas/board/iwg20m.yml" if TARGET_IWG20D
 	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
diff --git a/kas/board/zynqmp-zcu102.yml b/kas/board/zynqmp-zcu102.yml
new file mode 100644
index 000000000000..4663d8858a88
--- /dev/null
+++ b/kas/board/zynqmp-zcu102.yml
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Cybertrust Japan Co., Ltd., 2025
+#
+# Authors:
+#   Hirotaka Motai <hirotaka.motai@miraclelinux.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+machine: zynqmp-zcu102
+
--=20
2.47.2


