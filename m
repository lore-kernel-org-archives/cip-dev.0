Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14117F459FC
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 17:03:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.160911.1775840584828563060
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2026 10:03:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: 2IgRc8ToSqKR+ovZqFc3HQ==
X-CSE-MsgGUID: dPgA9I6QQu+ynLZPI9tINQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Apr 2026 02:03:04 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.85])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2E8CB402F55E;
	Sat, 11 Apr 2026 02:03:02 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 01/11] clk: renesas: r9a09g077: Add TSU module clock
Date: Fri, 10 Apr 2026 20:02:05 +0300
Message-ID: <20260410170215.393698-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Apr 2026 17:03:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22664

commit 79276fb06d2f7769613abeeed65d69013137cefb upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a TSU
peripheral which is controlled by a module clock.

The TSU module clock is enabled in register MSTPCRD (0x30c), at bit 7,
resulting in a (0x30c - 0x300) / 4 * 100 + 7 = 307 index.

Add it to the list of module clocks.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[cosmin.tanislav: resolve merge conflict]
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/clk/renesas/r9a09g077-cpg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 3d2a67f570220..af54dadb32331 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -220,6 +220,7 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[] __initconst = {
 	DEF_MOD("adc0", 206, R9A09G077_CLK_PCLKH),
 	DEF_MOD("adc1", 207, R9A09G077_CLK_PCLKH),
 	DEF_MOD("adc2", 225, R9A09G077_CLK_PCLKM),
+	DEF_MOD("tsu", 307, R9A09G077_CLK_PCLKL),
 	DEF_MOD("canfd", 310, R9A09G077_CLK_PCLKM),
 	DEF_MOD("gmac0", 400, R9A09G077_CLK_PCLKM),
 	DEF_MOD("ethsw", 401, R9A09G077_CLK_PCLKM),
-- 
2.53.0


