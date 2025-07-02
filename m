Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB0DC83F07
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:37:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.54])
 by mx.groups.io with SMTP id smtpd.web11.20589.1751452661217047482
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:37:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PQvtna/b;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lN8vXoVcGQK0iUvoYCX/u58Cqt6OVHfASo0VDm39CtKSeKGf4ZXVOvTdpf5xED6OprdyFqe+UcFnUwEzt3RzO8ZbVC9D9lgIWjfLqhThNTHjBJxl3U1szHSMBsIdzy/FhQJqk3CjbfB23bKpvraYluiNHIOmS4jRpOWYWk4cYHV/zMjGTF8EuIEMEWeuBjhAC2f61eIkAiu2qTH1zkNKjwCtI6ivFAJtkdEDPYe5vMbJCls8LNQkVuDLEnAfw6bpKoqKQlBvyus7OXJpKmBKnjEOQ4d9eSbI+2qyjEytz4/vNywIYsxGwCZJPPbRdInj4OIvZIcpWZbE8YCAlr5U+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp/Stf06FlQw9yLfOOkSBQ1de/29Rcu58g4VNKEeGjA=;
 b=mfeN9JUMQPwem1bBfuqizf3Z94aipE4BZvbSAH6EAsaBKAvuatnaijB9TowPPQMs8dNIDKYVrnGzN/XdQnfretm5VIQQSQtbvPNrEVxCTPQc/uSYJwQnFthWpYBvLTt9crfffEGiSVVhtNYgP5RE9QEJTduoF0n+/SIpO1299Fxs+TXyF0sqEX5NK7Sqi+Rg7V6jef2sXCEEX73bKGcZFaYZjktfk0Iqx9GR3CELma6fKR8xYfXE3lWAVM3mvG8J6h85b3prG3BJVyo71XXI3dOLWuvuqtvMZRf6yQhvvWL2vIGCZWv8CzVWM8sI7goZQDwPgKZM7h4aO+HLbNvuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp/Stf06FlQw9yLfOOkSBQ1de/29Rcu58g4VNKEeGjA=;
 b=PQvtna/bR7Ovf/Ijpe5iuGbfuKcf5braGKDjLOs8LITgQeWXGWgKHSesqJ3hmEGtKiR1TIUi193E4qAM1rLADyWuErxZXEaQN2Db2JOXiIIb7eXPb/n1vWdgWJEld6G789I5itgTIVcADs2l0EN/7InDl209gRyvGIMwIAW8Yj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13822.jpnprd01.prod.outlook.com (2603:1096:405:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 10:37:38 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 03/12] clk: renesas: r9a09g047: Add CANFD clocks and resets
Date: Wed,  2 Jul 2025 12:37:01 +0200
Message-ID: <20250702103710.117760-4-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13822:EE_
X-MS-Office365-Filtering-Correlation-Id: 34047adf-46af-4fa2-1a28-08ddb95476e9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9y1R4ziN/0/I/7SQhXqxlIq/9Fecr8OuIT3K5CKZbTjALedxNTtOuW0W0kYZ?=
 =?us-ascii?Q?0THncQuotfjg+NyLDxgqZ2+AMCxhgEJTI8GLB4xeWjZIrEOKbwHbbGOh0VAO?=
 =?us-ascii?Q?iOLd8aNVQJXxN8MLtnRl9gDbIf5/l1RjOFXRCgAV9q0ovanPIuiVj8Nwvwjm?=
 =?us-ascii?Q?/W/HyZM8ESPN4O1GE2eR0Y/PcdFNFSXbNbqaxT6yq6KStPnwGMKbD7ZQPcsn?=
 =?us-ascii?Q?NxZ2RelzdyJb/P7JfA6P8EBGdLI5MThyPIhnC3O3DlENK+YKFgC817MjdPnk?=
 =?us-ascii?Q?URPkHFaYxtFc7egR8CrbcpUZ3KauZ/z2EAiyL8WvsBwl9tJb1+3WIBnXurRW?=
 =?us-ascii?Q?4UW4s/WlSzOUQIl+ZehLm8hmMpMUvuDlA2ekMf7lHf4cE0NbGojYC5M0HrrY?=
 =?us-ascii?Q?Uwu6nSie/zy1Mh1JbdGGQ9tKTiamPrgUAbEa0izapH8rkH/kYadHq1hZ/XI9?=
 =?us-ascii?Q?U8LS5rQ4dvKrtg8lN1hO+LwhdNR+SyoySeQKpMv618fszITGXTDaXjd0uT/V?=
 =?us-ascii?Q?KKxvQoMpEPuoI0oQUlYSpAnqvigXmmTbbwe/Q5W0tC9IKf1yuHxBH1cPmPo2?=
 =?us-ascii?Q?sTxg6jUi0AY5Mi3Ze0NW0NHtrwW+WO9d1jSxUMdaSc0PZTph2rgDvJlyyBPW?=
 =?us-ascii?Q?wPbuND2TxNGV/iQsXgCoGt6wpsLRzvCM/d5cJDXSOe2I+BTqQHHNioVA6xpM?=
 =?us-ascii?Q?KImQNGCWOQzoPdUFOV5yohqI+uzv81cQELSc5X2fTfMKSx4GfJLKKQz7awoR?=
 =?us-ascii?Q?vgaWmEQ+R7qRXZ6rrunWNcGQVWZqgIiWssOusm6/QUVKKqi85w72EI0vheOd?=
 =?us-ascii?Q?fJsgbtYX/jAg/Abuqyz3leZb8Ys6hJWYmj+fkn2/3+hFJfMsZjajVg1ojeHn?=
 =?us-ascii?Q?keY3BhY3/5+7bx2viwk5hnFTfuwa4T0gtLwciGkKJ87GWWDr1c2l0RSeUS4c?=
 =?us-ascii?Q?sKbFfd24NwaAG6NBM2Ox3j2pHlKCkU86tagxMs4ggPArKHyzXnkfjZtcmXZ0?=
 =?us-ascii?Q?esjaS5USbEwiotZUoGprkT02a+tmusl15EUfduzGZPgx2kKmw5naXl3/W6zu?=
 =?us-ascii?Q?oe/MYh4vQQaFdJPEe8LqJnpmxI1jGGhoJw6Kd9QxVz/XkRAabxfpSNU3XGzJ?=
 =?us-ascii?Q?oz3dEBbN70PRxirvdWPhVrgdaFoUdUTjH4ZoFhzGXgpknxDZjaD2nNiBaHFn?=
 =?us-ascii?Q?oB+8B/Rvu9WQKDIkPkun8IPSVue2hYYphK9cEoB+bXp8s5clZa9EMq2tqCo/?=
 =?us-ascii?Q?tv4UGF2BPC3+kN3461ELK34VXygSzDpR5rvWHGuJTTJBrwsyV+/5+7XG3HY0?=
 =?us-ascii?Q?ICQoQiOEO4I+we86T1GusoiSiTKWIvUMZ2JYJzIuMsfNYJH4q0in1ikPFJMu?=
 =?us-ascii?Q?Siti87JWuG/FnIAR0Wtk9y8u39woMcUw8gYgXW1Qo4hF71SUv6Z7qgb9YOSe?=
 =?us-ascii?Q?oklsiOZjXn1zM9/N4NIox/AzV5BGZfTunp/DRruOzyB2v1ivvPdy67yq60Zi?=
 =?us-ascii?Q?UF364q9P28VPsrw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?d0LekfXzZSMdFSPqqtUF4jp22rEUyfDhVd0urgTRfA08exqciqtf6akzCCVp?=
 =?us-ascii?Q?gicn9LmtZHG38ZI525JJSHNsEZ57uiD0lSzxRM3viM5XBUaVgANi7/CluGsx?=
 =?us-ascii?Q?hOrR9N+jzSn3RPr9Ohth8eD78SDcq1LER42dLSvyGodFNoS6HcRkTUNSe8sP?=
 =?us-ascii?Q?7gQ1+j3c6F8XHcfFL6U5x7nBDGP+cPRICoG8Do0JYvpD/g4dvKjnNXW3s1Qn?=
 =?us-ascii?Q?LO8UUydDrJJf48Gvw3GYY7F+CifwikaSwRWIXanYH4MiOTOI7kS3CUtAJoqm?=
 =?us-ascii?Q?mdxcpAWNXsugbSJKybVC29bZjtsVTtr/C2yNKS2lwBnx8saUoaiKoNQItsWT?=
 =?us-ascii?Q?RQpKydfpjK5T8XbB/q6fYPtGHLzgMsNQRV26mbBqPDClAuVePvPZVLUJXKOO?=
 =?us-ascii?Q?X4dyUnatqWRfWCYYT387LGxovT2GmFD2gUIfgc4CWTva6NDETelXgK9wnkFV?=
 =?us-ascii?Q?UlAmZ3p8/re2xtbICLrvN0j6jVUWcPT8S/q4UQR5cb18hoxrXVDYU+MWudjp?=
 =?us-ascii?Q?3F63Zico6CDuBf9CzckphabrwVEBwixy+HOK3cxb5FIlWjdIBH11xyKhLCTo?=
 =?us-ascii?Q?g8p+ZMlPHVf6OGpG9rjhRnT+dRwQh7sMwszxl0KxgEoykpHV9KKmDKE2yWig?=
 =?us-ascii?Q?q4e2mVbBZI5xTH3RejhjcvrjLBnhVtgYBZOg0xSuY7DOhKG9alIEBfcHJnwA?=
 =?us-ascii?Q?URaBHikFdLUWbzm7zexd4Ae19Je/xmmIIfpF4TfjfKSZXy10e9SxZvb6PlMs?=
 =?us-ascii?Q?lL2AyCsovztCMUVpgnIgkD+0I66QVhdSgLaHD30wpYGSDa7k7YqDWyMeSLfh?=
 =?us-ascii?Q?8a0PhtcIIUbGeSTaRkGnEtPDeZ86Ux4sAnam1avl/VK8Q0HZPc33liliaU7S?=
 =?us-ascii?Q?evR+Mj/v+RxmTpBVKvwBDVhtacb6qXui2+bYO0ANEXT4y/L8AuKhDVoGImyb?=
 =?us-ascii?Q?u1B5d+PUO6eFQ78Mmpf2iW4W9gotHopQV0ghF1eqTxG78C9P3C+g69JgmPZq?=
 =?us-ascii?Q?0XeEy7pUTdNfHD3j3XdQYJv8q3x4h22AVTnZGRo8K4ELtZ8p4kWA+fuEp/qF?=
 =?us-ascii?Q?Hw9AKKRI31s7BxU78XHSFrrrYaLtRjlcoGrgCsD/enVPdAN0jjoj9dLk8hcS?=
 =?us-ascii?Q?rIkjFsQYPJqPTS6N/bgc0yFATseDtAaaIFF6GtenMiAwUE12ttsRGnkVn/Tt?=
 =?us-ascii?Q?EXuwcSz16/yTWbXa8Mpwck9czNobxrvX7JZcrZ2YCylzGXf4zyx8rdKFF5Od?=
 =?us-ascii?Q?jLo7mhA4gSGCmXpa7EZ5mi1ulvWer8Aa1cVMJ5ejnfVj/+N+Ku3MNKBanwRY?=
 =?us-ascii?Q?+svJ2HhLbKTyiB7RF6uHBdD8mAaKe6Wys57OW3o/W20WYqR/swg+jkpvmdl+?=
 =?us-ascii?Q?/Jn3fIZQi2TX5htkSjTSHubNddpG1kp1MkgPXa5pmyy1mC11d6EOI1ehRYvy?=
 =?us-ascii?Q?n47uNBv0sE+aXza9ztFhlRrbsrRETlT9IVFeZhg+JfaCW8OkZiNBC056Y7V6?=
 =?us-ascii?Q?+9Ax2kuu9IPnxhFSDH4dLHeIvH93JGwtpQTT9UEleiy8MsFyfC3K73cSxXWC?=
 =?us-ascii?Q?2Ectb84jyrUEFsFAheb8XeBL07r3wXpe2UJ3TFLQe0S6J1/lVsQKv0s2iFIa?=
 =?us-ascii?Q?tS+pbxq4ZxsqLT2KzyZKGs4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34047adf-46af-4fa2-1a28-08ddb95476e9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:38.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhM6ZnuSseotAfxiI+pcgjdalH5i/do0/zXj5HslcmLVpx96nHGQzFpqy4+5qmh3lmmDE2iXPc6AK3b4qe6FLMn7axD74PQxjI4kdW8uenfQP6GHMziTu1QCwn708clC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13822
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:37:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19301

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9b12504e8c8c2f1f7e5f16afdd829603dd0c9508 upstream.

Add CANFD clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250218105007.66358-2-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 5d02031219d8..ff015b3b4d2f 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -35,6 +35,7 @@ enum clk_ids {
 	CLK_PLLCLN_DIV2,
 	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
+	CLK_PLLCLN_DIV20,
 	CLK_PLLDTY_ACPU,
 	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
@@ -87,6 +88,7 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllcln_div2", CLK_PLLCLN_DIV2, CLK_PLLCLN, 1, 2),
 	DEF_FIXED(".pllcln_div8", CLK_PLLCLN_DIV8, CLK_PLLCLN, 1, 8),
 	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
+	DEF_FIXED(".pllcln_div20", CLK_PLLCLN_DIV20, CLK_PLLCLN, 1, 20),
=20
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
 	DEF_FIXED(".plldty_acpu_div2", CLK_PLLDTY_ACPU_DIV2, CLK_PLLDTY_ACPU, 1, =
2),
@@ -145,6 +147,12 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(1, BIT(7))),
 	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27,
 						BUS_MSTOP(1, BIT(8))),
+	DEF_MOD("canfd_0_pclk",			CLK_PLLCLN_DIV16, 9, 12, 4, 28,
+						BUS_MSTOP(10, BIT(14))),
+	DEF_MOD("canfd_0_clk_ram",		CLK_PLLCLN_DIV8, 9, 13, 4, 29,
+						BUS_MSTOP(10, BIT(14))),
+	DEF_MOD("canfd_0_clkc",			CLK_PLLCLN_DIV20, 9, 14, 4, 30,
+						BUS_MSTOP(10, BIT(14))),
 	DEF_MOD("sdhi_0_imclk",			CLK_PLLCLN_DIV8, 10, 3, 5, 3,
 						BUS_MSTOP(8, BIT(2))),
 	DEF_MOD("sdhi_0_imclk2",		CLK_PLLCLN_DIV8, 10, 4, 5, 4,
@@ -195,6 +203,8 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(9, 14, 4, 15),		/* RIIC_6_MRST */
 	DEF_RST(9, 15, 4, 16),		/* RIIC_7_MRST */
 	DEF_RST(10, 0, 4, 17),		/* RIIC_8_MRST */
+	DEF_RST(10, 1, 4, 18),		/* CANFD_0_RSTP_N */
+	DEF_RST(10, 2, 4, 19),		/* CANFD_0_RSTC_N */
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
--=20
2.43.0


