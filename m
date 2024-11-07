Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48735D4334D
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:58:14 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.69034.1730977083984737231
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 02:58:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=CQYDJ6S3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20241107105801bf0b30ad1638f6f9e5-m5eaeb@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20241107105801bf0b30ad1638f6f9e5
        for <cip-dev@lists.cip-project.org>;
        Thu, 07 Nov 2024 11:58:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GAx0EO1bD2lfZmWu7BUnXUNf32uLViWgdOW3Zc73PSw=;
 b=CQYDJ6S39DCWt1aafAFU4reR8cTCPuWA+eftflqd1cR3a3P5KZIqOukzntrXEjmywgu+zd
 PavRbBEheY22i+FJQLqx7fa6ONcfbQUaolwzyCCgVdaBTtbaWUlf4XHjyV31GV96uDFmFA/k
 VChuApDQjJ5XcY4O/ptpwRt69vMijk/k2IblsrOU06Ne4f0KLvfCFxV5Bztuf9AJKQ0CoLSY
 e2cJJDhJ67yS1YnWd3GKHP1jYzRR04o/tJ83DgAhQHpNmJ2hS6PE4uabHsnC+sy2TxTkuxSd
 EECYa3vWraIzzbeUdVs5JQh9TIyTw8+OXfJFeRenC+HoR9K/awDWLR+A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>,
	Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 3/9] swupdate-signer: Ensure compatibility also with latest openssl 3.3
Date: Thu,  7 Nov 2024 11:57:51 +0100
Message-ID: <c5639090dff12275d318d62fc19289faf6cbf05f.1730977077.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730977077.git.jan.kiszka@siemens.com>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 10:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17205

From: Jan Kiszka <jan.kiszka@siemens.com>

That -check option was probably never official and is now definitely
gone with openssl 3.3 from trixie. In fact, we do not even need it, the
return code is set as expected also without it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-devtools/swupdate-signer/files/sign-swu-cms | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/recipes-devtools/swupdate-signer/files/sign-swu-cms b/recipes-devtools/swupdate-signer/files/sign-swu-cms
index d844e011..cb0cd4af 100644
--- a/recipes-devtools/swupdate-signer/files/sign-swu-cms
+++ b/recipes-devtools/swupdate-signer/files/sign-swu-cms
@@ -10,14 +10,11 @@ error_msg() {
 }
 
 if ! openssl rsa -check -noout -in "$inkey"; then
-	error_msg "key '$inkey' is not a rsa key "
+	error_msg "key '$inkey' is not a rsa key"
 fi
 
-# if openssl > 3.0 we have the x509 check option
-if openssl version | grep -q "3.[0-9].[0-9]"; then
-	if ! openssl x509 -check -noout -in "$cert"; then
-		error_msg  "certificate '$cert' is not a certificate"
-	fi
+if ! openssl x509 -noout -in "$cert"; then
+	error_msg  "certificate '$cert' is not a certificate"
 fi
 
 key_md5=$(openssl rsa -modulus -noout -in "$inkey" | openssl md5)
-- 
2.43.0


