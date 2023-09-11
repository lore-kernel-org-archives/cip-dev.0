Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA1CEEB57D
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 14:47:42 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.60687.1694443655412777709
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 07:47:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="179428538"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Sep 2023 23:47:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 153CA4003FDD;
	Mon, 11 Sep 2023 23:47:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 12/15] rtc: isl1208: Fix incorrect logic in isl1208_set_xtoscb()
Date: Mon, 11 Sep 2023 15:46:59 +0100
Message-Id: <20230911144702.948246-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
References: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 14:47:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13036

commit f45d32d2cd183c09b6c9aa8689a91d6f2760b557 upstream.

The XTOSCB bit is not bit 0, but xtosb_val is either 0 or 1. If it is 1,
test will never succeed. Fix this issue by using double negation.

While at it, remove unnecessary blank line from probe().

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZN4BgzG2xmzOzdFZ@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Link: https://lore.kernel.org/r/20230817161038.407960-1-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 92ee75fbf4b7..5b0a161f9552 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -188,7 +188,7 @@ isl1208_i2c_validate_client(struct i2c_client *client)
 static int isl1208_set_xtoscb(struct i2c_client *client, int sr, int xtosb_val)
 {
 	/* Do nothing if bit is already set to desired value */
-	if ((sr & ISL1208_REG_SR_XTOSCB) == xtosb_val)
+	if (!!(sr & ISL1208_REG_SR_XTOSCB) == xtosb_val)
 		return 0;
 
 	if (xtosb_val)
-- 
2.25.1


