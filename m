Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC910C35FFC
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:02 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.50])
 by mx.groups.io with SMTP id smtpd.web10.67873.1742914613372273948
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:56:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=KIXrjfT/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd33JPxyG2OrkTQLbIdp6YLgguGghyd68i+Mc+G0jnHZojMLiXicdLOr1ebq+h8ryf5ipaWozMXnChOneMW7vMdeW+YSm3Frzx0E4lvU41grIHfFtnADwwxQIEY0mSoSDNvMpKxYUQIrJIbT+yXU+Bleb9ZlQdhkEM6sRE4b5T83i6IaqWdICHgSB5z5jOPr1Ljr0QQNgWBoPKZvCfIPqT3CxkSCgEWIYKzPgxVzIme3BhRm8NSum4BDnIdWVHgUOYBwBk1ak4lFZuJpG+ajMLybfsCPgJtsKrUSIAODUrovif/14MKSOpJVEzUpvtjpodc81bGAZUKDhq1cP5yrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hHFY/uphoB8J6mpv0K0NYFTpcz1aZh6bBvOiv6uteI=;
 b=Qnd+j/R9gQ1YPYokAPeLLE0nweZKJdM2m4QuC51fkTwkMrVqgjIYB+S7KL0tc1LoHwkkQPhIuKdYHJVokQo5ooTmvjk29jlBYK6yMDo/vSu7BQvrxav0RwFB/SmKpgVLPqi2NGQY/XtsOM0GgvaEKEMUSlK4cmnTkorGfAUTrFKp9pDM+YYxH81yoaa+iLj/ovQOjMciAVmTrApzMEuI9pLSodFUBluJqAOBLDhK7TZdfqskWglLBquG5X95j+CDM+Yz/nCItTjYePH5IZBnmvVvZ32rrMCOWB7GZAdbnE418Oex0ijbk88QETNel12Wgyf881a+hxZsAEIB5IuBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hHFY/uphoB8J6mpv0K0NYFTpcz1aZh6bBvOiv6uteI=;
 b=KIXrjfT/ek5zPt5f1KP3f5Pty5fBnmtqfY4mDPYqsvk6rrKrKGTsNbYFktgMqZCbQbw4H6C7kctG46goQDML9Z/zXEbUs5suwnKtVifuLAazUAtw179R5YPsEPAEjaszTl/g4mRe0uAEFDmEvJfYoSAqMyCvlnMvaj2RTvINfmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:56:50 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:56:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 06/16] clk: renesas: r9a09g057: Add clock and reset entries for ICU
Date: Tue, 25 Mar 2025 15:56:00 +0100
Message-ID: <20250325145611.3595454-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: d778be22-600c-41bb-cd0d-08dd6bad45f1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6R6rQFUgbDip74VfqBSD0xF5UScZHPHsXffF+/sAa1VzOTPeMPSXlBFBjtWl?=
 =?us-ascii?Q?ndFNlJBrK7z/CL4Cph32K+Dk3FL+CtRGS3Sr3L6eSFjpoOYCVFRane+prQ4z?=
 =?us-ascii?Q?T4GVsqMM+Yqnnn8wSqZXtoNTzjiQG9ftQRUM+IDF9RgP/fbyhJg8ENAUXXgn?=
 =?us-ascii?Q?L5HnTnbUuNP5FJpV91rC148RKM6GbB+iVXuILB3IWs0nKR6viUFfglR6tUat?=
 =?us-ascii?Q?cY8UR+MqmE6Ic5q3gQj9SM1rYesnBkjcqxKGPaduVU4CXNAcymWVjZ3wypzQ?=
 =?us-ascii?Q?9M3YIg16FX0xb7twMAq9BclkT19E4hXOndrArkph5WBoSO1ae0ZF7VSkXX8O?=
 =?us-ascii?Q?y8jTWSmvWkSnJEq869gEmWxcgBbyW1wcgL54Eouek/u04V74nkUU4m3/zVD1?=
 =?us-ascii?Q?XFMmcWDaK8Ti9uqk+enVAb2iD32Ad0RA1x/44fpq5Cs9Ukrf0ZH/o7cSCgJF?=
 =?us-ascii?Q?LUCA7Ao9+fnB4B3zK+3NgxzGYRhtjhe72UmPNwfBQ74S9Il9XXVsIv+jia41?=
 =?us-ascii?Q?acMAnCjJIcySBtnjdKyVEPmXWA7uEs4gtnQoZmJlpRMHkasVWqS/PXcrfdzA?=
 =?us-ascii?Q?2/3MKJizcxbu13WgzvObK9OgPgJojcVEgNC9LbgISnjTBn0BfP2rZLX4On+t?=
 =?us-ascii?Q?TQfIteMmTpwLqGmuxFt4fLnVnFOW7dDY2uo1UsN9YiWvn/3iU9ugoP3PMijz?=
 =?us-ascii?Q?yc+i0IFKuzASQQzhiC1KnWDl9T/n6rlG8nY2Osj9SH4oSeD0VfranKJV8o+n?=
 =?us-ascii?Q?Vjxu/yQGcYUXanPYjnkleY2fVNeOuXSWfB0WEk6YtVEvJq5mCz2S4NDFBhln?=
 =?us-ascii?Q?Q+kjTEiWWnjVORajsbGIDJhXFoZ7OytbmIxEMboZfTgtmE3d1g+L76uy0vpD?=
 =?us-ascii?Q?iHIY7upAd9TY7Pg/x08UNh3V/FjmTvXHZ5mLxa/KtFHVL1HNlMhCzzkaZCTv?=
 =?us-ascii?Q?gJDO0Wyr239WMt8RvQV9AnYSmsWm/TtsMw5sqwNqfthR1MAFXmqsd0dEUHAK?=
 =?us-ascii?Q?zDos/GCKbLDWKHPOCs6Q6lPmiHwMirvAjJll9EROg/RbQfxw7dr1ROVr89Wx?=
 =?us-ascii?Q?HDJbMqoemp3oVsFa0Cab7QrY2Ip3BqVz7TAuAs8K4VrkyfNY09ISr9AGf9d/?=
 =?us-ascii?Q?pRgyGAl3AgihOBFjU0MnuEsIXiBkteS3XVIJU8cTtOFFIE1QD6H5Ziv4//LV?=
 =?us-ascii?Q?e3PjGwpcAIjzcGiXK/JQgn721iWm8QjuXIb/xrn48SAcUwk58HenfPZJAzQj?=
 =?us-ascii?Q?P+0HjU3VGW0LWIUd78HMlr+8X1Ma3wHprJWkis658oBkUYBKi0f7oUJl3/XU?=
 =?us-ascii?Q?KhYuhXhgOWP0Vi+/f4pIgPdXvvq/NDnJqBBne7vmzWr/32NKJl/M/QEiybaA?=
 =?us-ascii?Q?FUr3lvOFRq+oEsLK92sAKA6OQo+OKqFBmmTZCRGBBgsMErztTgq0DY4VQmtG?=
 =?us-ascii?Q?VzlSnWm4pQvOCYlrD0Mt3u8W5moVViQ4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i5v4xr22uiQkLeXu35T7/kofX2EWLWamO6zd0umoJ5P+1MBt/ROmpWEC88/w?=
 =?us-ascii?Q?/OBkioFSxutRamtMtMXyQuvRigZT+u0QcRnwryFQK/vnK/1ROYUsbGXCLRLa?=
 =?us-ascii?Q?G01RahY3lCwkdPZdOzLybaAzjvLBHlAbvhiJTmAoRQ3otxxl+iK7VMYoove2?=
 =?us-ascii?Q?hlUyeiHZDtN2v4sHtca9st2hf+XnLy/wgbCkkFOtTQcxfBPef0UiWgBeFPXC?=
 =?us-ascii?Q?tVfk1CcVgOeooFuWFMOB/YNfj+yFORHCnRvybI0aTFXNYJ82IrcIl6PTWsan?=
 =?us-ascii?Q?2oEP4VCGApzkjAYtPt818du3nQwFYDNDg8dQGz0Stvc5ZLEV+0uTzG7k8vyb?=
 =?us-ascii?Q?5LjQLXprTM9+Dz1Th/4jq6eIjd320uB8sPDM9a8TC/kP7AWa4u9wCZX1CJZK?=
 =?us-ascii?Q?WC99KzLMdk/4a6GMMtZVDzGFq3t7ZQqlV/wWCZO5yHm6Lk3xYbjRLhJ0QURl?=
 =?us-ascii?Q?hp1IUGN8NoXLGZ1kCJzlaW+ogNMCxO6FSu9iLy8AT4I2yczU5mce6Mu2pZtc?=
 =?us-ascii?Q?gDoi+3gZ7mJnSG2+i9OSgrVmOWZe3szwQ+wvaWU8sxuc0I9CaqVuWikrXMol?=
 =?us-ascii?Q?vdCtLrlVXzFR9aVb2z486jAJ0BNMPAykHXJY8jAvACZ4dHUdHk5mArSEsM+m?=
 =?us-ascii?Q?GOLSDOAMJ9znqQvRPMGmSIKHqHhhBBMUaMrBfXxCcYgcgW6kC1EdNxTjWq0e?=
 =?us-ascii?Q?wJUCZslzyhqf8ixClu5GDYIM5DmxsLoFSPLbYEAudOjiIvfHJ1gVgtBmH4Nq?=
 =?us-ascii?Q?4j97zPBXDzWhUSM4pRrelUQgvpocoCwf0wqC3nUsHYPdyn1JhwWwSHttG7ZR?=
 =?us-ascii?Q?cP/XmxCOEnPtHIDyx7BGnFpWr2PICoDzyiABVuIXarlQO6s9P8xZOlNszXDN?=
 =?us-ascii?Q?jreSEVjUNfRj+/BfucqDCUxY9TWxbk6Oh9boMpZ6BtoUoc5CtxAnbGMcGbXY?=
 =?us-ascii?Q?iSgZLSIMP/UG8k0xT/QWJsjsYvaJ4Ly7ST4Bk+snR+os/cYlJ/eBjxhGl7Hh?=
 =?us-ascii?Q?fxXpMW9C4W0qcU+srIkVTjEIxqf55DxVAprvaMs6QI9RT+0SHXM7l68IyVGO?=
 =?us-ascii?Q?ct7VSK+dnE0tnrKguA7pF9EXEvs0qX4gJUtLT16cfGSFdxIbStZDkXZr2p4v?=
 =?us-ascii?Q?HKXOeRqCUgwSxoPg1JjvfefdX731622bvRrvW+ee7NcZM/NHNml9HVbd80kK?=
 =?us-ascii?Q?pQ7+CwYbxaRxt7ZiRxsupukMFh2GZdDoGvl6rF13uakKydDKIDV1BPjklnnV?=
 =?us-ascii?Q?561AvD5Kr//aNJLzRCjuCsBoipB2liQl3THBu2JwteCk5z002/jsrFVkjHmd?=
 =?us-ascii?Q?9BGNPN7K0l//qZR/wfnfA27cdCUkLreyiAmVXpoQa5SlBqqowxWh7ZqBXaiH?=
 =?us-ascii?Q?EWEEaA3b9K3KF/T8FsRndl04aemKP+zV5L+61YsOVOy/a6CZGjnbI0sxtEaT?=
 =?us-ascii?Q?GFgv9qs+zKvdij5X7PTObrbDpC9YURJAgpmIEz2TcUt/m22WOPrAI16RbV08?=
 =?us-ascii?Q?feMiVr3cQhg/GMyO3PdxahU6rfEgIUM1gdajcfVUOhW4EBL8eiptgwj1MWF9?=
 =?us-ascii?Q?UiJePNTNuXeAgg/YRp6EfMTJFDZ9hKGPhLaIiDuQ9BHCgnw8T403XDEisYz6?=
 =?us-ascii?Q?IVx9lR4H9e9V//CmJql8ZjQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d778be22-600c-41bb-cd0d-08dd6bad45f1
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:56:50.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWCnnFrs2RHsaY9jlr0dDNRO7WGH3VA9GHAt6MjUq/MwRkFBi2LkE6h1Thfm1Wh2nZJvt9zxX3tEZPaVtc1C7rMwCeoxzmRD8ZhX2WpclMi+XmyJiPa6zdn05nshTM1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18356

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 44d13e198cbf031fdb8cb20b6bbbe82adcb951ca upstream.

Add clock and reset entries for the Renesas RZ/V2H(P) ICU IP block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240930145244.356565-4-fabrizio.castro.jz@re=
nesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index a426d0aa45924..7c4507fd34e6a 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -94,6 +94,7 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __=
initconst =3D {
 };
=20
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst =3D {
+	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5),
 	DEF_MOD("gtm_0_pclk",			CLK_PLLCM33_DIV16, 4, 3, 2, 3),
 	DEF_MOD("gtm_1_pclk",			CLK_PLLCM33_DIV16, 4, 4, 2, 4),
 	DEF_MOD("gtm_2_pclk",			CLK_PLLCLN_DIV16, 4, 5, 2, 5),
@@ -135,6 +136,7 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[] =
__initconst =3D {
 };
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
+	DEF_RST(3, 6, 1, 7),		/* ICU_0_PRESETN_I */
 	DEF_RST(6, 13, 2, 30),		/* GTM_0_PRESETZ */
 	DEF_RST(6, 14, 2, 31),		/* GTM_1_PRESETZ */
 	DEF_RST(6, 15, 3, 0),		/* GTM_2_PRESETZ */
--=20
2.43.0


