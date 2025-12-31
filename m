Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625CDEEB564
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:00:53 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88807.1767200439989639331
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: RyubUhpyQXGHiVIbjDQceg==
X-CSE-MsgGUID: brlKtbseRMikVHGOatSEcg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:42 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 94CF74024131;
	Thu,  1 Jan 2026 02:00:41 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/17] clk: renesas: cpg-mssr: Add read-back and delay handling for RZ/T2H MSTP
Date: Wed, 31 Dec 2025 17:00:17 +0000
Message-ID: <20251231170026.17006-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:00:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21287

commit 934dcccf3ffc7568fdeb363842bb9fc36e1be608 upstream.

On the RZ/T2H SoC, a specific sequence is required when releasing a
module from the module stop state (i.e. when clearing the corresponding
bit in the MSTPCRm register to '0'). After writing to the MSTPCRm
register, a read-back of the same register must be performed, followed
by at least seven dummy reads of any register within the IP block that
is being released.

To avoid mapping device registers for this purpose, a short delay is
introduced after the read-back to ensure proper hardware stabilization
before the module becomes accessible.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251014105348.93705-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 4d2d945b3f5e2..68640959f6740 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -308,10 +308,21 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
 
 	spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
 
-	if (!enable || priv->reg_layout == CLK_REG_LAYOUT_RZ_A ||
-	    priv->reg_layout == CLK_REG_LAYOUT_RZ_T2H)
+	if (!enable || priv->reg_layout == CLK_REG_LAYOUT_RZ_A)
 		return 0;
 
+	if (priv->reg_layout == CLK_REG_LAYOUT_RZ_T2H) {
+		/*
+		 * For the RZ/T2H case, it is necessary to perform a read-back after
+		 * accessing the MSTPCRm register and to dummy-read any register of
+		 * the IP at least seven times. Instead of memory-mapping the IP
+		 * register, we simply add a delay after the read operation.
+		 */
+		cpg_rzt2h_mstp_read(hw, priv->control_regs[reg]);
+		udelay(10);
+		return 0;
+	}
+
 	error = readl_poll_timeout_atomic(priv->pub.base0 + priv->status_regs[reg],
 					  value, !(value & bitmask), 0, 10);
 	if (error)
-- 
2.43.0


