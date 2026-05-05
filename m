Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1268CD3440
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 15:25:41 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42381.1777994735187770246
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 08:25:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=Gq7I25Vs;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20260505152533ed4396110700020712-at_glv@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260505152533ed4396110700020712
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 17:25:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=q982Q4eS/rgU1sbIvgtT9Mm8YOjHYj9tDm61XIMngV4=;
 b=Gq7I25Vsr8tF/lx9C/vmk0fAEtJSqav23PwldEBEYY+pLifVrNN+a37fI0eP3d0Z5IQAW6
 AVfAb32SWqu9FEU2agGKFJk0/nS5Q102Lv4/O5oTEOIiJ8wGTynEC71dlmonjstEmDri3jUs
 gHUxMSZIICiYGF5yBLy4yQBj8mS2IBrRHdKtmxDDiStsslZsNe+18jVsIzihGacca6ejsZhx
 q4P+y9Y/wpHVN8ncZGx0N/KUV+B0lCDm5s26bGWLRfPFKwGSNb1/6+gaTLCfmSq1d+JHCFhZ
 yFoROpMfT3U6Eu1E2niE7cAcOZmnRgzlBw+evbFpMwgcyN6R9DWhL+Iw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/3] linux-cip: Update cip-kernel-config revision
Date: Tue,  5 May 2026 17:25:29 +0200
Message-ID: <bf3f7f5eb86d57e3a23d77f6c852f0a122d5c216.1777994730.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1777994730.git.jan.kiszka@siemens.com>
References: <cover.1777994730.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 15:25:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22886

From: Jan Kiszka <jan.kiszka@siemens.com>

This specifically brings centrally managed config fragments, first for
PREEMPT-RT.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 5bff1805..34fb354a 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -15,7 +15,7 @@ SRC_URI:append = " ${@ \
     if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "7742c0f098a3bae264dcb7db8128e99954249bb8"
+SRCREV_cip-kernel-config ?= "a292d21b5ef582b2e42be0f0404eb6fb19f0786f"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.47.3


