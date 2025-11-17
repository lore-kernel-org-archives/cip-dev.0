Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96B3CEBF93
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 17:15:24 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14980.1763399721869826293
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 09:15:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Y2eOYUjJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202511171715185ebb69032b000207af-hvcbxp@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202511171715185ebb69032b000207af
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Nov 2025 18:15:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ST7N0rclEJDA8KfYEhTEBGkRPc8y8fR+hQODRk5WgV8=;
 b=Y2eOYUjJbP41G3PJG3r2U0BgfiRu4g6esEjiCuv1sRN37av+l//2UwtrNiyyH+VKVWg6AE
 NdCElIJZOYvj0i+1JUNJvrcMhhm01T7H7YeBbWEuQKOxlFNa9ZmhRJMocTBdG+YQheVY/mub
 1myLmfiJhvzmgYIfmpblcrIYnONWldpgusHRetMN9yEQfVfuVooiEi6AuPuAucb9RYsuHzhN
 fMyH9j919lDBe0ax75qDQTr6xaVGty14WfTmOX8Z4HypcjxycLoMQpNMde7W7YroESOaNdSo
 yxul726jx3voWaHqMia+E5QEvJ13L7uiWJc1AoEGYOa8u2ijbLjIPdgQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [isar-cip-core][PATCH 3/6] arm64: Switch to cip_merged_defconfig
Date: Mon, 17 Nov 2025 18:15:14 +0100
Message-ID: <ae9f51993b0cf98e41452074a51cf1a15716f21d.1763399717.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763399717.git.jan.kiszka@siemens.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 17:15:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20598

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to use the same kernel for all arm64 targets.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/hihope-rzg2m.conf | 4 ++--
 conf/machine/ti-am62px-sk.conf | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index 0b3acf49..485683b2 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,7 +13,7 @@ DISTRO_ARCH = "arm64"
 
 IMAGE_FSTYPES ?= "wic"
 
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
 USE_CIP_KERNEL_CONFIG = "1"
 DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.conf
index 589f071e..bf3cf9ab 100644
--- a/conf/machine/ti-am62px-sk.conf
+++ b/conf/machine/ti-am62px-sk.conf
@@ -23,6 +23,6 @@ IMAGE_BOOT_FILES = " \
     /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-evm.bin;tiboot3.bin"
 
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/ti_defconfig"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
 
 WDOG_TIMEOUT = "0"
-- 
2.51.0


