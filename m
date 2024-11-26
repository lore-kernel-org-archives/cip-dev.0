Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DF6D3B9A7
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 15:18:03 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.48226.1732634275949667331
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Nov 2024 07:17:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=FhLi4yzc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2024112615175322afafad0c03db20d0-1chs2u@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024112615175322afafad0c03db20d0
        for <cip-dev@lists.cip-project.org>;
        Tue, 26 Nov 2024 16:17:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=7igqQ/TlIdO34pV/n+sXXhV/trE75GqOg9uIJSVgq+M=;
 b=FhLi4yzcbpIFfd9hdcmTiuEHaUs2iOGa9y6ZrKKtN66qK48Y/WcaU0gZ8NXV7fcA8Wqu55
 XMEY5bxoo676kzay9dHg3TkhapmsB1Ukfyt4J/Fgk1X4ExEhH0ShjEK8CB4UCJQbCbQCQjb1
 ct6CexXw8L4PYJYB1g3eGN1Gzf9ByGttanmlLdy98oEqRZ5TnUqBn1FarXqd7mkxmCrJQcRy
 6sl5ij8aBc+yX8pxRMG30pPEaYUyLLCXszioPjbv8p/89dd5hWthgACuzvo/Vnt8uEs7amnb
 gYtPJNDv9VIhWOl8qCqNjWhJnXkrwHHAvA9qq6TDvuaHBEGmnRL1Q2Kg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	Jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 2/2] qemu-arm/-arm64/-riscv: Switch to cip_merged_defconfig
Date: Tue, 26 Nov 2024 16:16:28 +0100
Message-ID: <20241126151751.1747275-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20241126151751.1747275-1-Quirin.Gylstorff@siemens.com>
References: <20241126151751.1747275-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Nov 2024 15:18:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17278

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to pick up all common features someone brings into the
merged config, like we already do for qemu-amd64.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/qemu-arm.conf     | 2 +-
 conf/machine/qemu-arm64.conf   | 2 +-
 conf/machine/qemu-riscv64.conf | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index d2dd81f..17c0883 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -11,7 +11,7 @@ DISTRO_ARCH = "armhf"
 
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 7acf107..a2c5e53 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -10,7 +10,7 @@ DISTRO_ARCH = "arm64"
 
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
index 02bb60a..36d6d94 100644
--- a/conf/machine/qemu-riscv64.conf
+++ b/conf/machine/qemu-riscv64.conf
@@ -14,7 +14,7 @@ DISTRO_ARCH = "riscv64"
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/qemu_riscv64_defconfig"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/cip_merged_defconfig"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
-- 
2.46.1


