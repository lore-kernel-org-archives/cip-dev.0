Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4583.1794226524550457157
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Tplh1weI;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.5, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaxfZWpaZfvgSqQ6fOMMEnfFjmDXvhNG6tBszEdQDrWyo3cBzuHrTN+yJtDJS8nG1ASo55LQV152P90mShDmJTDzLZpXGvehw7YXOJ+mh+YpfTWY11RZWNetTr0bFhWp1RMfTAqvM791c13JlF4jl/UwY+HWdYrC4fWx/L633Hte3ZZ8LH+0X+cz5NC6s+vUaBvypYRjOo/aLrlcO85AzMI6pZbbb6RsEIxz+I21TwlqyTdBjXbkXPOHjLjKS2QnNHDT1aLpmq/+PXdxEFQVeTKia5dz3mAce0KVVoF5S286UVyUbkA8/pY/Ly2XEgPf8SHXFk/siDordwH07i8tZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z13FAxqsGgQgDq1D5Vmh9tFtu0QfMNYOYQxhoT1yL6Q=;
 b=IR4znMVxbc/9sGCXYKmpQ0VDMoopPrKSm9snxwW4gtTph7/lmBFG6WZ83hmLjd1mg816coAd71wtCdvIkrcQ8BD1U9T6EYDDUzH1riPNnpD6dnrqUAn6R5OZGkmmnt4pfM47U4WQ80DkuK6isVrhHUqJY/XXEVubxNxxXZD+U0mUBqUak9+APBIqcNU7uD1l/LawuNYQ/xGiY2G2XtoxuQumIwEVOxMbhScfH2vjfUAv8dCDrR7aadDBBpz5hejHOZn781gzm0iOhqHIf1T8W0sx4rJayqfIT2PxXgiBuSDwZOgYD9y+oR5B5/GQ24AfilDeYgXEXKmEyex1bIe50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z13FAxqsGgQgDq1D5Vmh9tFtu0QfMNYOYQxhoT1yL6Q=;
 b=Tplh1weIiSclh3xQrq1PZcxI9JKToGiF4xYWl7Gkcezalwq6EblGNHdwlB9P/XZQB0kvR7idkAu7sFDwAngO40gdVUJcMjaX8+sREfLkqXkHP8z3nh848AoCiKMC6aFpHN0g6CIWfg5IjJwqDDqKoY8dXU3Axw4rdYFir7XG1cQ=
Received: from TYCP286CA0173.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c6::16)
 by OS3PR01MB7996.jpnprd01.prod.outlook.com (2603:1096:604:1be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:17 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6:cafe::48) by TYCP286CA0173.outlook.office365.com
 (2603:1096:400:3c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:15:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:17 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 02307300022D;
	Mon,  9 Nov 2026 21:15:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 14/24] clk: renesas: rzv2h: Add PLLDSI clk mux support
Date: Mon,  9 Nov 2026 12:14:41 +0000
Message-ID: <20261109121451.6042-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|OS3PR01MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 645a5a2d-8413-4fc6-73a3-08df3e5b1ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|260925021911599003|260925022911599003|260925021311599003|11063799006|56012099006|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261102130727099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: K/rJGHP5YF5BYxkp1DQcgeHdlMFHHdq0VkU6XdAjrwGwlIajgjUU46R7BdK1Xj7gLS1H2QEddjohM4jzKun07hS/BF+84LMVQELJKxP/v4/tl7492wBK+YaTDI7CT6OqGG88oDClCXQbGkF93iqTMsnD3K2aqy0es32wlIOhbJrAJb+osBJY85PfTKWDXyIMPVG0pJ+rX/NZgM3zonv3XuLb02UzYaQxZDb4el5/BdQ0QyjWp5NMRmFkDaaezqa5ShoGByTT5NiIPtTN/ImqnpSfS2FfPpInB/Utc/GBNxExvrKI4VD8ynV/+ZMP/7aQRzDfjQCBFnwlGhhRumje/H4xn2yaPqtkrH0MLyJcg1bbHb7/f0ejtgVDThlkFuYmcmVn4hMss2pK5pey1bNdBvFU2mMo99qjdjzoqOjwCXNEwbp7wFPVEDoV7NKNVIprfY3vvFvXo4JJtII7v8vGkwdrr7RZu/D+wWznoeFqb6LdPmZAIe1sk4vgXNZLxCb5nNbfeyU/8vpatUW+wCGnwlQTwaZg4p4bc5gLRdnGSz2dRQGF/XWuzEuX/GvWQrFbQTiyWh2PBJ29ktTNAim1NRUiNa+zZdbzdRlEX4ByDKwz+5oaLBKDbm8vEW+ZBsNcFR7o5oxO4cm1JwUxC272uxTf1aOjblD+lVS+lBnEe7A=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102130727099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pzh5XugI+F+/Yci7XDU31Jn5o08XD6wQZECVCwdf9fPVnUjVxvfrBQRJhdEWIZmC5MGZwrUn6pAeHAnQ/4HqYKf1Tm6jhxDhhzuwgb1/QVrYjKN9K8CkPoIrqagZsLfM38HnIggXlqqapGaKRpgStd16GSRVeXTHzDh6upYbHsyeiUmaE22BIluFNeXvuF6lVe0LVkyniwt8OVCX/z5dqKQiNW9tFL2V+RJ3p20h/BbwyDxQNsaHjDtJu/Zm5PeZ6s5ijCqMi+WCClPKpvAkveqFYRm4aM7Xl6oWQracz4deTtJXIb/Yjr79EaIrHieCSbZE6ysza+KR8yI7FXNycCoNNv+Jq2uv4im0m3SleFg2fhltVgSKarn+9d/lO56UUeMcnFv8J7U3Tv3+anb/5xuIgaggHqM3wvJaA7/1bOsheOBDyQrQCSCQ7V0Dxcrn
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:17.3328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 645a5a2d-8413-4fc6-73a3-08df3e5b1ddc
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24718
Content-Type: text/plain; charset="utf-8"

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

commit 3afccee4a3b88b4ba370916bbb8ab7027221b810 upstream.

Add PLLDSI clk mux support to select PLLDSI clock from different clock
sources.

Introduce the DEF_PLLDSI_SMUX() macro to define these muxes and register
them in the clock driver.

Extend the determine_rate callback to calculate and propagate PLL
parameters via rzv2h_get_pll_dtable_pars() when LVDS output is selected,
using a new helper function rzv2h_cpg_plldsi_smux_lvds_determine_rate().

The CLK_SMUX2_DSI{0,1}_CLK clock multiplexers select between two paths
with different duty cycles:

- CDIV7_DSIx_CLK (LVDS path, parent index 0): asymmetric H/L=3D4/3 duty (4/=
7)
- CSDIV_DSIx (DSI/RGB path, parent index 1): symmetric 50% duty (1/2)

Implement rzv2h_cpg_plldsi_smux_{get,set}_duty_cycle clock operations to
allow the DRM driver to query and configure the appropriate clock path
based on the required output duty cycle.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/24d3853ca2522df21e6a071a23e23ba4ca4b7276.177=
5636898.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 181 ++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h |   8 ++
 2 files changed, 189 insertions(+)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index e309129b73a8f..f3ef7b4a21434 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -76,6 +76,11 @@
 /* On RZ/G3E SoC we have two DSI PLLs */
 #define MAX_CPG_DSI_PLL		2
=20
+#define CPG_PLLDSI_SMUX_LVDS_DUTY_NUM		4
+#define CPG_PLLDSI_SMUX_LVDS_DUTY_DEN		7
+#define CPG_PLLDSI_SMUX_DSI_RGB_DUTY_NUM	1
+#define CPG_PLLDSI_SMUX_DSI_RGB_DUTY_DEN	2
+
 /**
  * struct rzv2h_pll_dsi_info - PLL DSI information, holds the limits and p=
arameters
  *
@@ -418,6 +423,20 @@ bool rzv2h_get_pll_divs_pars(const struct rzv2h_pll_li=
mits *limits,
 }
 EXPORT_SYMBOL_NS_GPL(rzv2h_get_pll_divs_pars, RZV2H_CPG);
=20
+/**
+ * struct rzv2h_plldsi_mux_clk - PLL DSI MUX clock
+ *
+ * @priv: CPG private data
+ * @mux: mux clk
+ */
+struct rzv2h_plldsi_mux_clk {
+	struct rzv2h_cpg_priv *priv;
+	struct clk_mux mux;
+};
+
+#define to_plldsi_clk_mux(_mux) \
+	container_of(_mux, struct rzv2h_plldsi_mux_clk, mux)
+
 static unsigned long rzv2h_cpg_plldsi_div_recalc_rate(struct clk_hw *hw,
 						      unsigned long parent_rate)
 {
@@ -649,6 +668,165 @@ static int rzv2h_cpg_plldsi_set_rate(struct clk_hw *h=
w, unsigned long rate,
 	return rzv2h_cpg_pll_set_rate(pll_clk, &dsi_info->pll_dsi_parameters.pll,=
 true);
 }
=20
+static u8 rzv2h_cpg_plldsi_smux_get_parent(struct clk_hw *hw)
+{
+	return clk_mux_ops.get_parent(hw);
+}
+
+static int rzv2h_cpg_plldsi_smux_set_parent(struct clk_hw *hw, u8 index)
+{
+	return clk_mux_ops.set_parent(hw, index);
+}
+
+static int rzv2h_cpg_plldsi_smux_lvds_determine_rate(struct rzv2h_cpg_priv=
 *priv,
+						     struct pll_clk *pll_clk,
+						     struct clk_rate_request *req)
+{
+	struct rzv2h_pll_div_pars *dsi_params;
+	struct rzv2h_pll_dsi_info *dsi_info;
+	u8 lvds_table[] =3D { 7 };
+	u64 rate_millihz;
+
+	dsi_info =3D &priv->pll_dsi_info[pll_clk->pll.instance];
+	dsi_params =3D &dsi_info->pll_dsi_parameters;
+
+	rate_millihz =3D mul_u32_u32(req->rate, MILLI);
+	if (!rzv2h_get_pll_divs_pars(dsi_info->pll_dsi_limits, dsi_params,
+				     lvds_table, ARRAY_SIZE(lvds_table), rate_millihz)) {
+		dev_err(priv->dev, "failed to determine rate for req->rate: %lu\n",
+			req->rate);
+		return -EINVAL;
+	}
+
+	req->rate =3D DIV_ROUND_CLOSEST_ULL(dsi_params->div.freq_millihz, MILLI);
+	req->best_parent_rate =3D req->rate;
+	dsi_info->req_pll_dsi_rate =3D req->best_parent_rate * dsi_params->div.di=
vider_value;
+
+	return 0;
+}
+
+static int rzv2h_cpg_plldsi_smux_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
+{
+	struct clk_mux *mux =3D to_clk_mux(hw);
+	struct rzv2h_plldsi_mux_clk *dsi_mux =3D to_plldsi_clk_mux(mux);
+	struct pll_clk *pll_clk =3D to_pll(clk_hw_get_parent(hw));
+	struct rzv2h_cpg_priv *priv =3D dsi_mux->priv;
+
+	/*
+	 * For LVDS output (parent index 0), calculate PLL parameters with
+	 * fixed divider value of 7. For DSI/RGB output (parent index 1) skip
+	 * PLL calculation here as it's handled by determine_rate of the
+	 * divider (up one level).
+	 */
+	if (!clk_mux_ops.get_parent(hw))
+		return rzv2h_cpg_plldsi_smux_lvds_determine_rate(priv, pll_clk, req);
+
+	req->best_parent_rate =3D req->rate;
+	return 0;
+}
+
+static int rzv2h_cpg_plldsi_smux_get_duty_cycle(struct clk_hw *hw,
+						struct clk_duty *duty)
+{
+	u8 parent =3D clk_mux_ops.get_parent(hw);
+
+	/*
+	 * CDIV7_DSIx_CLK - LVDS path (div7) - duty 4/7.
+	 * CSDIV_DSIx - DSI/RGB path (csdiv) - duty 1/2.
+	 */
+	if (parent =3D=3D 0) {
+		duty->num =3D CPG_PLLDSI_SMUX_LVDS_DUTY_NUM;
+		duty->den =3D CPG_PLLDSI_SMUX_LVDS_DUTY_DEN;
+	} else {
+		duty->num =3D CPG_PLLDSI_SMUX_DSI_RGB_DUTY_NUM;
+		duty->den =3D CPG_PLLDSI_SMUX_DSI_RGB_DUTY_DEN;
+	}
+
+	return 0;
+}
+
+static int rzv2h_cpg_plldsi_smux_set_duty_cycle(struct clk_hw *hw,
+						struct clk_duty *duty)
+{
+	struct clk_hw *parent_hw;
+	u8 parent_idx;
+
+	/*
+	 * Select parent based on requested duty cycle:
+	 * - If duty > 50% (num/den > 1/2), select LVDS path (parent 0)
+	 * - Otherwise, select DSI/RGB path (parent 1)
+	 */
+	if (duty->num * CPG_PLLDSI_SMUX_DSI_RGB_DUTY_DEN >
+	    duty->den * CPG_PLLDSI_SMUX_DSI_RGB_DUTY_NUM)
+		parent_idx =3D 0;
+	else
+		parent_idx =3D 1;
+
+	if (parent_idx >=3D clk_hw_get_num_parents(hw))
+		return -EINVAL;
+
+	parent_hw =3D clk_hw_get_parent_by_index(hw, parent_idx);
+	if (!parent_hw)
+		return -EINVAL;
+
+	return clk_hw_set_parent(hw, parent_hw);
+}
+
+static const struct clk_ops rzv2h_cpg_plldsi_smux_ops =3D {
+	.determine_rate =3D rzv2h_cpg_plldsi_smux_determine_rate,
+	.get_parent =3D rzv2h_cpg_plldsi_smux_get_parent,
+	.set_parent =3D rzv2h_cpg_plldsi_smux_set_parent,
+	.get_duty_cycle =3D rzv2h_cpg_plldsi_smux_get_duty_cycle,
+	.set_duty_cycle =3D rzv2h_cpg_plldsi_smux_set_duty_cycle,
+};
+
+static struct clk * __init
+rzv2h_cpg_plldsi_smux_clk_register(const struct cpg_core_clk *core,
+				   struct rzv2h_cpg_priv *priv)
+{
+	struct rzv2h_plldsi_mux_clk *clk_hw_data;
+	struct clk_init_data init;
+	struct clk_hw *clk_hw;
+	struct smuxed smux;
+	int ret;
+
+	smux =3D core->cfg.smux;
+
+	if (smux.shift + smux.width > 16) {
+		dev_err(priv->dev, "mux value exceeds LOWORD field\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	clk_hw_data =3D devm_kzalloc(priv->dev, sizeof(*clk_hw_data), GFP_KERNEL)=
;
+	if (!clk_hw_data)
+		return ERR_PTR(-ENOMEM);
+
+	clk_hw_data->priv =3D priv;
+
+	init.name =3D core->name;
+	init.ops =3D &rzv2h_cpg_plldsi_smux_ops;
+	init.flags =3D core->flag;
+	init.parent_names =3D core->parent_names;
+	init.num_parents =3D core->num_parents;
+
+	clk_hw_data->mux.reg =3D priv->base + smux.offset;
+
+	clk_hw_data->mux.shift =3D smux.shift;
+	clk_hw_data->mux.mask =3D clk_div_mask(smux.width);
+	clk_hw_data->mux.flags =3D core->mux_flags;
+	clk_hw_data->mux.lock =3D &priv->rmw_lock;
+
+	clk_hw =3D &clk_hw_data->mux.hw;
+	clk_hw->init =3D &init;
+
+	ret =3D devm_clk_hw_register(priv->dev, clk_hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return clk_hw->clk;
+}
+
 static int rzv2h_cpg_pll_clk_is_enabled(struct clk_hw *hw)
 {
 	struct pll_clk *pll_clk =3D to_pll(hw);
@@ -1095,6 +1273,9 @@ rzv2h_cpg_register_core_clk(const struct cpg_core_clk=
 *core,
 	case CLK_TYPE_PLLDSI_DIV:
 		clk =3D rzv2h_cpg_plldsi_div_clk_register(core, priv);
 		break;
+	case CLK_TYPE_PLLDSI_SMUX:
+		clk =3D rzv2h_cpg_plldsi_smux_clk_register(core, priv);
+		break;
 	default:
 		goto fail;
 	}
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 1f4f1b3dc0a7a..4afcfec92e03a 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -201,6 +201,7 @@ enum clk_types {
 	CLK_TYPE_SMUX,		/* Static Mux */
 	CLK_TYPE_PLLDSI,	/* PLLDSI */
 	CLK_TYPE_PLLDSI_DIV,	/* PLLDSI divider */
+	CLK_TYPE_PLLDSI_SMUX,	/* PLLDSI Static Mux */
 };
=20
 #define DEF_TYPE(_name, _id, _type...) \
@@ -239,6 +240,13 @@ enum clk_types {
 		 .dtable =3D _dtable, \
 		 .parent =3D _parent, \
 		 .flag =3D CLK_SET_RATE_PARENT)
+#define DEF_PLLDSI_SMUX(_name, _id, _smux_packed, _parent_names) \
+	DEF_TYPE(_name, _id, CLK_TYPE_PLLDSI_SMUX, \
+		 .cfg.smux =3D _smux_packed, \
+		 .parent_names =3D _parent_names, \
+		 .num_parents =3D ARRAY_SIZE(_parent_names), \
+		 .flag =3D CLK_SET_RATE_PARENT, \
+		 .mux_flags =3D CLK_MUX_HIWORD_MASK)
=20
 /**
  * struct rzv2h_mod_clk - Module Clocks definitions
--=20
2.43.0

