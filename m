Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5150D11701
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:38 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3933.1764667289341403028
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=PNwsTYeD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-20251202092121f2dd19cd5e000207fd-gtq_vm@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251202092121f2dd19cd5e000207fd
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NLJJwQ9PY/5f5r+slP4OoMqNX+itB72bj1MXB8JKovI=;
 b=PNwsTYeDv3VEOO+e+z/Kzr9PSquytBWsnUDYZ/2vZTX6DRKxcVxsh7opA5nTpRrPVBM2gu
 eQObU4SitWkmha4VQUVim/qZf+igZYwvFW2I7yYCUSZR+68clORWpZErwZe5hFwUNMIhpdRO
 plm/3+hnAW2OzIpTAUvkhc56dpCCw+H4MiWDIE3Q6GpaPecwF/827jhDgNLlHsWKXNT3h0pc
 QeyRX0qprqpB2nB03uMSFQtLgzLpdK2cSdX/j+6l/ocTZCgcsiRY883smAUl1bVVp9Y6qQTu
 q6lE8tvWAV/gcnOnaDmCjqBocFnXImRmQovRtEC9I38EI2E7RBwDduKg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 08/14] Kconfig: Do not offer swupdate or security options without a kernel
Date: Tue,  2 Dec 2025 10:21:13 +0100
Message-ID: <6b42744057af96e3f1c00918aeed3c5ad2e9202b.1764667279.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20796

From: Jan Kiszka <jan.kiszka@siemens.com>

Those variants only make sense for full images with a kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index deb6044d..f8a93c2d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -258,7 +258,7 @@ config KAS_INCLUDE_TESTING
 	string
 	default "kas/opt/test.yml" if IMAGE_TESTING
 
-if !KERNEL_4_4 && !KERNEL_4_19
+if !KERNEL_4_4 && !KERNEL_4_19 &&!NO_KERNEL
 
 config IMAGE_SECURITY
 	bool "Security extensions"
-- 
2.51.0


