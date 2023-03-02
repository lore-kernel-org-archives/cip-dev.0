Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C7C678D4
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 20:31:01 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.5529.1677789059735470594
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 12:31:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=N8lc/qwA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-2023030220305725027de5d9cc088d98-oqgdze@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023030220305725027de5d9cc088d98
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 21:30:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=f2Rx+RN2NGB1p7rbxxWFTbuY6aRml6rxHuIfKZkIyj8=;
 b=N8lc/qwAj94k99/f629f46fYC2PtjDqBnwL1TyPl6JMHdWOsRLAstvU9r9f8MVQjtq/hzy
 htWYOfk7kU6FxHyIY93KA1iET9if9wlnHzj2wJewWFGLHCg6inpdtPX6O6L4MeEEeG/3UCA0
 BHE4US+bSgrRQEy3fAeihqgcjslDg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 5/5] security-customizations: Fix password hint
Date: Thu,  2 Mar 2023 21:30:54 +0100
Message-Id: <caf09d788e1af7274774e8c65a8a0f41525080ba.1677789054.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1677789054.git.jan.kiszka@siemens.com>
References: <cover.1677789054.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 20:31:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10886

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/security-customizations/files/postinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index 4ff8ecf6..167bab1c 100644
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -4,7 +4,7 @@
 # Security Package configurations
 #
 
-echo "CIP Core Security Image (login: root/root)" > /etc/issue
+echo "CIP Core Security Image (login: root/Cipsecurity@123)" > /etc/issue
 
 HOSTNAME=demo
 echo "$HOSTNAME" > /etc/hostname
-- 
2.35.3


