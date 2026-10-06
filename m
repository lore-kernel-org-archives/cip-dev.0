Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE959CC6B2D
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 03:00:08 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37550.1791258187070601731
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Oct 2026 20:43:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=badrikesh.prusty@siemens.com header.s=fm1 header.b=CASn3bmZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1328765-2026100603325864b0da199c00020749-ir4mph@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026100603325864b0da199c00020749
        for <cip-dev@lists.cip-project.org>;
        Tue, 06 Oct 2026 05:32:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=badrikesh.prusty@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=7nLPD+hQq0eIjxIlIQVkBrp2b4RHGXqTrwTeFKBbE+Y=;
 b=CASn3bmZGXQiY9C428vWUYfvk4KR0W9P891SSHZbpOmVO3MfnFdgEezJpz40OczXOvlgjP
 0mEunqgYgks5mIsUsei2NbC75PsFb4PBxVwQRkgBPhMGsKnsxt0SAAVqxoHCoe0RZ3MCL5uU
 JI5mTmJ7ry0S/3oyl7ejk5FNt1+IQJJ90TZotSV+oU63OHr29X9DwNGP3MRMfymNhHsshOCq
 t0SW/1TUdOS5eUP18MXTd0SHc06gtN1j0ER1S++QG277O95VF8uRGr2hI7Z/9LVs8UcV5taQ
 V7GC3YR/4a0kfS5CavcLz4wyhXapERfE7CUw5PyWOholgaCarjUlrMGQ==;
From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Shivanand.Kunijadar@toshiba-tsip.com,
	Badrikesh Prusty <badrikesh.prusty@siemens.com>
Subject: [PATCH] swupdate-handler-roundrobin: Fix Lua version for bookworm and bullseye
Date: Mon,  5 Oct 2026 23:32:42 -0400
Message-ID: <20261006033242.301666-1-badrikesh.prusty@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328765:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 03:00:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24467

SWUpdate 2023.12 on bookworm and bullseye requires liblua5.4-dev, but
the roundrobin handler was being installed to the Lua 5.3 directory,
causing the handler to not be found at runtime.

Update SWUPDATE_LUA_VERSION to 5.4 for both bookworm and bullseye to
match the Lua version used by SWUpdate 2023.12 on these distributions.

This fixes the error:
  feature 'roundrobin' required for image in sw-description is absent!

Fixes: 902ad326 ("swupdate-handler-roundrobin: Keep default lua version as 5.5")
Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index 6e923e4..965e0f5 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -28,8 +28,8 @@ SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if
 
 SWUPDATE_LUA_VERSION = "5.5"
 SWUPDATE_LUA_VERSION:trixie = "5.4"
-SWUPDATE_LUA_VERSION:bookworm = "5.3"
-SWUPDATE_LUA_VERSION:bullseye = "5.3"
+SWUPDATE_LUA_VERSION:bookworm = "5.4"
+SWUPDATE_LUA_VERSION:bullseye = "5.4"
 SWUPDATE_LUA_VERSION:buster = "5.3"
 
 do_install[cleandirs] = "${D}/etc \
-- 
2.39.5


