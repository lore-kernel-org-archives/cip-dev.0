Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50ECC433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 11:54:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.30350.1641815634920037812
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 03:54:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106552731"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 20:54:09 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E4402429BEB4;
	Mon, 10 Jan 2022 20:54:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 15/15] clk: renesas: r9a07g044: Mark IA55_CLK
 and DMAC_ACLK critical
Date: Mon, 10 Jan 2022 11:53:48 +0000
Message-Id: <20220110115348.14297-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 11:54:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7364

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 664bb2e45b89cd8213e3c9772713323f75e21892 upstream.

Add IA55_CLK and DMAC_ACLK as critical clocks.

Previously it worked ok, because of a bug in clock status function
and the following patch in this series fixes the original bug.

Fixes: c3e67ad6f5a2 ("dt-bindings: clock: r9a07g044-cpg: Update clock/reset definitions")
Fixes: eb829e549ba6 ("clk: renesas: r9a07g044: Add DMAC clocks/resets")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20210922112405.26413-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 4c94b94c4125..1490446985e2 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -186,6 +186,8 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 
 static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A07G044_GIC600_GICCLK,
+	MOD_CLK_BASE + R9A07G044_IA55_CLK,
+	MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
 };
 
 const struct rzg2l_cpg_info r9a07g044_cpg_info = {
-- 
2.17.1


