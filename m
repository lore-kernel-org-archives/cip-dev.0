Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4BAC47088
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:07 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web12.3487.1649834202065311179
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=HSTR/Lbv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225,
 mailfrom: fm-294854-20220413071642b026afa83f16388c10-o5kdo_@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20220413071642b026afa83f16388c10
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=//SYPF7y8mH3m8VXx6pZfoDzeZRri59cQ02vgNv7K5Q=;
 b=HSTR/LbvHQ6pVbmesSCNBSFz1VQL5E4Td+u2Cm9g66M3bEOODH5Ak0FsId7NW7EbC5axkn
 m9uU1ruaHfaMrEWuZB3InnoUqs7Tle9MiuqVi0duiLUH1y8pyn3vNFX0dcYKO3ZYG8blyG83
 ECUPcHdIgMpD9WjCUMvdXYz17Z41o=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 16/19] linux-cip: Update cip-kernel-config
Date: Wed, 13 Apr 2022 09:16:33 +0200
Message-Id: 
 <77f74bd470100773cd9813916718d2b247d49eb7.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8069

From: Jan Kiszka <jan.kiszka@siemens.com>

This specifically brings iTCO support for QEMU which will be needed to
run SWUpdate full-featured.
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 84515c2..238e5b0 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
 
 SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 
-SRCREV_cip-kernel-config ?= "3f527304fdadd163e20b7a5a9cfabaca7506c716"
+SRCREV_cip-kernel-config ?= "0150b63d0e74d64cc0d5baa9b9440cc148abad8b"
 
 S = "${WORKDIR}/linux-cip-v${PV}"
-- 
2.34.1


