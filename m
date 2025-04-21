Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DA8C369D5
	for <webhook@archiver.kernel.org>; Mon, 21 Apr 2025 16:59:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.19917.1745254768476413106
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Apr 2025 09:59:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: ZNWCOv3lSGyrLumPyi6bxQ==
X-CSE-MsgGUID: ozjwfWWyQY+zNcfXCZ30Kg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Apr 2025 01:59:27 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.26])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 35F2C40134EF;
	Tue, 22 Apr 2025 01:59:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/4] clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const
Date: Mon, 21 Apr 2025 17:59:19 +0100
Message-ID: <20250421165921.631205-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421165921.631205-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250421165921.631205-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Apr 2025 16:59:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18530

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
index 6876261252e3..6e2d502fe7eb 100644
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
@@ -293,7 +293,7 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x5ac, 0),
 };
 
-static struct rzg2l_reset r9a07g043_resets[] = {
+static const struct rzg2l_reset r9a07g043_resets[] = {
 #ifdef CONFIG_ARM64
 	DEF_RST(R9A07G043_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A07G043_GIC600_DBG_GICRESET_N, 0x814, 1),
-- 
2.43.0


