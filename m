Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A13C7619A
	for <webhook@archiver.kernel.org>; Thu, 23 Mar 2023 13:43:40 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.72503.1679579014473176116
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Mar 2023 06:43:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=FddbZfzC;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-202303231343311e2df518955dfbf8cb-mol4dc@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202303231343311e2df518955dfbf8cb
        for <cip-dev@lists.cip-project.org>;
        Thu, 23 Mar 2023 14:43:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZtcR//zTOiwklRPfOB0CP1pTarEE3DGi/IEJsWJomGE=;
 b=FddbZfzCx4hw9MhLQ6+TqehwC8NEbPkhCHY+xKvm60oHQ4gxg83vpWrN/a4U/35yKv1VOA
 riJsP1vCSfOrZjhJEwZVr6JOyYawh5NH88lQdpt31tIBVPkZWLG+wngnsJ0I169sCWuA0Tob
 mgmuefN7SeiHPLQCV9vyDVjSFe+K4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 1/3] linux-cip: Bump cip-kernel-config revision
Date: Thu, 23 Mar 2023 14:43:28 +0100
Message-Id: <9a554834c02922d36b4d999778635759e638bfb3.1679579010.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1679579010.git.jan.kiszka@siemens.com>
References: <cover.1679579010.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Mar 2023 13:43:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11101

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings TPM/encryption support for qemu-arm/arm64 and fixes mqueues
on some arm targets.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 6dda973a..2d878a1d 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -23,6 +23,6 @@ SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "351538952cfa7c6336e83bf66ca4f3bbdc06f89b"
+SRCREV_cip-kernel-config ?= "0188d9a54615767c00b77116146409edfa35497c"
 
 S = "${WORKDIR}/linux-cip-${PV}"
-- 
2.35.3


