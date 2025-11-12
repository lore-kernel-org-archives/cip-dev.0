Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02423CD13D2
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:12:53 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7868.1762931570728783076
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 23:12:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=bvZTsGM+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20251112071247baff37447c000207c6-bnkarz@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251112071247baff37447c000207c6
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Nov 2025 08:12:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yKUm9H9KbsHppXbw2jW/xbSVdYjK0chgw6fvuxHoplo=;
 b=bvZTsGM+QO3wxx42R7FNis9YXcpDg39X/HDcJ5qEBXtuc3x9MIeziRalRZ1HJJZD01NSUW
 AHjib/1QLHOARn+fgL+YJoXILtCtFHypFots+EZEd4S2gv8cx0H08hjohADvx8qQJkKdkqU5
 HLrE18MhSVSJf6jVQn0tA5svwceBo6jEvv3fdVefG3gykeGzQxT3mfZyAJaJVpZh5s1Hdzzb
 JsP9Kxm/cDio1UOfg33GsE6yGwoXpULkg3JqDqfa6+pVH2MuaW1UlvLAM/4B59V709uRemtz
 7/w/L19OEB/INNdjH+r3WmaJKWgrijZF1iIU6P3a/cQrlTsilDET1QXw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/5] u-boot: Add U_BOOT_EXTRA_BUILDARGS to rules.tmpl
Date: Wed, 12 Nov 2025 08:12:43 +0100
Message-ID: <01cc55d02bfcb8fdd06a17d061cc4588e0a1e57a.1762931566.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1762931566.git.jan.kiszka@siemens.com>
References: <cover.1762931566.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 07:12:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20504

From: Jan Kiszka <jan.kiszka@siemens.com>

Upstream isar introduced that in 02e8053e6824. Will help to avoid forks
of the common rules.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/files/rules.tmpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/u-boot/files/rules.tmpl b/recipes-bsp/u-boot/files/rules.tmpl
index 593919c3..bbf7bb5a 100755
--- a/recipes-bsp/u-boot/files/rules.tmpl
+++ b/recipes-bsp/u-boot/files/rules.tmpl
@@ -24,7 +24,7 @@ override_dh_auto_build:
 		tools/efivar.py set -i ubootefi.var -n db -d secure-boot.esl -t file; \
 	fi
 	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_CONFIG}
-	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_BIN}
+	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_EXTRA_BUILDARGS} ${U_BOOT_BIN}
 	$(MAKE) -n u-boot-initial-env >/dev/null 2>&1; if [ $$? -ne 2 ]; then \
 		$(MAKE) $(PARALLEL_MAKE) u-boot-initial-env; \
 	else \
-- 
2.51.0


