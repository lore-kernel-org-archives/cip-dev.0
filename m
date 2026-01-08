Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46124CF6A9C
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:40 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3002.1767864571380245744
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=avDPfsN5;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.45, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdayFZnmngko9+K4al3BddWzEVaT5XENe62fZpkzeTNA7x6x9CcEYoDl4o3L79TXGmCECw3Ns/SnLEB5iRpnpKmWOry2di8+5dT3pvHGm4MOfGLCbNiSmte1A6htmPqAaZU5AlZiQxHLLPpDs7UfMw7jBfpJ7ANElG/oQQpqPeN5OEOrtrHzSMDjbpgsr/YwVORroSrMwqR0SBi7U+gqXM0LEmSiFr+O/Ce3lb8dWz/RCcdsoozG08Aog608f7jcok3avwSJRgjKjI9iQV/YxTstsrP3Ylwpi40zQsIGvGJ9KPNZiD5ll6Kw7wKSjFRXik7IZ5H5e4C59wyD7xZmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6YWmqi08Pw31c3d9zkJz4g5JK1dU/2UrZ9Ukz2GNbg=;
 b=fjZVqs8YOknXuipIFQImfykIt6KUMZELLxGB4erLk/8LKUDLXiMzZXJzaB6rNuHVEboV64EXo8kCqxQ3Zr4fyyTD14tzQCCeqniYB4zdkHWrTNOhD5wPtOjBSxc/U98iicunwB5np3UxUrV+NIZi1Gc55Morc0zyPEJHQn+HOW5N657YHw0FTtfwxIKsyp5pxAxu/duv8xrFH/o6UY8QG+ScUaP/E9eTNxGRCwJvz/UOuFvYvfyUwCqBX1DMCrRntBwPTDiGtNanSKs0pc7cclQL2HwATsNuxwFnsLtdX5uBgQwQgNeckBQF61xO8AM1LjGH17h+tyvBjEbxflt1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6YWmqi08Pw31c3d9zkJz4g5JK1dU/2UrZ9Ukz2GNbg=;
 b=avDPfsN5PdonVVlC/0IaWugfoDb+h3vM24dN+9SBlZyPSffskXhE6oKQSrFh1uIxHx2nMAgfM4TcoybCvTuiBngV/MkBxKgaTxO0CXEOPL93WLR4ujJKjoGd9A0uJQptRuwUuUT/cmxl3IZkySEEU9uRT/v2l9Eu8CugiRzNdzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:29 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:27 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 14/22] clk: renesas: r9a09g047: Add I3C0 clocks and resets
Date: Thu,  8 Jan 2026 10:28:15 +0100
Message-ID: <20260108092823.489287-15-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: a54607da-2b3c-472f-d287-08de4e986b40
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0/PLeyQtr83qoUw2MmLCvKmo5WpsW8jSLRRw3clte+SwwScChWIflkYQgVYx?=
 =?us-ascii?Q?8/xSGavB+EXDxKtnG7lyDdVUzGLjuemiiL5T3tGucj9Zj8vbPrqBq9kRSTEf?=
 =?us-ascii?Q?s+K5oiZr3YIUtVXOOC8y1dom84u6OWkNtddDrO7x9JtrLOSsH4xlGXAlzDLx?=
 =?us-ascii?Q?We9y4bjPooqaiqxEi4/JRPDFqHi2OeKjQBfqaiYcTb8YtptTTlM8gHkrl0pw?=
 =?us-ascii?Q?hhM3EaAL11T2Dlwl1TvKuIZsONke7pQ4cSTFMFl9q+lWH5Odr0Tsblr4zybM?=
 =?us-ascii?Q?b49L7HSCLzBfRWrUMWf2kNIU8RPLZ/7OhFp6n8qAEyxzMY5RYFnwX11y3E/q?=
 =?us-ascii?Q?RBuYwTZFSgSdA2VZt/jo2AJesgdKdbJAW+8zFNLtWaJUs4BesXMw21KQbb4N?=
 =?us-ascii?Q?0c3V6tGDhgQn0qs2+VjrOyzjyUVN5U/nlbapOn3jclfS7qQ8hqenHime/zdn?=
 =?us-ascii?Q?DyMuLgzIqqOiDzwPG1psmuG9n/jZHMiZ55YXqJqMdgAz87UrpnO/XS0MISb7?=
 =?us-ascii?Q?rBsE5Yi6lLjIAPh2KOZgx6ViPqLUxkPxSrkxS+Jxggrk7U656qddQe6/Q93u?=
 =?us-ascii?Q?uKhUpqkbUX0+8yE9Io5BjToTVNBSJc9BfBz1zsO+HnvyuE2lXIP8Vp9rOJMs?=
 =?us-ascii?Q?ybnsXloTIvQYXS83kJh5aCvwoM1X6G2uUr85EnsxAED4vWoH6cd60Dr9QfPx?=
 =?us-ascii?Q?TNf6/xQpvmp6i7IKAuJSS5kyjWCT9H/UZUH/NKTcjyHSeB2rn7+dTNEYEArZ?=
 =?us-ascii?Q?Tci3ZBMnMMqgneCHJBLsXwCaIdzNxtbLkZ4NuI/bm8fw4G17Wb94frAIh2di?=
 =?us-ascii?Q?hxqaIUCz34Isd//KjpxI6rErhy+8bhSCpKCR61A408Z1wPYCYY2qzSqsDYt5?=
 =?us-ascii?Q?FshZD7WbUx3z7Wb07UAHHIjkys4jAliujdqGmhtT7iuMNc/RWwmbIyap8AtT?=
 =?us-ascii?Q?pyat6e65ifvM2ZiedDwTzVCrioTUxBm/9Nwe6a8a9HcW+9jf78jfl/DhMqcS?=
 =?us-ascii?Q?zW91YLwvHsCmrha4kVf2/Teg7A/9y6hm94rFVyPnjUzVK4wmP3ZCTs9u9ttq?=
 =?us-ascii?Q?yMvE6/n+M+LdUIhVI6TUw1f8aB6QetVsVxCXzpk4cVJWBfTbS9hWbqO2GYAD?=
 =?us-ascii?Q?D9bzDwaH00kkDiwtKsGcu7i6dRqz1OjVR5+C3ikPNqUscmQEFwvioiebLZzF?=
 =?us-ascii?Q?zVLD9XURJH9NHQ1tphynbcLTuJ7cclyvOkAA/zmWtKDYvGZpOMQkwrezQo+o?=
 =?us-ascii?Q?XJ3D2HWAetWzDx/p2uX7rjRMLfFBFhfsR6/HrXMoe49d314Q5OjsdHrYwNbQ?=
 =?us-ascii?Q?ZL9mYnM2w9SPiauMMNTjlUUpPq6kbDa9KzsDYi3nzJaa5b38XcGDkA28KYfE?=
 =?us-ascii?Q?74hVi3rJ/qef15x4m36a6SgoZDKXV61wW262NpmeoF4f+ktk/QMGL7B2LV6o?=
 =?us-ascii?Q?I9bAYmgVtRmEkYpoZraR6Xu7fuy+/86Zgo2kWugnxdf8sYA3KeKnkQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Jk6ztQeAkM5BFScCsma/9j2nM3fVZ0/8gCGFuiPnJKIcUaJWEEOFvkqzIK6X?=
 =?us-ascii?Q?d7OojZm8JtxL2x+52IEipS3sR6SSHGaCkBL9xaeRSXO5Gwi2sSXsToc9LbQ8?=
 =?us-ascii?Q?q+vlN0BpoSEtEs+RLmEpt8+NECwt4TBYj29fpWI3qvYlyJze7QfOPYQiqkN1?=
 =?us-ascii?Q?4JaiQzOrenwctFBmCAtH5M5au8OzYQdM+7/f4Ex2i0SUxEowU0IehihLdFVr?=
 =?us-ascii?Q?G06Gpl3Bs/EyT9pX1FBbAKCPz2LH02Qt05g/Un9pY6xzCoWo8RGikxMDJkvJ?=
 =?us-ascii?Q?ViV0gQBd2iE3VoECXb1Rz6axNAOSr+9NjlkU9KOvERj8lwVnomKAyXfaSxzL?=
 =?us-ascii?Q?FySE6UuHHwRp7Ij2wvf91s+jI/eAYIde3XHS7VoQrtU0w9ChQOcUXsg7ujOQ?=
 =?us-ascii?Q?WiRQdZtsa0gEJr3htfMCn7wh4VnefG8nJAD0qKDz9NP10mPiwyjXbfRfj94W?=
 =?us-ascii?Q?F+nlwS/8C3ABz6yVQrJhJ5OqbCDeFB6rvkLE9XRfIjZxKcLGcmB4O6l4BFf2?=
 =?us-ascii?Q?0WFjXviYj8Cermns4I/ZAjeiTZEjNSzgPfjDQMVKdvZE2Ft8WfCXVESmcA5n?=
 =?us-ascii?Q?5EUlxK4Q9ylvk6wQFoPeiG3YWSeuLqG2nKXnfJzwAMRt27BfSHOQJkytAu70?=
 =?us-ascii?Q?sAcKsTzd5iiBFX8y5EHw1bkjsqwjKEOMGwgzNCEWZkel6B8DxjcoeYglIlJW?=
 =?us-ascii?Q?3/BTeodNJYu1Do6spXNJApka7aVIro2Wk+THxVhj0lLmKCe8qIBepnx5ls7B?=
 =?us-ascii?Q?dS8P4xpbTQCtc27Zh7G+xqvWBuZNXZQCya7lsbfGvhA+aaEUvdpSkgoSC9+/?=
 =?us-ascii?Q?sDcQjp1XPmT88ZiJTjvo207tAWh96ZxTKsu7BANG0pLSeniZCOjI1nMF+ovU?=
 =?us-ascii?Q?4Cr2c7NNDauu1b+uP8Eu/7u7mezm5aKnqFjz8vS57oXShjoJfEsFYq/JaZ8s?=
 =?us-ascii?Q?GkiHTdHNWhdeWPKjd6cR8o+biZhDYp7A5QMdaE3YWBkfh/96P/tyv0NI1YQO?=
 =?us-ascii?Q?wxKj0ah81BerZUYbyUoLAoAYx27aJyVK9lHsF4gWbB+hffbKlaUxnfElC6vL?=
 =?us-ascii?Q?znNrUVgRxlOls9A57VgGolL8ey5Q1tiqXSHogtkDa8iW+d0M5u9xTlz+4bHu?=
 =?us-ascii?Q?m56DKt9vVW3tgltLxdzMvELWgx1RRM4m7z658TbwusLagTN3wA6eLU09olqC?=
 =?us-ascii?Q?RTEtcvgtKGWo+MCg9JDkQrIg1xGE63X8Eet4M9lRXL0Qa3X0oMY6L3E9BTzO?=
 =?us-ascii?Q?uOJdIWCzyiu3t4tUbH20ZhyHs8mtlx57GiXZ+kKBPV5UZxXe1JgDo2ncnke7?=
 =?us-ascii?Q?ydWDASD5ZmJzOXBtr+uINo3dYPKrhUI2N33TncG0khI6Y2BlpRz21DqNJwf8?=
 =?us-ascii?Q?6abpKngr5F3ACZHFJGdHRhb7UxoXCDbGDMxi42SF4QgFfXLYkdFPTdEVJ+au?=
 =?us-ascii?Q?NI0r36npk4njI9okbw7U/tnXZYQapwuT9pR/WorUZkb4Q9pZSDNr9maP5oOl?=
 =?us-ascii?Q?f0EV9402NnNTlOfAT0ETHaO+V8lFz63/7PkV1k3lJH67PmyvHD9YIMMcvJVn?=
 =?us-ascii?Q?l5qxNqSDf6htuZOcm6GKA+4j9xkkrxZICxv0pKMC0ng8ALFs8S7xoiX/GN2d?=
 =?us-ascii?Q?p8hqT53V0laxyh/bP2En3K+nlzRUkgZZTsHuO0PnW6eG55ipEKgyQhjLqmQ0?=
 =?us-ascii?Q?MSaBGdDqy6V5L7lgP6esC5x5lr0yx7TbUCTrjXOyyMkTMRKVtjxEYb2uq7gr?=
 =?us-ascii?Q?WaHXw2pOVqbK3HcyyUenrAazWcb/6cPuoyaWogFubDShxGKzDoLq?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54607da-2b3c-472f-d287-08de4e986b40
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:27.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4PHKKhOWMsEAUuf2y5UBuKZ5Vq5dSNLt0UK9raCb7jVwpFid1dWaQX6oxILVQrz5Kb+Ol6oPQYHMxnZ22lr6wzGtFjUdCYfob0pJrtArajwXTMl++XfN0nTh/iVajqp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21450

commit c939b63f44e50c3d2bd3790cddf07c3ef805ca5f upstream.

Add I3C0 clock and reset support to the Renesas RZ/G3E R9A09G047 CPG
driver.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250611093934.4208-3-wsa+renesas@sang-engine=
ering.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 281d19782409..26e2be7667eb 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -198,6 +198,12 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
 						BUS_MSTOP(3, BIT(14))),
+	DEF_MOD("i3c_0_pclkrw",			CLK_PLLCLN_DIV16, 9, 0, 4, 16,
+						BUS_MSTOP(10, BIT(15))),
+	DEF_MOD("i3c_0_pclk",			CLK_PLLCLN_DIV16, 9, 1, 4, 17,
+						BUS_MSTOP(10, BIT(15))),
+	DEF_MOD("i3c_0_tclk",			CLK_PLLCLN_DIV8, 9, 2, 4, 18,
+						BUS_MSTOP(10, BIT(15))),
 	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19,
 						BUS_MSTOP(3, BIT(13))),
 	DEF_MOD("riic_0_ckm",			CLK_PLLCLN_DIV16, 9, 4, 4, 20,
@@ -301,6 +307,8 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
 	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
 	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
+	DEF_RST(9, 6, 4, 7),		/* I3C_0_PRESETN */
+	DEF_RST(9, 7, 4, 8),		/* I3C_0_TRESETN */
 	DEF_RST(9, 8, 4, 9),		/* RIIC_0_MRST */
 	DEF_RST(9, 9, 4, 10),		/* RIIC_1_MRST */
 	DEF_RST(9, 10, 4, 11),		/* RIIC_2_MRST */
--=20
2.43.0


