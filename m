Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26F1C83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.30])
 by mx.groups.io with SMTP id smtpd.web10.20505.1751452569112110536
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:36:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Fusj/TD0;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwLwGTVH7fBmJoZ1lFCzIEOymwq/+WP30Wesl3zhyOvDl+x4KZKmbix10fs+lgv4sMXemMkMFwh9b+K8rvSxszUxRf8ok2fwN1qs0sljwWfwPgLR8SDnhXm9AQgxWckjXi1+TUTzu6ccDkhtda9ulpgFwrKJSoBmzm+NRSAO9THNaXIhGGcNs57nljt7KTEFOrftZXm1r+QLaF/XorNGwQ3L9ydOF688p/0zFrF+FrlkpLWbKVt+0HI8c0yxL15xuVlWrh75tEQK4zg5vr7ugCQ/WItyin8dHdmFkFldSwO3p8SZdQYaKPD9s1UYUjkNlnOd6DjNTEMq8zZTxKewkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vnqx7GDogiXwCN8YdhxZeSD6w75IBgFf6G1JpKm2vwA=;
 b=LnnZCczFJsA8QfsOlL6QkMBlo7FhnKnUch35cE8wfRVe7VAwz6ygBLKFmn/HZKUj0w7ZPFAZRBFDpmWnseNou20zI8rPWum5hVcWbOLT5RW9ZSwZiAOySa9x27GoIo2a46/ycRlPR9DScqOnkGo7XPPshcqAqsqOgMqwJSs/1WFTHSn1frdYNKQrKwwq8q+s+Un2pwOru1jPxkDIxn9esv11QwLsMIQjroLxw8WSUCmGzz4g/Q30NHSQv4f8L0/WrWE4mLxpDrf1oUyyI77TOJYlKppuE7jt9Q3Q2FVkjoaTWd3zkuHdhxdLBhXijcW8tbniQZ8bpTSqFLHZk1e7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vnqx7GDogiXwCN8YdhxZeSD6w75IBgFf6G1JpKm2vwA=;
 b=Fusj/TD0eYYQybWYG1+TWjksj8nE76eGTP8JkQ91kYvuxfJR152WOA4hZcwC9xwvfDNRkrpZ8evTseHwZ6iOl6whrG/MjjaQYth7dKvkg4iiUiqtovPM8nrrzuinoXxwQK8WTbAWyeL81iaKAyE4RAUsFXuCacN0SXXvbpw5xgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:36:05 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:36:05 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/12] clk: renesas: r9a09g047: Add clock and reset entries for GE3D
Date: Wed,  2 Jul 2025 12:35:19 +0200
Message-ID: <20250702103525.117166-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94bb0ca9-8101-4037-d516-08ddb9543f53
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UDoRSLv19AYR+EY0X0vpiTaqFKSV9PxckZp/4J/7zqmmSeO4QgmieQkS9Q0s?=
 =?us-ascii?Q?XOZczRt27dpTze7NffHpJiHRGiq+zZ3igb0VgJLyNSzIhQJaqOGzGGMsmt21?=
 =?us-ascii?Q?7fKNiEOFoNhxHHwLfr57DNCeYCBRxUb5mgKLNv+hPVZfk0hJ7iyjsv8+fF9q?=
 =?us-ascii?Q?46lMQe2cG3P0pvzJlcfI+wVwWTschQmbaDNY1qQ8i0d0I+ZMh/pokr0Ocydx?=
 =?us-ascii?Q?k2QbK2fLsMu01Tn3CdBr3hgsSELw/wcldSm+21be2vRDdfpK56leGfG7i7wI?=
 =?us-ascii?Q?gLEPNat0AvS/l4N1PpoZJ/9p7h9H2zUAFL+raR1x/LN9lHPsNxfYGqmYgJHb?=
 =?us-ascii?Q?9bk9eQXs1BtX37EwimKCpw5x06sOLDLTMCHecl0aK8CYJ5L1JpSOcH02LhlI?=
 =?us-ascii?Q?9AGz6sfXID6QSfHlww0g3cb4oBzgXhy6+eUs7/0axz1hsfUwD4g4Byte/YkY?=
 =?us-ascii?Q?VgnW42luLA0ZC7vDVjS8FNollrpLUfdNwfyKqeobAMIvEpTuWge1VQlyUgFe?=
 =?us-ascii?Q?ss+RwmmJwfgvMjdYhlv58IVdIjX8LY7DwK6uoR/29KOHkuCyXpDXEg5Me99i?=
 =?us-ascii?Q?sHnef9UcXBAGKI5TWJ/aNIHeWfPnQRM+7FM7oQxkT7g397hR0cY+vU1dBAJe?=
 =?us-ascii?Q?A4TsH8v6igHeub8YyeaIf9yHTsG+xA5Np5VVSjThWexzjAjNbs5DgZ1dEMXd?=
 =?us-ascii?Q?tbJexnEWVzs6WroBGidTyeZvBT8MnrwX/LT/NYlr11F0PfJA5j2BTypaKqwS?=
 =?us-ascii?Q?QPTDVxuPhFO+gu/Ra6QD3BczTndvCMe4LqJSgzH/Y3FDeIymXTCa1H3Hiu2o?=
 =?us-ascii?Q?K85tVQ2PhcVg0r5lNnTgTicKo1fNxW8PO2Qzxq/HMhFJUsZtqIy36l4ZAyaK?=
 =?us-ascii?Q?jC38V+ZEOjA4mQCnXdnJfKI2VnB1ifMYGPMAtEgoZf0C6wrqkPeqkLSUkEDT?=
 =?us-ascii?Q?x2ih7Vu7+0xEe5weDUiAZF+ip/LYdytn13OlOHiJ0Z5Pbnqr00aGgHUskM/E?=
 =?us-ascii?Q?AIqEW6dfQ9F49xrExp5sK8mtIYraYoH2LTzlhaf6HvHiOTvCHKOXTgMuENSL?=
 =?us-ascii?Q?Lb4KJ5LX2xHfsRwf4hBeOAWZX1MlFuadrqSc/Sh8RLvHxOiBVTTux5HeyYyi?=
 =?us-ascii?Q?SZHsZgdfH6hCPPRQ5CU6Dui2QytdEY5/S+/xD7ZQwso8PROTZOBCxyAp3ohb?=
 =?us-ascii?Q?SVZU5J0/5POMWAV37LLdpMpVIcL6SEUWuSzHaE2ocJlSFboKueOJum46kcNA?=
 =?us-ascii?Q?3EbtoS0lY1jxwI6aY9HK62ARfKXrB+N9X9RX1ld9QU7xlzBRze1agzxWT9ty?=
 =?us-ascii?Q?XjqLiN0aSPsGbPMECZ3CDsRF2DrAiHwjLHM4dogJX2FIaWt4k5ri1k1IyaLr?=
 =?us-ascii?Q?2QOgo4iXIx1tgifHq6urVMIl6BGv3TMaHxy4ja3B5Z/Qve9ihcw/7f/tPxAk?=
 =?us-ascii?Q?Jb3R9sUejcgI7AOWMTLT/Sftkhm6isgZ7iQznFlDAmboZEWgIxzSB86yAElo?=
 =?us-ascii?Q?JyA5UeVaRNRWv7U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zW0c8u7BETrBLE5rqXdRAv1Ekk0U7lvKyMTPQ4EEcP7e/0ueogvSMVmzcJzF?=
 =?us-ascii?Q?9vjoEYTa6aTdzwxKlRLw9ivwRhlOBVMEMC/Fklw6DofsyTsFnhnWLoU3bsBh?=
 =?us-ascii?Q?G9VHo8/jMjv1eJPWHcN9BHSGCFv4vHse3lEPjkkAL7lLtl5oV/p1VsdFULOQ?=
 =?us-ascii?Q?UNXvrsjEXGLut/G2/P4frCi2VfYHpKjW0e54yWtCyJmUKw32XLy3qz+k/ieq?=
 =?us-ascii?Q?oCTcuGYeWD4dvaxoZ8qhVyB+4NmHR064NiicWNZ6iEU91e4fHHPdP2olP+os?=
 =?us-ascii?Q?puULl1LjrDEp4MjY5sNEezT1X9udO1038oGwSLNqq8lbrnNluWm9n1IqC+TD?=
 =?us-ascii?Q?6II2pfCgoOsceYrt5B4VYHlV/4Sc0KpQAo9UeQf4sa/Jm6Zart98kqK6FMcM?=
 =?us-ascii?Q?LwJzmBBfb8+jaxaEaBUe09ZbrJzsJnOJsCD1tA6CX8facdnzXh/nhUDKQ1QH?=
 =?us-ascii?Q?G278oArYtqKKtsuElJ2yqQF/mEgUjRSqRIqsHXTQkZ5sVk0oOqUVbggRgtKn?=
 =?us-ascii?Q?bo5Elq4LRimZLDzafDCBAqrKPxlLdhh1kXIu5WvP1XFp+M0CsrExsYpcVPY/?=
 =?us-ascii?Q?X2S57qd4KPyEm1GS1oNAZEI6d/aP4ZQLPNCSihYfK7nWFBljEfYq0gtx4TME?=
 =?us-ascii?Q?32zMa9pTP/0azINi7qdgg3LfzkqLPXIMoyXL6NOV6/zykBIiQ2xHyE1ozRzu?=
 =?us-ascii?Q?eo2xIt4MF8lg/nNJrZADlUuHhMe/HMaIOETISk5z4tbswoAF6+3OI2EkyPmI?=
 =?us-ascii?Q?tPjgcuZgLNohrXdOoqYhDOvvEziINSop/4JUdRAt6jjv1MU/5KCvt2BcW7b8?=
 =?us-ascii?Q?d3Yck4O6WF0Z/Ca1Nv026V6E6gZFou8A0EPNdmRJgbbGpXjZaS+YpRi0tLBt?=
 =?us-ascii?Q?u1R9app+vn79+ihHPz2KmdzS++obgPn2NP0w93iVV2T1B5JRM7xyrp3mnJMU?=
 =?us-ascii?Q?U3ddPQ017R/hfsY4jMSWEaSaTbR2+n9SvlKmhceMwEbLbuU0ukTc1QucE6xx?=
 =?us-ascii?Q?v9PWJ4cjsW/9MMK3IxNKzDKg8poIiG0cgzIcf93PWIk7it3P/JyTgmlecO7O?=
 =?us-ascii?Q?C2UMPHGFKijBAWIOogYmhSqXg5Nu4YHf0CGQ9+kSAzcJdAZp3EZp1O33v17z?=
 =?us-ascii?Q?SPewvhioftblwI66TUXnxgkFQ4LLHPvKbM6diitmmdz2YN5fkrKFsOB410k0?=
 =?us-ascii?Q?sBbcxpMhiljV4Lt42Jl+qLDUklMNoPR7xmSO4LrXlXjBLgytCafmPusvUoWm?=
 =?us-ascii?Q?syWJIsxUJXsssnl4EenHoHRuz8COIArbhriSFZa61hdjXIeGepIBKNynzTaz?=
 =?us-ascii?Q?tdMipDlfvFtWfRCIcJAeBfBAcNhfeBvo0pexn0sDoVrGDVNjMNvJWPetws3P?=
 =?us-ascii?Q?7CjYTpKQURkeyZtmdFhd9RxOCCZhmn4uc9XfZLhObQ8IabwSaUaaUrBc4hgG?=
 =?us-ascii?Q?PPVkLqTc+FtZ7yqi/NHL6SYeXfNwdEoLKFe51OpKTnE0PL9wWpOMoD3n+dVx?=
 =?us-ascii?Q?PuLTANmU36kqODE6MQfOM70fKmCa4n8DMPj1yZL+aPFYZgVqVa1Xyb4uf0Kr?=
 =?us-ascii?Q?JAIIdkMBe9lpcC828tGCtl2ntC+SpEzQnNjjrL7pXGNLLTuGfgJIdkw1fryb?=
 =?us-ascii?Q?AJ1y5JU31t7NddJ0h9aTqMk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bb0ca9-8101-4037-d516-08ddb9543f53
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:36:05.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iS+vbRmZRvJ/fpicr1fxXL70zAh6P+Xm7g075TSgyuxlG81rDpHP0tbfcSdB0OlkC55zqGE9TAN5T8bam/RJAi87+BtvqEzHn446v/+RmKarc5re5bFSoL/83eyyx8cW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19291

commit 9375d704d219006cc97b09ea0e93076655cf77d8 upstream.

Add CLK_PLLVDO_GPU along with the necessary clock and reset entries for
GE3D.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250402131142.1270701-2-tommaso.merciai.xr@b=
p.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 7b9311af603e..88a5a1c24ade 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -41,6 +41,7 @@ enum clk_ids {
 	CLK_PLLDTY_ACPU_DIV4,
 	CLK_PLLDTY_DIV16,
 	CLK_PLLVDO_CRU0,
+	CLK_PLLVDO_GPU,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -96,6 +97,7 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".plldty_div16", CLK_PLLDTY_DIV16, CLK_PLLDTY, 1, 16),
=20
 	DEF_DDIV(".pllvdo_cru0", CLK_PLLVDO_CRU0, CLK_PLLVDO, CDDIV3_DIVCTL3, dta=
ble_2_4),
+	DEF_DDIV(".pllvdo_gpu", CLK_PLLVDO_GPU, CLK_PLLVDO, CDDIV3_DIVCTL1, dtabl=
e_2_64),
=20
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
@@ -183,6 +185,12 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(9, BIT(4))),
 	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20,
 						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("ge3d_clk",			CLK_PLLVDO_GPU, 15, 0, 7, 16,
+						BUS_MSTOP(3, BIT(4))),
+	DEF_MOD("ge3d_axi_clk",			CLK_PLLDTY_ACPU_DIV2, 15, 1, 7, 17,
+						BUS_MSTOP(3, BIT(4))),
+	DEF_MOD("ge3d_ace_clk",			CLK_PLLDTY_ACPU_DIV2, 15, 2, 7, 18,
+						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
 						BUS_MSTOP(2, BIT(15))),
 };
@@ -213,6 +221,9 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
+	DEF_RST(13, 13, 6, 14),		/* GE3D_RESETN */
+	DEF_RST(13, 14, 6, 15),		/* GE3D_AXI_RESETN */
+	DEF_RST(13, 15, 6, 16),		/* GE3D_ACE_RESETN */
 	DEF_RST(15, 8, 7, 9),		/* TSU_1_PRESETN */
 };
=20
--=20
2.43.0


