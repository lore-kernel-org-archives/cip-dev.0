Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FC6C47DB3
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 12:23:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.21394.1706876625767381363
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 04:23:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,238,1701097200"; 
   d="scan'208";a="192661184"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Feb 2024 21:23:46 +0900
Received: from localhost.localdomain (unknown [10.226.93.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 87B1A421842C;
	Fri,  2 Feb 2024 21:23:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/6] clk: versaclock3: Update vc3_get_div() to avoid divide by zero
Date: Fri,  2 Feb 2024 12:23:34 +0000
Message-Id: <20240202122338.309435-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202122338.309435-1-biju.das.jz@bp.renesas.com>
References: <20240202122338.309435-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 12:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14630

commit eb16ddb838dd8602961b5fc17d1350cd41ae69e0 upstream.

Update vc3_get_div() to avoid divide by zero operation on
vc3_div_round_rate() by returning1, if there is no table match
found.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20231122142310.203169-2-biju.das.jz@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index aa36c68ea09a..2443ff3b4eee 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -475,7 +475,7 @@ static unsigned int vc3_get_div(const struct clk_div_table *table,
 		if (clkt->val == val)
 			return clkt->div;
 
-	return 0;
+	return 1;
 }
 
 static unsigned long vc3_div_recalc_rate(struct clk_hw *hw,
-- 
2.25.1


