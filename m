Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A011C0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 10:38:55 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.9750.1738146575819383950
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 02:29:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm2 header.b=IzheuPlg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1328765-2025012910293299aa3053a9b418f92b-gvj_cd@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025012910293299aa3053a9b418f92b
        for <cip-dev@lists.cip-project.org>;
        Wed, 29 Jan 2025 11:29:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=YO/jXIxappb44cFby2JLtAjiF6Nb8+5GJ92aHFGXmq4=;
 b=IzheuPlghlugmykfd/H9eLPeLRzTr0anicZQZ5IWmZDK8dxwnXdOsEGcQOsHO7h/a7B31G
 03yVDXyIyYSPnc6OwARk8kHIc1XlaKmZ1PxgBcKTILYSeJ4VLK3SArzsSvlsMiaILM4hOISs
 iytgIMUUxuvCig4ogWJe+CRJ6ONMWFU/bONEew3qRM9HTdZHZqg41NEfTIP6TKbPVai+oRqN
 Q5OyqORjYNI23VzNZqeV6fJ37Khs3HtozfgOXUOjPsiSfOhZheMTNCgAYLRjyjBUTgrf/yb2
 ux08svqVjCLE4xhz7bVrmfu9ZfICj2lm1wAnN1ZZKL2pwR0JoX7lzK4Q==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	cedric.hombourger@siemens.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [PATCH][isar-cip-core] efibootguard: update to 0.19
Date: Wed, 29 Jan 2025 15:55:28 +0530
Message-Id: <20250129102528.272043-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jan 2025 10:38:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17678

The latest efibootguard brings the Watchdog support for SIMATIC IPC BX-21A
and Advantechs's EC EIOIS200, added support for and usage of the BIT(x) macro.

Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 ...fibootguard_0.18-1+cip.bb => efibootguard_0.19-1+cip.bb} | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.18-1+cip.bb => efibootguard_0.19-1+cip.bb} (87%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
similarity index 87%
rename from recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
index 6d32833..981aa3d 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2024
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -23,8 +23,8 @@ SRC_URI = " \
     git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
-SRC_URI[tarball.sha256sum] = "023b96548e0779bd7aaf58899883099dba9993b1b4af0c858adc00382523ae52"
-SRCREV_debian = "7e31b8f9cc204d1210c6c03381f936a96c29b35f"
+SRC_URI[tarball.sha256sum] = "167a808d508558341b81d9a493f76161ac7fd7119e764435eae1b13e31a69737"
+SRCREV_debian = "040c116a61ffc99a92b6cbdb793abb7f51ef8d4a"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
-- 
2.39.5


