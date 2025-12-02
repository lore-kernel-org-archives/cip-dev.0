Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE47D11704
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:38 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4098.1764667289759072988
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=UvOQSCOt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20251202092121b4b6246cc9000207e3-jhp1c1@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251202092121b4b6246cc9000207e3
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=vwAQGhiSgv0VqFQMK6XSckIzvvDQjuXRl5agaFz3PSc=;
 b=UvOQSCOtg5quXsTHgG19LQ7BnD7pxSsDj3tUVdyQjfCFU1EcIUWCRTUjr6fvOSZ+nkcZ8W
 aLq0E0ndVlvW4ZtOWSlpRB1vYE1VPnzueqlyGPpqQA1baAG3un8NRVbp9Gf01rDKXEptcnJT
 UitAo+pvE+Lf0Ym2pERS5BK4bktxN1A0MHb77jHwd/Lj4Y3j8czbRS8y/iF40ZAEnExIg3kn
 ZxySlmUv48cZUTeU56c1RuhN9viBE4jqHN+Zvx9BoPwjMI5FkvsG9Ykn1LAElu0wuw3oQZ+8
 Jlbdj2V0uVBPB/llEOgeWAyN8/VKtI/M+u45s5X7pANbJ73VaBsLEPiw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 09/14] kas: Auto-enable targz format for kernelci images
Date: Tue,  2 Dec 2025 10:21:14 +0100
Message-ID: <e5b3eb9de71a4b27bc2816d4b5237f1e041cca4a.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20798

From: Jan Kiszka <jan.kiszka@siemens.com>

This is the only supported format for that scenario, so hard-code this.
Will simplify the CI pipeline configuration.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/kernelci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
index ec907929..517e7410 100644
--- a/kas/opt/kernelci.yml
+++ b/kas/opt/kernelci.yml
@@ -10,7 +10,10 @@
 #
 # SPDX-License-Identifier: MIT
 #
+
 header:
   version: 14
+  includes:
+    - kas/opt/targz.yml
 
 target: cip-core-image-kernelci
-- 
2.51.0


