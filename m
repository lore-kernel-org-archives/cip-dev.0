Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C118C35FF7
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.58])
 by mx.groups.io with SMTP id smtpd.web10.34436.1741778657383417688
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=o7Lqp1V7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.58, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ity9Ev1UN79Xx84vm1xa6pqfIC+Z96Y2v3Pq+05cgqHPu2w1BmjnEetw5L9LMsUBP5yBzDkWYWFbItPIw2XMrdjgB/BI2iWLYOrUxWNS5aYsT/PL0hvzEcJzlMpRiuXvXaYXMNmQhPInBiBJ3eZ+3TPQoSHhTBIID0/WXq5Dhqv7cf6g5zxFRIoKX1Nn2nolC7HN2q9lsuA8H6iC2wzBhp9RmEAv4fdEUfczvVAW2/lT/8px66ktTd+3dTt5b/QVckJqRcncNFjeUAZUnXxEnobCB1YaOLApbKS6BjckfTDfvQl3HQ68P4lpMTQKSXXek+aqNhLR+N10U81swgROcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDFM4FWilpeAY6NgusKYD9j2q1eVuxsa2K0eIg+Uw68=;
 b=hyV9e5lgDWFX6YhYNB3acBozkJfVnL0ZnJ5pemmzV2Iz9gBjyqHFiuVYHxfBheDmTkUU+lvXA5QE3tzfK8UuVHQ2N5TDATsHoNoJgxjCvLzVQrf8PimsNoKN899tIvfErmUZ+RIPA3Mtx9tlnIusvO0MhRJ4i+ZloSg2t/deYGZspWBsggLhkJFj20Do+lcGNp75Rtq7zIIrrGMpfG12uHl4chC/OvKfmKAkQ4BdMv0YeX4AvXexBz+oNwQrUK7saag7sXJyTKuhKXH0fcUKKr65TZV7FnP3LVWl0SQHnLPQ+/6rVTT14ulObbfNKHni8cop3+WysS4SmCxyBo7A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDFM4FWilpeAY6NgusKYD9j2q1eVuxsa2K0eIg+Uw68=;
 b=o7Lqp1V7VNHBLRxD0bMAlJyzwHWOHPlBIkqO2GZM1D749RRaGyd3/umolVHYYsMe3nmAoOrnMi2orEjmP1LDOKGY6Q2eX10rmAvHtscx6+i7YUZq+SdZiF2/tB4biIFDdbeWRvHL/2BwlrAWuucqU09/fP2ECMQZYXJ6zXb0SfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:15 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 13/85] clk: renesas: rzv2h: Add MSTOP support
Date: Wed, 12 Mar 2025 12:21:50 +0100
Message-ID: <20250312112302.1605750-14-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f89c7c7-9893-4bbe-7f47-08dd61586bc2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bj0c3LaGx1ZCKQmdlObHi1riP5Z/zjwXAgdZWACkrJ5GT0mSF0nNxPoWZQk1?=
 =?us-ascii?Q?URX/r9j9Kd/wilmAjLz7Qz4wlanlIVq5F0tu2rPwuidGt1XAcwNCPob/g/vd?=
 =?us-ascii?Q?R5Id+V/zkB8EpAQKlBicEiRI33GUY8650xE9kuItzjZ3/T/rDrZ69x+GVQIq?=
 =?us-ascii?Q?CBdEOlTAALlfGRsE57vkr+cvsfRiRgY6Mq/4DhaYcUdlDuUC8P6BNOgNY2ZD?=
 =?us-ascii?Q?8fZTvB9FhDZSkWe7UbzpvkPc6HfQ681fr7WSR4NJaAYPq4NhQ5868rmgCCT+?=
 =?us-ascii?Q?5VMtf4mLRmouHBuMYM1JlTNH7Nrgc6EWC553B0ZyQDbM++fMJv0uJcRFfRKK?=
 =?us-ascii?Q?ilydmjwptQruQb0BezTpxRgpxgP8IYMgabYFxMygPhhMIqVG2r/YKfyzNYEb?=
 =?us-ascii?Q?ZwV3guP8vYjuC7G8z1DXCPLYmKYw0JsyU3Rxs1hLOThtnGW1JY8F9PuDosSn?=
 =?us-ascii?Q?mXhMl+HyGQUOF3KZ3VJszTsjndTftlbxnaZzcrsA15jU8vTcNGDEvwSHnrgw?=
 =?us-ascii?Q?ppAddQjRD23YzLgeuvq00yc5toC9A5WIf0ci4e6OEj0TqJH2z2WYLbtJABcW?=
 =?us-ascii?Q?Rpfzj3AP8Ft2mPMjwN+EheGdEc73Tb+VM6npVYdhlSQKGnPihtn1xhusJm5T?=
 =?us-ascii?Q?fyuetfYSUxCLj65wWYwFeFq+2/evspOuG0I7QmjuvBUga3M5OK7riAi5pBqP?=
 =?us-ascii?Q?8n4TLgnVBrOPOw7mHvHZWSS8Dji2gtj3LjItw0cg39vS1ahH5f7NNIxbbCuu?=
 =?us-ascii?Q?iQCkXiZNNxhIcSB1yg2qTT54+2yI1SWN6oU5PvfIwe3cDSR3hNTQyhl0T8hy?=
 =?us-ascii?Q?8v+hqtk0ohWUwLV6pRC/HocujfbXKYhxbgamqOPaTtwbmL57Ifauu3zImcuX?=
 =?us-ascii?Q?Qb1hi/eESiUFjy0n8LKOolGGKkNPNhJOuRBVgY5XmYxvO9Nd9Bl/zLAM+C+6?=
 =?us-ascii?Q?8hGlewwxbk1HVJXXJjYXtqm7/isnDxQvun9Qq0iE/WKq+4+n3A9nWiNk0WU9?=
 =?us-ascii?Q?MtCAk+MlwiGild71nclt1Px1DA6T+nCuA9D6uvtfukNjSZZwXBtwbd4SMs70?=
 =?us-ascii?Q?FyZfV83fG2nGaQzaX3ryMXE8c1wOi4wkCDc8sVvrGVN61Ltr6fSl+FJElDOg?=
 =?us-ascii?Q?iQIIzUVJzgQaSn/hKFAXr9SI1JBtn1vB1sWcZUEX8poNXFLQnzmGvGJY7X6B?=
 =?us-ascii?Q?VfAHFQqJWRKY1RxbDE9U+iz4TNE6mrHEOYE4fww5Z5YX+E8HDmABdcevjFif?=
 =?us-ascii?Q?6fAMwB5QOq1J93BsrWAqjV1NqMn9ghfW2QE05+GzXbCZIAJwUPewwBIl4G7x?=
 =?us-ascii?Q?tH7wJmtzJFTmGhnia5szLAxhyvugUNLCO/Q2eLvqltEYR7MOPfVlY+Y4x9+n?=
 =?us-ascii?Q?CT/UDLU10uXYNNZmhxTA6orDogKOu50qTqZFpDvLe1Zuc4V3B10Md/NNbbGS?=
 =?us-ascii?Q?8HMllaNLzslisEBSb35nTbJFSss97flBqU574iAr39a1LW4Gy/bzGQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?obuGPAMbuI26oa5UKEStF25rNmdKXksB+mywPKzpnG27hf5Yuh9k4b+hNqK2?=
 =?us-ascii?Q?Z5C/g53MarrwXjzIAk8tPlfEc/lHlCG+PNBk6iDyF3lgE3V/Jf4KSnQWuw6S?=
 =?us-ascii?Q?FVKzGUZrfEBCJ3KpFusGSNhbeoO+HM41yt4Fg0uFm+WLl3WoPI64lQDTRXUM?=
 =?us-ascii?Q?VnPaB1WqobiM6r5T5Zz5ZJmhtJZ4ngNzK5s3gdDhTsUY25786vzErLjzWHBa?=
 =?us-ascii?Q?ml6hM8CUseYX3D0lNOiBmm/Zw/MdJuKEPN9H9jJLAGgaeWsWBQ+2Ym8DcdcM?=
 =?us-ascii?Q?GyjsFS377S2Qz9x2HfiuBP4TqO11KTKYuQlEQqvollniS3ev1ptaJeMvbpk8?=
 =?us-ascii?Q?TMLWpeMzGfrSyOgC3FdRmoEti0MNaorSJbh2+oUfRoH1/TsbpncB0pr4R3AS?=
 =?us-ascii?Q?rth7KTBrU3DIFKpKHvBqdKqZdOa8XLspfpREj5bEDHlIvQerYYw7N/4TsGyB?=
 =?us-ascii?Q?OdIrnQJ07MPu3Z2sPzH/KBbBYp7FXWuPjDPP+0mwoyWKjTzOQ0mdUyYPmfGS?=
 =?us-ascii?Q?KHI0ncM0BXo/5TV00YsnO9mzfG+EpLQRyByoIT5E/hVgm6IKwcShvHNhDqO5?=
 =?us-ascii?Q?sl8i7gDHYo2yxd8cgjhYtUvkQEG8C66Rd/XqZpfMCAukvXJc8X8/9g4CJvu9?=
 =?us-ascii?Q?EZ42El8RRrFdJWWjisfFhqsUctxRsPM2vkW6StVZRl2kzKNF8lcGh3cQajrl?=
 =?us-ascii?Q?U18BFf20s9Wk8JUPtBHU1spHxD2CS0sg0806Sh3KlxFbgatSOp1wkuQEjeqj?=
 =?us-ascii?Q?KU5QAxgenWQPUf0jROT3gIxa7BAfWpA5vlxsBJymXdp0V99boV+2S3ryfSWX?=
 =?us-ascii?Q?LgAvJOP9aQNI2c6+ynnhxLXPA556JST1vT6mS1M03ug/sKxI1NKmPnXkAJiH?=
 =?us-ascii?Q?28BZKFNknnXSt7HdsTK3uadKmOi9669Pfu5Ma9UWofzM1aSdzdEgU/fH2e3r?=
 =?us-ascii?Q?SkzeR8FbpD/J7viYTFc8NHeIN2piCfhwJb0qajspYBTtlEJP4BsvG0i7X3cY?=
 =?us-ascii?Q?AWPIll4VwsnKRFFoeyMXCoBPYvdrl0IQqdL7GWZS0ZY1plhr8+YG+8deECWR?=
 =?us-ascii?Q?Zf6YtxyJgse9EcnMr3Mk7D3Ui0Egy8/N2XVd/6kt5+22OkNH+tQI6zQEJKA8?=
 =?us-ascii?Q?zTTgb6QWJEV9y66Iz+G7djRUh4U6ItmjHwhDEpBZSiuqeb3K0SWHYyUAg4BZ?=
 =?us-ascii?Q?sqexPUQcYambbRXEcTMEsnx7F8MF3GTk/Si/mwC2ifO9qn7C8M+b5EzpaFqD?=
 =?us-ascii?Q?fDgWJDZgbYx978pjRchyArH/tfGc+AocaC6MhywmjcpSvGnDMms3urn97epP?=
 =?us-ascii?Q?foMCCmroul4gFQZdjwt7YsYdurPTgQ8o7GswnCwhRmHZeRz0STl8bo/rf6Kx?=
 =?us-ascii?Q?y68OCKl2hXdxe6w+jQZcVw+1wup/ZOpgISijmjUlxDU9b2nG9/quDHaLVs9T?=
 =?us-ascii?Q?BasMSIy51MSV38BxL+OkFkhF9xFB9B7myD1Zp+K4oTiV5p6bz+uyweV/hyFy?=
 =?us-ascii?Q?9P2/w3EpatcimbA1eeDgYD3OXMYpoA9l/8jP8Dnh0SNKEtOLHbC8YSRoXAQf?=
 =?us-ascii?Q?PGq7jzol+fOVct90y7ev9QoFiZUo9A3fFwc/503uH5gs2jy5tn/jdIqkmJdR?=
 =?us-ascii?Q?/T3qwmgcSs+Hnkta3LW7sDs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f89c7c7-9893-4bbe-7f47-08dd61586bc2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:15.3038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTNgkpS4VuKhUKxEhjL3WZsu3O9A9scaoIjcosz+vB8UHrhnKMHZ9Vpt5oTWDseCrly9vkWixZOy6o47awYzRbqPuXGUnzsarx5C9iba0hGXSSwjVdI7O8EDtFYjOlTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18105

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9b6e63a777ea5fb85bf24f9cb5ba902eed4f1f2f upstream.

Add MSTOP support to control buses for the individual units on RZ/V2H.
Use per-bit (instead of group-based) configuration and atomic counters,
to ensure precise control over individual MSTOP bits, and to prevent
issues with shared dependencies between module clocks.

Co-developed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Co-developed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241213123550.289193-2-biju.das.jz@bp.renesa=
s.com
Link: https://lore.kernel.org/20250102181839.352599-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Link: https://lore.kernel.org/20250102181839.352599-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Link: https://lore.kernel.org/20250102181839.352599-4-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Link: https://lore.kernel.org/20250102181839.352599-5-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 155 +++++++++++++++++++---------
 drivers/clk/renesas/rzv2h-cpg.c     | 146 ++++++++++++++++++++++----
 drivers/clk/renesas/rzv2h-cpg.h     |  30 ++++--
 3 files changed, 252 insertions(+), 79 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 5aa9710aa402..a45b4020996b 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -115,57 +115,108 @@ static const struct cpg_core_clk r9a09g057_core_clks=
[] __initconst =3D {
 };
=20
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst =3D {
-	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5),
-	DEF_MOD("gtm_0_pclk",			CLK_PLLCM33_DIV16, 4, 3, 2, 3),
-	DEF_MOD("gtm_1_pclk",			CLK_PLLCM33_DIV16, 4, 4, 2, 4),
-	DEF_MOD("gtm_2_pclk",			CLK_PLLCLN_DIV16, 4, 5, 2, 5),
-	DEF_MOD("gtm_3_pclk",			CLK_PLLCLN_DIV16, 4, 6, 2, 6),
-	DEF_MOD("gtm_4_pclk",			CLK_PLLCLN_DIV16, 4, 7, 2, 7),
-	DEF_MOD("gtm_5_pclk",			CLK_PLLCLN_DIV16, 4, 8, 2, 8),
-	DEF_MOD("gtm_6_pclk",			CLK_PLLCLN_DIV16, 4, 9, 2, 9),
-	DEF_MOD("gtm_7_pclk",			CLK_PLLCLN_DIV16, 4, 10, 2, 10),
-	DEF_MOD("wdt_0_clkp",			CLK_PLLCM33_DIV16, 4, 11, 2, 11),
-	DEF_MOD("wdt_0_clk_loco",		CLK_QEXTAL, 4, 12, 2, 12),
-	DEF_MOD("wdt_1_clkp",			CLK_PLLCLN_DIV16, 4, 13, 2, 13),
-	DEF_MOD("wdt_1_clk_loco",		CLK_QEXTAL, 4, 14, 2, 14),
-	DEF_MOD("wdt_2_clkp",			CLK_PLLCLN_DIV16, 4, 15, 2, 15),
-	DEF_MOD("wdt_2_clk_loco",		CLK_QEXTAL, 5, 0, 2, 16),
-	DEF_MOD("wdt_3_clkp",			CLK_PLLCLN_DIV16, 5, 1, 2, 17),
-	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18),
-	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15),
-	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19),
-	DEF_MOD("riic_0_ckm",			CLK_PLLCLN_DIV16, 9, 4, 4, 20),
-	DEF_MOD("riic_1_ckm",			CLK_PLLCLN_DIV16, 9, 5, 4, 21),
-	DEF_MOD("riic_2_ckm",			CLK_PLLCLN_DIV16, 9, 6, 4, 22),
-	DEF_MOD("riic_3_ckm",			CLK_PLLCLN_DIV16, 9, 7, 4, 23),
-	DEF_MOD("riic_4_ckm",			CLK_PLLCLN_DIV16, 9, 8, 4, 24),
-	DEF_MOD("riic_5_ckm",			CLK_PLLCLN_DIV16, 9, 9, 4, 25),
-	DEF_MOD("riic_6_ckm",			CLK_PLLCLN_DIV16, 9, 10, 4, 26),
-	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27),
-	DEF_MOD("sdhi_0_imclk",			CLK_PLLCLN_DIV8, 10, 3, 5, 3),
-	DEF_MOD("sdhi_0_imclk2",		CLK_PLLCLN_DIV8, 10, 4, 5, 4),
-	DEF_MOD("sdhi_0_clk_hs",		CLK_PLLCLN_DIV2, 10, 5, 5, 5),
-	DEF_MOD("sdhi_0_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 6, 5, 6),
-	DEF_MOD("sdhi_1_imclk",			CLK_PLLCLN_DIV8, 10, 7, 5, 7),
-	DEF_MOD("sdhi_1_imclk2",		CLK_PLLCLN_DIV8, 10, 8, 5, 8),
-	DEF_MOD("sdhi_1_clk_hs",		CLK_PLLCLN_DIV2, 10, 9, 5, 9),
-	DEF_MOD("sdhi_1_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 10, 5, 10),
-	DEF_MOD("sdhi_2_imclk",			CLK_PLLCLN_DIV8, 10, 11, 5, 11),
-	DEF_MOD("sdhi_2_imclk2",		CLK_PLLCLN_DIV8, 10, 12, 5, 12),
-	DEF_MOD("sdhi_2_clk_hs",		CLK_PLLCLN_DIV2, 10, 13, 5, 13),
-	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14),
-	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18),
-	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19),
-	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20),
-	DEF_MOD("cru_1_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 5, 6, 21),
-	DEF_MOD_NO_PM("cru_1_vclk",		CLK_PLLVDO_CRU1, 13, 6, 6, 22),
-	DEF_MOD("cru_1_pclk",			CLK_PLLDTY_DIV16, 13, 7, 6, 23),
-	DEF_MOD("cru_2_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 8, 6, 24),
-	DEF_MOD_NO_PM("cru_2_vclk",		CLK_PLLVDO_CRU2, 13, 9, 6, 25),
-	DEF_MOD("cru_2_pclk",			CLK_PLLDTY_DIV16, 13, 10, 6, 26),
-	DEF_MOD("cru_3_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 11, 6, 27),
-	DEF_MOD_NO_PM("cru_3_vclk",		CLK_PLLVDO_CRU3, 13, 12, 6, 28),
-	DEF_MOD("cru_3_pclk",			CLK_PLLDTY_DIV16, 13, 13, 6, 29),
+	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5,
+						BUS_MSTOP_NONE),
+	DEF_MOD("gtm_0_pclk",			CLK_PLLCM33_DIV16, 4, 3, 2, 3,
+						BUS_MSTOP(5, BIT(10))),
+	DEF_MOD("gtm_1_pclk",			CLK_PLLCM33_DIV16, 4, 4, 2, 4,
+						BUS_MSTOP(5, BIT(11))),
+	DEF_MOD("gtm_2_pclk",			CLK_PLLCLN_DIV16, 4, 5, 2, 5,
+						BUS_MSTOP(2, BIT(13))),
+	DEF_MOD("gtm_3_pclk",			CLK_PLLCLN_DIV16, 4, 6, 2, 6,
+						BUS_MSTOP(2, BIT(14))),
+	DEF_MOD("gtm_4_pclk",			CLK_PLLCLN_DIV16, 4, 7, 2, 7,
+						BUS_MSTOP(11, BIT(13))),
+	DEF_MOD("gtm_5_pclk",			CLK_PLLCLN_DIV16, 4, 8, 2, 8,
+						BUS_MSTOP(11, BIT(14))),
+	DEF_MOD("gtm_6_pclk",			CLK_PLLCLN_DIV16, 4, 9, 2, 9,
+						BUS_MSTOP(11, BIT(15))),
+	DEF_MOD("gtm_7_pclk",			CLK_PLLCLN_DIV16, 4, 10, 2, 10,
+						BUS_MSTOP(12, BIT(0))),
+	DEF_MOD("wdt_0_clkp",			CLK_PLLCM33_DIV16, 4, 11, 2, 11,
+						BUS_MSTOP(3, BIT(10))),
+	DEF_MOD("wdt_0_clk_loco",		CLK_QEXTAL, 4, 12, 2, 12,
+						BUS_MSTOP(3, BIT(10))),
+	DEF_MOD("wdt_1_clkp",			CLK_PLLCLN_DIV16, 4, 13, 2, 13,
+						BUS_MSTOP(1, BIT(0))),
+	DEF_MOD("wdt_1_clk_loco",		CLK_QEXTAL, 4, 14, 2, 14,
+						BUS_MSTOP(1, BIT(0))),
+	DEF_MOD("wdt_2_clkp",			CLK_PLLCLN_DIV16, 4, 15, 2, 15,
+						BUS_MSTOP(5, BIT(12))),
+	DEF_MOD("wdt_2_clk_loco",		CLK_QEXTAL, 5, 0, 2, 16,
+						BUS_MSTOP(5, BIT(12))),
+	DEF_MOD("wdt_3_clkp",			CLK_PLLCLN_DIV16, 5, 1, 2, 17,
+						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
+						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
+						BUS_MSTOP(3, BIT(14))),
+	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19,
+						BUS_MSTOP(3, BIT(13))),
+	DEF_MOD("riic_0_ckm",			CLK_PLLCLN_DIV16, 9, 4, 4, 20,
+						BUS_MSTOP(1, BIT(1))),
+	DEF_MOD("riic_1_ckm",			CLK_PLLCLN_DIV16, 9, 5, 4, 21,
+						BUS_MSTOP(1, BIT(2))),
+	DEF_MOD("riic_2_ckm",			CLK_PLLCLN_DIV16, 9, 6, 4, 22,
+						BUS_MSTOP(1, BIT(3))),
+	DEF_MOD("riic_3_ckm",			CLK_PLLCLN_DIV16, 9, 7, 4, 23,
+						BUS_MSTOP(1, BIT(4))),
+	DEF_MOD("riic_4_ckm",			CLK_PLLCLN_DIV16, 9, 8, 4, 24,
+						BUS_MSTOP(1, BIT(5))),
+	DEF_MOD("riic_5_ckm",			CLK_PLLCLN_DIV16, 9, 9, 4, 25,
+						BUS_MSTOP(1, BIT(6))),
+	DEF_MOD("riic_6_ckm",			CLK_PLLCLN_DIV16, 9, 10, 4, 26,
+						BUS_MSTOP(1, BIT(7))),
+	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27,
+						BUS_MSTOP(1, BIT(8))),
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
+	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18,
+						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19,
+						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20,
+						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("cru_1_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 5, 6, 21,
+						BUS_MSTOP(9, BIT(5))),
+	DEF_MOD_NO_PM("cru_1_vclk",		CLK_PLLVDO_CRU1, 13, 6, 6, 22,
+						BUS_MSTOP(9, BIT(5))),
+	DEF_MOD("cru_1_pclk",			CLK_PLLDTY_DIV16, 13, 7, 6, 23,
+						BUS_MSTOP(9, BIT(5))),
+	DEF_MOD("cru_2_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 8, 6, 24,
+						BUS_MSTOP(9, BIT(6))),
+	DEF_MOD_NO_PM("cru_2_vclk",		CLK_PLLVDO_CRU2, 13, 9, 6, 25,
+						BUS_MSTOP(9, BIT(6))),
+	DEF_MOD("cru_2_pclk",			CLK_PLLDTY_DIV16, 13, 10, 6, 26,
+						BUS_MSTOP(9, BIT(6))),
+	DEF_MOD("cru_3_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 11, 6, 27,
+						BUS_MSTOP(9, BIT(7))),
+	DEF_MOD_NO_PM("cru_3_vclk",		CLK_PLLVDO_CRU3, 13, 12, 6, 28,
+						BUS_MSTOP(9, BIT(7))),
+	DEF_MOD("cru_3_pclk",			CLK_PLLDTY_DIV16, 13, 13, 6, 29,
+						BUS_MSTOP(9, BIT(7))),
 };
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
@@ -224,4 +275,6 @@ const struct rzv2h_cpg_info r9a09g057_cpg_info __initco=
nst =3D {
 	/* Resets */
 	.resets =3D r9a09g057_resets,
 	.num_resets =3D ARRAY_SIZE(r9a09g057_resets),
+
+	.num_mstop_bits =3D 192,
 };
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index bbf0b4ee7b26..6f096abda33c 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
+#include <linux/refcount.h>
 #include <linux/reset-controller.h>
=20
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
@@ -40,6 +41,9 @@
 #define GET_RST_OFFSET(x)	(0x900 + ((x) * 4))
 #define GET_RST_MON_OFFSET(x)	(0xA00 + ((x) * 4))
=20
+#define CPG_BUS_1_MSTOP		(0xd00)
+#define CPG_BUS_MSTOP(m)	(CPG_BUS_1_MSTOP + ((m) - 1) * 4)
+
 #define KDIV(val)		((s16)FIELD_GET(GENMASK(31, 16), (val)))
 #define MDIV(val)		FIELD_GET(GENMASK(15, 6), (val))
 #define PDIV(val)		FIELD_GET(GENMASK(5, 0), (val))
@@ -64,6 +68,7 @@
  * @resets: Array of resets
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
+ * @mstop_count: Array of mstop values
  * @rcdev: Reset controller entity
  */
 struct rzv2h_cpg_priv {
@@ -78,6 +83,8 @@ struct rzv2h_cpg_priv {
 	unsigned int num_resets;
 	unsigned int last_dt_core_clk;
=20
+	atomic_t *mstop_count;
+
 	struct reset_controller_dev rcdev;
 };
=20
@@ -97,6 +104,7 @@ struct pll_clk {
  * struct mod_clock - Module clock
  *
  * @priv: CPG private data
+ * @mstop_data: mstop data relating to module clock
  * @hw: handle between common and hardware-specific interfaces
  * @no_pm: flag to indicate PM is not supported
  * @on_index: register offset
@@ -106,6 +114,7 @@ struct pll_clk {
  */
 struct mod_clock {
 	struct rzv2h_cpg_priv *priv;
+	unsigned int mstop_data;
 	struct clk_hw hw;
 	bool no_pm;
 	u8 on_index;
@@ -433,8 +442,71 @@ rzv2h_cpg_register_core_clk(const struct cpg_core_clk =
*core,
 		core->name, PTR_ERR(clk));
 }
=20
+static void rzv2h_mod_clock_mstop_enable(struct rzv2h_cpg_priv *priv,
+					 u32 mstop_data)
+{
+	unsigned long mstop_mask =3D FIELD_GET(BUS_MSTOP_BITS_MASK, mstop_data);
+	u16 mstop_index =3D FIELD_GET(BUS_MSTOP_IDX_MASK, mstop_data);
+	unsigned int index =3D (mstop_index - 1) * 16;
+	atomic_t *mstop =3D &priv->mstop_count[index];
+	unsigned long flags;
+	unsigned int i;
+	u32 val =3D 0;
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	for_each_set_bit(i, &mstop_mask, 16) {
+		if (!atomic_read(&mstop[i]))
+			val |=3D BIT(i) << 16;
+		atomic_inc(&mstop[i]);
+	}
+	if (val)
+		writel(val, priv->base + CPG_BUS_MSTOP(mstop_index));
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+}
+
+static void rzv2h_mod_clock_mstop_disable(struct rzv2h_cpg_priv *priv,
+					  u32 mstop_data)
+{
+	unsigned long mstop_mask =3D FIELD_GET(BUS_MSTOP_BITS_MASK, mstop_data);
+	u16 mstop_index =3D FIELD_GET(BUS_MSTOP_IDX_MASK, mstop_data);
+	unsigned int index =3D (mstop_index - 1) * 16;
+	atomic_t *mstop =3D &priv->mstop_count[index];
+	unsigned long flags;
+	unsigned int i;
+	u32 val =3D 0;
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	for_each_set_bit(i, &mstop_mask, 16) {
+		if (!atomic_read(&mstop[i]) ||
+		    atomic_dec_and_test(&mstop[i]))
+			val |=3D BIT(i) << 16 | BIT(i);
+	}
+	if (val)
+		writel(val, priv->base + CPG_BUS_MSTOP(mstop_index));
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+}
+
+static int rzv2h_mod_clock_is_enabled(struct clk_hw *hw)
+{
+	struct mod_clock *clock =3D to_mod_clock(hw);
+	struct rzv2h_cpg_priv *priv =3D clock->priv;
+	u32 bitmask;
+	u32 offset;
+
+	if (clock->mon_index >=3D 0) {
+		offset =3D GET_CLK_MON_OFFSET(clock->mon_index);
+		bitmask =3D BIT(clock->mon_bit);
+	} else {
+		offset =3D GET_CLK_ON_OFFSET(clock->on_index);
+		bitmask =3D BIT(clock->on_bit);
+	}
+
+	return readl(priv->base + offset) & bitmask;
+}
+
 static int rzv2h_mod_clock_endisable(struct clk_hw *hw, bool enable)
 {
+	bool enabled =3D rzv2h_mod_clock_is_enabled(hw);
 	struct mod_clock *clock =3D to_mod_clock(hw);
 	unsigned int reg =3D GET_CLK_ON_OFFSET(clock->on_index);
 	struct rzv2h_cpg_priv *priv =3D clock->priv;
@@ -446,11 +518,20 @@ static int rzv2h_mod_clock_endisable(struct clk_hw *h=
w, bool enable)
 	dev_dbg(dev, "CLK_ON 0x%x/%pC %s\n", reg, hw->clk,
 		enable ? "ON" : "OFF");
=20
+	if (enabled =3D=3D enable)
+		return 0;
+
 	value =3D bitmask << 16;
-	if (enable)
+	if (enable) {
 		value |=3D bitmask;
-
-	writel(value, priv->base + reg);
+		writel(value, priv->base + reg);
+		if (clock->mstop_data !=3D BUS_MSTOP_NONE)
+			rzv2h_mod_clock_mstop_enable(priv, clock->mstop_data);
+	} else {
+		if (clock->mstop_data !=3D BUS_MSTOP_NONE)
+			rzv2h_mod_clock_mstop_disable(priv, clock->mstop_data);
+		writel(value, priv->base + reg);
+	}
=20
 	if (!enable || clock->mon_index < 0)
 		return 0;
@@ -476,24 +557,6 @@ static void rzv2h_mod_clock_disable(struct clk_hw *hw)
 	rzv2h_mod_clock_endisable(hw, false);
 }
=20
-static int rzv2h_mod_clock_is_enabled(struct clk_hw *hw)
-{
-	struct mod_clock *clock =3D to_mod_clock(hw);
-	struct rzv2h_cpg_priv *priv =3D clock->priv;
-	u32 bitmask;
-	u32 offset;
-
-	if (clock->mon_index >=3D 0) {
-		offset =3D GET_CLK_MON_OFFSET(clock->mon_index);
-		bitmask =3D BIT(clock->mon_bit);
-	} else {
-		offset =3D GET_CLK_ON_OFFSET(clock->on_index);
-		bitmask =3D BIT(clock->on_bit);
-	}
-
-	return readl(priv->base + offset) & bitmask;
-}
-
 static const struct clk_ops rzv2h_mod_clock_ops =3D {
 	.enable =3D rzv2h_mod_clock_enable,
 	.disable =3D rzv2h_mod_clock_disable,
@@ -546,6 +609,7 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *=
mod,
 	clock->no_pm =3D mod->no_pm;
 	clock->priv =3D priv;
 	clock->hw.init =3D &init;
+	clock->mstop_data =3D mod->mstop_data;
=20
 	ret =3D devm_clk_hw_register(dev, &clock->hw);
 	if (ret) {
@@ -555,6 +619,41 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk =
*mod,
=20
 	priv->clks[id] =3D clock->hw.clk;
=20
+	/*
+	 * Ensure the module clocks and MSTOP bits are synchronized when they are
+	 * turned ON by the bootloader. Enable MSTOP bits for module clocks that =
were
+	 * turned ON in an earlier boot stage.
+	 */
+	if (clock->mstop_data !=3D BUS_MSTOP_NONE &&
+	    !mod->critical && rzv2h_mod_clock_is_enabled(&clock->hw)) {
+		rzv2h_mod_clock_mstop_enable(priv, clock->mstop_data);
+	} else if (clock->mstop_data !=3D BUS_MSTOP_NONE && mod->critical) {
+		unsigned long mstop_mask =3D FIELD_GET(BUS_MSTOP_BITS_MASK, clock->mstop=
_data);
+		u16 mstop_index =3D FIELD_GET(BUS_MSTOP_IDX_MASK, clock->mstop_data);
+		unsigned int index =3D (mstop_index - 1) * 16;
+		atomic_t *mstop =3D &priv->mstop_count[index];
+		unsigned long flags;
+		unsigned int i;
+		u32 val =3D 0;
+
+		/*
+		 * Critical clocks are turned ON immediately upon registration, and the
+		 * MSTOP counter is updated through the rzv2h_mod_clock_enable() path.
+		 * However, if the critical clocks were already turned ON by the initial
+		 * bootloader, synchronize the atomic counter here and clear the MSTOP b=
it.
+		 */
+		spin_lock_irqsave(&priv->rmw_lock, flags);
+		for_each_set_bit(i, &mstop_mask, 16) {
+			if (atomic_read(&mstop[i]))
+				continue;
+			val |=3D BIT(i) << 16;
+			atomic_inc(&mstop[i]);
+		}
+		if (val)
+			writel(val, priv->base + CPG_BUS_MSTOP(mstop_index));
+		spin_unlock_irqrestore(&priv->rmw_lock, flags);
+	}
+
 	return;
=20
 fail:
@@ -822,6 +921,11 @@ static int __init rzv2h_cpg_probe(struct platform_devi=
ce *pdev)
 	if (!clks)
 		return -ENOMEM;
=20
+	priv->mstop_count =3D devm_kcalloc(dev, info->num_mstop_bits,
+					 sizeof(*priv->mstop_count), GFP_KERNEL);
+	if (!priv->mstop_count)
+		return -ENOMEM;
+
 	priv->resets =3D devm_kmemdup(dev, info->resets, sizeof(*info->resets) *
 				    info->num_resets, GFP_KERNEL);
 	if (!priv->resets)
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index ed8d2cad3260..dcd65e9c09da 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -8,6 +8,8 @@
 #ifndef __RENESAS_RZV2H_CPG_H__
 #define __RENESAS_RZV2H_CPG_H__
=20
+#include <linux/bitfield.h>
+
 /**
  * struct ddiv - Structure for dynamic switching divider
  *
@@ -46,6 +48,12 @@ struct ddiv {
 #define CDDIV4_DIVCTL1	DDIV_PACK(CPG_CDDIV4, 4, 1, 17)
 #define CDDIV4_DIVCTL2	DDIV_PACK(CPG_CDDIV4, 8, 1, 18)
=20
+#define BUS_MSTOP_IDX_MASK	GENMASK(31, 16)
+#define BUS_MSTOP_BITS_MASK	GENMASK(15, 0)
+#define BUS_MSTOP(idx, mask)	(FIELD_PREP_CONST(BUS_MSTOP_IDX_MASK, (idx)) =
| \
+				 FIELD_PREP_CONST(BUS_MSTOP_BITS_MASK, (mask)))
+#define BUS_MSTOP_NONE		GENMASK(31, 0)
+
 /**
  * Definitions of CPG Core Clocks
  *
@@ -104,6 +112,7 @@ enum clk_types {
  * struct rzv2h_mod_clk - Module Clocks definitions
  *
  * @name: handle between common and hardware-specific interfaces
+ * @mstop_data: packed data mstop register offset and mask
  * @parent: id of parent clock
  * @critical: flag to indicate the clock is critical
  * @no_pm: flag to indicate PM is not supported
@@ -114,6 +123,7 @@ enum clk_types {
  */
 struct rzv2h_mod_clk {
 	const char *name;
+	u32 mstop_data;
 	u16 parent;
 	bool critical;
 	bool no_pm;
@@ -123,9 +133,10 @@ struct rzv2h_mod_clk {
 	u8 mon_bit;
 };
=20
-#define DEF_MOD_BASE(_name, _parent, _critical, _no_pm, _onindex, _onbit, =
_monindex, _monbit) \
+#define DEF_MOD_BASE(_name, _mstop, _parent, _critical, _no_pm, _onindex, =
_onbit, _monindex, _monbit) \
 	{ \
 		.name =3D (_name), \
+		.mstop_data =3D (_mstop), \
 		.parent =3D (_parent), \
 		.critical =3D (_critical), \
 		.no_pm =3D (_no_pm), \
@@ -135,14 +146,14 @@ struct rzv2h_mod_clk {
 		.mon_bit =3D (_monbit), \
 	}
=20
-#define DEF_MOD(_name, _parent, _onindex, _onbit, _monindex, _monbit)		\
-	DEF_MOD_BASE(_name, _parent, false, false, _onindex, _onbit, _monindex, _=
monbit)
+#define DEF_MOD(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mst=
op) \
+	DEF_MOD_BASE(_name, _mstop, _parent, false, false, _onindex, _onbit, _mon=
index, _monbit)
=20
-#define DEF_MOD_CRITICAL(_name, _parent, _onindex, _onbit, _monindex, _mon=
bit)	\
-	DEF_MOD_BASE(_name, _parent, true, false, _onindex, _onbit, _monindex, _m=
onbit)
+#define DEF_MOD_CRITICAL(_name, _parent, _onindex, _onbit, _monindex, _mon=
bit, _mstop) \
+	DEF_MOD_BASE(_name, _mstop, _parent, true, false, _onindex, _onbit, _moni=
ndex, _monbit)
=20
-#define DEF_MOD_NO_PM(_name, _parent, _onindex, _onbit, _monindex, _monbit=
)		\
-	DEF_MOD_BASE(_name, _parent, false, true, _onindex, _onbit, _monindex, _m=
onbit)
+#define DEF_MOD_NO_PM(_name, _parent, _onindex, _onbit, _monindex, _monbit=
, _mstop) \
+	DEF_MOD_BASE(_name, _mstop, _parent, false, true, _onindex, _onbit, _moni=
ndex, _monbit)
=20
 /**
  * struct rzv2h_reset - Reset definitions
@@ -184,6 +195,9 @@ struct rzv2h_reset {
  *
  * @resets: Array of Module Reset definitions
  * @num_resets: Number of entries in resets[]
+ *
+ * @num_mstop_bits: Maximum number of MSTOP bits supported, equivalent to =
the
+ *		    number of CPG_BUS_m_MSTOP registers multiplied by 16.
  */
 struct rzv2h_cpg_info {
 	/* Core Clocks */
@@ -200,6 +214,8 @@ struct rzv2h_cpg_info {
 	/* Resets */
 	const struct rzv2h_reset *resets;
 	unsigned int num_resets;
+
+	unsigned int num_mstop_bits;
 };
=20
 extern const struct rzv2h_cpg_info r9a09g057_cpg_info;
--=20
2.43.0


