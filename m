Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1D0C5479B
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 12:43:52 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.19997.1747745027254267249
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 May 2025 05:43:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=HqXk1oFQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20250520124344836cf2619c5e6e3187-tbhukk@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250520124344836cf2619c5e6e3187
        for <cip-dev@lists.cip-project.org>;
        Tue, 20 May 2025 14:43:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=F9Rh3p5bK8HMQm12IsX7SfF6GuWiiw5aIRmAajnw4CI=;
 b=HqXk1oFQmSUx9SS01QIHK0vo67f6aA2SsxV1tRe58jIVA710WHK1CWGAgGMGqxlkPgUEIr
 o4aKWertf5ZCIi7O8f38r227D9KGfz0uhjVKvsfNwDNPLRuH5gBo6DVsTG60hxaK2OZzTEwl
 SajLo3gZVX07KQApWCfe38ae14NDnBpCfCBPFQ94Y+7x9MkXApPW+tsWiKIeAQToF8GDNmZ+
 TGC3y5kdaMyb3y5C8t738fGzO3a5CzVZJtHSyG3FjpSNmWT6Zf1PXrPLft6Y/C6nXvG97U1B
 5ektHj+tBrSUhCTeI+VNgymhJMPC1SmBZ+Gtrprkvfue+U1nGI4hH1AQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/4] linux-cip: Bump cip-kernel-config revision
Date: Tue, 20 May 2025 14:43:40 +0200
Message-ID: <cf92ab3f76d18c1e773b9c776854efa39f4d0ef2.1747745022.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1747745022.git.jan.kiszka@siemens.com>
References: <cover.1747745022.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 May 2025 12:43:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18927

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings support for new 6.12-cip but also some config regenerations
(hopefully without regressions).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 3f9078d5..0e44433a 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "fb0a224685c6ffecfc2e45ec3e4d84eb98727c4a"
+SRCREV_cip-kernel-config ?= "4bebf19735a238f9e46e653751e8d47fb22f8c07"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.43.0


