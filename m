Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA85C369AB
	for <webhook@archiver.kernel.org>; Mon, 21 Apr 2025 18:30:38 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.22034.1745260230921982637
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Apr 2025 11:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: i0U644v/SC2Dqv7O7UKJ3g==
X-CSE-MsgGUID: WB1xzSgnRS6oAyX5f9qhRA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Apr 2025 03:30:31 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.26])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 87DA7405E62D;
	Tue, 22 Apr 2025 03:30:30 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 2/3] clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const
Date: Mon, 21 Apr 2025 19:30:24 +0100
Message-ID: <20250421183025.632955-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421183025.632955-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250421183025.632955-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Apr 2025 18:30:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18535

From: Paul Barker <paul.barker.ct@bp.renesas.com>

commit b8ae9d344d09b73361493054fbde15b9f5ebe91a upstream.

The r9a07g043_mod_clks and r9a07g043_resets arrays describe the module
clocks and reset signals (respectively) in this SoC and do not change at
runtime.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240320082831.9666-1-paul.barker.ct@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index d3da0d10f4ed..c3c2b0c43983 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -154,7 +154,7 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 #endif
 };
 
-static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
+static const struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 #ifdef CONFIG_ARM64
 	DEF_MOD("gic",		R9A07G043_GIC600_GICCLK, R9A07G043_CLK_P1,
 				0x514, 0),
@@ -297,7 +297,7 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 #endif
 };
 
-static struct rzg2l_reset r9a07g043_resets[] = {
+static const struct rzg2l_reset r9a07g043_resets[] = {
 #ifdef CONFIG_ARM64
 	DEF_RST(R9A07G043_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A07G043_GIC600_DBG_GICRESET_N, 0x814, 1),
-- 
2.43.0


