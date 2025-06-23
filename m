Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7914DC77B7C
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:48:52 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.17])
 by mx.groups.io with SMTP id smtpd.web11.419.1750690122755615946
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:48:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aqZwFKY9;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.17, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYRKcuI8iHaOI5jhjwxbPL2+k/oa/tCVFm9/rEHgBNSm/PpJOz5dLKcRoo9HEM5fNuIf8TvbfhY51qS6kZUCqgydkRj88hiE9QszszlbZON8qHsmjrhSSRSNdaK/4TyJqRSBeTz+Edp2/+T6157Kwe4bvmY1YAqEg8N7FENBa0/uL6XyrSx+9vnT+fkvfM19UlWI8Iwd/swVhszsTQ8GqzOuTDv383hvKcI0XhdUfyfipZtW6zr1pbZPy4RW/5p94qWAWx15b6cpaCWcvzdtziV5mAoW7WOxid4A7AlR3ZuPNmP4wH+cCSs/gr4g8Q91jLY1IVdj3QY7wUO5ueFReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bn1b0VTVvQarsm3HhswKba3KRfqW9E+PdfSyclQN+zI=;
 b=WYLl/tHulXF8PknmpLuTyfvaaURH8pfDslQmR/mDtEWygqyD/ZmFTBbZwrGNLDtWanjdWBTWOho5RQH5XTG5ET45PGj6AkYmUda9k5V7PnjpbLdijPRZW9TGlym6IOu66q6SW0Pz3OWsDUleZTjMha9VwPSJWCy93Eu+LiuOQcbbpD9rh2k32nBzt8lJPCMApjYtQHey/JetVKqrH0pU+RGzpTGa8O2fYe8kSPbRD8UEr18qrYxxMleSrbr9KjB0QsnaW+OtsVh7qXwpEeUpFTw1TyxCMquhlCEbHiTKvJxLT/JCcKOTMC1ul65mTd1l/u9tMp7cmEIsog+RD3vQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bn1b0VTVvQarsm3HhswKba3KRfqW9E+PdfSyclQN+zI=;
 b=aqZwFKY9Hoqoy7gFJbU2v+39Rs5klfkg/iUIxFpGYiMHIwldrmonIvfdy/Yqn8qk1K14RcFqL7gERZG302caccM35u7SsTZGxAG98wDB2S4JyrxMLuOsVeAJpQ9BmHxqKYmm9tsi15+ST2kucNVHV1OsOakDnra2Mr4R6UJFkwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:48:39 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:48:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 01/10] clk: renesas: r9a09g047: Add SDHI clocks/resets
Date: Mon, 23 Jun 2025 16:48:08 +0200
Message-ID: <20250623144817.2119838-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYAPR01MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b16d75-6493-4a56-e149-08ddb2650a59
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+oaMKH1CDLj7eu9GYBHxLJHDScBk99zNamj/2dN6sK/S7Y+E2HO7VuZn7oW/?=
 =?us-ascii?Q?6nWdNbkHF6DRLw6LQfjAPTCcvdDsDGIE/co/XNFNTIu7ddvt4HSS4P1CTr4u?=
 =?us-ascii?Q?DQiswglPnEzyi4OuHk/nu6UmcX25scU6M9kaKvIv9DKVpZPj5JENGvOR2bZL?=
 =?us-ascii?Q?vZXJxdyuulv8HA20oFq0hYdZHBVo9EJENJBVA7WVOH6tzvl7dW1vUIobV2Nl?=
 =?us-ascii?Q?9/c5DjMyx/GOu65K4rsMuerTphXGm7aRJFBHScrIt6ziex4J8ONWbQicJL/d?=
 =?us-ascii?Q?Ru6QEjlTp3/UGKXn4nfbzmHSJ6g06dJ856Or2r/v8BPojEJeZmSIOPr7UKLg?=
 =?us-ascii?Q?Us7PtvitCC1ortvW7taJTOlCpWo9HMfxuto8H85y+GYzpK3GfMfG0x38LHgQ?=
 =?us-ascii?Q?uLRxwt0H5opCuIsa4oJyofJ9Pqmb5ilelahTg6D2HkIkiKdYaQ/P+Sxqkq5S?=
 =?us-ascii?Q?6VW+V0xVXHLlkbK+AMk7fUFSzIxBINa7zA5W7/2UrGwD47AA03QNRcxpWhFn?=
 =?us-ascii?Q?eLAkwrYDCTT7xFmQXANlCUl3lS1R+Mo/C0YHe01TZs3MgF2xWuwKdE+kEZ+N?=
 =?us-ascii?Q?qYz/Zg2Q+sNch6do4abJYvD4tEToPD8YTeKWcXQdNcmoHfFXlPyMYa6Dzik/?=
 =?us-ascii?Q?tzGsuxYb+NXxlkwkafwBW200dUJ1hHw1TjjezyJiMZXPxR/ulm3rD45uXPns?=
 =?us-ascii?Q?/ePEMsK3XdKpcW49eecoaVZVIbmWG4sFjHIOSscljjqIpf/CRTdcb5Ia/s7g?=
 =?us-ascii?Q?7R4F6Q6uAT2gTC6MSWfpogwvgjydyhVuxPtguh2VJSKTa5dzkSVSWamVPPa/?=
 =?us-ascii?Q?Q2FWrsnx5jjXDqy/teiJih+4s4WU/LrcO8560ffnfKJA7AysOGiTCvCKDIJs?=
 =?us-ascii?Q?SueMdXRsYa9BG9n6P3MnGeS6OTOvE0Ek4d1D/952V/b3K48rwH2orsgLBY+I?=
 =?us-ascii?Q?6KjTjZVAz7mMqEwBjYkECB+vmyVmJZY21sUmbIrQImHgBiLOrU5O3tS1ZDBU?=
 =?us-ascii?Q?FrMlFnOipJLJA+SKfA7BSMtk7NOlO0vaHPXfnnYvdH3xKqT9CQZg8rrSMEEK?=
 =?us-ascii?Q?/V1XhlojDj7/CuyIEr8+PI2F/mo4B5IcxAqDPToSsPuQBgd1tzLb7Fwcn5SY?=
 =?us-ascii?Q?TBeM/rHWgBNulmdr6ID0z3//mwCYq0VBJ79PicSV8Nlz+fJnYXSZ8p0AouSr?=
 =?us-ascii?Q?/FUgX2Qhxhy4enJS9yvIQlaE0o4RXCCkrDOy6XWqxls0wQoTgyitew6PE4dn?=
 =?us-ascii?Q?emvBhixa1r+F+e9n4g1mZFeNHQZJsnD28yU3/HlKsEiXal4rG5TCHfJPN7TB?=
 =?us-ascii?Q?7lunfInmcrT0fseheTqkvXzqktnuISUhbUBpUEnQ+0Ea/8R9k6oyMCH8Fdnu?=
 =?us-ascii?Q?9rZnXey3uzPk8DavPG0Yt2l8s6QkKSz9falYy8wdk9szYGKfzxg9/KoosuJE?=
 =?us-ascii?Q?vTHmKYtPh8WuOdxUdtQj6AXoSgR9unKKhj/gsyYsGHz51UjVZGtVGlA9LyT7?=
 =?us-ascii?Q?E6cWaeHSLbc5JM4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fAWiSxOuYGH75AQmreVjMkYrCZ9lX+ypmq3zqMjOysYcGbTTokZb+Vu5FTjU?=
 =?us-ascii?Q?W5mmncbskQpwVxWyVOYvNdF6nZGkT+O/hzr3qsB+ZQLYldxG6VI3BjQ0nOk1?=
 =?us-ascii?Q?y0e3i1n+/rlqa58o6FiOSmgRiJ+F9WcKJWcvWmZTPB3D5jicll1FbmSpMVCT?=
 =?us-ascii?Q?k4yTbttze0jdfk3mI9hS0XGZnYtnk1NEzRf3PEvg2hJdzYO2HrzUl1gtn3sC?=
 =?us-ascii?Q?ghAx7ER/0EhysK4rJktSSI1pfyqgxrbdIwFCKBGFJsQ9+SWECg369AVx9Gsc?=
 =?us-ascii?Q?MOe3AY/xFsj083j0Db+OrY1FXK6I52bZz7nIVoB2s4FvPaEYoUGSVCIXDz4N?=
 =?us-ascii?Q?vnL0kAdSDGcL4JbJ0h/ouuG4NTVSQ6jrHsn/8cVp32e6GU7Aw5i9r131TYzw?=
 =?us-ascii?Q?19979uDuRX9Fx3DLEYYUdexjECt/Bh43j+xNQ+5eacdM/yu11ch6t8eJCaUd?=
 =?us-ascii?Q?osa9az5snN22VF29qIegW7UPWYLkH5nemMn3Ok/Ap3R99rop0pYEnVfhJj53?=
 =?us-ascii?Q?/cOSZ6R4kJ1W3cZ9HIY5MCMd2aMzRtx+WHJMwAoixKoePF0xppx+085fcvzk?=
 =?us-ascii?Q?VfdwRMru9fxiw6PpXkXyLLwIBfSQ2ULW3N7Ka44RXcU7VvsyX6+md7e297jD?=
 =?us-ascii?Q?NT3yqcQgBU/3WoH9QxSidkv6NXWWYiupVGraDxGKqPPNB481GPjp0uqnLxq4?=
 =?us-ascii?Q?JgCVr4Gg3rdZL3Ur8SSMvzSCNjVyvMqY3E/hjYxAGdYoonLGR2J/pdmmG4pR?=
 =?us-ascii?Q?OX5sEftBmeI9Z+dlpJEBjnqxMH7/lDlcnEc8TaGdjLBCwok/a3A8gSqiIVok?=
 =?us-ascii?Q?UF4mBQfirnzafDv0qKVtBkXFW/6xOTco1k/NHmRnnJ/p6ngNuDwDIaooe2mf?=
 =?us-ascii?Q?O3713YhOIM4dx/N6tAPSMaxczP+qL8ocw3ngEzYp83x7uT/0/9jS7T6yiEZ2?=
 =?us-ascii?Q?rxoE2innzo3E7t6dfKb3byiv7o1+tDNn0HI1uMVNcGpYWpz6V4HT8ffljlF7?=
 =?us-ascii?Q?Cs+B8ABuyCyJVFz9VEW4ZmSCpeQQcyL+w/5RXmhwI1b4Le11+gkEpFONmOX+?=
 =?us-ascii?Q?gc3vdjHInMTeR43qy9RDb2vCLK3tmRBX3kkRgfht2GrKX7tzAHkvojsj9AQU?=
 =?us-ascii?Q?t6/7VshKrr95fvihjT8/BpM6wKwf3Qyo+Ak3WApQCMAocg/nPQp6ie10MJ17?=
 =?us-ascii?Q?lP8UW/YB13anRGkq8/WIv1fV64/cNJAIvxO96fAdky5lNSqCIbJu9cX2FrVp?=
 =?us-ascii?Q?r63If3WPWBhw2yoxiiIO0S+4xYYgGMvBV4PwhoYY/KKLAzgYHkcu3spdRwoo?=
 =?us-ascii?Q?LkqcR2F+otRGP14JjmXH/Hux+X0OIP5bJjLSabvEP3tr7JUsiBkAxskAyEVg?=
 =?us-ascii?Q?0Hz9+TeaikZOLOYNprSMxxxj1OPiFyz2j81be4KIWulQyTBn+0sSHkvW4vLg?=
 =?us-ascii?Q?p2aYD72Xqu7czNfBKuS9ZQdySC+JwOsvCtI+9aff7CrtwwKOyjBatdESd4pw?=
 =?us-ascii?Q?KoxZ8tf/8oBO0SYLbExiwSMllmRbPxhsoeES9dNOJ0q+x+umH86s/Z9ObKOE?=
 =?us-ascii?Q?PEpFgVVlnZep98qO4h9Em+0J6ZoPx/d581T+HmMPkZytM56F86Habqutd73F?=
 =?us-ascii?Q?rzSluYGYl7uKNzSA5OuITl8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b16d75-6493-4a56-e149-08ddb2650a59
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:48:39.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TND4TDohvu03mkUBFxu9B5v/egG0i1RvhQvMQb/Km4eJdOafMPaPLldIy+UOfJBPMvWh+OTmAxGnw9v17nOWUI5TwK4SBjZ+dvQd+91SQnZQl3ymy8Fz2U9edLldMhbN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:48:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19206

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 922c892834689939953c74bd34d01788b17feb7e upstream.

Add SDHI[0-2] clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250126134616.37334-3-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 1886eab9ef9e..133582317490 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -31,6 +31,8 @@ enum clk_ids {
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
+	CLK_PLLCLN_DIV2,
+	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
 	CLK_PLLDTY_ACPU,
 	CLK_PLLDTY_ACPU_DIV4,
@@ -71,6 +73,8 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 	/* Internal Core Clocks */
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
=20
+	DEF_FIXED(".pllcln_div2", CLK_PLLCLN_DIV2, CLK_PLLCLN, 1, 2),
+	DEF_FIXED(".pllcln_div8", CLK_PLLCLN_DIV8, CLK_PLLCLN, 1, 8),
 	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
=20
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
@@ -124,6 +128,30 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(1, BIT(7))),
 	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27,
 						BUS_MSTOP(1, BIT(8))),
+	DEF_MOD("sdhi_0_imclk",			CLK_PLLCLN_DIV8, 10, 3, 5, 3,
+						BUS_MSTOP(8, BIT(2))),
+	DEF_MOD("sdhi_0_imclk2",		CLK_PLLCLN_DIV8, 10, 4, 5, 4,
+						BUS_MSTOP(8, BIT(2))),
+	DEF_MOD("sdhi_0_clk_hs",		CLK_PLLCLN_DIV2, 10, 5, 5, 5,
+						BUS_MSTOP(8, BIT(2))),
+	DEF_MOD("sdhi_0_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 6, 5, 6,
+						BUS_MSTOP(8, BIT(2))),
+	DEF_MOD("sdhi_1_imclk",			CLK_PLLCLN_DIV8, 10, 7, 5, 7,
+						BUS_MSTOP(8, BIT(3))),
+	DEF_MOD("sdhi_1_imclk2",		CLK_PLLCLN_DIV8, 10, 8, 5, 8,
+						BUS_MSTOP(8, BIT(3))),
+	DEF_MOD("sdhi_1_clk_hs",		CLK_PLLCLN_DIV2, 10, 9, 5, 9,
+						BUS_MSTOP(8, BIT(3))),
+	DEF_MOD("sdhi_1_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 10, 5, 10,
+						BUS_MSTOP(8, BIT(3))),
+	DEF_MOD("sdhi_2_imclk",			CLK_PLLCLN_DIV8, 10, 11, 5, 11,
+						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("sdhi_2_imclk2",		CLK_PLLCLN_DIV8, 10, 12, 5, 12,
+						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("sdhi_2_clk_hs",		CLK_PLLCLN_DIV2, 10, 13, 5, 13,
+						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14,
+						BUS_MSTOP(8, BIT(4))),
 };
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
@@ -143,6 +171,9 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(9, 14, 4, 15),		/* RIIC_6_MRST */
 	DEF_RST(9, 15, 4, 16),		/* RIIC_7_MRST */
 	DEF_RST(10, 0, 4, 17),		/* RIIC_8_MRST */
+	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
+	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
+	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
 };
=20
 const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
--=20
2.43.0


