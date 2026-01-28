Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E488BD3F088
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:00:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.720.1769616014445519675
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 08:00:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=jg31XDp9;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ayz0yV9ZzZ9IPVLU9ycT2abqLxTUVDZZESdEejUdD8/A0jeWHmhnwEImWPY+ep0J9jICC7YXoFtADXInQBAwi/r4UOWNfVVWRzzUMmKHt0CA8EMqs+5+FTRL1sCqe6VRixro3zClkShGTHdNnqSodBXQjmWrHz3sBomX8PdsA9Oep46Y9gac2RcBGL3xRcFQM60sLHkhi1/Du25NkCSRBQ7z3Z7ur9tiG6yYfiUDjCtzlz30dHYjotC0kMCVKy4YrHBzk+2wFXt4/qx6lH3B202TV8TW/1SP9QXjEPpBPhDLORbGd3TmRIVV3lhmx4kueSkdJsLK48DQ6xqNlago/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEAVPo4bPPaUxgOMbxz2phvE4zgttcQwiinEUHUCeoU=;
 b=EkQrCtCehH4nzbqlC+dserD3Rc4PJfCj4Maj2nb1HiNgrOrjdFUIonMvzqhKU0jqMdOCvpHYTST/W+4rzo0eCb5aV637PyoqDTbONBJqpPTXJjbMOgWGqgLH/y+c6FVSXSOAddkb6UGUwa13C4jJTIZlYJEME93lzr2+t3/e2EM3U9gisweDrjptak5c+pyCzX4Ubw0e7zldoGLIDGEb0+yz+FnvY7sJuk+Xe0AMDhKljj4drtM1UhvoYSW9iRCZ6+kTe3j/SkIZhbh/5Z55oIbJ11++GWlT+OV2/rZULfPtGqtEA+U3xNPNIy4jU9A1n43G9jGT6A0a54Y1VOmhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEAVPo4bPPaUxgOMbxz2phvE4zgttcQwiinEUHUCeoU=;
 b=jg31XDp9q8Ya24AxM7YTl4tA4TdSY2HBf8+gLjw+wr5gZX9kyBSPKUJtdXnj+ZtGVJn4bb7k7hS3pN4JHRI/PVrGevjBRgrlsmAYaGOoOfUz0RzaIhexkkSnbyaZtX0feY6vk/qI53VW1hnZD7vcgOfjVizT4Prd6WPG24vMnP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by OS9PR01MB12487.jpnprd01.prod.outlook.com (2603:1096:604:2f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 16:00:09 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:00:09 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 1/4] clk: renesas: r9a09g047: Add DMAC clocks and resets
Date: Wed, 28 Jan 2026 16:59:37 +0100
Message-ID: <20260128155940.1445842-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|OS9PR01MB12487:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c869b0-25af-43e4-c284-08de5e864fb9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?i9RNvg1vH0RIVCyBSKmMbDE+h/WKNsqED/IOstamvArUdvivmoMm+ikpHI2p?=
 =?us-ascii?Q?H3hXfWxKcPx7FTommhxhi4SOXX5FLZyavgHOQ5Wfay5J7a58E2Dm2ekr3wbq?=
 =?us-ascii?Q?ZBQSyTU53oE+oMxPSBkOaCfC26xbVFg/4E4+xHF0JAbJH2l/acPWBg4sddS7?=
 =?us-ascii?Q?cHGQEeZr3/+VmoB30xWuk+1WftWz1EPb2vbzmb12S+LXzmV6ap0ax4XlehUy?=
 =?us-ascii?Q?OAuBPLqbxKgLSK9YKgSlm1N6pPuAN7ZIT5Uj0HCeTzCHINUy702h/UzE7fMF?=
 =?us-ascii?Q?nn46v3SJL8bbmQ1E4Om6tKh4dprxadRp+q0xMNT6q3n6mbQVPiaavY6i2lru?=
 =?us-ascii?Q?bdtZg4RT9Zp5CEpj2yDkeZSoSCAIVcfNTtl5W0VQY1h+9hKa0KfcZUKTiVvY?=
 =?us-ascii?Q?yQSsdIc0CdGTIiEq1byThZKoOPfnFLiroSdeo7UmyI8FkQo8ve4DN0QI2ruM?=
 =?us-ascii?Q?gMglEBRri6JRJbld0z13dqjv3p4ZOPRrmUEJ5uDBOq/+G+kHtwOnLVLT9owM?=
 =?us-ascii?Q?fmQUf5Hye+JwpYhZOzNfMqool5XjsSBCPrGRgA8p3CkLZkDttbrfUzyvQBXO?=
 =?us-ascii?Q?yoMmZpwPqo8xw+8EV+PrYBhnqnY5QUxf8KgL6/8SkYCffXI2eWsTMevgYCG3?=
 =?us-ascii?Q?llhobSzUtIJvrjO8VV6LJFp79XcyhuCTlveGhX3q8b1wBqYWRPUyfUHzNxc0?=
 =?us-ascii?Q?YTzXFQnj4vJgwm3GvUFIxaTJDDealy7kyMFrf54jhkIZX6Oo5W7yxaikyTWh?=
 =?us-ascii?Q?Y/RZfxunl25IznHh3WKK0q0tEC4PovuAZK7LEu3mOmgD66BQdoPesx+AvOAz?=
 =?us-ascii?Q?2i6F27xZ+8mtxwgxV7QcAqcglA9W3vaiLhO+09765nbxkNlvD+7PcEXcsh1g?=
 =?us-ascii?Q?NVt7kD1xnkX8uynfIXplffJEOWQXDZaYsKNYcZluXyxoH+pHe9z5PQ8mPP/8?=
 =?us-ascii?Q?5TgPoulGv6VQsbqJlUJO5aKGx33SWgDz1uchVNONgsUOHfh8sojoqr3BHQtY?=
 =?us-ascii?Q?72r3F0FtiKwfyHqjme9ot8SWBtZJtKN0SOe80uVHuteXujK/LjxSI75YJQQL?=
 =?us-ascii?Q?fIHfOTsYMX6Z/o7EYSW60q8eVjXS0gFvj+jIH5noMbPzV7oQVh9lw1OwPZuk?=
 =?us-ascii?Q?6xsm23gKJ7dL/xcs27vbc/GWbNpRen7FDDplbV9998ejLzp+ZPBEJqt5zM0N?=
 =?us-ascii?Q?DRuk9jZdyc0e03Ah54j3khmVwTmHCJKywOuiZLmBVPc01/0SG3M06FmfgU5A?=
 =?us-ascii?Q?zgKJV53BmBPYwCuLZi80OoKHdt1SpkJuD9Wbgdi/P/dTuOduprEgMz3wL6/0?=
 =?us-ascii?Q?lCiff4Xai6t1NNxTZt0KISFMQdI2UrHBeMvnHwUdnA56cRVHJMxRLdT3TWMb?=
 =?us-ascii?Q?l/afjB9goHHYMGlLlZn838M+rRgjdXADv3/4PcT/mQZ6z4SlW4vJG6VzBDl1?=
 =?us-ascii?Q?XR+csg8w9TWNUOFlaXMuDg3eEs4nV9dRzy+uAwfyJxq9APc3Eh8aiVrSwPHV?=
 =?us-ascii?Q?atpRIzfsHYWFQvhFMUXiQJ6tu/UjX/FrMT1LGAAcmVtbjV0hxFQpX1BzXbPL?=
 =?us-ascii?Q?b5R2we0W016Pf/Y6JvHxjHl4cIAsHLr32k/xiA6p6yIUgxbEj9yYWpqrqaC3?=
 =?us-ascii?Q?92JUHptoNZQO2Qmbre9KSjU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eVwFOs5S53rYNo0Rus8HNkDK0ysRZculIsxvqg0kpdiuga6yo1LowFjQTGkJ?=
 =?us-ascii?Q?IXzF8Avez50/QY87m78quKMqpJqqEldYMphjW05S3GfDvEzfJlIBBS6C7NW0?=
 =?us-ascii?Q?pEYWXvA7KhwZsL1vMWGqAQvIOSxT3T0Drz8oVUSR+5KgH2WDCrsRCGseyZdk?=
 =?us-ascii?Q?9ysNgz2+R4nPA+cmp57GwQnbOI9gBe1rdnRbiMVXdN5J8KqhMcy5n/SsSolM?=
 =?us-ascii?Q?ErIIg9CcR+xoBpwND36bqVwlK0ptg98u9LVpLjLR9tGPVcslrPpYG8yt8LZn?=
 =?us-ascii?Q?a+C1X62FxSPEw45NmAlZ3WiPdVhJJckrng9GgYmyFBZtgXyOF9AcJ//HAyOC?=
 =?us-ascii?Q?VPhnyPgQdkBYGVernsqJrg9GG4B4UdZvFpQtsj7bLSMpRW38hNriw8ubcWm4?=
 =?us-ascii?Q?+0pVLUmm1LwtmGrZx9IIw363YEzHuGuiGVicz4vAe17ThlawyCbCj0xM/cDG?=
 =?us-ascii?Q?0Uvx1D5fPsQI+ecXnZFr6OD3LPmiUPyGJ1TtTssMw7qwq/Z81gtNB5Ns/9FP?=
 =?us-ascii?Q?947F3jk3o3cTJgeg3RRFRbYy2MqqF0dcvFn5QkdvEoi22LaFf9qB78BMh5sv?=
 =?us-ascii?Q?c/zRUSSdw4yRvizEGFSfLI9SJNCWJzExwmIKaoQtMbljY5Pi6eqxmBH96L3x?=
 =?us-ascii?Q?voz74u0isN7UfdpyHhr3wkZkyYbY+NVE336SA75HDxfXzxOceOspGA8b5NXl?=
 =?us-ascii?Q?QTQEu0Qu7RcH/aTKHVVMvYH9gey7/Aj/y97jn+pcfs8NXljYgCgoGAoMuDcA?=
 =?us-ascii?Q?D+aEQZHK0NqTulHqnlVqiWrckXDiQ8raHNoPcuSjnVlTAiMbsWU+bzLFpfKF?=
 =?us-ascii?Q?QCCipqy4moLmbruhkQwEsLqopxPQuX8bNG1ChoO00d5Qfq11JqDho5oWsUYT?=
 =?us-ascii?Q?4x4RnN72KO291ag9DE/Rd8+7Nye7rGwzVlTIcGgroD1peXfYLQhKn4VKPiov?=
 =?us-ascii?Q?k6tI7Na4jxKyCjVh0ZuXnYiAoEUpcqDAy0c7/fKIAut3CQxE/mw32eMF+Jiq?=
 =?us-ascii?Q?J/9GIk3Z+Q4+hFjpkeRIUwWg7qKEamQFsmEHruXZuPvYNcI3QrgB8LO+HEXC?=
 =?us-ascii?Q?jePuNqRUYl9Z6B2N1RCg4ndh020yOubk6qkKC6GUekcbWQMxrmV38NLbaoCA?=
 =?us-ascii?Q?Sfw3+LqhJjZAwS17R6kkC3EMRsW6oWAj4b93yh1WLiLyUsMUkikT57q2Iuz/?=
 =?us-ascii?Q?P5xhQBx1tVTa8fGP+8MYxm2/shTELWDvPWSXF8jNDHTqgNNR5DqJRWMHj+4f?=
 =?us-ascii?Q?ODyKAi3DCBn8pxrby+BXRU+vpPRYn2QGqlBJld/4aDfKfG1I214n0pyOeJaJ?=
 =?us-ascii?Q?/n4YYdxCUt6eo+rz2Q3JbRlZE7uKBUGXfWcQTtfjVCfkecLqg2ggqbd2e6Td?=
 =?us-ascii?Q?J8Rg2APPa0wq5Ok+L9b9bU1Btx1IfNgu93pgFhSlUGIX+HCGhNK2/9NvdYbw?=
 =?us-ascii?Q?ju4TefZZSuPmQwca9y3FEMhO4pA20lScIOc9FMMnrlixViog7ObO/hgLgKRq?=
 =?us-ascii?Q?a1iKj6gCw1h8Hffu+2+8npmoetv77RrkST0awyE0Ytv3rFXG6erdMZnGQqZr?=
 =?us-ascii?Q?gNJb3zYzs49npobQSdRSGh2gXi5EL5lLU5kjhY5Sul7JrkHvT3nHHEMraWp4?=
 =?us-ascii?Q?5CzHN4VrVVvQNhhV31+vzHQpHm/WSY7bx1b+4uKDsyctn9Qo4OIdDzOK9nvE?=
 =?us-ascii?Q?B3QtgIm6e4ld1/AbbKdmF2fGEjI0CFaoEPbHzyS6uac3S/hn2DvKlxeA742K?=
 =?us-ascii?Q?9R9DS/YPOF0TX23vk2fW8SkgP7/Gy+GufPzBLe1TVGewHL1b98Sc?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c869b0-25af-43e4-c284-08de5e864fb9
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:00:09.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXE/Yv1jkGvz6IdaZmC+ae+TXU0GFdADJglccBKP697YrtDvXVUtRs0SSN7BAADIz4v/ye/qUhWJA8T+WyzleJYRFLa4aYOR4VFht5/OyUyBHvDMVaiMex08Iph7wSlK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12487
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 16:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21769

commit 059db30b32e968fdbf6e416411fb78d481ff94bd upstream.

Add clock and reset entries for the Renesas RZ/G3E DMAC IPs.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250801084825.471011-2-tommaso.merciai.xr@bp=
.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 26e2be7667eb..4e8881e0006b 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -48,6 +48,8 @@ enum clk_ids {
 	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
 	CLK_PLLDTY_DIV8,
+	CLK_PLLDTY_RCPU,
+	CLK_PLLDTY_RCPU_DIV4,
 	CLK_PLLETH_DIV_250_FIX,
 	CLK_PLLETH_DIV_125_FIX,
 	CLK_CSDIV_PLLETH_GBE0,
@@ -157,6 +159,8 @@ static const struct cpg_core_clk r9a09g047_core_clks[] =
__initconst =3D {
 	DEF_SMUX(".smux2_gbe1_txclk", CLK_SMUX2_GBE1_TXCLK, SSEL1_SELCTL0, smux2_=
gbe1_txclk),
 	DEF_SMUX(".smux2_gbe1_rxclk", CLK_SMUX2_GBE1_RXCLK, SSEL1_SELCTL1, smux2_=
gbe1_rxclk),
 	DEF_FIXED(".plldty_div16", CLK_PLLDTY_DIV16, CLK_PLLDTY, 1, 16),
+	DEF_DDIV(".plldty_rcpu", CLK_PLLDTY_RCPU, CLK_PLLDTY, CDDIV3_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_rcpu_div4", CLK_PLLDTY_RCPU_DIV4, CLK_PLLDTY_RCPU, 1, =
4),
=20
 	DEF_DDIV(".pllvdo_cru0", CLK_PLLVDO_CRU0, CLK_PLLVDO, CDDIV3_DIVCTL3, dta=
ble_2_4),
 	DEF_DDIV(".pllvdo_gpu", CLK_PLLVDO_GPU, CLK_PLLVDO, CDDIV3_DIVCTL1, dtabl=
e_2_64),
@@ -180,6 +184,16 @@ static const struct cpg_core_clk r9a09g047_core_clks[]=
 __initconst =3D {
 };
=20
 static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst =3D {
+	DEF_MOD("dmac_0_aclk",			CLK_PLLCM33_GEAR, 0, 0, 0, 0,
+						BUS_MSTOP(5, BIT(9))),
+	DEF_MOD("dmac_1_aclk",			CLK_PLLDTY_ACPU_DIV2, 0, 1, 0, 1,
+						BUS_MSTOP(3, BIT(2))),
+	DEF_MOD("dmac_2_aclk",			CLK_PLLDTY_ACPU_DIV2, 0, 2, 0, 2,
+						BUS_MSTOP(3, BIT(3))),
+	DEF_MOD("dmac_3_aclk",			CLK_PLLDTY_RCPU_DIV4, 0, 3, 0, 3,
+						BUS_MSTOP(10, BIT(11))),
+	DEF_MOD("dmac_4_aclk",			CLK_PLLDTY_RCPU_DIV4, 0, 4, 0, 4,
+						BUS_MSTOP(10, BIT(12))),
 	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5,
 						BUS_MSTOP_NONE),
 	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
@@ -300,6 +314,11 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
 	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
+	DEF_RST(3, 1, 1, 2),		/* DMAC_0_ARESETN */
+	DEF_RST(3, 2, 1, 3),		/* DMAC_1_ARESETN */
+	DEF_RST(3, 3, 1, 4),		/* DMAC_2_ARESETN */
+	DEF_RST(3, 4, 1, 5),		/* DMAC_3_ARESETN */
+	DEF_RST(3, 5, 1, 6),		/* DMAC_4_ARESETN */
 	DEF_RST(3, 6, 1, 7),		/* ICU_0_PRESETN_I */
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
--=20
2.43.0


