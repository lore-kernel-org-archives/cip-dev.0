Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FA9CD4F3E
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:13 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6960.1778751609053216275
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=N9XDkyvA;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.42, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL6JCXXaFDZgPEpRPm7xbXGBiEL+t0R6SkO7G0KDlR6X8SWHHjQh6Xj+7hb3bWOL21bVT8s5EfUnk4aUWDz6wwomLZGLfn7iQ57inMfdX47kAsP529iHlFevSJ10wg+8kg38DMvqIDFORvXS+C45CkNdAVraucqdgU2OvtK6PhkeCOayqDzKCYPqTWrqVkTiqbymb/AGtnELPVI0X60zrg+Q8Hx35PUqMB7k+V2/toS5RvJDNXxcZeNVH4PLc59Z6toXTkign5Ejo6y3m8tPvmAWppW0mxAAXsQ7HEWTQAiaCI6c+EV2JTaHGmFNHep+yCos4W/AKuWHwh54t46oaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVqaKyNvvWGn7RchRYqnTIw2g0p2n8k24jDndlFMPxU=;
 b=DiGNsCl6k8LLz5LH9h8ICRvglKQIcbssCrzAXzB+bNdFJDd9gBwcEuL+2wGECTeMewQ8l+yKkdG0iSSVBcNHmp4WOCZZ5Y0EEI4mN/Bi4I0nICUx4wzb+EFlmEabYJjFKMmDgqf5RfMfaTUM9+FZwqKMdsh3ehEEuG0ddkYBz77+iEsxRLrfqEHITHFop6r6tSpSEQ4YS6/J4kXH7suHiOl78b2P12PxKWJ4U8ihRoxwZ6Xfs3Fnq2DJoJ/VlJs+XcmBcBLchSF1PKyVAj/zoC9Zo3byoKghVTbzD3ry14qCkEldPkWbak7s0jq4s0o9pCqA7VsMZ1uL3YpA/dnCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVqaKyNvvWGn7RchRYqnTIw2g0p2n8k24jDndlFMPxU=;
 b=N9XDkyvAXu7XLDTaVWrGUC5Tq2eR8IpNH2gghvxjk0g2yOovCO41AjBgnZtQB7XgZxXTjR5aoOcoTjNmDQ9elAKqh2ByyVTNWpxAHKnOvIZuMjDZtQASbWbqfEamTCZZXVnMKponI2Oadcgfw2NN9ETkOgv3N+MwIlh1Tt6GzuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYWPR01MB8821.jpnprd01.prod.outlook.com (2603:1096:400:16c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:07 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:06 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 01/17] clk: renesas: r9a09g047: Add PCIe clocks and reset
Date: Thu, 14 May 2026 09:39:19 +0000
Message-ID: <20260514093935.2212718-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYWPR01MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe814d7-e397-4a7d-9292-08deb19cc839
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	WYRuR7wQ8F9WRUSHwYqDWvE/BDJXcgwcaSDEAo7hpqG88oYefZk7/b6XBmeshl4RvPFiVJP5ZRQ74F8Xf2gMjCJyNDTOwPmHqbOhdwJEp3m9qM61Di4r1hqD+9OqOEp+tMT9j88fiBaqBHQm4U2QHE7etKiOzBckiiRlmLlDmbw1wAIZ5wy7u+a35rCuJ+pBK3iI/4A0RswTdgO71ccDWwDb/GCzcySlGG7CHCQYZu2bo9meK4ySk7PiI2r6ZWAzIGUfFOgW/gWdJkyWujcBMj6d8AL9Vsk5tKBAf7sC+jqYVrbPg7Vn2bkbvvw/Yk8L5Sy6zbWKyqpAbfidNAH0S4kC7WD34sMpCzNhKtwqROiWPh1LebRcKEyqMzj25TTsRzBRe4Ooj3mq7P1dx7t393eJbiyxdJ/46BIMKIElLJPALs/rDil30pBXDvwJ7pgaqApA/AbFKYmsY1/GQD1sLet7TMa3StYGZPvFOYs45bx7iGullp/zMOhH7s9NnM3Pf/OqcYsilzHuMmC3Pnb+N015IoN6ICvGgkWf2N/uyGPf6nvUPtJIczQzIY1z3myR/TxLIuYQTe8JId3cPnxerbT75l3v481cqQBNjX1EKAGH3BKNNaROCI3aZhbZcRrjykuS1M/E3cR3YUKf1PaDEDhaS5RFcBtCowBeJLWxzqvIGSYbjemWzNUPhFqjUPj6CjJNacI+2remNxJC4+uJWw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?swVvhTDr2wtuLSBTQcJcPfJZFhfEhp3gbAUOpXakDHlVpS8QMSZlYzKfISK4?=
 =?us-ascii?Q?Rj1KUgf/nSc1ZJMIUafoWKt55cgumUiD7mIYalqht9sGT8un+vbciqQxZk1n?=
 =?us-ascii?Q?1iZmVKvXYVl7J0piTV6Gs3xBUOJ9DJmItPhBMTT0304RI2fsBWTgBayOPqBn?=
 =?us-ascii?Q?guTn6bwB3j7NKSDIMWc2wOvFh0Od7EU3L9ftQUr5JHHB4D3Jv0wkHa4aibPT?=
 =?us-ascii?Q?QKbg9qHlky/4Uwzl2LF088tVJ+ree/oLaROpeMl/JY0LHWKydwoK//45EUdZ?=
 =?us-ascii?Q?NkCEhl1w7jNl9KO1Z1M230Ya0MVOZ6RKiMSNHZ1zMu9k/UB+uTYLh43qwixM?=
 =?us-ascii?Q?vHmhQLCLVpCZU1pdZfmFBWNc05UqkFsXVNG2xHSEmQDaprV/luqgTYowqH42?=
 =?us-ascii?Q?+vA4SgzGz0GRTe+pZoCgmfS6spIBbJHtjhiNshT17xvAKAzBcH5ad1GYyRZY?=
 =?us-ascii?Q?qb2zeEZUp5wy/4FabnJLHd3PZxO4lZAFIjywRf64EtxEP0mgAUnAZbSzckWW?=
 =?us-ascii?Q?u+Y8ztyyYmTbQauWyOkY/eSq2RazBvtXNjHMz3yJrx4oeVFrJQzVqWS4FoIx?=
 =?us-ascii?Q?S9ME/pcLLltVt2hoYIZSGYwgMfWNrSbwJSMr5bJLSFYKKKJEsNDeg2//aBfz?=
 =?us-ascii?Q?j6Uvd3hBNdcW2sQfaUjZlI4yEX9rOp8J9xpILbU016F8K4rSvwb4mm9uWCSh?=
 =?us-ascii?Q?+SOdVYBQawilkUnOUsdq5CMYhfvAcJWS3FXVge8MY1yolm1woqZeMtMOpSvJ?=
 =?us-ascii?Q?PGQdrUpDTlqS+RYEL9DUJCBMDdCpza9bcDxgjksa3w3L7whA7iKJZ7zQ+Qsg?=
 =?us-ascii?Q?RibUfJtIZ6Ld0hqTghNKxs0BS45q6+aazbbvZGmdFSryrS1Lrwss2ZmluVHk?=
 =?us-ascii?Q?Udg4h1YJtTPKomr2RY3gEUSTMatX4fhgqwGudyOnyXLcWkessBWAt6YaEcRI?=
 =?us-ascii?Q?s6jpdTykHJ/QDc1mP/HW2nwmwWSKVim51vGP2YTonwGMNXL8LqqhJwtqa8bC?=
 =?us-ascii?Q?qvY5tf6t7tNXKNZ1XEAgibNDUeRXv7sUvi8G0hpt9+igckvOhK3BRdh4jwpE?=
 =?us-ascii?Q?af1lqm5RaeSl5zqFZOM4OIrbcZqrjNZauTyY2d9OnD6jw9vsvfLpZI5hOUdM?=
 =?us-ascii?Q?VLcQGmQBBqWr7xncc7Oc8OJySRkUGScS14AdYB1VICEWU5xzjrP7Iit6f4uz?=
 =?us-ascii?Q?jc7bMS/buwXyAHhdk3eOYKG39cAmrTZmU9PAbi/IpTWsTuU4WcuuMUPcgxzM?=
 =?us-ascii?Q?6QnKmnk+w99gwwxEfkqFliCq5ZVUZEL+RqTYHJhEnxtAbBRvYYp0WUarNVBl?=
 =?us-ascii?Q?t0lOvBMAfIcYtIYzZaWTyZopzsXj6SGhokWGMQkKR0yVAB74EmB6O/VYsEt9?=
 =?us-ascii?Q?T1UDDFu2+1qVqQOy8wMc+/Vw2O6gp0kCj9QcSa7/YPKfnf1HfBEWGWxBR8G2?=
 =?us-ascii?Q?GnLIgikrzDFKv8QNvKv+v0vQTZXSz6KFuKsJSFn6vB3tV0M9L+S5VimEVSCW?=
 =?us-ascii?Q?bt90FpXcq5gDcwcH2HA8thcLmDMCLd9tlQwukWQE7QE7j+iuBqgg2hK8EMhF?=
 =?us-ascii?Q?Ber8XYna58TI/MyCxrLWeME4SgfmYicGQV3pOwtvGVIRMzMhUZq/pfgzLupm?=
 =?us-ascii?Q?HXzs1b8PtL+ZMvnYWppH997kS0OxmmEJ6gXI7C2JG7pUwWMyxckFeKfEH1/r?=
 =?us-ascii?Q?rReZ+Un+dPR4R8dr/3W8AjoKcElEJVUUMmGYnTHdhfQC+QPZ8s9MrIcxc14f?=
 =?us-ascii?Q?I5pT7yEizXWgEI1YI5Cuuv7yay1zQX8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe814d7-e397-4a7d-9292-08deb19cc839
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:06.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ6bZsagAn7tF8iz4I9N3Z2kkQtRsxUDVfcLUd8rpXNEAacaNbj/BKRCbiLFaWaFPKbC8qBzPtGJxyhvqnWCUpCyXLz1Bd96sSVI5xIsEiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22935

[ Upstream commit d85cb4ff46c7b7f393b30666a41fff18962ba21a ]

Add necessary clocks and reset entries for the PCIe controller.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Link: https://patch.msgid.link/20260318085119.44717-2-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[john.madieu: Fixed cherry-pick conflict]
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index b112e436433a..728a72093d87 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -408,6 +408,10 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(8, BIT(6))),
 	DEF_MOD("gbeth_1_aclk_i",		CLK_PLLDTY_DIV8, 12, 3, 6, 3,
 						BUS_MSTOP(8, BIT(6))),
+	DEF_MOD("pcie_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 12, 4, 6, 4,
+						BUS_MSTOP(1, BIT(15))),
+	DEF_MOD("pcie_0_clk_pmu",		CLK_PLLDTY_ACPU_DIV2, 12, 5, 6, 5,
+						BUS_MSTOP(1, BIT(15))),
 	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18,
 						BUS_MSTOP(9, BIT(4))),
 	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19,
@@ -479,6 +483,7 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(10, 10, 4, 27),		/* USB3_0_ARESETN */
 	DEF_RST(11, 0, 5, 1),		/* GBETH_0_ARESETN_I */
 	DEF_RST(11, 1, 5, 2),		/* GBETH_1_ARESETN_I */
+	DEF_RST(11, 2, 5, 3),		/* PCIE_0_ARESETN */
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
--=20
2.25.1


