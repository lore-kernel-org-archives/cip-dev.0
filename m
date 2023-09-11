Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35FBEEB57D
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 14:47:32 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.60527.1694443636159672754
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 07:47:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="175705271"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2023 23:47:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9977F4004940;
	Mon, 11 Sep 2023 23:47:27 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/15] regulator: raa215300: Add missing blank space
Date: Mon, 11 Sep 2023 15:46:57 +0100
Message-Id: <20230911144702.948246-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
References: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 14:47:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13034

commit 6673fc98953231f5d85f780d3025ea95c7584683 upstream.

Add the missing space in the comment block.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZN3%2FSjL50ls+3dnD@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230818141815.314197-3-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/regulator/raa215300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/raa215300.c b/drivers/regulator/raa215300.c
index ffcdd4ac2bc4..13a21c1f5004 100644
--- a/drivers/regulator/raa215300.c
+++ b/drivers/regulator/raa215300.c
@@ -86,7 +86,7 @@ static int raa215300_i2c_probe(struct i2c_client *client)
 	val &= RAA215300_REG_BLOCK_EN_RTC_EN;
 	regmap_write(regmap, RAA215300_REG_BLOCK_EN, val);
 
-	/*Clear the latched registers */
+	/* Clear the latched registers */
 	regmap_read(regmap, RAA215300_FAULT_LATCHED_STATUS_1, &val);
 	regmap_write(regmap, RAA215300_FAULT_LATCHED_STATUS_1, val);
 	regmap_read(regmap, RAA215300_FAULT_LATCHED_STATUS_2, &val);
-- 
2.25.1


