Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D7ECA0EFE
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:39:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.15351.1755679146753582501
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:39:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: euWRnwKnQyuD+xyEmCjrZA==
X-CSE-MsgGUID: J9RRUV5CR9qPjpqr+ypemg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:39:18 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6CE70415F3C9;
	Wed, 20 Aug 2025 17:39:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/22] clk: renesas: rzv2h: Fix missing CLK_SET_RATE_PARENT flag for ddiv clocks
Date: Wed, 20 Aug 2025 09:38:14 +0100
Message-ID: <20250820083855.6337-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
References: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:39:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19775

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 715676d8418062f54d746451294ccce9786c1734 upstream.

Commit bc4d25fdfadf ("clk: renesas: rzv2h: Add support for dynamic
switching divider clocks") missed setting the `CLK_SET_RATE_PARENT`
flag when registering ddiv clocks.

Without this flag, rate changes to the divider clock do not propagate
to its parent, potentially resulting in incorrect clock configurations.

Fix this by setting `CLK_SET_RATE_PARENT` in the clock init data.

Fixes: bc4d25fdfadfa ("clk: renesas: rzv2h: Add support for dynamic switching divider clocks")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250609140341.235919-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index ac6b025911c5..482e8e40d46c 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -383,6 +383,7 @@ rzv2h_cpg_ddiv_clk_register(const struct cpg_core_clk *core,
 		init.ops = &rzv2h_ddiv_clk_divider_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_PARENT;
 
 	ddiv->priv = priv;
 	ddiv->mon = cfg_ddiv.monbit;
-- 
2.43.0


