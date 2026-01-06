Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1A3CD043A
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 06:01:16 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83558.1767673328087974727
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 20:22:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm1 header.b=EZcpSAGY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1328765-202601060412012f6d18306e000207cc-1wkthq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202601060412012f6d18306e000207cc
        for <cip-dev@lists.cip-project.org>;
        Tue, 06 Jan 2026 05:12:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=VYC4WgoL3Mjpi5nbbFzMnzpApbe/GUXZ5Xo05uFC7as=;
 b=EZcpSAGYnID8tE0W//PhYKDHLAnf5TDhd0nfjQ3yDutRuJB5a89NM7PXKHscu8UQU0wnkP
 k+Vo5QyWxj5O2zCHhhmA/FnmBnLOSimAztYlH1FP+nTYztKvKZ1I6kY50KiLIFnxOSwv7D9g
 0S6kMhR38DfMSM2vY06RDuCuweEhGHBPZ9xwTfBnH8GMiYw8pPU8XZ5g7w2ksCUhL4uR2uHJ
 UwtJNlGmJarM0K2SyGXxTIJowNmN/ThcExP2B+6QHQ2NuDYLjS5j2UdftCkAp5V8hoXH5l5o
 IBohifKa8Np1U6bmbYzjPEwH9fos2i3hdlW4n8wVKuxRDDeeeo8NdCFQ==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update kernel config revision
Date: Mon,  5 Jan 2026 23:11:49 -0500
Message-ID: <20260106041149.270874-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 06:01:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21319

On 6.12.y CIP kernels, CONFIG_MATOM=y as set in 6.12.y-cip/x86/cip-merged-config
causes the kernel to fail booting on CPUs that are not Intel Atom, because Atom
specific code is initialized unconditionally.

This enables CONFIG_GENERIC_CPU in cip-merged-defconfig, allowing the kernel to
initialize generic x86 CPUs and ensure successful boot on non-Atom CPUs, while
retaining Atom optimizations when available.

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index c69c054..0e0326f 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -15,7 +15,7 @@ SRC_URI:append = " ${@ \
     if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "fd712bb82f87c73dd9c0b4f0970edf5dacfe028f"
+SRCREV_cip-kernel-config ?= "cda3f5841dec33b81f24cedcc32ea09bb58bbfb5"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.51.0


