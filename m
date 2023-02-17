Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C778DC64EC4
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 13:05:53 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.5858.1676639144708798471
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 05:05:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ob4rQc8E;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20230217130542893ed914943defe4ba-h5dbyy@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230217130542893ed914943defe4ba
        for <cip-dev@lists.cip-project.org>;
        Fri, 17 Feb 2023 14:05:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hhqRL1NRwMqNVDJNshsuOiHUEuW40R+hltrGCBnd0OE=;
 b=ob4rQc8E/cxlIeIvZzO/9sntD5vwBo2AzGaMCnWUvhxzUE1mFJaHbUajqc7QCTlDq+HO19
 K9w/1TwO/l9NQY9I6hFbQemez6S4I6nyACnZgNKSM9WR4v1pxWdeEek/Ky3yNrXigwOk6m/f
 0KY7HJztjG+tlrsbbDByOxjtyWUt4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 1/7] linux-cip: update kernel configuration for tpm2 support
Date: Fri, 17 Feb 2023 14:05:34 +0100
Message-Id: <20230217130540.509910-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 13:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10714

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
2.39.1


