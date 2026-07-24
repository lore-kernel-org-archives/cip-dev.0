Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA03C5321A
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:49 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18265.1784896844892105859
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=IfntfKW8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20260724124043c52b31ad460002079d-kblh3u@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260724124043c52b31ad460002079d
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 14:40:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=44jQBr5rHf2YhnXoe7FNSxhS/VF+0HYrllvN/DLarWA=;
 b=IfntfKW8At3iAyhSKUD9qLsnYpqtC+gGzBDZnYAWb9Kx+YZ+tB8g4/qdiRP9PlY6nHfnja
 Sy32DjeX/f5hpAYddB6IeB2zjkPM01ZkZ1HDPRjUwCG5mo1poRL1MGO39aytFPDIX5gCZumL
 fvYH99EWVBBtRIGAtXdQ7D4se1jrcYLdlymMmk1O6vngnjcGgTsFS9Dvd64mi9HfgInKZGyj
 cjcBVKp9lJ11AZSm6AuCb0ziyDoSKMOBrzUnaRuv8ilj514jplPoV3gAk9p3tOQol19b6oN+
 m1plaoW5olrFrYt6M98i15u8NpFm0a3T5HJooU22xnvbxevUq6+OcYjQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 07/14] Add kernel hardening to cip kernel build
Date: Fri, 24 Jul 2026 14:39:09 +0200
Message-ID: <20260724124038.3633611-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 12:40:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23744

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This enables the use of the hardening kernel config snippet in the
linux-cip build.

Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 6533523..2519791 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -16,6 +16,7 @@ inherit linux-kernel
 MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
 
 require recipes-kernel/linux/cip-kernel-config.inc
+require recipes-kernel/linux/kernel-hardening.inc
 
 KERNEL_CONFIG_FRAGMENTS:append = "${@(' ' + d.getVar('RT_FRAGMENT')) if d.getVar('KERNEL_NAME') == 'cip-rt' else ''}"
 
-- 
2.53.0


