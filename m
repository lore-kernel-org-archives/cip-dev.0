Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C1CAC5A7
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:07:50 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.13254.1758622066726487006
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 03:07:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=EazxW6Es;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202509231007433653f7c07c00020749-pzgjzs@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202509231007433653f7c07c00020749
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 Sep 2025 12:07:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=WZjL6WwW+7Gqfr2i5Xu9bg6434n/p/4Y7Yi9FJvSj8U=;
 b=EazxW6Escu9dVeY4lhCfvvwreOkPz1oi/xOcM/UyIigKP552wIIBjJ56DqMvyuWjKnQvbi
 lauHlVZRCm8y4gH1b/0PmT0tcSAr9T2KKYL6WgsfgG08riUX7W5db6R8Pe4eUwidmaFdV7qX
 z1GKzwU77YNdfmT/j1iWgi7HVoNWlR//V/2TnnP73leI2AMWlV1VCO6By+1LdsBDjSSV64oM
 VkuKL+9MEDty+EU92Pkv8qc2vrdanPQbYLcfRl/1aPAY4zgKykXuFbspreya+S+bG1NyIS6Y
 AtirFNRggEgIVKwyclmM2fic24VVbUxVxBWlKwB09zUPYdYhTuodsiWA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v6 3/7] Set PREFERRED_PROVIDER_factory-reset-helper for all machines
Date: Tue, 23 Sep 2025 12:02:37 +0200
Message-ID: <20250923100734.319688-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
References: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 10:07:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20098

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

We use in most case the file helper as:
 - QEMU arm/arm64/riscv64 do not support secure mmc storage
 - QEMU amd64 needs writable efivars which are only available in
   cip-core with swupdate based build
 - efivar were not tested on the targets bbb, hihope, iwg20m

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/bbb.conf          | 1 +
 conf/machine/hihope-rzg2m.conf | 2 ++
 conf/machine/iwg20m.conf       | 2 ++
 conf/machine/qemu-amd64.conf   | 3 +++
 conf/machine/qemu-arm.conf     | 2 ++
 conf/machine/qemu-arm64.conf   | 2 ++
 conf/machine/qemu-riscv64.conf | 2 ++
 conf/machine/x86-uefi.conf     | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index 8c42ec0..f9ef832 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -20,3 +20,4 @@ KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_de
 WDOG_TIMEOUT = "0"
 
 PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-bbb"
+PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index 0b3acf4..447745a 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -20,3 +20,5 @@ IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
 
 WIRELESS_FIRMWARE_PACKAGE = "firmware-ti-connectivity"
 INSTALL_WIRELESS_TOOLS ?= "1"
+
+PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index f5d5dda..401ca57 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -20,3 +20,5 @@ KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/renesas_sh
 DTB_FILES = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
 KERNEL_IMAGE="zImage"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
+
+PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index d786646..dd96fae 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -11,3 +11,6 @@ DISTRO_ARCH = "amd64"
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
+
+PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
+PREFERRED_PROVIDER_factory-reset-helper:swupdate = "factory-reset-helper-efi"
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index d2dd81f..29adaa5 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -17,3 +17,5 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_
 WDOG_TIMEOUT = "0"
 
 PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm"
+
+PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index a2c5e53..cdb94d5 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -16,3 +16,5 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_mer
 WDOG_TIMEOUT = "0"
 
 PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm64"
+
+PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
index 36d6d94..25b19b0 100644
--- a/conf/machine/qemu-riscv64.conf
+++ b/conf/machine/qemu-riscv64.conf
@@ -20,3 +20,5 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/cip_mer
 WDOG_TIMEOUT = "0"
 
 PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-riscv64"
+
+PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/x86-uefi.conf b/conf/machine/x86-uefi.conf
index 33f82b1..28ef245 100644
--- a/conf/machine/x86-uefi.conf
+++ b/conf/machine/x86-uefi.conf
@@ -13,3 +13,5 @@ WKS_FILE ?= "x86_64-generic.wks"
 IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
+
+PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-efi"
-- 
2.50.1


