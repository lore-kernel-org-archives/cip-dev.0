Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F82D43349
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:58:14 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.69365.1730977083585632412
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 02:58:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=PzaY78io;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20241107105801de928480eaaa2c87f1-vcsq8z@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20241107105801de928480eaaa2c87f1
        for <cip-dev@lists.cip-project.org>;
        Thu, 07 Nov 2024 11:58:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IM+lVJiFnurms4Gm7mqJigdFQxkEVJW1evCjP08B6x8=;
 b=PzaY78io5jKsxMWvEWsfLhwzb11g97w0PhlqCXZJuvdK+LWXtluPwg2Lm1mzeSSq7h4Dhn
 Z+AtJg1ZUov9LgwLnwH+5/g/gJoyqqN5jduualj9+MWIekdXHHnRLd8f+WT+AwNicNq6+NMe
 DRDEaAVL/g+tQuTk+bUkzWos4a7UEs0dPrQvG+aUpD25Lt3Qg5opPDgYcae7zfVn31w/DFMd
 L68fKmlque8SFqDX0RenS6lV8zy4X1hqwr60iX8KPX+mGJgqROvpP8SDjTx2w9NfKffgCYl+
 x3g9vQ97q6v7/G0cCnAG6rnnxUpg/Ohra3YrMU7UTyEmUay38zWWZhtQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>,
	Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 2/9] swupdate: Control self-building via boolean var
Date: Thu,  7 Nov 2024 11:57:50 +0100
Message-ID: <c6ab307ddf903298d2fe23ad93b1e6a251ecc6b1.1730977077.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730977077.git.jan.kiszka@siemens.com>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 10:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17208

From: Jan Kiszka <jan.kiszka@siemens.com>

Under the assumption that future versions of Debian will deliver us the
needed versions of SWUpdate, this eases to opt-in for self-building.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/swupdate.inc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 96994b5c..b1cad439 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -17,9 +17,13 @@ SWU_HW_COMPAT ?= "cip-core-1.0"
 IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
-IMAGE_INSTALL += " swupdate"
 
-IMAGE_INSTALL:remove:sid = "swupdate"
-IMAGE_PREINSTALL:append:sid = " swupdate"
+SWUPDATE_SELFBUILT ?= "0"
+SWUPDATE_SELFBUILT:buster = "1"
+SWUPDATE_SELFBUILT:bullseye = "1"
+SWUPDATE_SELFBUILT:bookworm = "1"
+
+IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
+IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
 
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
-- 
2.43.0


