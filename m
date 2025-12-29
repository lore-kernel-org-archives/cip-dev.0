Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0744E92FF2
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:25 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53287.1767047956505708700
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: pb/Ce2JGQJqK8pUFOa2OGA==
X-CSE-MsgGUID: r6pntZ5aSiuK09KrH92tZQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:19 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EFDBD4005037;
	Tue, 30 Dec 2025 07:39:17 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/17] clk: renesas: r9a09g077: Use devm_ helpers for divider clock registration
Date: Mon, 29 Dec 2025 22:38:57 +0000
Message-ID: <20251229223911.8663-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21261

commit 7a9d0318da5d1d148021d9c9762cefecb552c54f upstream.

Convert the divider clock registration in the R9A09G077 CPG driver to use
device-managed (devm_) helper functions.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251028165127.991351-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g077-cpg.c | 30 +++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index b1b4c66c12bbe..04fbc0539241a 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -164,21 +164,23 @@ r9a09g077_cpg_div_clk_register(struct device *dev,
 	parent_name = __clk_get_name(parent);
 
 	if (core->dtable)
-		clk_hw = clk_hw_register_divider_table(dev, core->name,
-						       parent_name, CLK_SET_RATE_PARENT,
-						       addr,
-						       GET_SHIFT(core->conf),
-						       GET_WIDTH(core->conf),
-						       core->flag,
-						       core->dtable,
-						       &pub->rmw_lock);
+		clk_hw = devm_clk_hw_register_divider_table(dev, core->name,
+							    parent_name,
+							    CLK_SET_RATE_PARENT,
+							    addr,
+							    GET_SHIFT(core->conf),
+							    GET_WIDTH(core->conf),
+							    core->flag,
+							    core->dtable,
+							    &pub->rmw_lock);
 	else
-		clk_hw = clk_hw_register_divider(dev, core->name,
-						 parent_name, CLK_SET_RATE_PARENT,
-						 addr,
-						 GET_SHIFT(core->conf),
-						 GET_WIDTH(core->conf),
-						 core->flag, &pub->rmw_lock);
+		clk_hw = devm_clk_hw_register_divider(dev, core->name,
+						      parent_name,
+						      CLK_SET_RATE_PARENT,
+						      addr,
+						      GET_SHIFT(core->conf),
+						      GET_WIDTH(core->conf),
+						      core->flag, &pub->rmw_lock);
 
 	if (IS_ERR(clk_hw))
 		return ERR_CAST(clk_hw);
-- 
2.43.0


