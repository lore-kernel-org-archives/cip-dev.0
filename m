Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC17BD1D478
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 15:17:02 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8640.1767885416528865130
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 07:16:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Mxsj7SJp;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2026010815165889fb16387e00020760-2_v_v0@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026010815165889fb16387e00020760
        for <cip-dev@lists.cip-project.org>;
        Thu, 08 Jan 2026 16:16:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=A0/XgbTA4hFtXDH/Xp7xlUR5ToJMELGhyMkFySomNi4=;
 b=Mxsj7SJpuc6XCbZGRaTULAJTmVzuzVzNci2/1cnYBuATksAt5hQs3jaytt6LaxMOqA5aXE
 kz3BYM3FTsw8N9xYpSdMURtls3lkcFg/N7Nt14BJiyjQmPn85I0sql+HfkF19Qx8Ygtw1VdK
 GMDf8rVuAgqp2Pgj+iUCqYmW0Oceu4w89JVNUtd89Wp7DdTTNZnqVddrMMxJOTdK7MYmmDEr
 +wsyXUWjBcGvVoYt4OphIkRr28tY1me7/4Ahw/y0CGPD5Dm+C6SLZfzZ1MJ3qd6yzjWqkN5q
 z42dCGlvpCzD4EbXst3f8ej4KGu1JUOyBXfTzIuwYTCeoWDnFWvWug8Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	benedikt.niedermayr@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 3/7] Default SWUPDATE_BOOTLOADER to efibootguard
Date: Thu,  8 Jan 2026 16:16:10 +0100
Message-ID: <20260108151650.124306-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
References: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 15:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21484

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The variable SWUPDATE_BOOTLOADER is used to select the A/B root file
system bootloader. In isar-cip-core we default to efibootguard.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                         | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index d2edbbd..59ac49e 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021 - 2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -17,6 +17,7 @@ SRCREV_swupdate-handler-roundrobin ?= "5deb75df5469c5a66cdd727eb72af83ce0784054"
 
 SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 
+SWUPDATE_BOOTLOADER ??= "efibootguard"
 SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "${@ 'swupdate.handler.efibootguard.ini' if d.getVar('SWUPDATE_BOOTLOADER') == 'efibootguard' else ''}"
 SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG') else ''}"
 
-- 
2.51.2


