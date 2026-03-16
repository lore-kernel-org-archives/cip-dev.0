Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E8F53D69
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 15:00:16 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52771.1773673200178532310
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 08:00:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: D9N5XszJTzOBdaAzqBm8nA==
X-CSE-MsgGUID: ZtrZ45+eQdieg5DRz5T4pA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Mar 2026 00:00:08 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 07C5041B7CD1;
	Tue, 17 Mar 2026 00:00:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 29/35] net: pcs: rzn1-miic: Add RZ/T2H MIIC support
Date: Mon, 16 Mar 2026 14:59:06 +0000
Message-ID: <20260316145915.8580-30-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 15:00:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22421

commit 08f89e42121d421b3a6571dd82485a0669beeb45 upstream.

Add support for the Renesas RZ/T2H MIIC by defining SoC-specific
modctrl match tables, register map, and string representations
for converters and ports.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20250910204132.319975-10-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/pcs/Kconfig         | 11 +++--
 drivers/net/pcs/pcs-rzn1-miic.c | 82 +++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index f6aa437473de..76dbc11d9575 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -26,11 +26,12 @@ config PCS_MTK_LYNXI
 	  which is part of MediaTek's SoC and Ethernet switch ICs.
 
 config PCS_RZN1_MIIC
-	tristate "Renesas RZ/N1 MII converter"
-	depends on OF && (ARCH_RZN1 || COMPILE_TEST)
+	tristate "Renesas RZ/N1, RZ/N2H, RZ/T2H MII converter"
+	depends on OF
+	depends on ARCH_RZN1 || ARCH_R9A09G077 || ARCH_R9A09G087 || COMPILE_TEST
 	help
-	  This module provides a driver for the MII converter that is available
-	  on RZ/N1 SoCs. This PCS converts MII to RMII/RGMII or can be set in
-	  pass-through mode for MII.
+	  This module provides a driver for the MII converter available on
+	  Renesas RZ/N1, RZ/N2H, and RZ/T2H SoCs. This PCS converts MII to
+	  RMII/RGMII, or can be set in pass-through mode for MII.
 
 endmenu
diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index d8ba1164c886..c0a52994f962 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -21,6 +21,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <dt-bindings/net/pcs-rzn1-miic.h>
+#include <dt-bindings/net/renesas,r9a09g077-pcs-miic.h>
 
 #define MIIC_PRCMD			0x0
 #define MIIC_ESID_CODE			0x4
@@ -125,6 +126,57 @@ static const char * const index_to_string[] = {
 	"CONV5",
 };
 
+static struct modctrl_match rzt2h_modctrl_match_table[] = {
+	{0x0, {ETHSS_GMAC0_PORT, ETHSS_ETHSW_PORT0, ETHSS_ETHSW_PORT1,
+	       ETHSS_ETHSW_PORT2, ETHSS_GMAC1_PORT}},
+
+	{0x1, {MIIC_MODCTRL_CONF_NONE, ETHSS_ESC_PORT0, ETHSS_ESC_PORT1,
+	       ETHSS_GMAC2_PORT, ETHSS_GMAC1_PORT}},
+
+	{0x2, {ETHSS_GMAC0_PORT, ETHSS_ESC_PORT0, ETHSS_ESC_PORT1,
+		ETHSS_ETHSW_PORT2, ETHSS_GMAC1_PORT}},
+
+	{0x3, {MIIC_MODCTRL_CONF_NONE, ETHSS_ESC_PORT0, ETHSS_ESC_PORT1,
+	       ETHSS_ESC_PORT2, ETHSS_GMAC1_PORT}},
+
+	{0x4, {ETHSS_GMAC0_PORT, ETHSS_ETHSW_PORT0, ETHSS_ESC_PORT1,
+	       ETHSS_ESC_PORT2, ETHSS_GMAC1_PORT}},
+
+	{0x5, {ETHSS_GMAC0_PORT, ETHSS_ETHSW_PORT0, ETHSS_ESC_PORT1,
+	       ETHSS_ETHSW_PORT2, ETHSS_GMAC1_PORT}},
+
+	{0x6, {ETHSS_GMAC0_PORT, ETHSS_ETHSW_PORT0, ETHSS_ETHSW_PORT1,
+	       ETHSS_GMAC2_PORT, ETHSS_GMAC1_PORT}},
+
+	{0x7, {MIIC_MODCTRL_CONF_NONE, ETHSS_GMAC0_PORT, ETHSS_GMAC1_PORT,
+		ETHSS_GMAC2_PORT, MIIC_MODCTRL_CONF_NONE}}
+};
+
+static const char * const rzt2h_conf_to_string[] = {
+	[ETHSS_GMAC0_PORT]	= "GMAC0_PORT",
+	[ETHSS_GMAC1_PORT]	= "GMAC1_PORT",
+	[ETHSS_GMAC2_PORT]	= "GMAC2_PORT",
+	[ETHSS_ESC_PORT0]	= "ETHERCAT_PORT0",
+	[ETHSS_ESC_PORT1]	= "ETHERCAT_PORT1",
+	[ETHSS_ESC_PORT2]	= "ETHERCAT_PORT2",
+	[ETHSS_ETHSW_PORT0]	= "SWITCH_PORT0",
+	[ETHSS_ETHSW_PORT1]	= "SWITCH_PORT1",
+	[ETHSS_ETHSW_PORT2]	= "SWITCH_PORT2",
+};
+
+static const char * const rzt2h_index_to_string[] = {
+	"SWITCH_PORTIN",
+	"CONV0",
+	"CONV1",
+	"CONV2",
+	"CONV3",
+};
+
+static const char * const rzt2h_reset_ids[] = {
+	"rst",
+	"crst",
+};
+
 /**
  * struct miic - MII converter structure
  * @base: base address of the MII converter
@@ -204,11 +256,24 @@ static void miic_unlock_regs(struct miic *miic)
 	writel(0x0001, miic->base + MIIC_PRCMD);
 }
 
+static void miic_lock_regs(struct miic *miic)
+{
+	/* Protect register writes */
+	writel(0x0000, miic->base + MIIC_PRCMD);
+}
+
 static void miic_reg_writel_unlocked(struct miic *miic, int offset, u32 value)
 {
 	writel(value, miic->base + offset);
 }
 
+static void miic_reg_writel_locked(struct miic *miic, int offset, u32 value)
+{
+	miic_unlock_regs(miic);
+	writel(value, miic->base + offset);
+	miic_lock_regs(miic);
+}
+
 static void miic_reg_writel(struct miic *miic, int offset, u32 value)
 {
 	miic->of_data->miic_write(miic, offset, value);
@@ -675,7 +740,24 @@ static struct miic_of_data rzn1_miic_of_data = {
 	.miic_write = miic_reg_writel_unlocked,
 };
 
+static struct miic_of_data rzt2h_miic_of_data = {
+	.match_table = rzt2h_modctrl_match_table,
+	.match_table_count = ARRAY_SIZE(rzt2h_modctrl_match_table),
+	.conf_conv_count = 5,
+	.conf_to_string = rzt2h_conf_to_string,
+	.conf_to_string_count = ARRAY_SIZE(rzt2h_conf_to_string),
+	.index_to_string = rzt2h_index_to_string,
+	.index_to_string_count = ARRAY_SIZE(rzt2h_index_to_string),
+	.miic_port_start = 0,
+	.miic_port_max = 4,
+	.sw_mode_mask = GENMASK(2, 0),
+	.reset_ids = rzt2h_reset_ids,
+	.reset_count = ARRAY_SIZE(rzt2h_reset_ids),
+	.miic_write = miic_reg_writel_locked,
+};
+
 static const struct of_device_id miic_of_mtable[] = {
+	{ .compatible = "renesas,r9a09g077-miic", .data = &rzt2h_miic_of_data },
 	{ .compatible = "renesas,rzn1-miic", .data = &rzn1_miic_of_data },
 	{ /* sentinel */ }
 };
-- 
2.43.0


