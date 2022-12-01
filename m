Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C93FC4321E
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 00:17:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.29816.1669853872880056979
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Nov 2022 16:17:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 2B10HaSJ010493; Thu, 1 Dec 2022 09:17:36 +0900
X-Iguazu-Qid: 34tr7GBnhmu3Q6f5ky
X-Iguazu-QSIG: v=2; s=0; t=1669853855; q=34tr7GBnhmu3Q6f5ky; m=XdUnT0yabxEpniWT0ijx4iHfV66G/Q8Zz9cMZW9trvU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 2B10HXSg025188
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Dec 2022 09:17:34 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: pavel@denx.de
Cc: cip-dev@lists.cip-project.org, uli@fpond.eu,
        Peter Foley <pefoley2@pefoley.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH] extcon: adc-jack: Fix incompatible pointer type warning
Date: Thu,  1 Dec 2022 09:17:08 +0900
X-TSB-HOP2: ON
Message-Id: <20221201001708.1695254-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 00:17:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10146

From: Peter Foley <pefoley2@pefoley.com>

commit 8a522bf2d4f788306443d36b26b54f0aedcdfdbe upstream.

This patch fixes the incompatible warning of extcon-adc-jack.c driver
when calling devm_extcon_dev_allocate().

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
[cw00.choi: Modify the patch title and descritpion]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 include/linux/extcon/extcon-adc-jack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/extcon/extcon-adc-jack.h b/include/linux/extcon/extcon-adc-jack.h
index 53c60806bcfb6d..373b76a90ed41c 100644
--- a/include/linux/extcon/extcon-adc-jack.h
+++ b/include/linux/extcon/extcon-adc-jack.h
@@ -58,7 +58,7 @@ struct adc_jack_pdata {
 	const char *name;
 	const char *consumer_channel;
 
-	const enum extcon *cable_names;
+	const unsigned int *cable_names;
 
 	/* The last entry's state should be 0 */
 	struct adc_jack_cond *adc_conditions;
-- 
2.36.1



