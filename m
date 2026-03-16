Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80138F53D63
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 15:00:16 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52469.1773673205403344636
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 08:00:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 8370ouEHS76xwK5vJYQPUg==
X-CSE-MsgGUID: P6H7LLClSYynTPmk+uXCjA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Mar 2026 00:00:06 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4A44641B7CC0;
	Tue, 17 Mar 2026 00:00:05 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 28/35] net: pcs: rzn1-miic: Add per-SoC control for MIIC register unlock/lock
Date: Mon, 16 Mar 2026 14:59:05 +0000
Message-ID: <20260316145915.8580-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 15:00:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22420

commit 419747319e3a138ed3ee862fe9b66aa1735ae3bf upstream.

Make MIIC accessory register unlock/lock behaviour selectable via SoC/OF
data. Add init_unlock_lock_regs and miic_write to struct miic_of_data so
the driver can either perform the traditional global unlock sequence (as
used on RZ/N1) or use a different policy for other SoCs (for example
RZ/T2H, which does not require leaving registers unlocked).

miic_reg_writel() now calls the per-SoC miic_write callback to perform
register writes. Provide miic_reg_writel_unlocked() as the default writer
and set it for the RZ/N1 OF data so existing platforms keep the same
behaviour. Add a miic_unlock_regs() helper that implements the accessory
register unlock sequence so the unlock/lock sequence can be reused where
needed (for example when a SoC requires explicit unlock/lock around
individual accesses).

This change is preparatory work for supporting RZ/T2H.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20250910204132.319975-9-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 765d6ca4e4ca..d8ba1164c886 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -155,6 +155,9 @@ struct miic {
  * @sw_mode_mask: Switch mode mask
  * @reset_ids: Reset names array
  * @reset_count: Number of entries in the reset_ids array
+ * @init_unlock_lock_regs: Flag to indicate if registers need to be unlocked
+ *  before access.
+ * @miic_write: Function pointer to write a value to a MIIC register
  */
 struct miic_of_data {
 	struct modctrl_match *match_table;
@@ -169,6 +172,8 @@ struct miic_of_data {
 	u8 sw_mode_mask;
 	const char * const *reset_ids;
 	u8 reset_count;
+	bool init_unlock_lock_regs;
+	void (*miic_write)(struct miic *miic, int offset, u32 value);
 };
 
 /**
@@ -190,11 +195,25 @@ static struct miic_port *phylink_pcs_to_miic_port(struct phylink_pcs *pcs)
 	return container_of(pcs, struct miic_port, pcs);
 }
 
-static void miic_reg_writel(struct miic *miic, int offset, u32 value)
+static void miic_unlock_regs(struct miic *miic)
+{
+	/* Unprotect register writes */
+	writel(0x00A5, miic->base + MIIC_PRCMD);
+	writel(0x0001, miic->base + MIIC_PRCMD);
+	writel(0xFFFE, miic->base + MIIC_PRCMD);
+	writel(0x0001, miic->base + MIIC_PRCMD);
+}
+
+static void miic_reg_writel_unlocked(struct miic *miic, int offset, u32 value)
 {
 	writel(value, miic->base + offset);
 }
 
+static void miic_reg_writel(struct miic *miic, int offset, u32 value)
+{
+	miic->of_data->miic_write(miic, offset, value);
+}
+
 static u32 miic_reg_readl(struct miic *miic, int offset)
 {
 	return readl(miic->base + offset);
@@ -430,10 +449,8 @@ static int miic_init_hw(struct miic *miic, u32 cfg_mode)
 	 * is going to be used in conjunction with the Cortex-M3, this sequence
 	 * will have to be moved in register write
 	 */
-	miic_reg_writel(miic, MIIC_PRCMD, 0x00A5);
-	miic_reg_writel(miic, MIIC_PRCMD, 0x0001);
-	miic_reg_writel(miic, MIIC_PRCMD, 0xFFFE);
-	miic_reg_writel(miic, MIIC_PRCMD, 0x0001);
+	if (miic->of_data->init_unlock_lock_regs)
+		miic_unlock_regs(miic);
 
 	/* TODO: Replace with FIELD_PREP() when compile-time constant
 	 * restriction is lifted. Currently __ffs() returns 0 for sw_mode_mask.
@@ -654,6 +671,8 @@ static struct miic_of_data rzn1_miic_of_data = {
 	.miic_port_start = 1,
 	.miic_port_max = 5,
 	.sw_mode_mask = GENMASK(4, 0),
+	.init_unlock_lock_regs = true,
+	.miic_write = miic_reg_writel_unlocked,
 };
 
 static const struct of_device_id miic_of_mtable[] = {
-- 
2.43.0


