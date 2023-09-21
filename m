Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89252E70715
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 10:23:40 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.12703.1695291815864610475
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Sep 2023 03:23:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=bTS0Yv0A;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202309211023333545f504c00ac16f63-pwk2rm@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202309211023333545f504c00ac16f63
        for <cip-dev@lists.cip-project.org>;
        Thu, 21 Sep 2023 12:23:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cwIgwMwOZWNyjrwz1d0ITAvCeLgvy9mwkn8zE5328RE=;
 b=bTS0Yv0AFPHEN7GAYGSkEN/wKR0g4MTSOY2JNtACNAD1w14QBsYW5z0ZRz2WK7aZPGg43x
 yLwVIQmaee1t7VrbiUV86154xCxriWZt6PgZ/gJlRkMVy3xRJ3Sc8eC/J6s/8Fw37SmtrHPf
 gIZ+W9sVy+1RDpTHZHaQrMvYbze2w=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 4/5] Make bookworm the default Debian version
Date: Thu, 21 Sep 2023 12:23:30 +0200
Message-Id: <f1ee1157dad948b8e78c491967fda6568555bbb6.1695291811.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1695291811.git.jan.kiszka@siemens.com>
References: <cover.1695291811.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 10:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13195

From: Jan Kiszka <jan.kiszka@siemens.com>

It's time to move on, but not deprecating support for bullseye or buster
this way.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig     | 2 +-
 kas-cip.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index dca137d5..f5ea5aff 100644
--- a/Kconfig
+++ b/Kconfig
@@ -122,7 +122,7 @@ comment "Debian distribution options"
 
 choice
 	prompt "Debian Release"
-	default DEBIAN_BULLSEYE
+	default DEBIAN_BOOKWORM
 
 config DEBIAN_BUSTER
 	bool "buster (10)"
diff --git a/kas-cip.yml b/kas-cip.yml
index 59d7ac25..43e6e47f 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -12,7 +12,7 @@
 header:
   version: 14
 
-distro: cip-core-bullseye
+distro: cip-core-bookworm
 target: cip-core-image
 
 build_system: isar
-- 
2.35.3


