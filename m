Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9F7C8303F
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:38:03 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.38])
 by mx.groups.io with SMTP id smtpd.web11.20594.1751452672352793971
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:37:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IMDYtnDF;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6/mug9Oo883eBh+egXpoj68wo7Jn5pNQQ6UrG0ZPeX2NDBdtpnege5iCoC7rzaQrOijhPpwp/l/4fAG1Dcp/1DcSacYeD/EdeC/XNLHJZcyLzDgW6v7YOgSDmoBsbWV0lka3yGB75Ac2qJ65yd9L+6t72VHliCOk74MGWG8uG7Ns6kOQADboSjrAFjVpMd1W1QMu1J9k8xLLshgH/llHvsUyDz82v7O2GOEZHqDI3CVuBUd1xLGg0SmmVwWauxUTQVa4/K482amhP3WwQnhE25Pi3+mM5lkVd1SItxNmjVTz1Khhz7eT1RgUVC1RQ08HW9gbfgfn7mWnEYh3Ep5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73wudY8AkmKywKYKrVU16oEhqZU6efEUG4+koVt8SFg=;
 b=kgWIcEt/JAioRaadt62qVCnj49IW95xV5Z85TV81qy+5aoRnSicrn1cV2g3LbqAPGrIOS35TZx8EtSJqE5c/WT6jqkeRb2OtJLeJS0pb/0mwnVDKhDkWrbGddaeKT2nE9AjRJrpoTSBbBG82abJr9lyNe3gQwvlkGokLvD4SPFlbJNFI6vq+sC/MYsjpb6VLhLnxwBUcsLcs4b8t14Q8KcnoXZ7deupEU9tCUSM7u4q3g6fK43w1Piy/478pl1nbTEG6X2iwHZbt0iAxHf2nZaghsisCG2kos8WJgG3k2btgjHYBO2hY3Os9dWeK02+LPDf2lE51HXG4ORofDpilSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73wudY8AkmKywKYKrVU16oEhqZU6efEUG4+koVt8SFg=;
 b=IMDYtnDFeL10VOijnuYZfTK2nPJEcm1mF5VrV4pvniAfaEoS3N9X9+TsnUZyNX9K6bD/lD8tkjH6E9agvE3g7DxrQtw8GlJytR0gOmsezBuYH1MN7MSBtU25m9EFvzNJnGjyXED1/l6vmoZ0rxmPZbdgR6pEAFPB0EKJPovbypg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB10187.jpnprd01.prod.outlook.com (2603:1096:604:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:37:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 08/12] clk: renesas: r9a09g057: Add clock and reset entries for GE3D
Date: Wed,  2 Jul 2025 12:37:06 +0200
Message-ID: <20250702103710.117760-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 836d0889-aeff-4460-50ed-08ddb9547f58
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zgHmykuSjXdrDzEBjgpPRacxPlXqpn0SnUsOyCg+aHVZVaZokiQ6ioiyQpL2?=
 =?us-ascii?Q?iNiZs4ELOkG8d55MMRKRjkB0qDKMIhVE6MHJHjl8ipcNJ9VybpZMfCbQ2qTY?=
 =?us-ascii?Q?qR8erY2h64pWhkFycAotEcPqKfvwFw8aYhO74wowmuz3zlbTNhvQTClA8VJ6?=
 =?us-ascii?Q?VTb8QLbsV1TFFcizFhCZs5ZMf13MEJOZwRln4bL44E/4/5l1PUiNUiryY6rx?=
 =?us-ascii?Q?XAUYS9X4z85iUfw18viDTkCMKrtWoWstI+9aRC3Zu8fRedkokRRwqpiERT/v?=
 =?us-ascii?Q?x5owpAeR5xWbAcRv2dHCumUWgIWLkQ35nLBAYs0E0C3evT1BpWDdVTK1+4Zk?=
 =?us-ascii?Q?oc/qjGjcWowbSOOW+yHI9MXbzQqXVZodwAF0RKuDX5HFEJSd3gSE+t7VY7N3?=
 =?us-ascii?Q?/eI/sEtQUVPx26cmUNRelbGfFeetvsWtIw0WwzFHDv2519N/1a8cgVCUIlng?=
 =?us-ascii?Q?VI0RRlObxwGmKr4wYOyY08JGQVFrnvtk60xFDAWrd/5W+qeqW4moxRRCeyjw?=
 =?us-ascii?Q?Ka4KVnrkgQ2nHucieRLCLESZt1tJ5EjUWielqqtklJR6VYuVWbKWjIec60eP?=
 =?us-ascii?Q?015xtCpNsgAImuNOu8psIFSUEUaFQWLXWBaZBbcgxkZzLwcWHPINTX/JkTev?=
 =?us-ascii?Q?+fclIikMQXewmz4SPdOmI5Oo8uAG6FkOl20V09Yo2MoYOtscAZ4nJonwnWyi?=
 =?us-ascii?Q?3HLJdsm7S2VBF1zxXGgff3kGxfNM0QQiS/HecodYi1rmB98bzoZ3FJmaA1SC?=
 =?us-ascii?Q?8vzgjDyO2UTpMLkRVKBcnv0zH/fLPrOa7R+nJHHcSqzmMjCkQdZV9jWGYxto?=
 =?us-ascii?Q?Z5FGJz3u34OodW+zcgt7l7dmEnEFuE6yx1/lcWRE6XJmljcH/cnfuW8DQcUP?=
 =?us-ascii?Q?hM6rNcWcTGAMhx8CLJ6NE83ISMVUN0U4GF5Hu33Uy6Xqrxy5Hoz3ukkDNqfG?=
 =?us-ascii?Q?tn8hf40hv1hBnYXpXd5A/DkDlfKhgSPF/Jl2khtcGyUAHWJcOQEQDdNSRgIS?=
 =?us-ascii?Q?yZyoaVKfTnM7/6qatsgJ7XDNkmY0M+64/XWnTBjShGx6r2q4q3gGOkV0LmEN?=
 =?us-ascii?Q?mUm8hVL+PzrZgQTPL1xickEXEYkIFKLWQFZQ+YEGrA/9qLWdWfVSdFyKEusH?=
 =?us-ascii?Q?DuA+RgfxxZRcjZQUm6AUA/SXyga6/EJAMoq9VLhQC7f9WbyfsGU1oq31e1PJ?=
 =?us-ascii?Q?W7H1my+a7EgBYebPI3OIO4Qj4fIt/AU0Qsqr4xXgTnc14F7QGoqoR6VvmuFQ?=
 =?us-ascii?Q?jlrPfLmFWEPmn93AiUnPWhDw7woShUVW5q46b/NNcL6Ip7wtQUGusVC95Z1S?=
 =?us-ascii?Q?m9xFDf+z81Dzz5e1WE3dXANUf+Xah9/0T5ShJ07GqMTMG7HEjH+4Orn7sbxw?=
 =?us-ascii?Q?kLTX8Iig2ppOMlF4GVqp6V7aUGmP1RKyB5aFH9iQ5yf732ZW4ZvRYJzH1nou?=
 =?us-ascii?Q?5PWYnl2ST2Bwx09bv+qXnzPanDI93eF6RoXewrk+jeYon7c5uURu/wbEDIWH?=
 =?us-ascii?Q?BpXMXBiNbLasTxw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OsulJicujtr5ZTaCWvHPjqVmLENRrUDm0nBHyeSsk6VdUNQ1oZ+AFBeTAXLF?=
 =?us-ascii?Q?Dx5jYKlp+yOz3cm7jxHbocVCYsA5YR5THp7CYFivJTfYwm/kBpnoRp0XgBoQ?=
 =?us-ascii?Q?+5dilHl3Zdm9vQ/1vL2KDBRuXr0gZLE8hXc2fm5LzBrIQcuYbosV9f/V9acQ?=
 =?us-ascii?Q?Hgagt/kqLGt7unZHySYowkHtlrFWpXFDUDGwCzKheBkFqsphVVk0u5g+PYto?=
 =?us-ascii?Q?TAEo7qfj3jYHVFSC4pPiD/7tqNqkpkT4U2qdR3ZXpvx5zvJhxhXmgeqiIpFy?=
 =?us-ascii?Q?f5/d+I8wPVoCUNF9OmigFnRa7ignrxt3MWi8TZcHYfm3sNWxkAEUcsjXGoWG?=
 =?us-ascii?Q?aU3SM/BVwWU50CkY7adgqwnOMkVUTBT0u7bXNqaD1Z2tLih56DOUFKf3WJHC?=
 =?us-ascii?Q?TZ+ckTwmd5sfiVG1F34e/JMGLV6PzqgS7nWKnabu4nMTJvgeN2pb/l79xwPu?=
 =?us-ascii?Q?IcQx+Y4sLVyVTUC71VuusBLb6nljKzigvZNvLS1pbwgyXKbzkgAqNvboR8kD?=
 =?us-ascii?Q?vNg/C50/g267P5k9vH6aDM7DLwMdlPXA8I7O8Rm2gALWne5LmLbfHUxerv3w?=
 =?us-ascii?Q?ukmbU6WD7YdW02Lo9/SNCbrvnZvI0dFWwXRCQam6h9pv0uFR+aZVh7rSYWgy?=
 =?us-ascii?Q?3Wngx2feQEaY88aoAlPHPYH2Ft5Gcqq+XhIa02gVOW18f7B6v/nJsgaiDkhF?=
 =?us-ascii?Q?b1I2N4iZbdYv7G22KnYFTwvj6Xlyhbv615emoFORQwlqeGVtEqzJ+5qQaUW2?=
 =?us-ascii?Q?R6GjNnF6NgSPFJQgQKV2JxOUBvT52F0g86eTcsvJiZORUOA3E4TKpM0e/yjM?=
 =?us-ascii?Q?F03Vvohl5IGnOy5EqAcu/osBvYkqGNTov/8BTDi87iv0WkDXJ07h/fq5sD0q?=
 =?us-ascii?Q?9mkcqd+RlPkb+j22va2wn6h2rljYZ0extD5murVbxcHkQLn6Q4sFXwOq6Auo?=
 =?us-ascii?Q?kELGZ4GpP7jDaRqB7X2yVxTO4n1f/ZrkElj+TqPTSQNKDAC+CrBUKVDjEv/i?=
 =?us-ascii?Q?rxUgcnaUkQyQp3/khhi6zqXAtkvCfLAaTG6Br1yCOF5kF/vznU+QygK6UA5j?=
 =?us-ascii?Q?2WC7Am6qqK0rlCA31BwehnbRjIjFXe0LUx/fY+9LaVqV0muTWs1aA/2dpFef?=
 =?us-ascii?Q?L8jJjI9rZno63wBZPRDcYgC6HKkg/npfehpSN54ORDwQIfuFyiHCmG0NLOrL?=
 =?us-ascii?Q?uDYK5s2b0nnOlrfL2ZK9AmMYbBEDmPOU1xhqdIuu5G/1mBRulDx2YhuIcEw2?=
 =?us-ascii?Q?SALsQUQobAfnbp/jMNHuzDOOuAld+4OIOPI0NGmbMrveBft5TJf2jJ06m9sx?=
 =?us-ascii?Q?apiPKD1WsBzutwIsEAW2ezwkma2kbnNpZiy6HWWPfB3NsvsNpBExBT6kgwUb?=
 =?us-ascii?Q?zVTpMVXrdlTJf5e10sg3z/4KVcZn2fjVNSBGzQcLqNbOjJZPCmUb5qWQHMGy?=
 =?us-ascii?Q?3mA1rgD5c+6uAUiEbW90vnF1WanUZ2ShRP+TSobXQ6Wxj60XADCu7f2ien5q?=
 =?us-ascii?Q?V95bLUUJUD4/HyIQTitdwORo4zNSHOItka4GWIlHFxCURmTgxYVhcsTgJM06?=
 =?us-ascii?Q?ca6DyTADPDFB8wBC0zL1QJJc8QQTYLF3ZS+R42LgIuasXqbmy8GFJFgwem1p?=
 =?us-ascii?Q?pF1yNQs8aZA90Z5vZGVcKpM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836d0889-aeff-4460-50ed-08ddb9547f58
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:52.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qtH2fkruYAG344GHf1IF8Q22JJrCZ2hJDSUfVQCr+pCe1ll4yY6CnmjlPk/a2btTXARwTKvWVkY921H10k7Yo4WRjuZB53xg+6vDePGw6Vl0CwHoS1MP4sbbBch3QvO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:38:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19306

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


