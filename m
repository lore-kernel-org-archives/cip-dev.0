Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C72C35FF6
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.43])
 by mx.groups.io with SMTP id smtpd.web11.34787.1741778655057438917
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EGBe821c;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.43, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0YWw8fQlY57//ymouNDkKI9KojHHZQmaJXxmw9uBp60lOVeJUum3XOcHXrIYHaQZKgoQoISpVpvmKwvPiqwu8KvL2qf/Tj6lZDhfVIJya2756YkwA6wyEIIQZJtrM7PkKVcz28AT/SIJlUXyn8w6nFjsIiFXmLC6/oj5kR4Be/TH6mY/mZL6LYZFFp6ds8wd7qaTtAV5mpy1ht93uJ6ABk+0nmJCj4R1ZlyEVeMa+bYmWn51e0T3azuu+9GDZ1oFk0fLEUfnsJdQuRx30Y9lsq+mkfGPd/NsxJu1opjWA3UBThxPGUWkU9lO2mhq+47jqNNgGBwnauRnxgg80Xegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj6XbEg1OkZOKYsMiz8gSOL7UNwbzk2D0cWYfOvkxlg=;
 b=p2zuQDt4LrF/DuWqU1v+YY15KQ2JdyQ6wy+HI5aU5ABVEZCfQnavqvtw3wJfo5RMqrLIaIAlXxJw1w165pTjOsnn/3n1rneimLqhJ6/TRpL5IZVo8Y3llVkd9yoj2gA6+Ii6+KW5t2CNGF/4IGhaHEuP7L9pgGnNN/WjN+8wD2KB5Ag1wQZ43H1gFODwdwF3I9I8zo0z0EI6twKdvh/GM0macv4gWBdHjVhaDo6Gn00yQVM9soEEeeIrPlcgg/IC+x7XOh78XuSRA59rYnl7Fd2EVCE9gWjfV4hHlzF907yM74AZUhZb5xAlg+NqUckAKDKwoXeCfA6US69ZZi/ykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj6XbEg1OkZOKYsMiz8gSOL7UNwbzk2D0cWYfOvkxlg=;
 b=EGBe821csw5IM2MJAmBZMucfag12YI8+wCHqLVT7v7SWeUCWRpuiGV0ffxfHAVzFvdaqL1U9EoxlQHRPxUuZfGcvMy8U2WpxvJrGoFXyJxveerTwn6YeRCS7atz7GeI+HiCE0CCOv5miZcDoQLHFic5i8lC7KAggawSZbdYxREA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:12 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:12 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/85] clk: renesas: r9a09g057: Add support for PLLVDO, CRU clocks, and resets
Date: Wed, 12 Mar 2025 12:21:49 +0100
Message-ID: <20250312112302.1605750-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9e300c-a801-420a-e6da-08dd61586a05
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0s3vhc3oRdATWCEH1X+0xIEaDYDZ9bUQ5gxHCFAAoiVgNWoNdNHHvI0FKheP?=
 =?us-ascii?Q?krjJ5lVD4xKRCzYBNrBW1h+CB21wQ6stm42L9I9NH/riQVPpkpLu2SG+jym2?=
 =?us-ascii?Q?2P+CRyVZ01TpADuC5166Qd9ajdaKmizg0yzrqrj6Unmq/o9VYtE4A9bdG3dp?=
 =?us-ascii?Q?qE7NwzGGidgHoa+nqeO5kCAskwcd8IdwAgnAKIb4I1cxxBQ58TYtMBbV73OE?=
 =?us-ascii?Q?ip+HXXtTE8jHlgopVzH+xoQMNH/HtNBQjkJclmeqbOhRdppWDWgTbRrM/qM3?=
 =?us-ascii?Q?AHjXJfAfBwL1tS4t4vu8QqGqoi/CqwLeYcxFKigAokSrRmape6NgTBEKjNNK?=
 =?us-ascii?Q?BxGJ6lCdpyvS12aeZC/v2LiyUCRl2IaEDRLuPIBZhW0ZXD5hgRH8GQUii279?=
 =?us-ascii?Q?JN3Jnnw0L1VuWmfhYkOPZwQSwma8pOigZDb9A+QHp0b5F7oiHOWoybQ1EBhE?=
 =?us-ascii?Q?+62zIXCea4/SXzVfmQ7UU+LuwYSBMs1oKEJSFVaKK1wmrt5zC5oIeVAyKfX7?=
 =?us-ascii?Q?jfDhlJQObRufY0fVI3McXyjthu5UUOLMHag6pUnd+gfI6BINC2uqHZoTE3WO?=
 =?us-ascii?Q?M7I/7Th080gHloWQvtmKmWRFD42alPX1+gRcFm/1rjPHTkPb+bCpWTzk9pPv?=
 =?us-ascii?Q?+uWnZNO69YcTgd8jqpdPykQq0l9w90slxIgDzKc4ZdXTZXBeGxhgYRe0Vau9?=
 =?us-ascii?Q?nA0ddCaVz4FwTfVLtJvFCWtTEOnZ8lfbCSy6yVFRWoAIACJWSsUEBLElkvQz?=
 =?us-ascii?Q?UWPfwTDD9qdYTR5FDtYYqwdTYViK2j7rTZeI5L996bPyyASjpJO6XSWekKzU?=
 =?us-ascii?Q?8lVUKY/RW2goJpIbeu3ir01vB30GGMKAvk/fklqaKEh8zMhktnGKL91gnNB4?=
 =?us-ascii?Q?Fw4eQSJ+ZBD8axU1Z8nXjg9vfS4VyLtCiZOYCJ/fWsj1RG2COCqSc2n0MR+I?=
 =?us-ascii?Q?0q7WWwBNpN208c439vMidFnaSncSLPrYkzr7yyG1M+Mzq8Gm+U+9+x7UEUEj?=
 =?us-ascii?Q?1OJ8CEQbnOf7olgaxcsiM7Kep6ATLIogQJ88ihWuaD+U1tqt0PTgZ8vUQucs?=
 =?us-ascii?Q?vtr734enznPG+2gBqllS3AYUFNggTU/C2rMptkPYNo5SWB1PxjpTCPHG+WJV?=
 =?us-ascii?Q?6pj8HXw6l6HjXaqRfLWfhtPFZnkhyKAVhyH7V7LFCh4frIkcEV3yCwV4avGC?=
 =?us-ascii?Q?L+Cs+CbUsZM1vtG0HcBtqUBlj/H3hhlCDrM3R6yXOsKj9Mov2uz+mNZFUdRS?=
 =?us-ascii?Q?bbplJlb4ojzE5myxDHbSdplqMU1rW0zNdz7cUXx6d05VJRJ14F70hI63446/?=
 =?us-ascii?Q?UQ0HnMITtpajIUmBPKSgbllqLFPnvzq+ZfuWEMUkSAprnxKpODYp8coxW7br?=
 =?us-ascii?Q?xIvXAK4NksjTTfsGZb3YrA/GEHRH/yoaorkVFWJpxRJjWNLzPorMp7Gm6ARp?=
 =?us-ascii?Q?j2CeHW+wwZBS9DLicMz9sZPEvQZBg2D1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L3zlYOQ7jWDxgFLzwHN6r6tix1MhHQqPjb1uYg/FoZBYSoQBRztYecWeOS2n?=
 =?us-ascii?Q?h38cramRFYeNOa0+0LWHEuvp0K8u13SkK+3Or27M2bTbBOCYlw5/Pant+mgr?=
 =?us-ascii?Q?IifctaURoiE8MPWTG/E4cbs8Zh41uwqDKzXMEfphVHbTc7eUwXOg320z28DD?=
 =?us-ascii?Q?R7kHvYwRgfHM8w9eaqK+IDzAxBJkUsAXn8dO0u2ILvtUsAf+rjMP1suA8rOB?=
 =?us-ascii?Q?bcqW28jldtJj7/wkkeP04lvVxDZuGxFOXKKR6AsRVnWQB1Q3abg13sCPo1Fj?=
 =?us-ascii?Q?8Jl8v5mxyePQUlFmbAYnDI9Si8VaB4Ra4W9e3d0/hhwfFU7f+qZ5q6mIrG45?=
 =?us-ascii?Q?PH8/VUoQ8MKgSfBytPOwqYNaaMlQmtvhhj1tFLsI7TXT7OvzmxJJOEf77M7F?=
 =?us-ascii?Q?fXb4AHnMQ0uQd+AdYPsKGZNd7oUG19hTa5X6lJ10cJVirJHEVjiALHhT9QDA?=
 =?us-ascii?Q?kwz54zBq64DIhF4/Uro+P0UDWA3QW4+ozZfwucWclP/1xev9l9kg8YCkID+/?=
 =?us-ascii?Q?BbplT9DGH8sRqJKPqdSto+STkp+2tegY9BNDFre63cRMj/VcbTvgXO0RHnxr?=
 =?us-ascii?Q?9tsRA7ar0PcZ2GyugQ4OVVZzXPAa2VhpdhX1vYqHVIqTZKHApu0N56jewCeP?=
 =?us-ascii?Q?ammVN6ox7QkYLGknowqJeKC9EVFWWkJKqJEPcFGVVIXWZag77Zy5sd28LEqv?=
 =?us-ascii?Q?6liAyO8PPwAuiriroRlZ33hN5UsKiE9lXnl3oiU8DWzcpedSPbn0lkyfQy1r?=
 =?us-ascii?Q?SPn2ZyHZN7wwUYppPM0r29+A1ePr/MdyUDX9LwtWjcffsfLmQwew/stJwROE?=
 =?us-ascii?Q?ERrVoKZBu4+J3/+VvppawEOSsyNK3cTGkvdYTRpYfVQdDjp6j0QL7gb1IZay?=
 =?us-ascii?Q?EaJbr+PZl4f7XtRNeYlasI2LxM9WzaMUhbbGBNIp0EHo+TKz4vE8sUVPrQvs?=
 =?us-ascii?Q?4cZg+/quJPLV0iV9GqZ1TEd+q8En7E5RL4/UNDpFYWaqEUvJ7JPFT95voyuc?=
 =?us-ascii?Q?RJFotDjUBHqg3W71GBL7rQgTiVDHe4Mzk3J8tOUZl52oc9LngbbUwSrYKdpj?=
 =?us-ascii?Q?eFnVxno2XPCiEmrmycUjWxazRYN7DeQHD9i+MgV5f4/RpxyP89otndz6nkrp?=
 =?us-ascii?Q?DwSpKUC8nPYPDA5TUpR50VQsADg5EihGZznRdgHmBoUyHoJO5km9jtmiNRYw?=
 =?us-ascii?Q?+NntkUPYNKJTbPuw5Cg2qFyyZrLVXkfDg38haRRA0g4HOCV31on6uCgQF5iI?=
 =?us-ascii?Q?foT6EiJewYoTJ3OPcY7S71Re5pNwtgppvzwHUUnbr4b2paXv2LiiMuOVQ4L7?=
 =?us-ascii?Q?DBX47HNu+b0DDGhK4rvygXOS2HtfkRRdDnGTe6S/rVJ5mlauRvBAYjXIyYwx?=
 =?us-ascii?Q?qU4nhdJ4sh5z7C8KVKnqlv+U1ty2Z7cijFuKX25OsXyW0nNhVZblSXcCN3ng?=
 =?us-ascii?Q?q/0aBVjjKq79MjSkL6NqV6GJk+rV8PSpzUPaGuMnFKdiYDcSNjrkdG8wvHIs?=
 =?us-ascii?Q?0WlDqdkhiphqO8gc9MDS+mpC7lOtI4QU619hRKTh4CIMColJO7DSEs+Z/qd2?=
 =?us-ascii?Q?ETMpEoWbby90m577etA1a/uJf0+ZRb8Yb7Gofdt5JRChdJBaJdM18Q3xrFy/?=
 =?us-ascii?Q?zH0GiRZqyJfrGrWRAsgGi7Q=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9e300c-a801-420a-e6da-08dd61586a05
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:12.3564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0a1TRVH6h7GAXje5csCVSmX7lT9JEk5UciQDLzwaygz7j0IavGtv8KfeadLto7uVfFNnOBA50vgK+eFkYRZPmNuExB4IBIdW9gnJJjtFE6r3tdYTncfP1KiL7tOc5J2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18104

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ee47b94102d2eaed23ac60910003cd0f3fade13c upstream.

Add support for the PLLVDO clock and its related CRU clocks and reset
entries in the r9a09g057 CPG driver. Introduce `CLK_PLLVDO` and associated
clocks like `CLK_PLLVDO_CRU0`, `CLK_PLLVDO_CRU1`, `CLK_PLLVDO_CRU2`, and
`CLK_PLLVDO_CRU3`, along with their corresponding dividers.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241202203916.48668-3-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 45 +++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  6 ++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 7c4507fd34e6..5aa9710aa402 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -28,6 +28,7 @@ enum clk_ids {
 	CLK_PLLCLN,
 	CLK_PLLDTY,
 	CLK_PLLCA55,
+	CLK_PLLVDO,
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
@@ -35,7 +36,13 @@ enum clk_ids {
 	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
 	CLK_PLLDTY_ACPU,
+	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
+	CLK_PLLDTY_DIV16,
+	CLK_PLLVDO_CRU0,
+	CLK_PLLVDO_CRU1,
+	CLK_PLLVDO_CRU2,
+	CLK_PLLVDO_CRU3,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -49,6 +56,12 @@ static const struct clk_div_table dtable_1_8[] =3D {
 	{0, 0},
 };
=20
+static const struct clk_div_table dtable_2_4[] =3D {
+	{0, 2},
+	{1, 4},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_2_64[] =3D {
 	{0, 2},
 	{1, 4},
@@ -69,6 +82,7 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
 	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
=20
 	/* Internal Core Clocks */
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
@@ -78,7 +92,14 @@ static const struct cpg_core_clk r9a09g057_core_clks[] _=
_initconst =3D {
 	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
=20
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_acpu_div2", CLK_PLLDTY_ACPU_DIV2, CLK_PLLDTY_ACPU, 1, =
2),
 	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
+	DEF_FIXED(".plldty_div16", CLK_PLLDTY_DIV16, CLK_PLLDTY, 1, 16),
+
+	DEF_DDIV(".pllvdo_cru0", CLK_PLLVDO_CRU0, CLK_PLLVDO, CDDIV3_DIVCTL3, dta=
ble_2_4),
+	DEF_DDIV(".pllvdo_cru1", CLK_PLLVDO_CRU1, CLK_PLLVDO, CDDIV4_DIVCTL0, dta=
ble_2_4),
+	DEF_DDIV(".pllvdo_cru2", CLK_PLLVDO_CRU2, CLK_PLLVDO, CDDIV4_DIVCTL1, dta=
ble_2_4),
+	DEF_DDIV(".pllvdo_cru3", CLK_PLLVDO_CRU3, CLK_PLLVDO, CDDIV4_DIVCTL2, dta=
ble_2_4),
=20
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G057_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
@@ -133,6 +154,18 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[]=
 __initconst =3D {
 	DEF_MOD("sdhi_2_imclk2",		CLK_PLLCLN_DIV8, 10, 12, 5, 12),
 	DEF_MOD("sdhi_2_clk_hs",		CLK_PLLCLN_DIV2, 10, 13, 5, 13),
 	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14),
+	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18),
+	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19),
+	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20),
+	DEF_MOD("cru_1_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 5, 6, 21),
+	DEF_MOD_NO_PM("cru_1_vclk",		CLK_PLLVDO_CRU1, 13, 6, 6, 22),
+	DEF_MOD("cru_1_pclk",			CLK_PLLDTY_DIV16, 13, 7, 6, 23),
+	DEF_MOD("cru_2_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 8, 6, 24),
+	DEF_MOD_NO_PM("cru_2_vclk",		CLK_PLLVDO_CRU2, 13, 9, 6, 25),
+	DEF_MOD("cru_2_pclk",			CLK_PLLDTY_DIV16, 13, 10, 6, 26),
+	DEF_MOD("cru_3_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 11, 6, 27),
+	DEF_MOD_NO_PM("cru_3_vclk",		CLK_PLLVDO_CRU3, 13, 12, 6, 28),
+	DEF_MOD("cru_3_pclk",			CLK_PLLDTY_DIV16, 13, 13, 6, 29),
 };
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
@@ -162,6 +195,18 @@ static const struct rzv2h_reset r9a09g057_resets[] __i=
nitconst =3D {
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
+	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
+	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
+	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
+	DEF_RST(12, 8, 5, 25),		/* CRU_1_PRESETN */
+	DEF_RST(12, 9, 5, 26),		/* CRU_1_ARESETN */
+	DEF_RST(12, 10, 5, 27),		/* CRU_1_S_RESETN */
+	DEF_RST(12, 11, 5, 28),		/* CRU_2_PRESETN */
+	DEF_RST(12, 12, 5, 29),		/* CRU_2_ARESETN */
+	DEF_RST(12, 13, 5, 30),		/* CRU_2_S_RESETN */
+	DEF_RST(12, 14, 5, 31),		/* CRU_3_PRESETN */
+	DEF_RST(12, 15, 6, 0),		/* CRU_3_ARESETN */
+	DEF_RST(13, 0, 6, 1),		/* CRU_3_S_RESETN */
 };
=20
 const struct rzv2h_cpg_info r9a09g057_cpg_info __initconst =3D {
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 0723df4c1134..ed8d2cad3260 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -33,12 +33,18 @@ struct ddiv {
=20
 #define CPG_CDDIV0		(0x400)
 #define CPG_CDDIV1		(0x404)
+#define CPG_CDDIV3		(0x40C)
+#define CPG_CDDIV4		(0x410)
=20
 #define CDDIV0_DIVCTL2	DDIV_PACK(CPG_CDDIV0, 8, 3, 2)
 #define CDDIV1_DIVCTL0	DDIV_PACK(CPG_CDDIV1, 0, 2, 4)
 #define CDDIV1_DIVCTL1	DDIV_PACK(CPG_CDDIV1, 4, 2, 5)
 #define CDDIV1_DIVCTL2	DDIV_PACK(CPG_CDDIV1, 8, 2, 6)
 #define CDDIV1_DIVCTL3	DDIV_PACK(CPG_CDDIV1, 12, 2, 7)
+#define CDDIV3_DIVCTL3	DDIV_PACK(CPG_CDDIV3, 12, 1, 15)
+#define CDDIV4_DIVCTL0	DDIV_PACK(CPG_CDDIV4, 0, 1, 16)
+#define CDDIV4_DIVCTL1	DDIV_PACK(CPG_CDDIV4, 4, 1, 17)
+#define CDDIV4_DIVCTL2	DDIV_PACK(CPG_CDDIV4, 8, 1, 18)
=20
 /**
  * Definitions of CPG Core Clocks
--=20
2.43.0


