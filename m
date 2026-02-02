Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB404E7316D
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 12:57:57 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51900.1770037072080920447
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 04:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=GJyS/kkd;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20260202125749762da5d3e5000207e7-9roe0q@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260202125749762da5d3e5000207e7
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Feb 2026 13:57:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=n8mlKOtk9SUkMqGiL6aSODLL6eWbW4wWAIvxGRKDhPM=;
 b=GJyS/kkdzQj4BVfjx1Vjg0e9pmAffts6M9nlP0mhXNm9f+MRK11Sd+G1zGLC1D1uFU0ATe
 crYcKtHtz5UD1xTE6mZqAlWsFr3IqmIdP5XfYXkjqjJmXAjXTthylwCM7i+/X13S7bsYLOSB
 +n4aIBBOcARr5/XMXr5j/PBSQm2edCDSajXjLgRZFWcdBCRRkY9BxqvX+EJ9ZkyOfZcTjfJ8
 x/rUpZbIaMiCdJ0GNXNJ8SoHlnBJZsFJToYjBbH2JMDc6ijObMdvkruv9S+gxVGGumwuNvpj
 NUI8TGj5YvOFKgBXD3RnLgcsT8DV5OqsIurm0bBDkXIMDZhAB7IyF+LQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 6/9] linux-cip: Update cip-kernel-config revision
Date: Mon,  2 Feb 2026 13:57:45 +0100
Message-ID: <cb5833e69ffd39bf7d0f16e5f9d55b96d7f0e543.1770037068.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1770037068.git.jan.kiszka@siemens.com>
References: <cover.1770037068.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 12:57:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21799

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings support for the BeagleV-Fire, the RZ/V2N, RZ/T2H, and RZ/N2H
Renesas SoCs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 0e0326f9..05a0f4a4 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -15,7 +15,7 @@ SRC_URI:append = " ${@ \
     if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "cda3f5841dec33b81f24cedcc32ea09bb58bbfb5"
+SRCREV_cip-kernel-config ?= "1dc986a03d529225404696a5169c29b6958f453c"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.51.0


