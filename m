Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F72EC001E0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:21:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.162057.1692195660973914437
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:21:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100239"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:21:09 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DFFE74210C30;
	Wed, 16 Aug 2023 23:21:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 20/31] rtc: isl1208: quiet maybe-unused variable warning
Date: Wed, 16 Aug 2023 15:20:06 +0100
Message-Id: <20230816142017.147173-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:21:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12702

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 413b7841f166d851105654c27ade51384d36f003 upstream.

When CONFIG_OF is disabled then the matching table is not referenced.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20210202112219.3610853-9-alexandre.belloni@bootlin.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 563a6d9c9fcf..182dfa605515 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -99,7 +99,7 @@ static const struct i2c_device_id isl1208_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, isl1208_id);
 
-static const struct of_device_id isl1208_of_match[] = {
+static const __maybe_unused struct of_device_id isl1208_of_match[] = {
 	{ .compatible = "isil,isl1208", .data = &isl1208_configs[TYPE_ISL1208] },
 	{ .compatible = "isil,isl1209", .data = &isl1208_configs[TYPE_ISL1209] },
 	{ .compatible = "isil,isl1218", .data = &isl1208_configs[TYPE_ISL1218] },
-- 
2.25.1


