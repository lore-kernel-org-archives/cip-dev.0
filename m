Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D09CD13D3
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:12:54 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7869.1762931570792306373
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 23:12:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=X1g4qIAy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-294854-20251112071247ac2167c654000207fe-xccjit@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20251112071247ac2167c654000207fe
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Nov 2025 08:12:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=c+imTNowKQBZFYTLYRoE6Vgy4sxfZuIvJNstwD588bY=;
 b=X1g4qIAyjk0YQhzesMUiaBMNZw7T4KC7+ea87kZWR6L/fGRbfjxooB3QvyQBkDo1Bam8rw
 E9zrO6b//4gTKhdd/UQUXs2fn8UXKk3XrLqbbLqbCrN0PHS+OqKyrIofi4EWJMcp1DalodfF
 8ZfX3brSnAWo1XEa41Ihab5R2KXt22CXpRz36CnpXPSxZih5r1oo8eevda+rO3sAGlPTMYAu
 G7Prz9QwL+K9y3yJieOsq/OF/zYI8+mC4ggJMLFsCXn15UMgio53KJXR7R7HOTvNmsBA1+cp
 V4guOSRzqVPkFnEbeq/e4aUehOa8Ssb3sR2gJpbGLLhmGbhiwcKDjcKw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/5] u-boot: Set COMPATIBLE_MACHINE to drop PREFERRED_PROVIDER_u-boot-*
Date: Wed, 12 Nov 2025 08:12:42 +0100
Message-ID: <4ba393e85e5a832e4248b6842badec41207846cd.1762931566.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1762931566.git.jan.kiszka@siemens.com>
References: <cover.1762931566.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 07:12:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20507

From: Jan Kiszka <jan.kiszka@siemens.com>

This is better to maintain as it keeps the key information local to the
u-boot recipe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/bbb.conf                             | 1 -
 conf/machine/qemu-arm.conf                        | 2 --
 conf/machine/qemu-arm64.conf                      | 2 --
 conf/machine/qemu-riscv64.conf                    | 2 --
 recipes-bsp/u-boot/u-boot-bbb_2025.07.bb          | 4 +++-
 recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb   | 4 +++-
 recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb     | 4 +++-
 recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb | 4 +++-
 8 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index f9ef832b..3005b336 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -19,5 +19,4 @@ KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_de
 # for SWUpdate setups: watchdog is configured in U-Boot
 WDOG_TIMEOUT = "0"
 
-PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-bbb"
 PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index 29adaa51..768ea997 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -16,6 +16,4 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
 
-PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm"
-
 PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 0745938b..dfb986de 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -17,6 +17,4 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_mer
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
 
-PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm64"
-
 PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
index 25b19b08..399672ac 100644
--- a/conf/machine/qemu-riscv64.conf
+++ b/conf/machine/qemu-riscv64.conf
@@ -19,6 +19,4 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/cip_mer
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
 
-PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-riscv64"
-
 PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
diff --git a/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb b/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
index e727c5af..d62058f6 100644
--- a/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2024
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,6 +11,8 @@
 
 require u-boot-common-${PV}.inc
 
+COMPATIBLE_MACHINE = "bbb"
+
 U_BOOT_CONFIG = "am335x_evm_defconfig"
 U_BOOT_BIN = "all"
 
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb
index 9ce62937..40a39858 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,4 +12,6 @@
 require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
+COMPATIBLE_MACHINE = "qemu-arm64"
+
 U_BOOT_CONFIG = "qemu_arm64_defconfig"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb
index 8540bfc5..416462dd 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,4 +12,6 @@
 require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
+COMPATIBLE_MACHINE = "qemu-arm"
+
 U_BOOT_CONFIG = "qemu_arm_defconfig"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb
index 43b9e28d..8db94910 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2024
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,6 +12,8 @@
 require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
+COMPATIBLE_MACHINE = "qemu-riscv64"
+
 # we run as OpenSBI payload, hence use smode
 U_BOOT_CONFIG = "${MACHINE}_smode_defconfig"
 
-- 
2.51.0


