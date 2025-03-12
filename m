Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A8C28B30
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.54])
 by mx.groups.io with SMTP id smtpd.web11.34783.1741778641190208736
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XWMgsw7b;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwXnaCYaTzrGvKnvbrYaWWuvwlIzvC3LGixmjzAuDuEv8Edbhg4+qSjKZjuWzzw9ePVYj52GolLpTB375oDO+D3qTj9L1gJdg+MuJl1Kevl3Y0NjcMWsHOOAur7F5on69BPmsYkJGTh1IKSME7SWz/+h43Py9xBIW0GOZqhztAOert9sQ2AOlljj/8sBGq06o+m0El6FVfGZ6iSi05W1nOsB9BFXOABs+1cpXwsMznlC+CYGWLQQA0UPRRa/8Bne+913Ma6pzv6dAVsa+i++bJ++lc8gzKDxS5VrXCa90+8wTuIM9OuoYg5Ut/BWg0iQw15SHZr4XuKiNogAau+1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXjt0ZRi4RIr9pvgTaLnDsFSRfj7sE6IUW6LGEbZvto=;
 b=H6Uua4v0ipk1qR0Z1wjOzrBLnUnDFLwtXkPDXpZh0qeQRCqTwyesjX8KvJj9P+eQuIeDok9EGJxL8pWjRyXRXMv/kHJDHr1rXd57Z9+QGD3gj3UqgyyLyXt0F0/kT1dKo74kHg8qFGq/RRR3WdHjL01zkl1hSqn3qVYbeUOP41D/es00x8M2uqHY5REwwg5VKXpg54najxA8tW8x8uUEqnQyM5EbTco96GS9Kg6Ws6l4ieP6yYolf5xnpmI5A0YFWLsKokhnkpoxYilTrTsD4tcSoasGTMGv+4C/sDIY9anYooRvvTlTAgM2bKk0ExoDwiYOPk7m84sZ6P3J4Udc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXjt0ZRi4RIr9pvgTaLnDsFSRfj7sE6IUW6LGEbZvto=;
 b=XWMgsw7bwMYn/ICKqB04gQeJu7wQHV7RxdyZ2PTQASQGjKfXK9icBg8AiA0wX5dHiCjnFwrRd19cnMNnapEksWyAnxbgbP90rjX9ZYKiQHwD8NRBjuppuQQgwPDdKZeC7gKpACIpHr5tQByk9avvU7dBBY4zQd9SOom87U4S5RA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:23:57 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:23:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/85] clk: renesas: rzv2h: Add support for dynamic switching divider clocks
Date: Wed, 12 Mar 2025 12:21:44 +0100
Message-ID: <20250312112302.1605750-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: a1994865-988d-44eb-95c4-08dd61586153
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4FfQmhy8pjlbYDk9ZhRND8TmDMQj8tO8gnBTkdB5xoH84z4/JWlpjzjzOWTz?=
 =?us-ascii?Q?srtn2FFbkILYE7bT7h42CLLfqSrND81p6yJEqVvJp8xQmwP+e61S+HWzToAl?=
 =?us-ascii?Q?8QvgmTzCuba6Owx8YfTMRrZIeFk8tR0c+6rI03zBpfWnTPBI2BdXOQk+B+mA?=
 =?us-ascii?Q?47qM/2AM3UBrn9OKo6Ew6zl3mWDFDNa1BsaXamnOSkG0XHpsQ9rZdcVGBXlQ?=
 =?us-ascii?Q?oKl1RSCIDOJKosKLnrKJKl1D+dOiI1gNDOvxqrGEUzaL4qst3fbxliiVzQhK?=
 =?us-ascii?Q?G/qRnas+LulLM69xbT5cvyP2gphCcr5kyeZ1L63c/JeO+YM501ES+2JmbH/s?=
 =?us-ascii?Q?WkdR/jqc2WzfJ1xV7EMNBKPif96Ly+e2oXvgDfnh53pY7/cYfZYe/Bb2TKnk?=
 =?us-ascii?Q?/g8EL9DSOp0hr9bdn8aWUomkPVNR10blD6w+lb2F4NxAoRBWDL/XJefjeROH?=
 =?us-ascii?Q?S6yBeTLWu4ZSESOjZAMIvAEUeAN2o1h0Y23aWFXmNE2/v1KX9nJwqCUj4klT?=
 =?us-ascii?Q?TkZAQiLPYABDBWQzUHB+uIAXNd9qM8Bg/bh4Ic1C9VdNdehuIeWZNA3d/ML0?=
 =?us-ascii?Q?YPl8XBXO2uAt0HRJN1+sf+5/MUhJ2CXMyReUhNIULgJXg8eVptSE5bed0Hug?=
 =?us-ascii?Q?yXjgmWC6/lXNVTKkzpmBSSmJ0xApux8z9FU6gro7D6qG1PpDVhmRpOCpRf1E?=
 =?us-ascii?Q?aId9XPEU83580hmLx1shcbC5McWfHq5iCtR/rNgpIQi+Pm5/VNRbqnhRMso6?=
 =?us-ascii?Q?NRWNAktYoLAcUrOa7oGmdqyW+obKkCBrW1BTbqms6rzKpc09Tb8y0ZEFSMzq?=
 =?us-ascii?Q?4DhABMuF2qdUh3yPT3HBrtirIyrYLU9K9M9NplXiEpNau/B6t9phSwXANCfw?=
 =?us-ascii?Q?PPOz66+zOhQU0pTwfJs5HZTePAd6mqnAFpJkIWFLszPUYjvs2tVc9qalhL/w?=
 =?us-ascii?Q?u6MjxySavpIlhXEvW+PJxbCMAmafS7Vdk5VmCrz4pvZBJRZMabX5nXi2e6Z6?=
 =?us-ascii?Q?Auj8hca6J2zUGvulk4qQUbsO7s7HrL9pxYDHHEgNqMWvRHHUwUMaeL3IiYFk?=
 =?us-ascii?Q?whHEnQkKicB/zJsdD2P4+jsiO7j/wb8ezKkDBRHDaHXy9oxQt+p+Rhr5OV3h?=
 =?us-ascii?Q?1fUNVMjHNWsgxdscB+QFn0WOHiaukPAzjdSNb+vrvlc++P9qQFECECpQuO5D?=
 =?us-ascii?Q?4C09TLXh5j/bbzDT3P8MI6NFjUQ/JMJ6KJIzrAqI8WraH/vpEHKfmEw3DK7l?=
 =?us-ascii?Q?Vmjra7aIayxxGiYxtlDYcjG4zxUe2cm9ryW5RKfbWWTnYGAdqEyPZ1JeWqCi?=
 =?us-ascii?Q?0UgOryVsi5G8Q3xGE5QCANuJFEyVavSbNbz7ssHl7kMxhzV4IE6MflYz25BK?=
 =?us-ascii?Q?hfPngMCKRAqQFSUAAr5VviFO4pu64v61I+vIE2TDpjLw5V/1mZZ7nlBnehlU?=
 =?us-ascii?Q?n/rf8w69EkD7ee/vMyEylOMBWcBvGHVQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j0FYkcHar0J5jD5VsTwKtNKf61fPIKtODVJ4kjlydfZLYpiSMF8VXY3gWne9?=
 =?us-ascii?Q?HxsQ8twGTbA8ajW/JI6wI98wYiNUSYgXQBr/bFU2xm4IAVJQPX7vZgkL0W6q?=
 =?us-ascii?Q?zeg11/HaPf+jq1Cq8M0jaxGDAy70Fc4iDnh6cQsY8BCZkFjUbqM8FYMwOCgq?=
 =?us-ascii?Q?kcIPJaWCrFHjQiuT8yI4lX8U21ZHQN02WEE7jMc7TNt8trETUKZeKhilmFji?=
 =?us-ascii?Q?FaKHlRHhwLiDgHbuc6amklOGHulWdtw9rKOYTF8KIQ/LRh6WLTyKeZmM4dQi?=
 =?us-ascii?Q?+7u4RZeIv+dsk0xuUnmQKDMyI3U8cGfpxBRX4ojMLyuk714BNf/Xabt7lvUm?=
 =?us-ascii?Q?ggqfk7jYMaCIwPo33QDpkIx+UI6s4E3zsYA/V6nqiYEoEkCiCnUl9kOz8U8R?=
 =?us-ascii?Q?8WBwPClNIJrs389qx1lgUrzhblG+ZGGWFLwWjBi/PpI7wGLRVOm4arl0973R?=
 =?us-ascii?Q?wjynOtnR1CpUrxzMFMumHv/Yx0lP4ur2761a+eM1iNOj45gNRUIGgCKOgups?=
 =?us-ascii?Q?Waxd/6XYQyb70vHJm2LoeiPN9lJegmB7Gdtd+vpYq0EOCdHQWnYhaXKy5N1v?=
 =?us-ascii?Q?uvZ9lQdwlwhEo3jVQKOk9vKUZvFnL2IdmhOQSVSLQkCIjUEwXkWfatqfR/mU?=
 =?us-ascii?Q?ctZjglwWhTZm5wYJPag4HGZpDo/rI6yAXsjJFI/6baTRGbnv9Jdjt+SF0X5+?=
 =?us-ascii?Q?ct8eer67zko+59KQJn0/UDklb4q1G2gQJfpDPqpRKviNGY4stHCQwnVIg+e9?=
 =?us-ascii?Q?vZ+4Be2tivjsV1N0T9dtEwLMSZVRM7JnCrbK7tcBv0AXYai59dTIKFELOlOg?=
 =?us-ascii?Q?Ydh7D+ttZf6uUifyhr1JXJTF1fuAP1siDYPeXU1cmJxJTvkw1U3xjRYAmBuO?=
 =?us-ascii?Q?KfZk64nnUquNmD2xsH8GI7YKf6e/T6BwhPldJQdm9fBRSITbzATMWEScfbDX?=
 =?us-ascii?Q?40wINioicWeo2iU98cwUCgEF/vVQpObfdVuA881Jmudh9B6Kt9gbo2QxWYZU?=
 =?us-ascii?Q?y+cusubKusBcXRMSsGLeqO7z4XIRMjqpE52bBvjM01WpwBUXE6mnhweC/Kn7?=
 =?us-ascii?Q?rLoSu2+eO7KPnHKXSHhZEIS28pAGI1hS4inAkSe4JUXUT5wc7wcELvxOFzM9?=
 =?us-ascii?Q?6xjVmyGXpla59xMJV/nYFP6m+WITiB0qGKTX7DlHQ2euGL5wpV88KZXRrYNT?=
 =?us-ascii?Q?7cPv7SThwYXjUFfvNGkVyp45bBHNe7eb73IOp3np9Qii+criJIe7us8stB0r?=
 =?us-ascii?Q?UtvxV6nOMbEhtX7X9IVtPKko7rkIN0MWNqgz2cVEwalNvqKbYjmooo+LAiiR?=
 =?us-ascii?Q?wcAVDjVTrj3pSHrMpgyrhN601VxqtvZy2mYWlGd9nutQalbuTLc2J/m+g5Gv?=
 =?us-ascii?Q?fHQNU4ndmr3WXWazrwsMWBdR9w41LKEoOURhxwGOVmxL//CPCCQmOC7A60DW?=
 =?us-ascii?Q?mhLCOvIUP1tgtfzNKgD5huIHak5/8k2ymf2GtGZQMyc7f4a68r6amxQ25jLa?=
 =?us-ascii?Q?PZIhpYh1EldP/J+ubHTzKQR1B4BgyIK4F3CdtN3J/vG+hEBgi2VUftvaW02s?=
 =?us-ascii?Q?UDkwFLujT+AtzKRYFWg2f6PP9Z2PP2jm4as55wBV9+FHFEnyNMa/yyLsnCu+?=
 =?us-ascii?Q?xpoeEKgvT7Jbg4YhG+f/aDg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1994865-988d-44eb-95c4-08dd61586153
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:23:57.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9iGOANemn5xykcPmAQ1sa/eBF/OJb0AioHIUvbY/gSYFDd5iBPwwTmg08d2lmFtQ7teweUa8Ybcam98eXE8UMe96X7b9W6xeGzglLh9s8sv2PmHUosl+tprupvd9vrA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18098

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit bc4d25fdfadfa80dc3ba690792b5220d50ea7b52 upstream.

Add support for dynamic switching divider clocks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240828093822.162855-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


