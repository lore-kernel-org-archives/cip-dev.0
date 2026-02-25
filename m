Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650CFFD376B
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 15:52:44 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48308.1772034758770876156
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 07:52:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=POZTp+wQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1330684-202602251552361c49b69aec000207e3-kaz_nd@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202602251552361c49b69aec000207e3
        for <cip-dev@lists.cip-project.org>;
        Wed, 25 Feb 2026 16:52:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=n57tkqatypk1VZsTC6J0SDtZifuO1mqlYPTNltvvOM0=;
 b=POZTp+wQ6WFeoyjHpTW5O2Bzy0n3q1RjPuku/hNCB82yI8J9Zoq1ws2Qh/OTTmnlpesSUF
 KU57BOYcfOerBeWBL84BHIGPE5PZQATPpPKJuk0ekCV88g1SAR/rjOlVv/jrybk1ZHrFjaeo
 yONyBZgFQrUv059xtWCyTRWatD32n41Bb2XTncJJCHGiROXGh5ct2OOzDcOor+Hx2Mk522T3
 KejxvT8GLU3YDGzj6bbnbtOtYT2Fryd4rl3S2p+AUi5QN6ZrX7HiscFY6WbZKz5uooKSKqH1
 rsCT1qnfYTD0uUo3F7Qz8iF8HskKjNkkUa6ZZlDKfFkZagztj16fG36A==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v4 1/2] swupdate: Enforce signing and verification for swupdate by default.
Date: Wed, 25 Feb 2026 16:52:25 +0100
Message-ID: <20260225155226.534978-2-alexander.heinisch@siemens.com>
In-Reply-To: <20260225155226.534978-1-alexander.heinisch@siemens.com>
References: <20260225155226.534978-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 15:52:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21985

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Aligned defaults for SWU_SIGNED to enforce signing of swu files
as well as verification in swupdate binary.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 recipes-core/swupdate/swupdate.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
index c92b14a..1f9eda5 100644
--- a/recipes-core/swupdate/swupdate.inc
+++ b/recipes-core/swupdate/swupdate.inc
@@ -32,6 +32,7 @@ def get_bootloader_dependencies(d):
 DEPENDS += "${@get_bootloader_dependencies(d)}"
 DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
 
+SWU_SIGNED ?= "1"
 DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 # add cross build and deactivate testing for arm based builds
-- 
2.47.3


