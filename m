Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F3CCD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:30:44 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10902.1781685038496827426
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=asH273j0;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.5, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtgUiEVKjxBkrtesBE70HyoslMX8mgNOkkKcrKjPBjvoUo6UapJ2vsOObBagzr2yvR8RthD1rKpqtdblzVBirbnWUuHEvF8dHhErg4cQxov6WJCJPUu5cNIZyuwK6/JGFEZ3Y+LRnoaPQ7muwWkc81zyS5aiBZsVbut//Xbs9mcwuBX2PI/Tglt4Z8As4bB9UxUASpGXPQ1e8uAlEuC5T1YgZQ6i0jY8G92b4SE93l/yY+Kb0ZydKz231YSXEf7ezShXw9uPLqxJKC1OB4P4DSPqmqP40pqfOtxX9XVUu2vZGLf1Muq9l2x/vWdxajxTUOWDLFdLNbso7yexa0SzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry+LSIac4XMqWsV3cXSQxUfdAt2TsC2Z8/t3QOAE5as=;
 b=ERngyJTiKxFgi/aQeB+iV/bfFombQQs4TWjK3TznzLkX0RM5Vh3kwN8Cf5FySLoZpr9aJF8OAldsOeLKTfNyVhks3BuE0aviA0zsIBaLBHfkPYqBAuS3HQQEgU26U3vWNEjWIm9bRg1sEVa3Iv7f5eHj/xk8nFyRirXPxhwFaK/EA7GQ9fxPxEWXiniUMH7kEIqKkJMYNyx4JkEmrMMH3ryltBdgyUS58Vf42n+JJfq4wahDRks6xOjRBnCaPcHz+Hs0IFOJnvnLvdzZCN6mBJo2HP40uCuiEh5Jb+UcoJzFx3n87fhQTczdb06iTzEyDsb0T8ekoatU2faPQHMRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry+LSIac4XMqWsV3cXSQxUfdAt2TsC2Z8/t3QOAE5as=;
 b=asH273j0YR5CiSrRa0QTTm3zvwDzipjo45bnZrZ6eJjuCtCdT3EhLH1/zY3+8dNhsWKsSP8gRvfESikdFC/OGxyaJFq7iuojq7KiGZcXkmdW5pBEjD/F99p3EQkpa9nxWZlyhG7r8bfYb7Fa7C5FEDwu92KbpV9OHcm7nXsKanI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:34 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:34 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/32] clk: renesas: r9a09g047: Add entries for the RSPIs
Date: Wed, 17 Jun 2026 10:29:34 +0200
Message-ID: <20260617083003.1071543-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbb5ca8-79b0-4541-3820-08decc4ab384
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	B6I9tDa0rEhF01NyZ1K/5auuTzmoz+ema2+xfugimDAqckBNB9rdDmRe11z0ci9MXTr/Lm0WIZvPRWPEhevcugQe49n70GX19Y0vvlgBIrP5ivBIeCK+DJI3Xsl4irzy0+9TLcb42mpswJ1/IFA0XhtA2XqTtvn3wZZvVUS5GiEgFGbVwmdIA47D6Vaakgx75sOLIAMreNAz/gDhAfgzpjULGgu+2Nx86THa9HkxeDhTI7/suAFVS+UhtW9TDgFAGUIPver79Xo4FyYmYLNhlCchpf9awzz8SF6uLQjUxevTNWJJPn7N+gVkT9LMeANW5pe3NY3RYBkn9VmIAafnWgnzs589d5s3k/UOwkB2l078I4taIbwTmmz0ONUCh0GBBuvqEGxFYVnhbytVfu4MDxF5XZ3YsiqTePj1EMl6omRCczad/CE1GbcDnunkIlB2m08XDyNqcFsFX3e+Z0cnoKqKkiszsB/FgWB5OfTUC13a717Xkyuz4toF20d9KDF4fIndzcksQqw7Qdai6Epj8xEQsrp1MkUQJKVVlzGVGb5L9wYI8rRTG3AfgL2cl28TWmIsPz2j6+2UAluMxHYqT46CG4wc0UvU6zP+dtdOeRPoVivp7EsEtFafkae04iHVT1a4cEGmGeNzpN8QBvB6C8hcpFtVlQdsZrq5AsWLYYSQ0b1Ytd9wx4GuP+uifprF+kM2G69dtdWXVUT1DQ3f7g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UVm7XUAYf48ogf5J5dNQTTPBHITXjNn2W4ZPaGHZX1z6DHwLXCVPDAGn/kZL?=
 =?us-ascii?Q?YkkZ8lDW4zpPQVXbfay84tCwvKa2h2/et2rgOQ9w7lihcWr1Pm1a9aREzCzI?=
 =?us-ascii?Q?KduPAp0myJsmg9Iof+916OXHjvGCXxr+gfD8KJ47M8zFpsPfrAgfBcKcUTr1?=
 =?us-ascii?Q?A5Q6hMxOVVg4oMfaKDzWtlBDarI0PxREZ+KLrcavYoQAD+5p8E6Mq0FKD29E?=
 =?us-ascii?Q?LnXyFG3mNGGyKwaFvI7K6mLxQQQZjhfIHHb0huRz8IPmVAUUzJjsFbkp0Nat?=
 =?us-ascii?Q?VHQ4AvY7cJew7AtPV3Slyk2PYg+EnTXRVGqhkJ6xIxB5SWk0l1Dw9qw1SLGU?=
 =?us-ascii?Q?2eiScWj2RKr7bQ72gzH1HnX80zJskKLfVRbxxDOHVSi2CpvzXHRLgW10V430?=
 =?us-ascii?Q?EajjruOvpV1EHi6zR0LyHDdjAdpILkDS6QD3c3K6XEWitzreZISQtY0epeKP?=
 =?us-ascii?Q?hFyv627RnWpYVYBKE/SEQrKcxJTguVjxijnJdpqXo6dnTxSMOys24wtvneAB?=
 =?us-ascii?Q?5TqAEUi64yvUd1EHPBo5d/SGjDUi8nsQGTOT82Iel5WdwoPcV5sNpdCPfjrF?=
 =?us-ascii?Q?26b48OyuRKb/XIkBaKHjZ+wVkI97Nut3xoPUsbtTVsQCN8XyimjY8eaWezY2?=
 =?us-ascii?Q?UAfadM3I7456WCxsvOdehIxZ0b+/Qw+YIFjM37BigVXQhTSVVLSpvbeb+Qgx?=
 =?us-ascii?Q?NRJdufdeXyj2hegymzQLJQwbXYLme40F546jTwGpDy3Ijq5J8DvG12jvRiAS?=
 =?us-ascii?Q?uoPQHlnBfUz4HihkEihid9DxfBlTAaXonF1R9MDPPvWyXU4Ndg3tCxGx1Jxi?=
 =?us-ascii?Q?QVBttqNSaL/3wNIN41hZiBWFUHy+BpXCFG9xLEjXUvxnaH35YLPCD0W0ADE4?=
 =?us-ascii?Q?u/HKzRh0x9jzDCWKYoPsdU1NQWd6SDnEmDF8hIUa9rR+Z80F5ZFhk0gYhPNc?=
 =?us-ascii?Q?Y63maOfT1LCbCrD6urp9UAJ6MO/qJqrCI5cR+putSWNMPzM2wRbRvs7mI6ol?=
 =?us-ascii?Q?RcR8Hbvhr7Zw7PsjlZy0QKfqGUn0JZKejv0NV9JjxRUdvWFhzFqyj0/2Fpww?=
 =?us-ascii?Q?Mntj1qkSOWJQB/01XxJ2u9dpCKcixW56jjYLyyrZgVxndJOJoKTCWu3IFRlB?=
 =?us-ascii?Q?oRma8Mo3xYUYIXOBZUF9spORBXG9IGdsWU+/xJ8HJ3SRLXD00ZgnrVKihOA1?=
 =?us-ascii?Q?6tS9cZcd/GkcbxjLf9TPl9Sw65mmsCZ1m/SaVvJQjE08WJGADEhCuCmf+emM?=
 =?us-ascii?Q?9lq5FMTu3BT7bh7Gu/Rze7adGw30Xp5J6i0e5N1YdBhPluBynhoBeVFWHwiP?=
 =?us-ascii?Q?1B8FUisQw8XnkT9iPqWP7MbLyNunX2BFnWKY0GjgRJgBWSXigEgL+87dB5op?=
 =?us-ascii?Q?JfbJmrP73ilZCxGLDxmBSxJKj92xqBKnl0TayO+ltPoFrLaKg6980GqwEy2C?=
 =?us-ascii?Q?s4qKuOgqWgJ0d8dHyfpuLzpkmMDsHZp0vSKFTpPMI0COj6kSFLDTXvAsT5jm?=
 =?us-ascii?Q?3XTO0CG3SJqs86BIXwy2vGJyO2c0BAOhv0U/T/BfM/a25JJnUN2UrQ4QeU0u?=
 =?us-ascii?Q?PVKviBV5rIe5xomuVZcKvlx38SewqQ/SLjjdW/bS8MLJPykVxBekp/59jJMT?=
 =?us-ascii?Q?p8X8yj/AlmKigTfP/2PfS0YDBCrxGEsvwH8Cpl5X3OOkGu0RYMsCJLfaHj58?=
 =?us-ascii?Q?Wv75D8B+DJf9oexCq/6PyrpnHdoHCgtFE7JTju7RNG3Jp2eIZdY462rKvUfy?=
 =?us-ascii?Q?yI0MAOKVNcodx+mRbpumb5Qv5bETkq+l4ROLcRl4bFNkdUMC9uWB?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbb5ca8-79b0-4541-3820-08decc4ab384
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:34.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Auq8woI6FuwF0z/+L7agn/HTEv8aNbp3V7o3gCCVjCkMgjyyQqaEu85dodpwhKxFUVjMOQKa6YEGIEGmfony13Md2sjqFGI8fmbU/IhViUFOIImpEX9UNST8hD88dcdU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:30:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23162

commit 24a51f8bf869053de4927e0798d17dbcda9ea3cf upstream.

Add clock and reset entries for the Renesas RZ/G3E RSPI IPs.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/ca59fdcc6c32b8f6659aa9218f1a42d2bcd258c3.177=
1344527.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 728a72093d87..bca513f48133 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -218,6 +218,24 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
 						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("rspi_0_pclk",			CLK_PLLCLN_DIV8, 5, 4, 2, 20,
+						BUS_MSTOP(11, BIT(0))),
+	DEF_MOD("rspi_0_pclk_sfr",		CLK_PLLCLN_DIV8, 5, 5, 2, 21,
+						BUS_MSTOP(11, BIT(0))),
+	DEF_MOD("rspi_0_tclk",			CLK_PLLCLN_DIV8, 5, 6, 2, 22,
+						BUS_MSTOP(11, BIT(0))),
+	DEF_MOD("rspi_1_pclk",			CLK_PLLCLN_DIV8, 5, 7, 2, 23,
+						BUS_MSTOP(11, BIT(1))),
+	DEF_MOD("rspi_1_pclk_sfr",		CLK_PLLCLN_DIV8, 5, 8, 2, 24,
+						BUS_MSTOP(11, BIT(1))),
+	DEF_MOD("rspi_1_tclk",			CLK_PLLCLN_DIV8, 5, 9, 2, 25,
+						BUS_MSTOP(11, BIT(1))),
+	DEF_MOD("rspi_2_pclk",			CLK_PLLCLN_DIV8, 5, 10, 2, 26,
+						BUS_MSTOP(11, BIT(2))),
+	DEF_MOD("rspi_2_pclk_sfr",		CLK_PLLCLN_DIV8, 5, 11, 2, 27,
+						BUS_MSTOP(11, BIT(2))),
+	DEF_MOD("rspi_2_tclk",			CLK_PLLCLN_DIV8, 5, 12, 2, 28,
+						BUS_MSTOP(11, BIT(2))),
 	DEF_MOD("rsci0_pclk",			CLK_PLLCLN_DIV16, 5, 13, 2, 29,
 						BUS_MSTOP(11, BIT(3))),
 	DEF_MOD("rsci0_tclk",			CLK_PLLCLN_DIV16, 5, 14, 2, 30,
@@ -441,6 +459,12 @@ static const struct rzv2h_reset r9a09g047_resets[] __i=
nitconst =3D {
 	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
 	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
 	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
+	DEF_RST(7, 11, 3, 12),		/* RSPI_0_PRESETN */
+	DEF_RST(7, 12, 3, 13),		/* RSPI_0_TRESETN */
+	DEF_RST(7, 13, 3, 14),		/* RSPI_1_PRESETN */
+	DEF_RST(7, 14, 3, 15),		/* RSPI_1_TRESETN */
+	DEF_RST(7, 15, 3, 16),		/* RSPI_2_PRESETN */
+	DEF_RST(8, 0, 3, 17),		/* RSPI_2_TRESETN */
 	DEF_RST(8, 1, 3, 18),		/* RSCI0_PRESETN */
 	DEF_RST(8, 2, 3, 19),		/* RSCI0_TRESETN */
 	DEF_RST(8, 3, 3, 20),		/* RSCI1_PRESETN */
--=20
2.54.0


