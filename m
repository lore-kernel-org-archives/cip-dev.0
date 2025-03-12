Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B923C3DA4A
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.13])
 by mx.groups.io with SMTP id smtpd.web11.34785.1741778645560955406
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=viZru6hS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.13, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzQUzw1qSd5wioDjkW4iU5+DF5IhNET06F4flSVhHPcXPx2NlS5Fw/IHAE9i62RY7WRA7U0ZhVPxBUsvu1714bQ+colJSlh/Laqa4CjXMMIHiHDoXbrYhoVtsuDdlUR2iJyqxbp0Zahj0/tGEM23wXNk5E2E6PBlEznzzIaBGlx8OhaVDLCX+lGECv/7DyuaOUGF5PHMnVe5toeAN2Z0L5KPp6+bhRLuYOCGjXPU3aFudq+2nJBWbYLZGVbL0I5XAJSE7o+tPX7xZxYE8EXskR+NoVBQersL9uUCmGsPFQHEottThAuJ9LBqEz2I/cfBxNycVnrDxontysGFdB6vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nt0PDrVFPi4wwZw2cjZG04dKHNP4efnexxCmuFX5w8=;
 b=PEISMaGSugtHuFwGsJHJq90ScVeL0XjXSvu//nbZiwmsTxk4JcEmQOhT/A74fxdBHwmIW1a8uNf9TRTGKEY3/E8bIvx9BK8ypbq0tQKIOlfTOyWyCGtbBP5uTWNcybozIflnha3Vdph+QESYswZSfYdkDHJtDZ4hptIdP38xrQuEdE4eVSdJOMKR/uPqhTiFQnXflT0ZAHWsirT3Ssj7qyFWYqzQDT5abiwuugwYP7sJVTlp8Vohqqr1hu/DBf5Jp3LlMgb5GuGVy8vN1hLT35hnNe8IdSurKuuvp+3lL8GHgH5bB27ilBAVDCoNijXLEBUlIs+pQSsNgBZ5sWhGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nt0PDrVFPi4wwZw2cjZG04dKHNP4efnexxCmuFX5w8=;
 b=viZru6hS7JemVHEWP0J/H5upYt+6Epf1QWKa4/zq9THxI6B31KGiLX/ep0o9bisdHIAlWg7NF4WV35IRwsogXXM5curzELhAYPCVbO0m5JMddXHm6FmYbsN4lPR0PPFzyq41QhXpI0O+qZVKeaIkS9uAhRb2dMO2ryUUQhKP1rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:03 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/85] clk: renesas: r9a09g057: Add clock and reset entries for GTM/RIIC/SDHI/WDT
Date: Wed, 12 Mar 2025 12:21:46 +0100
Message-ID: <20250312112302.1605750-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a6e309-0af7-490c-0137-08dd615864e3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?40s7FgPWMeItO3ZxeC7W3j/UB4rUw3mb4waLwn7iNO7AfmWoM04QmZMBrsEY?=
 =?us-ascii?Q?FswXdUVbfYF8tKncdOJTsc0Y0MeeAVXuiSxYrVHo3/I5Mi4ifAHNc9bZW0Qg?=
 =?us-ascii?Q?4sN+jG9/aJvZB6YLRNuzSK42Ls1WZu37VkAtY+a2cwA6XzNhLsW9EXKY8UJA?=
 =?us-ascii?Q?AFtQof0dJ5BAKkk2FUljjP28KNxPlU/xKg2Vv/6RZ9u85r9upTtR6xB8zJIA?=
 =?us-ascii?Q?2xcbXf1s0hnQIOXUcqA/hV1Q5SjYN6X1MLS3M3rXHnU9DP5rzkMl81hnwsLN?=
 =?us-ascii?Q?H42KGjfD1+J3e8bxJrwkDbx4dFLmKSYJouciuh1Pu9hF2cHqHU2/qjkEatlS?=
 =?us-ascii?Q?9z/3fKSxXn0yZrUR+HWSOkfl53KVS94TM8OhkPVn74e57hJYYmWNOE6jT0se?=
 =?us-ascii?Q?Y8O6AtnDSrf3KD2wAKNsrH6/1xgTZEdijcx3EEoQpYnHePADGCIuynknOq9j?=
 =?us-ascii?Q?c/FvZfQKKQtV8zyHAQ+QQgt63SGhWgEVp/FleHmm953VbqHyNTSGxgCo8Opp?=
 =?us-ascii?Q?3dCPNC1c/VvYjtRV0Dz4LTEZqjMEHm3/UufbWu6mDxF0SBxqAkcWJMncDUSi?=
 =?us-ascii?Q?v+egNI2iWbMB6fgUZU5fRY931sTPbBcok5crR+EMBFr1+tBMTvl6fgRT/JXU?=
 =?us-ascii?Q?1vdFjX7KDzzZaz0fr2Lux7aLm4FMrBAeeaLdz4oh+Cy+EGg33Z6Abc9Pi0XW?=
 =?us-ascii?Q?22OfoIp2zp+hUtfphMgsVXS0Ko3IMhPUvPeQzl7MLHpyXVBwxb5sD1FVSKf4?=
 =?us-ascii?Q?Aimr/6RkxCctB49KhDMMDk8ROvnG9TFp06s+YLWu9TacU4UE4f2q/QhidMce?=
 =?us-ascii?Q?FfwjNlUIKZEYDfIVUw9h2XtpcuV7bVq2Xn+ycDg3J0S6H0afYuP0COcLvuhI?=
 =?us-ascii?Q?EBfnZBl9fuUzcLWBhQ6Wy0H+Z01lBSnrtz9spF0/Bdh94L2zyT3jQfM9TVlQ?=
 =?us-ascii?Q?DCy2z+hEH/Ixw/qJuOXX/PGcMJeEvwQaV1zj6Y1U7MqDfvp/eiofZXn4MEkO?=
 =?us-ascii?Q?aKqMLiYXbAwdFXNI2yzyr9cSosokxQEQrnHgulvnmbx6oDB5VHjuyOHhn7Po?=
 =?us-ascii?Q?0bnIERij19HDP8fJdmuhofmqmgDE5jUZSS3x8Z7CVcXv1XACQvU0wL4X8PE4?=
 =?us-ascii?Q?UOK/CSOgwWp2pdWUNr3MBVuT+pKzSd/PPORV5TM2IaztJKmkVJVd5bWiHttE?=
 =?us-ascii?Q?BDhNntFIs0PmtFSUti2PJVGksQCys9yXootLT1pEtwtClVl3TVZOGQclFwIE?=
 =?us-ascii?Q?j5ULe6/EAS1ZR7Y45I58KnY9Bo0Ij+VU0XUkCjeaz5bmGptr7Y+umkBaKRFU?=
 =?us-ascii?Q?leg4x+Y3/Azi0ini0jiI5gztoPITURUYjhPVSKEbqmhtipSc+OrdDjCj/gRW?=
 =?us-ascii?Q?3vVw81Z9OW5bARQpCZoTxcKFbpngl6aABTxoLyJGNakSV+eiWXwTbeEsSSEJ?=
 =?us-ascii?Q?klaNFG9sYIG33ex8FA9laKD46phKR86A?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TGfDkXZ5MKrbedvzyp+tpIituNuBCdvMTTOd9vFmRxVutnRXe/RaDziF2tCS?=
 =?us-ascii?Q?oXJ9HNPL4J+xWm6YT2Q5eGXgVzajAGazJFiM59lOMfFTc46fAEb14RQqCJUa?=
 =?us-ascii?Q?HC9Ssio1eAuqy5GpPCN397906fgNMit47d7/Dw4CJ0UMzc2yTmRO0oDOrrQy?=
 =?us-ascii?Q?wKDK10FGBpkfgBBxE+adCFehcLz7SJJnqbqlGbUu4K41eKG/djfmqDizmJf6?=
 =?us-ascii?Q?SebU9j5s8QOT4k6BgK0/0Re3GVBsggsXFP2EkBBRJBCVzFxvMtw/sIWzIldn?=
 =?us-ascii?Q?hCpwNuL+DQz+uftTsjA5bVJ2vaqb3pRJpQoPs1E+1HcVGLllGuiNGN1NLbIc?=
 =?us-ascii?Q?re8lO55kdY1e3KRkUAZ4HFgkY6i8d/97PvCUoc44p3kMykSm+5mnklZPw0i7?=
 =?us-ascii?Q?ohdHgmQDxGkO3FxA7LFcqxKtMF3trBqdqOqYgO1BapHWw+uBv0hYCSTQyspU?=
 =?us-ascii?Q?4hg4yGeEgkZOzX9HcjvWMxDmNjWYFDDFz66FrSdxNp8bVQc7WXynAPrUTeLr?=
 =?us-ascii?Q?Zi7/jLKIB/5rIEaHz3dE5GW0541RRZPKCGaOF2Qvd8ZltBZwqWr27VEG9fPo?=
 =?us-ascii?Q?xraPSOmmpQYoSdAU0ZYV+eJ/xxpJjRRaggcOniJK5+ecaDewkAqyHIThe5dR?=
 =?us-ascii?Q?W5ixI875AlN1Jy+t1MS2Uw2zM5sephXyUnFfoHsot9M2gpTj9y4553xLgkcC?=
 =?us-ascii?Q?qSi+1gFI705nmzee0Z+CkK4ZYmlgeTHRSpSnXdWpV5lW4T4HCmfSVu1ML5Fo?=
 =?us-ascii?Q?X/xJCfK1sBBG/hb3wkXV+fdofaGVEJaIJriHy6PjUDlVyRO8KmXN7HYxS879?=
 =?us-ascii?Q?blKcagaxRJxzopPkALyx5VmXFjm1ChvOv4kNUJiMqgiQ9fv7mtSMf0lwLWFK?=
 =?us-ascii?Q?/4sQekqTLLhRjzENbkXMCGbqwywWowTVouCspVKXXPIRnTkEM4S/s+bDjfop?=
 =?us-ascii?Q?8d4HUYk7xGQbPqHMMaBJMEzLZ0rYIGx3FsgCAViFGEzzvcXMI2ak9IZyVKCa?=
 =?us-ascii?Q?TeZrUXYmGFRdsAdrrqPHhtOmUciLbifL7nWIwK9Vh22P3J41aP0b7hjfB2wA?=
 =?us-ascii?Q?+BK6KWrLjjHRsB/NiwjcG23d8rq5j1dBXdwnZ+23bWzzqB0pHPkxpaphNtKm?=
 =?us-ascii?Q?2D96V7Ik8wpYqP0J1kg14g3kCNTqcv2Ou/+DtwLpwmSXu22530FjbRsZQa/y?=
 =?us-ascii?Q?mHrrYvEgLB4q7seWIMYZyEbOMusuwgEAefbNkEGUfPNtv+pLCK4q6W/Iuuo+?=
 =?us-ascii?Q?O1gD1Fc96tRMTPJEEon/qHECp6RVN9u1v0HkYfld4vDFFHRKLaLQbPxz/sOc?=
 =?us-ascii?Q?yQNBilxcaX63BEeVZkgUSh/e1STi0xCRvcfbPMV/4HEdV8OJMLR/hN0ZWS/3?=
 =?us-ascii?Q?oWpKdiE1ZsFGcQKFM5eYWj7KpVHkK90CtPyOX9UHigO0dCADP/Q4A/bHr4Kn?=
 =?us-ascii?Q?76llfYfe02HWsIfwhOm/kG7T90ocXIxmDR3hK2NkLroiiudLvpth/r/bLNUC?=
 =?us-ascii?Q?RvIxZyDUMMOjTMSRn3uzt6oSSvAsrfzyFGndlUkCq8lOlOk13LxG3iFa3gjm?=
 =?us-ascii?Q?222fdh0UfJArq50n2neSFeWjzfYQV1GtgfRlAd7jydid33qTRxUf/4FdDynJ?=
 =?us-ascii?Q?onpZby8mW2iyzwPPlwP7CuY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a6e309-0af7-490c-0137-08dd615864e3
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:03.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sleRW50ZGOTTsGCILpOQKj0T4HFlYYSOc2nwqFSTGBUjo0U2ZPVOcllnZ2qIjj1+2pii4zm41xOM/1JNsURFUDaTpyICSHBml9YH9oirPhiWG6Il2t03vfo3unU2Oy3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18101

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3aeccbe08171b79f82fb802393a6324c7b732669 upstream.

Add clock and reset entries for Generic Timer (GTM), I2C Bus Interface
(RIIC), SD/MMC Host Interface (SDHI) and Watchdog Timer (WDT) IP blocks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240828093822.162855-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 84 +++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  4 ++
 2 files changed, 88 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 9722b810e027..3ee32db5c0af 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -25,16 +25,31 @@ enum clk_ids {
=20
 	/* PLL Clocks */
 	CLK_PLLCM33,
+	CLK_PLLCLN,
 	CLK_PLLDTY,
 	CLK_PLLCA55,
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
+	CLK_PLLCLN_DIV2,
+	CLK_PLLCLN_DIV8,
+	CLK_PLLCLN_DIV16,
+	CLK_PLLDTY_ACPU,
+	CLK_PLLDTY_ACPU_DIV4,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
 };
=20
+static const struct clk_div_table dtable_2_64[] =3D {
+	{0, 2},
+	{1, 4},
+	{2, 8},
+	{3, 16},
+	{4, 64},
+	{0, 0},
+};
+
 static const struct cpg_core_clk r9a09g057_core_clks[] __initconst =3D {
 	/* External Clock Inputs */
 	DEF_INPUT("audio_extal", CLK_AUDIO_EXTAL),
@@ -43,23 +58,92 @@ static const struct cpg_core_clk r9a09g057_core_clks[] =
__initconst =3D {
=20
 	/* PLL Clocks */
 	DEF_FIXED(".pllcm33", CLK_PLLCM33, CLK_QEXTAL, 200, 3),
+	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
 	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
=20
 	/* Internal Core Clocks */
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
=20
+	DEF_FIXED(".pllcln_div2", CLK_PLLCLN_DIV2, CLK_PLLCLN, 1, 2),
+	DEF_FIXED(".pllcln_div8", CLK_PLLCLN_DIV8, CLK_PLLCLN, 1, 8),
+	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
+
+	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
+
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G057_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
 	DEF_FIXED("iotop_0_shclk", R9A09G057_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1,=
 1),
 };
=20
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst =3D {
+	DEF_MOD("gtm_0_pclk",			CLK_PLLCM33_DIV16, 4, 3, 2, 3),
+	DEF_MOD("gtm_1_pclk",			CLK_PLLCM33_DIV16, 4, 4, 2, 4),
+	DEF_MOD("gtm_2_pclk",			CLK_PLLCLN_DIV16, 4, 5, 2, 5),
+	DEF_MOD("gtm_3_pclk",			CLK_PLLCLN_DIV16, 4, 6, 2, 6),
+	DEF_MOD("gtm_4_pclk",			CLK_PLLCLN_DIV16, 4, 7, 2, 7),
+	DEF_MOD("gtm_5_pclk",			CLK_PLLCLN_DIV16, 4, 8, 2, 8),
+	DEF_MOD("gtm_6_pclk",			CLK_PLLCLN_DIV16, 4, 9, 2, 9),
+	DEF_MOD("gtm_7_pclk",			CLK_PLLCLN_DIV16, 4, 10, 2, 10),
+	DEF_MOD("wdt_0_clkp",			CLK_PLLCM33_DIV16, 4, 11, 2, 11),
+	DEF_MOD("wdt_0_clk_loco",		CLK_QEXTAL, 4, 12, 2, 12),
+	DEF_MOD("wdt_1_clkp",			CLK_PLLCLN_DIV16, 4, 13, 2, 13),
+	DEF_MOD("wdt_1_clk_loco",		CLK_QEXTAL, 4, 14, 2, 14),
+	DEF_MOD("wdt_2_clkp",			CLK_PLLCLN_DIV16, 4, 15, 2, 15),
+	DEF_MOD("wdt_2_clk_loco",		CLK_QEXTAL, 5, 0, 2, 16),
+	DEF_MOD("wdt_3_clkp",			CLK_PLLCLN_DIV16, 5, 1, 2, 17),
+	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15),
+	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19),
+	DEF_MOD("riic_0_ckm",			CLK_PLLCLN_DIV16, 9, 4, 4, 20),
+	DEF_MOD("riic_1_ckm",			CLK_PLLCLN_DIV16, 9, 5, 4, 21),
+	DEF_MOD("riic_2_ckm",			CLK_PLLCLN_DIV16, 9, 6, 4, 22),
+	DEF_MOD("riic_3_ckm",			CLK_PLLCLN_DIV16, 9, 7, 4, 23),
+	DEF_MOD("riic_4_ckm",			CLK_PLLCLN_DIV16, 9, 8, 4, 24),
+	DEF_MOD("riic_5_ckm",			CLK_PLLCLN_DIV16, 9, 9, 4, 25),
+	DEF_MOD("riic_6_ckm",			CLK_PLLCLN_DIV16, 9, 10, 4, 26),
+	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27),
+	DEF_MOD("sdhi_0_imclk",			CLK_PLLCLN_DIV8, 10, 3, 5, 3),
+	DEF_MOD("sdhi_0_imclk2",		CLK_PLLCLN_DIV8, 10, 4, 5, 4),
+	DEF_MOD("sdhi_0_clk_hs",		CLK_PLLCLN_DIV2, 10, 5, 5, 5),
+	DEF_MOD("sdhi_0_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 6, 5, 6),
+	DEF_MOD("sdhi_1_imclk",			CLK_PLLCLN_DIV8, 10, 7, 5, 7),
+	DEF_MOD("sdhi_1_imclk2",		CLK_PLLCLN_DIV8, 10, 8, 5, 8),
+	DEF_MOD("sdhi_1_clk_hs",		CLK_PLLCLN_DIV2, 10, 9, 5, 9),
+	DEF_MOD("sdhi_1_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 10, 5, 10),
+	DEF_MOD("sdhi_2_imclk",			CLK_PLLCLN_DIV8, 10, 11, 5, 11),
+	DEF_MOD("sdhi_2_imclk2",		CLK_PLLCLN_DIV8, 10, 12, 5, 12),
+	DEF_MOD("sdhi_2_clk_hs",		CLK_PLLCLN_DIV2, 10, 13, 5, 13),
+	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14),
 };
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
+	DEF_RST(6, 13, 2, 30),		/* GTM_0_PRESETZ */
+	DEF_RST(6, 14, 2, 31),		/* GTM_1_PRESETZ */
+	DEF_RST(6, 15, 3, 0),		/* GTM_2_PRESETZ */
+	DEF_RST(7, 0, 3, 1),		/* GTM_3_PRESETZ */
+	DEF_RST(7, 1, 3, 2),		/* GTM_4_PRESETZ */
+	DEF_RST(7, 2, 3, 3),		/* GTM_5_PRESETZ */
+	DEF_RST(7, 3, 3, 4),		/* GTM_6_PRESETZ */
+	DEF_RST(7, 4, 3, 5),		/* GTM_7_PRESETZ */
+	DEF_RST(7, 5, 3, 6),		/* WDT_0_RESET */
+	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
+	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
+	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
 	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
+	DEF_RST(9, 8, 4, 9),		/* RIIC_0_MRST */
+	DEF_RST(9, 9, 4, 10),		/* RIIC_1_MRST */
+	DEF_RST(9, 10, 4, 11),		/* RIIC_2_MRST */
+	DEF_RST(9, 11, 4, 12),		/* RIIC_3_MRST */
+	DEF_RST(9, 12, 4, 13),		/* RIIC_4_MRST */
+	DEF_RST(9, 13, 4, 14),		/* RIIC_5_MRST */
+	DEF_RST(9, 14, 4, 15),		/* RIIC_6_MRST */
+	DEF_RST(9, 15, 4, 16),		/* RIIC_7_MRST */
+	DEF_RST(10, 0, 4, 17),		/* RIIC_8_MRST */
+	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
+	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
+	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
 };
=20
 const struct rzv2h_cpg_info r9a09g057_cpg_info __initconst =3D {
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 99bc08bd7cc1..60016b6122a9 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -31,6 +31,10 @@ struct ddiv {
 		.monbit =3D _monbit \
 	})
=20
+#define CPG_CDDIV0		(0x400)
+
+#define CDDIV0_DIVCTL2	DDIV_PACK(CPG_CDDIV0, 8, 3, 2)
+
 /**
  * Definitions of CPG Core Clocks
  *
--=20
2.43.0


