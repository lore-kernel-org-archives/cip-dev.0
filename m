Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D3EC61DA7
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 14:28:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20658.1700663304421656546
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 06:28:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="187743109"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Nov 2023 23:28:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D577A4010DEB;
	Wed, 22 Nov 2023 23:28:43 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/11] clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum
Date: Wed, 22 Nov 2023 14:28:18 +0000
Message-Id: <20231122142819.203737-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 14:28:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13622

commit eec11486d191c6247e6ffdc898bc31da3cfadcce upstream.

Make vc3_clk_mux enum values depend upon vc3_clk enum values to avoid
any accidental breakage in the future.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230824104812.147775-5-biju.das.jz@bp.renesas.com
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index dd4c1f3b5863..aa36c68ea09a 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -118,14 +118,6 @@ enum vc3_div {
 	VC3_DIV5,
 };
 
-enum vc3_clk_mux {
-	VC3_SE1_MUX,
-	VC3_SE2_MUX,
-	VC3_SE3_MUX,
-	VC3_DIFF1_MUX,
-	VC3_DIFF2_MUX,
-};
-
 enum vc3_clk {
 	VC3_REF,
 	VC3_SE1,
@@ -135,6 +127,14 @@ enum vc3_clk {
 	VC3_DIFF2,
 };
 
+enum vc3_clk_mux {
+	VC3_SE1_MUX = VC3_SE1 - 1,
+	VC3_SE2_MUX = VC3_SE2 - 1,
+	VC3_SE3_MUX = VC3_SE3 - 1,
+	VC3_DIFF1_MUX = VC3_DIFF1 - 1,
+	VC3_DIFF2_MUX = VC3_DIFF2 - 1,
+};
+
 struct vc3_clk_data {
 	u8 offs;
 	u8 bitmsk;
-- 
2.25.1


