Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694B4C001E0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.161745.1692195636868099658
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787663"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:36 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7A0804210C24;
	Wed, 16 Aug 2023 23:20:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/31] rtc: rv3032: fix nvram nvmem priv pointer
Date: Wed, 16 Aug 2023 15:19:52 +0100
Message-Id: <20230816142017.147173-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12688

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 767fbb7102c69bedb8dca5a877c4eae4bbf8cf9b upstream.

The nvmem priv pointer is set to rv3032 but the rv3032_nvram_write and
rv3032_nvram_read expect the regmap pointer.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201108223710.1574331-1-alexandre.belloni@bootlin.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-rv3032.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index 9e6166864bd7..e7b343a7ef02 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -889,7 +889,7 @@ static int rv3032_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	nvmem_cfg.priv = rv3032;
+	nvmem_cfg.priv = rv3032->regmap;
 	rtc_nvmem_register(rv3032->rtc, &nvmem_cfg);
 	eeprom_cfg.priv = rv3032;
 	rtc_nvmem_register(rv3032->rtc, &eeprom_cfg);
-- 
2.25.1


