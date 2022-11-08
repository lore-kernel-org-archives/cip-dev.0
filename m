Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DAFC43219
	for <webhook@archiver.kernel.org>; Tue,  8 Nov 2022 12:56:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7381.1667912195619553618
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Nov 2022 04:56:41 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.96,147,1665414000"; 
   d="scan'208";a="139360143"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Nov 2022 21:56:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.61])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 100314007204;
	Tue,  8 Nov 2022 21:56:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/3] clk: renesas: rzg2l: Support sd clk mux round operation
Date: Tue,  8 Nov 2022 12:56:30 +0000
Message-Id: <20221108125630.3853219-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108125630.3853219-1-biju.das.jz@bp.renesas.com>
References: <20221108125630.3853219-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Nov 2022 12:56:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9947

commit 1625fbc1f73f1fa8f77c38ea554cc0b2327b156b upstream.

Currently, determine_rate() is not doing any round operation
and due to this it always selects a lower clock source compared
to the closest higher one.

Support sd clk mux round operation by passing
CLK_MUX_ROUND_CLOSEST flag to clk_mux_determine_rate_flags().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220919084110.3065156-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 4d056057f28e..42c6405d6025 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -161,7 +161,7 @@ rzg2l_cpg_mux_clk_register(const struct cpg_core_clk *core,
 static int rzg2l_cpg_sd_clk_mux_determine_rate(struct clk_hw *hw,
 					       struct clk_rate_request *req)
 {
-	return clk_mux_determine_rate_flags(hw, req, 0);
+	return clk_mux_determine_rate_flags(hw, req, CLK_MUX_ROUND_CLOSEST);
 }
 
 static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
-- 
2.25.1


