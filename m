Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36B2C54764
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 14:09:01 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.40997.1708349342844519972
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Feb 2024 05:29:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=S+QXHoLm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1321639-20240219132859c0fbd9d1c5362ed3df-q3pxmg@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240219132859c0fbd9d1c5362ed3df
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Feb 2024 14:29:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=e7afDw2FzvcLF4CeOjVCi1xA+3dvLL7uK/h7rkj2bAI=;
 b=S+QXHoLmKeR3bQVmMJc1BHllFcS4qS6LW6CyFCg6EErPFj5aiwLkhstCF4ooG+XpbziDht
 FWZsWm207173RoabjEzboC/dry8cAkr4T22rgvwyvzyWm4uyNcfyB1g1+9F2BZMEnnonkvKB
 QLyBbzmCs3qfkP3sm1P+UXTk1pp0U=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	shivanand.kunijadar@toshiba-tsip.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC v4 1/3] update ISAR to latest next for dh-compat improvements
Date: Mon, 19 Feb 2024 14:28:48 +0100
Message-Id: <20240219132850.68686-2-felix.moessbauer@siemens.com>
In-Reply-To: <20240219132850.68686-1-felix.moessbauer@siemens.com>
References: <20240219132850.68686-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 14:09:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15039

This patch updates ISAR to the latest version on next which includes
enhanced support for debhelper-compat. While doing so, we switch from
ISAR/master to next and also add this branch to the kas file for easier
tracking.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas-cip.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index b255c97..6130ac2 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,8 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 30471bb3f787fb0aa822d15e141ecce2f3b99860
+    branch: next
+    commit: 07573d7a6030b8b381518387867b6406b1441f09
     layers:
       meta:
 
-- 
2.39.2


