Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121AFCCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:12:54 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7682.1762931570791358993
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 23:12:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=MUl8jFI2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-294854-20251112071247935d0279b5000207d5-wjdfop@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20251112071247935d0279b5000207d5
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Nov 2025 08:12:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=bETwZVE3KwgPFiHQ0PgQiD/+6V/hvIC2MSFHKfMrev0=;
 b=MUl8jFI23CEvLBhy4mxAkyhdzkqC8A5y7V8tpCSYV1E1JIU+ziHErMIJRPLr7HqI3lZggd
 l7yrCssk9k7lWKnKkKw0UJ3PzcqQYVSJJ+7pWSPM8AWUSLezCB1eINvl32yoYco1u+2bTfhv
 D0vzFaUGihzc8akRB3Sin3g55Ct4JMYRIoyd6aRCDvVub46YMXrD7vsxCMgkwGWWXnUCzJkz
 37rZCngcgjLV0vK8I4KCY/Fdu2ywLeoWszqhSdXxe7WSUyFNzw38czN1dJhgWN5t5pSOCZRD
 yKD+UKTERyC27XFz17m6Dwj9None1v8SY/dgLEcn1lx59S+XiXMJc2Fw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 4/5] Update isar revision
Date: Wed, 12 Nov 2025 08:12:45 +0100
Message-ID: <f55901885e891313fe0eaf14c21fc5333075cc87.1762931566.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1762931566.git.jan.kiszka@siemens.com>
References: <cover.1762931566.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 07:12:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20508

From: Jan Kiszka <jan.kiszka@siemens.com>

Specifically brings simplified OpenSBI building, some small fix for
initramfs-tee-ftpm-hook and fixes in the recipe dependency chain of
cross-built kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index b7d403f2..806ba182 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: fd711088bc7eb84fb040c0fad5059e79a765bc89
+    commit: 5bb743ad0ae4e87ef5a14ce4897c14694b46d0c5
     layers:
       meta:
 
-- 
2.51.0


