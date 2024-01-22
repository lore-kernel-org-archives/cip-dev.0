Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8238DC4725D
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 09:16:19 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.69494.1705914976900709009
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jan 2024 01:16:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FtEFe52O;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20240122091613401dd5b37fd3c8e088-m3lo0w@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240122091613401dd5b37fd3c8e088
        for <cip-dev@lists.cip-project.org>;
        Mon, 22 Jan 2024 10:16:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=PtDgQAFyU8j2pr+ybGWNweUMgT3pdPLzxq6a22R+UV8=;
 b=FtEFe52OaVwUfsKaWZATPQ4aY/OS1uickUX0wkeHUzxn//M3NW3m3vcUVLa5LDaqT90fYK
 fr0zquvT++z9YzSyn3xAjiH9Rushkzx8YWfvx05OJ9LzK7KTMQKrzMVGG7yCPtRZsqo61nnd
 XF5gMJS0pG0oj7YP3HlNAIgy+H9S4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][{PATCH] efibootguard: Fix broken SRCREV
Date: Mon, 22 Jan 2024 10:15:17 +0100
Message-ID: <20240122091613.18505-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jan 2024 09:16:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14431

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is now the tag version of 0.16-1.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
index 93114c3..d071ff8 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
@@ -24,7 +24,7 @@ SRC_URI = " \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
 SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
-SRCREV_debian = "eacf94e767136a0257850ea0c888d234cb8cace4"
+SRCREV_debian = "ee551bc5239068ce5ab024089cf20385749ae77e"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
-- 
2.43.0


