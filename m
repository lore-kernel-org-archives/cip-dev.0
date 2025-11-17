Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D8CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 17:15:24 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14979.1763399721869651809
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 09:15:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=abFZxi7X;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-202511171715185328aac2eb000207cb-koryyb@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202511171715185328aac2eb000207cb
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Nov 2025 18:15:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CslUYkxJKt0gi/FDFKx+Sn5OAmSo49J2WerWwGiZAm4=;
 b=abFZxi7X8BDRSqYEFs6Nfc9/MtyAYchc7+HUhSQEBsgW5QRY0myAiEmPWpcjY2OEhlDfED
 UuVRr92oE2w2QlHUCgzqSSMWuUIYlwiza+VJEzkG1cl1pa/Zj5B4jUKUKCPH7MC3gySblysQ
 IXept42qFKM6L/UZh7Af0Imtrv3dBm0u/K/q6HxoJobyrme6/yyRDWZoeJmlNOzWrEtNMxaL
 u1MrtDZS/+QxTY2AritirHT/c/nYe0Snot1DRWGOYkQXg/pK1Lm2cpb4fpw8Dq32UXnNpGdS
 g1W41CJOADRoS8s30q7+Ny0HRr9vA0mwc9hhG6CDbXVZ5zVXvtmMaIxg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [isar-cip-core][PATCH 1/6] linux-cip: Add lz4 as build dependency when using cip-kernel-config
Date: Mon, 17 Nov 2025 18:15:12 +0100
Message-ID: <b937623e2e5e3f94fde3830e550e416844bfe925.1763399717.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20597

From: Jan Kiszka <jan.kiszka@siemens.com>

The merged defconfig for arm needs this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 8b3de446..e944a128 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -19,4 +19,4 @@ SRCREV_cip-kernel-config ?= "ba0204aa6c1c5a41dcb4fa1087b5ef5dd3ebf81f"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-KBUILD_DEPENDS:append = "${@', lzop' if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else ''}"
+KBUILD_DEPENDS:append = "${@', lzop, lz4' if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else ''}"
-- 
2.51.0


