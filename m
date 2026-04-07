Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE728EDB7FC
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 10:58:23 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78524.1775559493719073492
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2026 03:58:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: xQp8GQGNS+y9+HBeaBSNEg==
X-CSE-MsgGUID: AeQZPgvJTP6pnLpE5L1rwQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 07 Apr 2026 19:58:16 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.188])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E80B5400FCA5;
	Tue,  7 Apr 2026 19:58:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/10] clk: renesas: r9a09g077: Propagate rate changes through mux parents
Date: Tue,  7 Apr 2026 11:58:01 +0100
Message-ID: <20260407105808.15196-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2026 10:58:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22624

commit e68100006bedc361197e6cb9da1cced87ee3e5b0 upstream.

Enable CLK_SET_RATE_PARENT for mux clocks so that rate changes can properly
propagate to their parent clocks. Several clocks in the R9A09G077 CPG tree
depend on upstream PLL or divider outputs being recalculated when a child
requests a new frequency. Without this flag, rate adjustments stop at the
mux layer, leaving parent rates unchanged and preventing the clock tree
from converging on the intended values.

Set the flag in DEF_MUX to ensure that parent clocks participate in rate
negotiation, which is required for correct operation of the display and
peripheral related clocks being added for RZ/T2H support.

Fixes: 065fe720eec6e ("clk: renesas: Add support for R9A09G077 SoC")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251121090853.5220-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: fixed merge conflict]]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g077-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 979888e89eb93..62e548ea1ebb8 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -71,7 +71,7 @@ enum rzt2h_clk_types {
 #define DEF_MUX(_name, _id, _conf, _parent_names, _num_parents, _mux_flags) \
 	DEF_TYPE(_name, _id, CLK_TYPE_RZT2H_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, .num_parents = _num_parents, \
-		 .flag = 0, .mux_flags = _mux_flags)
+		 .flag = CLK_SET_RATE_PARENT, .mux_flags = _mux_flags)
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-- 
2.43.0


