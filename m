Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E960D59F76
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:58:14 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.69367.1730977086117674580
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 02:58:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=ViZ/H/6M;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20241107105804ac167ea13fa6d24719-o_bdh8@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20241107105804ac167ea13fa6d24719
        for <cip-dev@lists.cip-project.org>;
        Thu, 07 Nov 2024 11:58:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4u6dsiZDEDO5OvWsSo1zLwGopKwkaOlJbR+xL8g9VIQ=;
 b=ViZ/H/6MaaSnafYQEAB0O1Muux/cMgGUn/FouJLO7MnAILRPXS5FziYJB158CnjZAwO2ZV
 p6FtBZ28ZGoTJCWLiRUIr/fInW61iPPjvvSORJZjMG3R44vsTo0cFnVPV+BxUw2Tw3jKqwwA
 g/Cvp2nvkIzt9HVO4vENl695eAQqJkO5lySnUZOZsSAS262PZDtpsyf1s0C+laoX2mjUdqPC
 CiaS5/vwz4zjiy5GQbcx60QmYOFWKoq74NG/aA8WrqUst9PYJ+BOFHaBGzRbOlfPWP/7xz39
 txV+EIv4aXG75rGehjJ5hrc4/CrrOOU/TgYpYNO8x1Smmmp8drWCnEpw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>,
	Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 7/9] efibootguard: Use prebuilt python-shtab from trixie onward
Date: Thu,  7 Nov 2024 11:57:55 +0100
Message-ID: <6946d79d99ac67744e9e9c59829a03ffb5809547.1730977077.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17213

From: Jan Kiszka <jan.kiszka@siemens.com>

With trixie, we even get 1.7.1, so we no longer need to use the
self-built version.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
index 63373119..5f1a47e8 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
@@ -34,7 +34,9 @@ PATCHTOOL = "git"
 
 inherit dpkg
 
-DEPENDS = "python-shtab"
+DEPENDS:buster   = "python-shtab"
+DEPENDS:bullseye = "python-shtab"
+DEPENDS:bookworm = "python-shtab"
 
 DEPENDS:trixie = "gnu-efi"
 DEPENDS:sid    = "gnu-efi"
-- 
2.43.0


