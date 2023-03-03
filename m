Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B115C678D4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 13:12:36 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.21951.1677847723155587649
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 04:48:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=XRBx1Ar+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-2023030312484134084c01ad0f4e3a7f-lnejiz@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023030312484134084c01ad0f4e3a7f
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Mar 2023 13:48:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=O6v3uLo535eF5K2sA5VzwgRvR4T4GWzAXjzUxDMjLJc=;
 b=XRBx1Ar+DOpbtbiHqKsIOQmJEVwhQNJ0JFi6ADuhP3oWttjEamRcR69AYQFMw3RSsrpWWw
 C06JNu4BTImM8gcjI7gSmRBH4Tkgpljm2iDqQGuBgYuoeSM3ng8EAIRKPrRks/ZRyOPLqSfd
 U6+3NpOTju+SVtigxndJlii2rhLFQ=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 1/8] make reason for disabling wdog on arm more precise
Date: Fri,  3 Mar 2023 12:48:13 +0000
Message-Id: <20230303124820.2209954-2-felix.moessbauer@siemens.com>
In-Reply-To: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
References: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 13:12:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10906

This patch reworks the comment describing why the watchdog is disabled
for arm and arm64. Previously it was stated that the watchdog is armed
by u-boot, but technically it simply never was supported to have a
watchdog on these platforms when using the start-qemu script.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 conf/machine/qemu-arm.conf   | 2 +-
 conf/machine/qemu-arm64.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index aa3a6b4..d2dd81f 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -13,7 +13,7 @@ IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
 
-# for SWUpdate setups: watchdog is configured in U-Boot
+# watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
 
 PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 7f42369..7acf107 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -12,7 +12,7 @@ IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
 
-# for SWUpdate setups: watchdog is configured in U-Boot
+# watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
 
 PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm64"
-- 
2.34.1


