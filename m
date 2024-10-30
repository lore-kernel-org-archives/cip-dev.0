Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD52D5CCA0
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 11:52:02 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.13030.1730289112364198584
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 04:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=aAA7iOix;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202410301151493982eecc4406d2bffa-uhj96f@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202410301151493982eecc4406d2bffa
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Oct 2024 12:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=vBYcazKv1rot7s1PkcKNQ7wnLUdoeBObFtZTwQ7MZEY=;
 b=aAA7iOixTVjcYhMS1qHaU/r1JQC6jHM35nmIP8H3TGcQxJDZnwiHnOVgudWkdduIzRXz5L
 F2TyAwk1qzEVacBLoT0L8UP2Yqestoe5QF7Ik6DxYkRfbKvXpkPqVXGRXzAGz/T04OTmoKG+
 gADRSq1PvYHNTq5n+O8NkFgz1bcMBzVc1fb2ixVb2vmbwf7OesMJzzEWOCLhGAQWYfAX4DtJ
 4BiGeRoIfp6CQfP8XaWXJCW/0pUd2K2nu+gIu3aEhM3e0/sRK6/nYRYaNW8H0afZYKul3vzG
 FVg2UtJp2oKWDgB7e8cbWWytfsfupr8A5BTnzGM9EN6ppHjrytB6buSg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 6/6] kas: Add option for selecting read-only rootfs type
Date: Wed, 30 Oct 2024 12:51:47 +0100
Message-ID: <e299b31a99d6fd4f1b261babcf28d98b8b973729.1730289107.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730289107.git.jan.kiszka@siemens.com>
References: <cover.1730289107.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 11:52:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17116

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to select EROFS as alternative to squashfs. The option is
limited to 6.1 kernels, older ones will no longer be enabled.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig           | 16 ++++++++++++++++
 kas/opt/erofs.yml | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 kas/opt/erofs.yml

diff --git a/Kconfig b/Kconfig
index 8062cdb7..83f2c2f6 100644
--- a/Kconfig
+++ b/Kconfig
@@ -198,6 +198,22 @@ config IMAGE_DELTA_SWUPDATE
 
 endchoice
 
+choice
+	prompt "Read-only rootfs type"
+
+config IMAGE_RO_ROOTFS_SQUASHFS
+	bool "Squashfs"
+
+config IMAGE_RO_ROOTFS_EROFS
+	bool "EROFS"
+	depends on KERNEL_6_1
+
+endchoice
+
+config KAS_INCLUDE_EROFS
+	string
+	default "kas/opt/erofs.yml" if IMAGE_RO_ROOTFS_EROFS
+
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
 	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
diff --git a/kas/opt/erofs.yml b/kas/opt/erofs.yml
new file mode 100644
index 00000000..7c44f5b8
--- /dev/null
+++ b/kas/opt/erofs.yml
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
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
+  erofs: |
+    RO_ROOTFS_TYPE = "erofs"
-- 
2.43.0


