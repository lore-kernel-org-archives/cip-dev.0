Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E138BD29C43
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 16:25:31 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38516.1768839927748115975
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 08:25:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=cevAQuGF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1330684-20260119162525580f0da58000020755-abnj_f@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260119162525580f0da58000020755
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Jan 2026 17:25:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=r/1mqnDebL1OtD9JBIpl9pPHcQV5R+FCA7l4G0u6dm8=;
 b=cevAQuGFDb9Fhqf4uUgI3BFzD2aovQ/e+IfQfWQmvFPFwBux/lwNTDmTvgUbiBpQbU7rIq
 cULQ3ms9/vyoN7IntOZ5cbmvgBiw2TpOnOtAuPaLBLhAeZXrB+JMHRKbJF2OX9tbb+EKhS0B
 wyAsebKU3XEiZVRYrBQKn+9XyQz9ZzC+deXqFawwgf5fAA7TTLtMo5Y4PYnAf5OK1rZuUDvV
 jaruh8mox7jbxP+1FliTrQyDWUVb6ZHRoTFPIFooZYPjneEdfw7h3RNwlX6UolQ4LGsKH8cE
 +V2gYB2QGjeVDQYhgFjhxdqRRslSVfaOGfCgvosMSzr/Q0rLoppaN4Ng==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] swupdate: Build swupdate with signature check enabled.
Date: Mon, 19 Jan 2026 17:24:43 +0100
Message-ID: <20260119162444.672037-2-alexander.heinisch@siemens.com>
In-Reply-To: <20260119162444.672037-1-alexander.heinisch@siemens.com>
References: <20260119162444.672037-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 16:25:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21676

From: Alexander Heinisch <alexander.heinisch@siemens.com>

In cip images using self built versions of swupdate, the signature
verification is not enabled when selecting swupdate support.

While the image itself got signed, the verifcation part was missing.
Both parts, can be enabled via SWU_SIGNED, but defaults for the
swupdate-recipe and the image diverged.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 kas/opt/swupdate.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index c5b7c61..bc7ec6b 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -23,6 +23,7 @@ local_conf_header:
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
     ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
+    SWU_SIGNED ?= "1"
     PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
     PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
     PREFERRED_PROVIDER_swupdate-signer ??= "swupdate-signer-cms"
-- 
2.47.3


