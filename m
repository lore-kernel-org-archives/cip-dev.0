Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51551C7EE2F
	for <webhook@archiver.kernel.org>; Thu,  2 Mar 2023 15:30:50 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.18834.1677770846576666441
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 07:27:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=nEtMEum/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-72506-20230302152724fd9893325caeb33e89-acec1h@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230302152724fd9893325caeb33e89
        for <cip-dev@lists.cip-project.org>;
        Thu, 02 Mar 2023 16:27:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=goUYLnCbE+z6Wgayx9Ahsq+uNzH0fly5PgAojaCCLes=;
 b=nEtMEum/qD6CkSNp6cgSCvUJl2I4uf2tBPe6+Z0C1gPLOfkQEBKm11vchp9fvHwJUwAcZb
 OLHFXsXAPQb97Zii6SCYkTChA8TSqE8YlL0v4bbsGyaFqn9SHgyaimQfR9kFU4dULbhsUSYY
 e6KTlqdrDnqAI2SRwgEWbd2jLswKI=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 2/9] update cip-kernel-config
Date: Thu,  2 Mar 2023 15:26:52 +0000
Message-Id: <20230302152659.2096307-3-felix.moessbauer@siemens.com>
In-Reply-To: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Mar 2023 15:30:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10877

This patch updates the cip-kernel-config revision to 3515389 to get
support for qemu-riscv64.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 7148a98..6dda973 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -23,6 +23,6 @@ SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "ce52837418aea714e780e0cbc8afb9515c12cc1b"
+SRCREV_cip-kernel-config ?= "351538952cfa7c6336e83bf66ca4f3bbdc06f89b"
 
 S = "${WORKDIR}/linux-cip-${PV}"
-- 
2.34.1


