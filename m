Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D14C678D4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 13:12:46 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.21956.1677847738881411491
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 04:49:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=IEJLVdcz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-202303031249014ce417102a399fe445-gzcx4p@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202303031249014ce417102a399fe445
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Mar 2023 13:49:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LayOr8+KEwYFBEOiHZ+dC9pa5ay35Ccx2+toRqYyZTw=;
 b=IEJLVdcz2ID1ijm47GgI8u7I8cpF63i4+EEnDmPr82tbaTxPCBEC13Pyz0rLXp6Wz4iFqV
 n3oDWaRUsVf+3Fsj+a2CxQT02tRHMQgl3SQYAFHwSgKw0c7TjXzPzQEo8oyflFqtVgJhk1zi
 VkfzpTvaiAzaAoPzPSeCRjI7Ub9XE=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v4 5/8] enhance qemu-riscv64 machine to be testable
Date: Fri,  3 Mar 2023 12:48:17 +0000
Message-Id: <20230303124820.2209954-6-felix.moessbauer@siemens.com>
In-Reply-To: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
References: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 13:12:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10910

This patch enhances the qemu-riscv64 machine by adding a reference to
u-boot. Further, we now use the qemu_riscv64 defconfig from
cip-kernel-config.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 conf/machine/qemu-riscv64.conf | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
index f1f3e87..02bb60a 100644
--- a/conf/machine/qemu-riscv64.conf
+++ b/conf/machine/qemu-riscv64.conf
@@ -12,4 +12,11 @@
 DISTRO_ARCH = "riscv64"
 
 IMAGE_FSTYPES ?= "ext4"
-KERNEL_DEFCONFIG ?= "defconfig"
+USE_CIP_KERNEL_CONFIG = "1"
+
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/qemu_riscv64_defconfig"
+
+# watchdog is not yet supported in our QEMU executor for this platform, disable it
+WDOG_TIMEOUT = "0"
+
+PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-riscv64"
-- 
2.34.1


