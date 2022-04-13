Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD73C4707E
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web09.3447.1649834200872258805
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=R3jILmdP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-294854-2022041307163890b23aeba13d20deb3-hxb1kk@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 2022041307163890b23aeba13d20deb3
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0iZkS2Ii5LwsnX7UEwhus5w40IPOXD/pNrnYYVadXsc=;
 b=R3jILmdP/YrPlE5hjHHBUFZDiFIrCbeYpt460xSAhSV7bgUMxgAOKC2sIuAXcpFCFZj4ko
 G/KVWCDfxhFlnewEzmWU95kj3NDPryUNxIOxcIjWzsNS6p83yLOvOk/wXzp3LsLd9BKKUxgc
 bNKeX1CM69Vk/DgoLjWT4d6pjEzdQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 03/19] swupdate: Drop no longer used
 SOURCE_IMAGE_FILE
Date: Wed, 13 Apr 2022 09:16:20 +0200
Message-Id: 
 <5420dbbd4bd6ef2bb59a8feaa4a9e2523eaddd3d.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8062

From: Jan Kiszka <jan.kiszka@siemens.com>

Obsoleted by aed961de08e1.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/wic-swu-img.bbclass | 2 --
 1 file changed, 2 deletions(-)

diff --git a/classes/wic-swu-img.bbclass b/classes/wic-swu-img.bbclass
index 5e6de40..f03befa 100644
--- a/classes/wic-swu-img.bbclass
+++ b/classes/wic-swu-img.bbclass
@@ -12,6 +12,4 @@
 inherit wic-img
 inherit swupdate-img
 
-SOURCE_IMAGE_FILE = "${WIC_IMAGE_FILE}"
-
 addtask do_swupdate_image after do_wic_image
-- 
2.34.1


