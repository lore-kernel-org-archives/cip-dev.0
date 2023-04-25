Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94BFC77B7C
	for <webhook@archiver.kernel.org>; Tue, 25 Apr 2023 10:48:47 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.76328.1682419719878722501
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Apr 2023 03:48:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=bENH4KTi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2023042510483786702246d823820756-lnj_ha@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023042510483786702246d823820756
        for <cip-dev@lists.cip-project.org>;
        Tue, 25 Apr 2023 12:48:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=t21x8IcN/qa4iEyHVkdaNbh+TcI7T5DUhz0Jpdf+G/c=;
 b=bENH4KTi85ZYj2UUFK69xw8nvzvqpf9G6YrEEtngOeGAZTCDy06NtvHgZrAWtyWIU3WDqd
 v7ckM1/TOPCi1MIUUD9OZL+P9AQB64LgV5AX6/wmuHZfbISVnK/WcwawtZwsTFKpEtzPnUVL
 tDg/JspURbWUjlWqvijUSm9rtJgb8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 3/6] linux: Add missing kernel option for LUKS2 encrpyted partitions on buster
Date: Tue, 25 Apr 2023 12:48:32 +0200
Message-Id: <20230425104835.655946-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230425104835.655946-1-Quirin.Gylstorff@siemens.com>
References: <20230425104835.655946-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Apr 2023 10:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11343

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

cryptsetup uses the user api of `CONFIG_CRYPTO_USER_API_SKCIPHER`
to generate the keys.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/files/buster-crypt.cfg | 2 ++
 recipes-kernel/linux/linux-cip-common.inc   | 1 +
 2 files changed, 3 insertions(+)
 create mode 100644 recipes-kernel/linux/files/buster-crypt.cfg

diff --git a/recipes-kernel/linux/files/buster-crypt.cfg b/recipes-kernel/linux/files/buster-crypt.cfg
new file mode 100644
index 0000000..e3ca518
--- /dev/null
+++ b/recipes-kernel/linux/files/buster-crypt.cfg
@@ -0,0 +1,2 @@
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
+
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 2d878a1..762a86b 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -24,5 +24,6 @@ SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
     }"
 
 SRCREV_cip-kernel-config ?= "0188d9a54615767c00b77116146409edfa35497c"
+SRC_URI:append:encrypt-partitions:buster = " file://buster-crypt.cfg"
 
 S = "${WORKDIR}/linux-cip-${PV}"
-- 
2.39.2


