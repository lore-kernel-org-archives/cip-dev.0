Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3040BC4332F
	for <webhook@archiver.kernel.org>; Mon, 19 Dec 2022 13:29:16 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.21607.1671456553832740422
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Dec 2022 05:29:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FoENJAsu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20221219132911f8fbd640c85c818847-koeazr@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20221219132911f8fbd640c85c818847
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Dec 2022 14:29:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=3qODs9V+apx57zkTVpRJnLqWYMRV0eQc7KwiSqnUC5s=;
 b=FoENJAsueR74eHduFjlItFQvN0RtqUOybM9tCY2aEoGxt1ZHDooMBkQ39WgoWtQCFA/zh+
 zYhBSV0W+0lLNusjqgJCVZoq/kE1B/Iin/WYoZeNGxRry7ZIqcNoPuNS3Xy9L/pWyam9NhyM
 eicw/5XhmH2cZR6seyzyjtjztOwOU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] kernel/rt-common: Remove prepare_build_prepend
Date: Mon, 19 Dec 2022 14:29:10 +0100
Message-Id: <20221219132910.326418-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Dec 2022 13:29:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10251

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

*.cfg files are automatically added to the kernel config.

https://github.com/ilbers/isar/blob/d26660b724b034b602f3889f55a23cd9be2e87bd/meta/recipes-kernel/linux/linux-custom.inc#L119

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt-common.inc | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/recipes-kernel/linux/linux-cip-rt-common.inc b/recipes-kernel/linux/linux-cip-rt-common.inc
index dffb77b..8e2c293 100644
--- a/recipes-kernel/linux/linux-cip-rt-common.inc
+++ b/recipes-kernel/linux/linux-cip-rt-common.inc
@@ -13,6 +13,3 @@ require linux-cip-common.inc
 
 SRC_URI += "file://preempt-rt.cfg"
 
-do_prepare_build_prepend() {
-    cat ${WORKDIR}/preempt-rt.cfg >> ${WORKDIR}/${KERNEL_DEFCONFIG}
-}
-- 
2.35.1


