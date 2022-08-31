Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ECCC3DA6B
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 07:36:09 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.22621.1661931368547651191
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 00:36:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=hqFpRhUt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-202208310731238571d149e96b0e78c5-r9lhfy@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202208310731238571d149e96b0e78c5
        for <cip-dev@lists.cip-project.org>;
        Wed, 31 Aug 2022 09:36:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=LbuQ/cfeDG+vk554zIz5tfQ4VxlyaMVy206zZxq6Grg=;
 b=hqFpRhUtvnxvQnxdPuUts5xyRAv/vMHjSWBmhc05BJUocMemnYuELdxkTkvZvfUfwYRoIP
 SK/F9uiql+nDVFL5TtD4PDxNtFKLVvnj41l4N966y+dOhJi3Lj36e1dKP/6Nx+CXEcyOmiBn
 571ZAIEzJFLLBiRmK6XgAdFGXYTas=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/6] linux-cip: Update cip-kernel-config
 revision
Date: Wed, 31 Aug 2022 09:31:18 +0200
Message-Id: 
 <e1911dbfe8b73a19922fc668bef41786afa2a68c.1661931081.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1661931081.git.jan.kiszka@siemens.com>
References: <cover.1661931081.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 07:36:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9332

From: Jan Kiszka <jan.kiszka@siemens.com>

Will allow to use the BeagleBone Black with UEFI-based SWUpdate.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 15d8370..9b6cd3b 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -23,6 +23,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "59f7903d120e529cc26b8e5fd7b13c3bbb632e15"
+SRCREV_cip-kernel-config ?= "ce52837418aea714e780e0cbc8afb9515c12cc1b"
 
 S = "${WORKDIR}/linux-cip-${PV}"
-- 
2.35.3


