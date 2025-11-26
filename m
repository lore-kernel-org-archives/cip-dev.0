Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EA9D1038C
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 08:15:24 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6405.1764132942048059222
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Nov 2025 20:55:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=arulpandiyan.vadivel@siemens.com header.s=fm1 header.b=SPhFL7I6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1328317-20251126044533bc50cf86310002072f-n1bef4@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251126044533bc50cf86310002072f
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Nov 2025 05:45:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=arulpandiyan.vadivel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=we/j2tw4DYArRtJL6oXhfUBjzUeyFDE+mOY6E5sh/F4=;
 b=SPhFL7I69RxEK80gR7jHWCgIuHz+p9jjqihZ1VATgs8q5Z0mT9qlZ3nXAswz+Y2OR4ecb2
 M8BWminCnYAoGcR0ka03xXDziP0gLSDzqZDk3U0H7hQPERjfLjd7mNb4fhh0+8T0dpt4uA/X
 SiJoV6z2W7qvjp3J+wfs2z96iyQOmObLnF7/lPcVclkG/JhH9BRafux1yYdsYCBs3SEr/4Hm
 6ohuhgRJIc8YEaujYmDdTmVhbOaquGK9Dsxnh0iXfaAuF3wE0411FZ3Fk5SzoWpmEZKpzuvp
 7k3vLcs1WWzc2BMyc8x0//58XM5ttBhTi36a8hVG+bmf73JKsVbSTC6Q==;
From: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cedric.hombourger@siemens.com,
	hemanth.koturappa@siemens.com,
	Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
Subject: [PATCH] recipes-core: ltp: Update to 20250930
Date: Wed, 26 Nov 2025 10:17:10 +0530
Message-ID: <20251126044710.230439-1-arulpandiyan.vadivel@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328317:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Nov 2025 08:15:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20732

Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
---
 recipes-core/ltp/{ltp-full_20250530.bb => ltp-full_20250930.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-core/ltp/{ltp-full_20250530.bb => ltp-full_20250930.bb} (69%)

diff --git a/recipes-core/ltp/ltp-full_20250530.bb b/recipes-core/ltp/ltp-full_20250930.bb
similarity index 69%
rename from recipes-core/ltp/ltp-full_20250530.bb
rename to recipes-core/ltp/ltp-full_20250930.bb
index 553b58d..279ddac 100644
--- a/recipes-core/ltp/ltp-full_20250530.bb
+++ b/recipes-core/ltp/ltp-full_20250930.bb
@@ -11,4 +11,4 @@
 
 require recipes-core/ltp/ltp.inc
 
-SRC_URI[sha256sum] = "27586ba78eac1e40cd422add2842f1ad70f09fea55da3bd6a25e10feb786d4f2"
+SRC_URI[sha256sum] = "048fa4d69ddbe8a94aa15da9bdc85713ab07a0abbc3de2b8bdd9757644aef1e4"
-- 
2.39.5


