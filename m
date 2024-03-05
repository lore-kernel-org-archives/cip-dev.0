Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74187C54E5C
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 09:07:53 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.18062.1709629665336844753
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 01:07:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=Wxu1hZL4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20240305090734f61f1c2f42051aa259-qgwit_@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240305090734f61f1c2f42051aa259
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 10:07:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=9Pm2PuE8ydN3FiYL7dyTU9+9Obuf9DlixFbkWsVGCXg=;
 b=Wxu1hZL43XbZUH/Os2P5+sQW3lrcHe/31kntFexfuykL1qRm/a0wjWQuNOzSRiJI6vCosP
 enKPK5N7IRURSd+ikpQTwnhB6IAMWiMu7LJOQ/2Hog823tBjuMHgRVjzP8xvky8tSt8knA7s
 M0Fwq0Cdz4qk5PrNbepWUB9v/RMo4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 4/4] linux-cip: Update cip-kernel-config
Date: Tue,  5 Mar 2024 10:07:33 +0100
Message-Id: <22426e38224aa9dda6f2cd34e64f54c3b8bd446d.1709629653.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1709629653.git.jan.kiszka@siemens.com>
References: <cover.1709629653.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 09:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15210

From: Jan Kiszka <jan.kiszka@siemens.com>

This specifically brings the config switches needed for RISC-V in order
to use our SWUpdate integration.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 5013eb95..40c378bf 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2023
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "8133457d8e156c34eebe52d9affab9df3f7b597f"
+SRCREV_cip-kernel-config ?= "ee86aca8abbe7a41536bcb53142fbf0f57b1c9b7"
-- 
2.35.3


