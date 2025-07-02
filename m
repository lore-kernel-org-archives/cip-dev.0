Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFD7C8303F
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:23 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.16])
 by mx.groups.io with SMTP id smtpd.web10.20510.1751452574691991287
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:36:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Zdec9qDZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.16, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJV/1ZfeeMh2KnAx2qTO7euU7honpUwUfAxmG8qfGa7kBb669Xm8MKjdf2u1OPn3RruqQk/H1MnH6WSze7LmzHWT+ID+45hZ0E1d73D/ONywYuZt6uzIdeyEmV466dhO6Z5NhwH61Ktzk2nODJqIsbMeTwmuv8ciJPnlKbUom+Ddv03OkR5WXpNGYpcJa9IcdqztdCeeelFxAU1kVqJfoMYfIcuw7hU4JaRSn6ALWrp/WpS4205o3IVrrKvvlSNDvyHlpQNcT/PavHUuviZWDGMoLMQWu0WCkuhgfoVLKLmBpYuxAY/qK/96peV1kW1HcKXyusIHmwEpQMhvdDaUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73wudY8AkmKywKYKrVU16oEhqZU6efEUG4+koVt8SFg=;
 b=GY8jKmF/2CwcaTN7ld6+4/zYK5fxEXnqmdyDMFOVBkpXvTHz+XgAz3AMkLBFYy9Gm7m57G0T9rRYBzkBO8S7ShsgAnBVtdlR6iCdBDwqVIO1clYf4gmcmr70lPcBdRW12zldfANADdnmHoqX9VlZDOikx4eOoH1K2Gui8gLKZNvqZOeaGAfZ0IOZ75btW3oX9aEa9E3gmku3S5PO36GR2WPLtM2VRMOLqZF5uhGtxd29HlpA97Cxgynz7TqefHRkDdQxBzdGgYY5WGf9WE0x2tHZ7bhaoW0GKke83sugBswjwNaVKXa6M56x1YLmwyBwzGey22TUQOojw1CdSo7Hyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73wudY8AkmKywKYKrVU16oEhqZU6efEUG4+koVt8SFg=;
 b=Zdec9qDZuDsfCtUCsQ36BQABRyCfyQXBA65MAPgUvQgEn+aADBeqLW2qmRCn+ktQE0o1aF8pfpGlLWGyr3SHvTJOAMrXkmoIoFYzKuBV5X+nP52npQUAf8vrr5taozwZX5W1VvnKC6x4bi5Isz//oWIb9FwTEG8KjcsDzEYQUyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:36:11 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:36:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/12] clk: renesas: r9a09g057: Add clock and reset entries for GE3D
Date: Wed,  2 Jul 2025 12:35:21 +0200
Message-ID: <20250702103525.117166-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: a8312480-c3bd-44f6-9011-08ddb95442dc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zZT3E33cfDHZhxcVwFFt0J+OaTETxojLgXfsCPP/uy33aUP5l9R3mYK1NA5H?=
 =?us-ascii?Q?ZWV2aXpVPZIKrM6yaZtHIVv/glzPlrSG/IfeMagueutpJ+HGEzzQelHaCB+S?=
 =?us-ascii?Q?zkvhtMUFcNQ0RSKnE/7p8CSu5lD2UmrgZuk41ES7xdnxclYaK+HHKNN8nrUv?=
 =?us-ascii?Q?N4nok7k8mL2iWCJSY8yWwfYXOpcvGRJ2JvQXH5RCRr6xO8wqJeylEEqqQEK+?=
 =?us-ascii?Q?mHIM92vsVPpk3oSxCXGw55XyjCwOvJgcz+JP12a5t4zM1c+rrBoa7Ypvx9GZ?=
 =?us-ascii?Q?O6cyVPUZ4xZM89ttcg9P3nDVbc7hrWoLD3suplBoVSa+HfjnRSRofMyoAm0k?=
 =?us-ascii?Q?OrjiwI5RVx4gVky+rhstk44yEA/W1rnZss8m83wGLULBhPeC9hdDoc6bcZYj?=
 =?us-ascii?Q?/8mVIHqdGKBLvS6gDJ2mpOwE98WZu533UZYxnSkeDTQLGkx96ZAdSC7KNB1K?=
 =?us-ascii?Q?o6E8ggn3YMZQL998Ky57aheISSS0e2f1Jrk5UGYh5Emst5g0c8AWplVAANpp?=
 =?us-ascii?Q?Qv4U5Li19EfoXcv/aQIPAqiKeDW+6ZwcQePisYB/SuZ9dMKam5rLwxBhhEEp?=
 =?us-ascii?Q?twY0tz/1WcPjSfWsxBn2t2rk5MkKjnSZieclB4KcLO/+c9sLLbeaXzri+zUj?=
 =?us-ascii?Q?2bOp104Hw8QL/JrSDleV2u5mmN4Xbv4S8Tkej8gjo4j0EySGWcuJUsf25XQ/?=
 =?us-ascii?Q?imBEnXrfWHXDZMmtliKt0Cl/FD6ifBaTWIOohyECUZJe6NlwYyjgp8MKdKwi?=
 =?us-ascii?Q?y3NyhwV5Z0DJcNjhSaP4aE0yu4SNJXfU4jDAv5UcrdgeJQ4DlHlildeIFKKM?=
 =?us-ascii?Q?ISNVhEYFrgMvTggS6A1pLdJq5xb7D14ZOQgMQl9Fdg/AEQKdh30iQtugmYv/?=
 =?us-ascii?Q?cuIFwNVVTXZBjr6JYmzhVUFF2XXE/QMybUoCSSouyv6f3mZJjNbfpcEZvctR?=
 =?us-ascii?Q?4uf93b5DIb2EjMyenxh4aU3FAkUXRS3vaSsfSRLHbSZX2av0qYoA9XHOo959?=
 =?us-ascii?Q?t68UR/vXzeUVg+/a9akYpBWtuxJoecfIHJjRugLGNADMMSobgyGq0TDwRoAY?=
 =?us-ascii?Q?G6YeGjJ9h6H5Ov4SnHj6mLM1+zuZ2h3QlKo24EjrIVvPfI0dmvsUasHsUBrl?=
 =?us-ascii?Q?VZtkBFIm6qyZXX37tgD6goo0ckXIiYEUoQB/eslVTErP1AjFuDk5EdJf3JgO?=
 =?us-ascii?Q?uTM46thYTbmzCgU2RM+CdYbBnLu4C5vwcBi54iNBLX6NE1aRm9TgpoMCs7Zo?=
 =?us-ascii?Q?Kzc9rorQOkWIsQva2QSXgOJbjvtcSnUs20GuVpVeUb1YyZXgzn1hrWLuWVTW?=
 =?us-ascii?Q?BOPgQkEFzxe3I8UyxVu48Zu0QAWArNt+Gxrz77AufWXIlRbo6VPadBlD42kq?=
 =?us-ascii?Q?AdZ6K6LN0rsA32kcQX2tNACXWaLU1TTG8Xx85EE3yrWr6W33NPzplzEVPT0t?=
 =?us-ascii?Q?/3+fYGDgKpwQ1wxoqV8rpgYiABvjcE8QquRt2GAXfWYfW/Icwn5XtcZzXdbc?=
 =?us-ascii?Q?2fkcBosXFoUi1mk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?veVUeuM3IfGh5pRHuBT0v4V4Uhq70uG4TM59HXYsmB4gPeDGXEpSF+LFBABQ?=
 =?us-ascii?Q?8c9NjmULiolcF5D7mEAjwi7j7dcq/kc6kTor0CIpojoWhkZuXz4TsRtPlJX+?=
 =?us-ascii?Q?YQ65kNizPd9prTii6mR14ynMapl4fbeMivQf7llZ0RbT+erw74eASpUe6y//?=
 =?us-ascii?Q?JjqDUYWYNLnZKE180m/jXD9oPTDn67eiSDH/OxGzCo67G3unrQJq4owS9B9u?=
 =?us-ascii?Q?1t6qeWOcUIQHayHbtAJcHxxCyrZmJ3Bh1HHbQAb9ptZIEKIopconZlRR2TPk?=
 =?us-ascii?Q?/rubSzHOF6bnivH3WhG4+vy3+rIKzU0GYI3OEGLvwbSNjl4EbDZE/OZbhNor?=
 =?us-ascii?Q?GbjO/lQhNIU+sVw/WtWBCC5Hn9MnHESTJzVzOrBbQDqEorWXDGmuaTNaOqPi?=
 =?us-ascii?Q?zsOnGoTa6HRe6OpIuHL4D5DAYAPwKucQJCnEg0fCLdZIgpSvPaOm7fzxENzO?=
 =?us-ascii?Q?nFCCEwXyD5AFG8E4Dpl2IgsKeMNPUHg1katMrnXxGqHw4gADNduUrLONslxR?=
 =?us-ascii?Q?l8ysIGpXT348QbBbhO9EABxZPucHBoQ4M249IsbIJg+aag5i7ci1O9+3CFoI?=
 =?us-ascii?Q?XCYTcn+uNiZu1zICqSAvvhu2UCW/kuLl9miXhBornuiXOfJNNte+iTGzegdz?=
 =?us-ascii?Q?+4UukYyLjnULOvkuIKoqMK3mLluofXqWqowSo38dA6LTn6eIvX3RN7c/dMNw?=
 =?us-ascii?Q?Nv430wBeCaoVOl3fhmUwFIi1pIhmcBDbeoiFV6KfXMJHrZ1skSnD8bCfxrdo?=
 =?us-ascii?Q?zfru/jYS0wnAOXkudj3mycj2V7/5xKAtT8x+wQZXSyTWRGLv0SsbTsZzj6yh?=
 =?us-ascii?Q?+eIKB7Rbn/xcXeFt9RcO7sV/NctuLim/nQYqqPi8r6ngm6ABQ0GzsKXN4W2x?=
 =?us-ascii?Q?cjIVwC8kx+0CCLlEcK0ibJS75gmWENX0kW/pL2QmTG4lxLdvuBxDIhmWhc8n?=
 =?us-ascii?Q?HL06cNgExZHpCHK2DzNshHhM9/CW+y58m+Bx2QeuB37Muo9eJmKzlDeu0gWm?=
 =?us-ascii?Q?8VFJwDiijw1qgTLZs72jst05AwCSw3gMBPMU4lgIyKk3LDwwYgWb+kVGhlIT?=
 =?us-ascii?Q?od76PGskHdsmJO9BUmYlh8vqyS4EK7qLht1yz0lgi67nQX0ovaXQG9ETda6c?=
 =?us-ascii?Q?QoBRLK25bn0S4vQdtLik6BsfP45HOZyxVLRdLCsBB/Prt41GZicv9BBVi1ma?=
 =?us-ascii?Q?LD7eO4ACId4F7zLKsj87LyZaoepazKuPHd0UOnDWmYT5z0wUMg1LKCrB8Gg2?=
 =?us-ascii?Q?6b7WhQtzfxziBn3Mx6UdUapXb/2KA+QL+0z2aUmfZkJnh4jIf9Myp9f9sqzv?=
 =?us-ascii?Q?MvbPCtOl7Jeo25nHemt743CFoiXwZ4i0GLeONXIMZYeEc/sra80cJfJ0f8xl?=
 =?us-ascii?Q?eKe6B/uo1ZIJcCullP+X+x2qA/2WMz0L4PIBJBbkT/Oqsxg9CrKlN/GmC3UA?=
 =?us-ascii?Q?fKlXm04Qh7Z5U7K1d81k2y1CXLFNIdVqgCqYtZeZAFeWP+cV40Rim5PBkjhe?=
 =?us-ascii?Q?JbpMkngBUwcUz9NyAztKLmVpcbDovbbvZ0nOtuEDYi7y1UhYR3iJNe71b17L?=
 =?us-ascii?Q?hlDbqS3da55jM+/L+RpaFs04No3dhrYe+0zaIdP3FIq2quc8/2ik5sAWUIOO?=
 =?us-ascii?Q?pu5fWfJvWAphlRBljL1tzhs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8312480-c3bd-44f6-9011-08ddb95442dc
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:36:10.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrSIYV4ELfUtN9ldrhQheXVpHXe0fwZYRn0KZ0s7qNLiVMFM+qAONbA11wCd+CwYhNaDWC1sqE9VHcGfS5AHnivpEK3rzXPnEVgQMpxAD4eJ9q67xOhb2DkMneKmsAiO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19293

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b6f2c6bd4e9ea47afa2b66c0c64c296a1fbf4489 upstream.

Add PLLGPU along with the necessary clock and reset entries for GE3D.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250309211402.80886-6-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 14 ++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 031f332893a1..da20dbaead1f 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -29,6 +29,7 @@ enum clk_ids {
 	CLK_PLLDTY,
 	CLK_PLLCA55,
 	CLK_PLLVDO,
+	CLK_PLLGPU,
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV4,
@@ -47,6 +48,7 @@ enum clk_ids {
 	CLK_PLLVDO_CRU1,
 	CLK_PLLVDO_CRU2,
 	CLK_PLLVDO_CRU3,
+	CLK_PLLGPU_GEAR,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -87,6 +89,7 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
 	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLLCA55),
 	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
+	DEF_PLL(".pllgpu", CLK_PLLGPU, CLK_QEXTAL, PLLGPU),
=20
 	/* Internal Core Clocks */
 	DEF_FIXED(".pllcm33_div4", CLK_PLLCM33_DIV4, CLK_PLLCM33, 1, 4),
@@ -110,6 +113,8 @@ static const struct cpg_core_clk r9a09g057_core_clks[] =
__initconst =3D {
 	DEF_DDIV(".pllvdo_cru2", CLK_PLLVDO_CRU2, CLK_PLLVDO, CDDIV4_DIVCTL1, dta=
ble_2_4),
 	DEF_DDIV(".pllvdo_cru3", CLK_PLLVDO_CRU3, CLK_PLLVDO, CDDIV4_DIVCTL2, dta=
ble_2_4),
=20
+	DEF_DDIV(".pllgpu_gear", CLK_PLLGPU_GEAR, CLK_PLLGPU, CDDIV3_DIVCTL1, dta=
ble_2_64),
+
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G057_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
 	DEF_DDIV("ca55_0_coreclk0", R9A09G057_CA55_0_CORE_CLK0, CLK_PLLCA55,
@@ -238,6 +243,12 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(9, BIT(7))),
 	DEF_MOD("cru_3_pclk",			CLK_PLLDTY_DIV16, 13, 13, 6, 29,
 						BUS_MSTOP(9, BIT(7))),
+	DEF_MOD("gpu_0_clk",			CLK_PLLGPU_GEAR, 15, 0, 7, 16,
+						BUS_MSTOP(3, BIT(4))),
+	DEF_MOD("gpu_0_axi_clk",		CLK_PLLDTY_ACPU_DIV2, 15, 1, 7, 17,
+						BUS_MSTOP(3, BIT(4))),
+	DEF_MOD("gpu_0_ace_clk",		CLK_PLLDTY_ACPU_DIV2, 15, 2, 7, 18,
+						BUS_MSTOP(3, BIT(4))),
 };
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
@@ -287,6 +298,9 @@ static const struct rzv2h_reset r9a09g057_resets[] __in=
itconst =3D {
 	DEF_RST(12, 14, 5, 31),		/* CRU_3_PRESETN */
 	DEF_RST(12, 15, 6, 0),		/* CRU_3_ARESETN */
 	DEF_RST(13, 0, 6, 1),		/* CRU_3_S_RESETN */
+	DEF_RST(13, 13, 6, 14),		/* GPU_0_RESETN */
+	DEF_RST(13, 14, 6, 15),		/* GPU_0_AXI_RESETN */
+	DEF_RST(13, 15, 6, 16),		/* GPU_0_ACE_RESETN */
 };
=20
 const struct rzv2h_cpg_info r9a09g057_cpg_info __initconst =3D {
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index d52f5416e371..59f72fbed133 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -28,6 +28,7 @@ struct pll {
 	})
=20
 #define PLLCA55		PLL_PACK(0x60, 1)
+#define PLLGPU		PLL_PACK(0x120, 1)
=20
 /**
  * struct ddiv - Structure for dynamic switching divider
@@ -63,6 +64,7 @@ struct ddiv {
 #define CDDIV1_DIVCTL1	DDIV_PACK(CPG_CDDIV1, 4, 2, 5)
 #define CDDIV1_DIVCTL2	DDIV_PACK(CPG_CDDIV1, 8, 2, 6)
 #define CDDIV1_DIVCTL3	DDIV_PACK(CPG_CDDIV1, 12, 2, 7)
+#define CDDIV3_DIVCTL1	DDIV_PACK(CPG_CDDIV3, 4, 3, 13)
 #define CDDIV3_DIVCTL2	DDIV_PACK(CPG_CDDIV3, 8, 3, 14)
 #define CDDIV3_DIVCTL3	DDIV_PACK(CPG_CDDIV3, 12, 1, 15)
 #define CDDIV4_DIVCTL0	DDIV_PACK(CPG_CDDIV4, 0, 1, 16)
--=20
2.43.0


