Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CE0C02196
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:29 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.12054.1738229961729648921
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=L7IQ7m3Q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-2025013009391978161e4903394ceea0-luh_h9@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025013009391978161e4903394ceea0
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dVtxcPlXGjzFFvklSFBUBg6X+UPTjFa1GaSy7DTN9Yg=;
 b=L7IQ7m3QwqxZIm+ACuP7rHNivX9HYENGbT5AGRilS5pG8KUINa5bWrW3SRRz8lY6d2IFnv
 Zl3jk6QdWxMQcIzptPw4tMe+xfYpadI0fRiE14YDA0Fo+Rr+7Rx/YDHi9GgvXWggE9gY8z+0
 YicJtdnzlfhCx5S0eI9RVjT2I1H+eVPmpQz3uqtcbyPG5hr3H2gFaSwQZ1Rm7WyHLYeAMI8r
 4gjTdL2h5aWWTI4XCskM4Eh5MATiEAuUYl4v8W0XWswr1fkytqrrw38sZpSfJmtgk4tFIM3i
 YJWtAyNWNo87GRngoS6AQ99QdBc8JQKVg3fNTYqgsNSXVV5jjc7o0S/A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 10/10] Enable A/B snapshot for /var on x86 and qemu-arm64
Date: Thu, 30 Jan 2025 10:39:17 +0100
Message-ID: <39b2a0d2ec39701f76a2b6b800f34ba3c123b0e8.1738229957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17702

From: Jan Kiszka <jan.kiszka@siemens.com>

Other targets still need testing, some even kernel config tuning.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/qemu-amd64.conf | 5 ++++-
 conf/machine/qemu-arm64.conf | 5 ++++-
 conf/machine/x86-uefi.conf   | 5 +++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index d7866468..5244c86a 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2024
+# Copyright (c) Siemens AG, 2019-2025
 #
 # SPDX-License-Identifier: MIT
 #
@@ -11,3 +11,6 @@ DISTRO_ARCH = "amd64"
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
+
+IMAGER_INSTALL:wic += "btrfs-progs"
+VAR_FS_TYPE = "btrfs"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index a2c5e53e..49323a11 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2025
 #
 # SPDX-License-Identifier: MIT
 #
@@ -16,3 +16,6 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_mer
 WDOG_TIMEOUT = "0"
 
 PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm64"
+
+IMAGER_INSTALL:wic += "btrfs-progs"
+VAR_FS_TYPE = "btrfs"
diff --git a/conf/machine/x86-uefi.conf b/conf/machine/x86-uefi.conf
index 33f82b16..0a69ea82 100644
--- a/conf/machine/x86-uefi.conf
+++ b/conf/machine/x86-uefi.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2024
+# Copyright (c) Siemens AG, 2019-2025
 #
 # SPDX-License-Identifier: MIT
 #
@@ -10,6 +10,7 @@ DISTRO_ARCH = "amd64"
 
 IMAGE_FSTYPES ?= "wic"
 WKS_FILE ?= "x86_64-generic.wks"
-IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL}"
+IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL} btrfs-progs"
+VAR_FS_TYPE = "btrfs"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
-- 
2.43.0


