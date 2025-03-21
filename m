Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E1EC36002
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:09 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.34])
 by mx.groups.io with SMTP id smtpd.web10.18683.1742554863785682361
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GNcfLJq8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sD4Zk5WQ7XTlM1u4OGglw372XqpmYQ/1qY84VVKwsD/bxJcvnSQ/QEcRVUDGMpmxlX1pJ73uSnjFwExRVunFuItb3G74AVYdXBB49oRzH61HirW2zX5yOd2wUFUyxeOQLgyhVp0FPGW3TGy3bL3r4C863+blL9UINDGi+equkhW/Xx66Uo0WOJ7bU0vKc7VR9T4urV80QBwg9dhsncZDyjoflUw5LJzK/Ni4QzPD5/vdYb1GDFh1Dk5gjOLFtUTKbg+IiCMwrIu7usm3ytvDlEhLxKDkVrTWjMzWQFvjh8cl1adImTZsLAhg/2Rk+E53Cv6uhUC7B/JcsnZ//TAqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6k4DqyAv+2kQZ6MiuAY40PVg7FbZK3O4C/A1+QkWkw=;
 b=GKhURILue5JBywkOLPBQKLXvS5Qqw/epxn/46X7Gt72qbFbWC8MYgJfRgCeQOAWft4p7ZUu3A1yE4UILGnWa/RKSd04bA5br11hlcMvA6p3qW64qtIfId//wta0GiKvhYJC1fb6mkYcbZjvbT1KatBUBYh4QCXkMTpZSCCuF2hnz7an6iE/2NUFe02WWytZfP9PcOpKbOyza/pheuto3q6S/APaRM1wquFT9juBmLgI6nZGq0M0YrGzLTR6Y/SsuEz8leWjEbkG+iROktgaxO0lKEba/rO900ZEJtZvzDwHf6e5FhKRzAoitHP01+ENuIkLsUTDM/S+hgTK8HOC6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6k4DqyAv+2kQZ6MiuAY40PVg7FbZK3O4C/A1+QkWkw=;
 b=GNcfLJq8VZgZz0XXIu0XDUpVn71xA/xjG7+zWRysUW3G8At1xic/mWZ8SkLFbxN+183iVo2asALFsbVoe9rldX9ywgdhLtNvKQrR7F/0tjbwlIIskTf19y7Fx0J8dtXbv8nVQnVJdGhNwaLrt2etRlyzMZ2jEyPnINhMQEAAs9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB12437.jpnprd01.prod.outlook.com (2603:1096:604:2e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:01:02 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:02 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/21] clk: renesas: rzv2h: Add support for dynamic switching divider clocks
Date: Fri, 21 Mar 2025 12:00:07 +0100
Message-ID: <20250321110021.3612805-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB12437:EE_
X-MS-Office365-Filtering-Correlation-Id: ea73eac5-3c05-4b91-3165-08dd6867ab21
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UEDcsjvaCL2OniHiQk2i5O8y6V45/RXiIfKSpwDWV4176KTVZMtpurWjFrv3?=
 =?us-ascii?Q?YzeCFgI5hI06RXrrVpuOLQQ8a+UobgPIOzg23CKT6grooAyHSKrGnnvVWo8O?=
 =?us-ascii?Q?CWOlM2egdhUkTmQEaSQL/ibzFsUlZYCuv0DIz3HNAQ0WUTeIHpgn6+1Yv5Mb?=
 =?us-ascii?Q?qovycA8CgUdO+suFgw5DpDGuwM4tESrz7im2ROXJ6vtyP/BP3Mi9WOqZCzAB?=
 =?us-ascii?Q?20vOs2NRCA+wd6U7b4dgvL2Wega7Wq+wsShD0Dau6fNIGb5XxFE7e9XCAcEG?=
 =?us-ascii?Q?/VDF9jIu1n37EUjBMQLM1w6kQjhprg0tW+/Qq4ltNSQNGFLd6te9Uv88GPRJ?=
 =?us-ascii?Q?XzRF+Zs050HahLz0nacSm52aDt9Pu1yWymV4RPt4yBl5NJhpxoA5z9FZbvxT?=
 =?us-ascii?Q?wU9YNzDht7HGXt45P5ITYPtPqz0fZhhrCbIBBIrOoG6q8QUGDVR0Fin/13KO?=
 =?us-ascii?Q?qEtykVhD8rVFSNiPNCv3aikPi/sX9cCeVjAYyzxEXwWQqr96+nOHWzJCuDTG?=
 =?us-ascii?Q?slZztAe7HrYR/Lnsm3PfRJk45K09D/E9MWDVIPgiSZLfLyw/I15OWWhbXRVF?=
 =?us-ascii?Q?mlySYsfIPx/po1VMIHLzIt4CVIdEVvTezk/0trA20f/2uINrUiZcQ78TDPjn?=
 =?us-ascii?Q?zjtKHxvuQKhBXh7fdA/RxST4472iChLUh7++xwVOd0mJBevNtnGAhbea22iD?=
 =?us-ascii?Q?Qojtn/Lf1Shmb4wYMKp7HcEBHNkzsXK7P2hFUryjme6Ruj7OOclnHcSbjcDP?=
 =?us-ascii?Q?B0L8IoKBpKrWsDb4otd2bQdy8h7PO4BYnl6yho8flxW+ZqdPG0b5smDBR6QE?=
 =?us-ascii?Q?AE6tx5eSz3VSozOi7M5KPcWWDugD85C5+xdEdE/p1yS+iP1RAEQpERlGwNjh?=
 =?us-ascii?Q?Euc9fZz/M5gZLVZ6nqMwhNgmcihVzINagNoaVhlS54RVboVet0xD2Lkzb0XT?=
 =?us-ascii?Q?ill7jzhdkIAKc5MBwE+TpSOYxD1Sjus2KYLjF7sEa0MDdFkY3b1Cow+brAKX?=
 =?us-ascii?Q?70C7wgUNJe0lzhK37Lr9tEzvMrO+7dzasUy2aA++uSMNoS/o9S4WLOzT2nYQ?=
 =?us-ascii?Q?YTtG1k5FtNcfj5ZwH/lDE+d0fTokep8Jr6v0kpBZ1z0gkm6cLdWs2ZnCashU?=
 =?us-ascii?Q?kyhq3EGo6R18mALFltDPEgIVa2YApaCX6YlaBeZz4w60jvStdG53HQ9Q1WiG?=
 =?us-ascii?Q?PDpEBPsnwREpzRGbUZ0Rmv+UlKCfae7RyEF2rtBZSMNJHWHan7MH2UAUPEBA?=
 =?us-ascii?Q?EOlCUyESAhGusK3Ac8k1NxDXLCkDHG1t0Z9CTPBpUyQG8sa7VsLZHd5p2+2n?=
 =?us-ascii?Q?AyEQVqACIxTwlgTfThreLqH4ReDUDq1xthQomzgwhyzzRuIrMKczZQjHUwhp?=
 =?us-ascii?Q?GheBGEb4Ar7V3iy+92cXTvZBWw6lARQSlMC2meTYPvFmUmjgewTutWH8l4H3?=
 =?us-ascii?Q?CLbeWDOTmvp2jCKiuWBrPbcvgzPnb815?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K5kB3CvCmnKb4Crmmx7WsUcXkDtWbxQ/0vdYllMYeZoHknDEvHSQJx3PAObm?=
 =?us-ascii?Q?755WIQcCB5v0Di6JIhAUUH1xpdpA0q548iW+0iObIamfP31TTR1sNyA2DW3e?=
 =?us-ascii?Q?nBhpjRhLyOSs14Ozbb2oU4qZOfw3w9TF/mIcIok7ZulNYmkSKU3YzwAFx0FT?=
 =?us-ascii?Q?33hnJL1nvetKhFNmKVMpBQ5kMppgpkhy0IhtAkQUKta6f6pGiqOpvcgATnZh?=
 =?us-ascii?Q?DrSFsxpOjQKSePBfPPGJK84IWopKUIXHfED7ilT8CgJ3S0kf2gT6rPV0ywkD?=
 =?us-ascii?Q?CGdF1RJ8sLKoTEomeEeiUMkGa3mK43nlxVVq4/9Sb9olDju5NqbqH0avNzXZ?=
 =?us-ascii?Q?asYGjocVmC0YfbUanRxRLtG4bk4dxnoqvF4/7ueBnLcnhVb1ariLsaIbNNQQ?=
 =?us-ascii?Q?0FEzeq28ZMMJow5hNhYSYKDmlXtoxIBB8Ll1ZTFolUO5XbMVUxJgKzX49161?=
 =?us-ascii?Q?hUtI8JJTVgiAiN+vQ0lKhQ2uHVfAgDda41EbcowR7yK5dKUSNQHoAxeSPyXX?=
 =?us-ascii?Q?llOiUQPFlrbUa+G/rR6g28ks/6EmYG2ZvSZ5LHh9Svjr47yiiqAnfdvdxyuK?=
 =?us-ascii?Q?K6hpper4UhyXySHTBpbMejwPdVv+TUm/7Ar5Du8+8yfPsTVTf2Jb3dsxZ8V4?=
 =?us-ascii?Q?+v+bpjVvHVldZK8hkRaiv+QynUyBPCnbbxWFJMIfYcNiht/l6spH2HwG7Dhv?=
 =?us-ascii?Q?VDoHxrH7hkUFy0Acu59HSH8cjl6/sD9m1fxeBke6VSByu4eaDDz06AOGt6mc?=
 =?us-ascii?Q?UUx/h9JMQ6qw4mkbysemYAlwTXdgzeHpyFyhAJegJn8b1z9fJXq0nNEz9HpP?=
 =?us-ascii?Q?WsRc6UX9bjGsKWTgBQIPyCQMdHkl/bqc7RwU6KekD6WmJh1cRJT1CJz1bXCC?=
 =?us-ascii?Q?fDHrsFa9OUJIaepZm6TngvOl/pi9SYTseARbBKUNfzocjXnreVU7Ouzoe/B0?=
 =?us-ascii?Q?W/tdRoe2nsP5o3hfnAk+n6r/qKmneEhIfFhX69tnmEDk7b9Yx2rGnLB8DHXO?=
 =?us-ascii?Q?2ej9L+/MUb3TV3qBhBZJNL3UTuRJql7FFlu4GLE6pgijclCBHAPovIx6HCiu?=
 =?us-ascii?Q?EndmPY9Bz0k34+m6MONIWHUdxVkHDpTj6TQmZ9KlWpty9+0dHX3SlpCujvwC?=
 =?us-ascii?Q?FrihMvjr1UMQFR51aV+e4sRPUTAxoOtGlp4jlLUrLq3WNuetMghm9ZuZ5MXZ?=
 =?us-ascii?Q?GvH45EMYu7ePK/dfDsPtZf9pDu9+6SrxDKQK26GffaTDSEtRsRpD/Eio0HIu?=
 =?us-ascii?Q?pUERWovCrR3gmmF9nKg98diICwDscQIqLaLnW2Adq2joTCCDb1h9f5oz+hK0?=
 =?us-ascii?Q?vsaOCpsEvFZaFF371Wb6O1JAI0NvWGH9mSts3+G6Hb5AyqZ0wQLK3wjXvbMw?=
 =?us-ascii?Q?kdqzF+IN989ov/89VLXqpxTdOiFNAjMAJSrVGmPdnYdBWV9++YSrTUmDi5BF?=
 =?us-ascii?Q?Q9YfT9n2/IUopzfc9u2tSikpmkde7nau+2rF1AcHdYfb+cB/+0LcZ+NMd4rG?=
 =?us-ascii?Q?KmQ7QNFRnoGkZDvkSXh68DOspLRLxSHdAc7E12v7TQqPZf6qLNyReOtl9FPL?=
 =?us-ascii?Q?vIT0i8vKuJ5ZZIYJ525lV2TOusG6mXf71Xp6YEKLi0m5BDWnkZgdx5XWJfRE?=
 =?us-ascii?Q?yx9uPyDLuuwKx+3ZWvNlzdE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea73eac5-3c05-4b91-3165-08dd6867ab21
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:01.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKupk/cmsrF22zwLMPDPaHPV39UhlBAdW5SKjCO0a5TOOWG+rFxfjGrHUImLPVFOR8k9UMCycTLfCyaswTeGsWz4u6m88R//v3Dfml6TJfV7Or3MEiZO1xlreRHp36+X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18314

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit bc4d25fdfadfa80dc3ba690792b5220d50ea7b52 upstream.

Add support for dynamic switching divider clocks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240828093822.162855-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 165 +++++++++++++++++++++++++++++++-
 drivers/clk/renesas/rzv2h-cpg.h |  39 +++++++-
 2 files changed, 201 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index 4e10cc835c63..9fa00f5c1237 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -45,14 +45,19 @@
 #define PDIV(val)		FIELD_GET(GENMASK(5, 0), (val))
 #define SDIV(val)		FIELD_GET(GENMASK(2, 0), (val))
=20
+#define DDIV_DIVCTL_WEN(shift)		BIT((shift) + 16)
+
 #define GET_MOD_CLK_ID(base, index, bit)		\
 			((base) + ((((index) * (16))) + (bit)))
=20
+#define CPG_CLKSTATUS0		(0x700)
+
 /**
  * struct rzv2h_cpg_priv - Clock Pulse Generator Private Data
  *
  * @dev: CPG device
  * @base: CPG register block base address
+ * @rmw_lock: protects register accesses
  * @clks: Array containing all Core and Module Clocks
  * @num_core_clks: Number of Core Clocks in clks[]
  * @num_mod_clks: Number of Module Clocks in clks[]
@@ -64,6 +69,7 @@
 struct rzv2h_cpg_priv {
 	struct device *dev;
 	void __iomem *base;
+	spinlock_t rmw_lock;
=20
 	struct clk **clks;
 	unsigned int num_core_clks;
@@ -108,6 +114,21 @@ struct mod_clock {
=20
 #define to_mod_clock(_hw) container_of(_hw, struct mod_clock, hw)
=20
+/**
+ * struct ddiv_clk - DDIV clock
+ *
+ * @priv: CPG private data
+ * @div: divider clk
+ * @mon: monitor bit in CPG_CLKSTATUS0 register
+ */
+struct ddiv_clk {
+	struct rzv2h_cpg_priv *priv;
+	struct clk_divider div;
+	u8 mon;
+};
+
+#define to_ddiv_clock(_div) container_of(_div, struct ddiv_clk, div)
+
 static unsigned long rzv2h_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 						   unsigned long parent_rate)
 {
@@ -161,7 +182,7 @@ rzv2h_cpg_pll_clk_register(const struct cpg_core_clk *c=
ore,
 	init.num_parents =3D 1;
=20
 	pll_clk->hw.init =3D &init;
-	pll_clk->conf =3D core->conf;
+	pll_clk->conf =3D core->cfg.conf;
 	pll_clk->base =3D base;
 	pll_clk->priv =3D priv;
 	pll_clk->type =3D core->type;
@@ -173,6 +194,143 @@ rzv2h_cpg_pll_clk_register(const struct cpg_core_clk =
*core,
 	return pll_clk->hw.clk;
 }
=20
+static unsigned long rzv2h_ddiv_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned int val;
+
+	val =3D readl(divider->reg) >> divider->shift;
+	val &=3D clk_div_mask(divider->width);
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->flags, divider->width);
+}
+
+static long rzv2h_ddiv_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+
+	return divider_round_rate(hw, rate, prate, divider->table,
+				  divider->width, divider->flags);
+}
+
+static int rzv2h_ddiv_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+
+	return divider_determine_rate(hw, req, divider->table, divider->width,
+				      divider->flags);
+}
+
+static inline int rzv2h_cpg_wait_ddiv_clk_update_done(void __iomem *base, =
u8 mon)
+{
+	u32 bitmask =3D BIT(mon);
+	u32 val;
+
+	return readl_poll_timeout_atomic(base + CPG_CLKSTATUS0, val, !(val & bitm=
ask), 10, 200);
+}
+
+static int rzv2h_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	struct ddiv_clk *ddiv =3D to_ddiv_clock(divider);
+	struct rzv2h_cpg_priv *priv =3D ddiv->priv;
+	unsigned long flags =3D 0;
+	int value;
+	u32 val;
+	int ret;
+
+	value =3D divider_get_val(rate, parent_rate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	spin_lock_irqsave(divider->lock, flags);
+
+	ret =3D rzv2h_cpg_wait_ddiv_clk_update_done(priv->base, ddiv->mon);
+	if (ret)
+		goto ddiv_timeout;
+
+	val =3D readl(divider->reg) | DDIV_DIVCTL_WEN(divider->shift);
+	val &=3D ~(clk_div_mask(divider->width) << divider->shift);
+	val |=3D (u32)value << divider->shift;
+	writel(val, divider->reg);
+
+	ret =3D rzv2h_cpg_wait_ddiv_clk_update_done(priv->base, ddiv->mon);
+	if (ret)
+		goto ddiv_timeout;
+
+	spin_unlock_irqrestore(divider->lock, flags);
+
+	return 0;
+
+ddiv_timeout:
+	spin_unlock_irqrestore(divider->lock, flags);
+	return ret;
+}
+
+static const struct clk_ops rzv2h_ddiv_clk_divider_ops =3D {
+	.recalc_rate =3D rzv2h_ddiv_recalc_rate,
+	.round_rate =3D rzv2h_ddiv_round_rate,
+	.determine_rate =3D rzv2h_ddiv_determine_rate,
+	.set_rate =3D rzv2h_ddiv_set_rate,
+};
+
+static struct clk * __init
+rzv2h_cpg_ddiv_clk_register(const struct cpg_core_clk *core,
+			    struct rzv2h_cpg_priv *priv)
+{
+	struct ddiv cfg_ddiv =3D core->cfg.ddiv;
+	struct clk_init_data init =3D {};
+	struct device *dev =3D priv->dev;
+	u8 shift =3D cfg_ddiv.shift;
+	u8 width =3D cfg_ddiv.width;
+	const struct clk *parent;
+	const char *parent_name;
+	struct clk_divider *div;
+	struct ddiv_clk *ddiv;
+	int ret;
+
+	parent =3D priv->clks[core->parent];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	parent_name =3D __clk_get_name(parent);
+
+	if ((shift + width) > 16)
+		return ERR_PTR(-EINVAL);
+
+	ddiv =3D devm_kzalloc(priv->dev, sizeof(*ddiv), GFP_KERNEL);
+	if (!ddiv)
+		return ERR_PTR(-ENOMEM);
+
+	init.name =3D core->name;
+	init.ops =3D &rzv2h_ddiv_clk_divider_ops;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+
+	ddiv->priv =3D priv;
+	ddiv->mon =3D cfg_ddiv.monbit;
+	div =3D &ddiv->div;
+	div->reg =3D priv->base + cfg_ddiv.offset;
+	div->shift =3D shift;
+	div->width =3D width;
+	div->flags =3D core->flag;
+	div->lock =3D &priv->rmw_lock;
+	div->hw.init =3D &init;
+	div->table =3D core->dtable;
+
+	ret =3D devm_clk_hw_register(dev, &div->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return div->hw.clk;
+}
+
 static struct clk
 *rzv2h_cpg_clk_src_twocell_get(struct of_phandle_args *clkspec,
 			       void *data)
@@ -254,6 +412,9 @@ rzv2h_cpg_register_core_clk(const struct cpg_core_clk *=
core,
 	case CLK_TYPE_PLL:
 		clk =3D rzv2h_cpg_pll_clk_register(core, priv, &rzv2h_cpg_pll_ops);
 		break;
+	case CLK_TYPE_DDIV:
+		clk =3D rzv2h_cpg_ddiv_clk_register(core, priv);
+		break;
 	default:
 		goto fail;
 	}
@@ -612,6 +773,8 @@ static int __init rzv2h_cpg_probe(struct platform_devic=
e *pdev)
 	if (!priv)
 		return -ENOMEM;
=20
+	spin_lock_init(&priv->rmw_lock);
+
 	priv->dev =3D dev;
=20
 	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 6df59e041701..1c7a979ab790 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -8,6 +8,29 @@
 #ifndef __RENESAS_RZV2H_CPG_H__
 #define __RENESAS_RZV2H_CPG_H__
=20
+/**
+ * struct ddiv - Structure for dynamic switching divider
+ *
+ * @offset: register offset
+ * @shift: position of the divider bit
+ * @width: width of the divider
+ * @monbit: monitor bit in CPG_CLKSTATUS0 register
+ */
+struct ddiv {
+	unsigned int offset:11;
+	unsigned int shift:4;
+	unsigned int width:4;
+	unsigned int monbit:5;
+};
+
+#define DDIV_PACK(_offset, _shift, _width, _monbit) \
+	((struct ddiv){ \
+		.offset =3D _offset, \
+		.shift =3D _shift, \
+		.width =3D _width, \
+		.monbit =3D _monbit \
+	})
+
 /**
  * Definitions of CPG Core Clocks
  *
@@ -23,7 +46,12 @@ struct cpg_core_clk {
 	unsigned int div;
 	unsigned int mult;
 	unsigned int type;
-	unsigned int conf;
+	union {
+		unsigned int conf;
+		struct ddiv ddiv;
+	} cfg;
+	const struct clk_div_table *dtable;
+	u32 flag;
 };
=20
 enum clk_types {
@@ -31,6 +59,7 @@ enum clk_types {
 	CLK_TYPE_IN,		/* External Clock Input */
 	CLK_TYPE_FF,		/* Fixed Factor Clock */
 	CLK_TYPE_PLL,
+	CLK_TYPE_DDIV,		/* Dynamic Switching Divider */
 };
=20
 /* BIT(31) indicates if CLK1/2 are accessible or not */
@@ -44,11 +73,17 @@ enum clk_types {
 #define DEF_BASE(_name, _id, _type, _parent...) \
 	DEF_TYPE(_name, _id, _type, .parent =3D _parent)
 #define DEF_PLL(_name, _id, _parent, _conf) \
-	DEF_TYPE(_name, _id, CLK_TYPE_PLL, .parent =3D _parent, .conf =3D _conf)
+	DEF_TYPE(_name, _id, CLK_TYPE_PLL, .parent =3D _parent, .cfg.conf =3D _co=
nf)
 #define DEF_INPUT(_name, _id) \
 	DEF_TYPE(_name, _id, CLK_TYPE_IN)
 #define DEF_FIXED(_name, _id, _parent, _mult, _div) \
 	DEF_BASE(_name, _id, CLK_TYPE_FF, _parent, .div =3D _div, .mult =3D _mult=
)
+#define DEF_DDIV(_name, _id, _parent, _ddiv_packed, _dtable) \
+	DEF_TYPE(_name, _id, CLK_TYPE_DDIV, \
+		.cfg.ddiv =3D _ddiv_packed, \
+		.parent =3D _parent, \
+		.dtable =3D _dtable, \
+		.flag =3D CLK_DIVIDER_HIWORD_MASK)
=20
 /**
  * struct rzv2h_mod_clk - Module Clocks definitions
--=20
2.43.0


