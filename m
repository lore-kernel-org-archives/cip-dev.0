Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4625D3F08C
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:01:21 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.753.1769616074619039322
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 08:01:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bRxk1G1i;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6gwjtg5ppOSgfc0Rqmdc9NB8umkw+KN/cyHKJhc5EFaKVhaFu+GaU045XcpZd0DObsNmASkMaPwcPf+fOb3U2yoUQw/QOHDEdR8YEe2Qi56PD54O77TTewa1rVH8P7s2PM7D5h+pHdbD8kNG6Hd4Ae+utxb9LqGHfGagGld3iKMft3FdmiRbhKw6Q7RmUHw/wco95v7/qnYUKmLWu1uPsWArBbhdTvB014rJYYWaWwgRV5H89oWXkhkm5I08Rtj4NLFyucdBbPed2VsIpzGxzoH3heFk1gMDz0mhr4brJwFV3TsNFPlWD6XDm+8W0bpnvOj0U9VTfeuzQn7oEorrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEAVPo4bPPaUxgOMbxz2phvE4zgttcQwiinEUHUCeoU=;
 b=dNNVgagnWx7mLQdMJX5BupC2R/f8P/ucFf/o5QW7R1JwX8sfF3bpZGrSEhS3yW/tKGe0FksZP0bFX6wYRGF/SymAvKBCNo5LGtz9Ni7G2G0sSgY/7BPXdkxNfCOgb40dlM7Oz+yZrqb5FjtSiT4t+JtJwa/LZAvTsINXsq7shypkfy+9zim/2Qnr392jAHOkEgUfKW1tlaHNdalgdKAWJpoTGhFF8yBUM75Uiw079GvU+Lq0QFpilGqkaf1MFUrZyu+LTBfbjmR6HNZYiw9Xr13exEw9IbnbeNIYz735WrqUU3VlrjOnU0ClHuzFepDFe7alSmHHVgU5jVwTiLewuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEAVPo4bPPaUxgOMbxz2phvE4zgttcQwiinEUHUCeoU=;
 b=bRxk1G1iQM5Af6V/ChamQ8Jegr5NYbTl1/bX6quLjjYmnFqmQPcNuu6YGcu2ci/PBgr6KxAFoQao6EEnNelyQUOoN7rY10tfBSfVgkrs5cQd41tOWET4vJe15UAgAhHTIFEA58K2COlS4aykVdnfhehTR+Xbm//0S7ildvKAzOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by TY4PR01MB15588.jpnprd01.prod.outlook.com (2603:1096:405:28b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 16:01:12 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:01:12 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 1/4] clk: renesas: r9a09g047: Add DMAC clocks and resets
Date: Wed, 28 Jan 2026 17:00:45 +0100
Message-ID: <20260128160048.1445926-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|TY4PR01MB15588:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1abdb0-668c-4c29-4aab-08de5e867546
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fMF2YXmOVhwTVp/Q7ohMDr8KWXGH/GLohMci7SkxQIgSU+nHtyTu8fjLBpEW?=
 =?us-ascii?Q?I979cduhG4du7g1tX3/oHnNzjMa7B1fz8W7PF+kCCYB/K/cNWQoRMX4XTVYe?=
 =?us-ascii?Q?A2TeJldDOU2VRdL5LLfeJZkfBKsYfLMo6kukTCOsXrYjlp8Hdmd4oxecj41E?=
 =?us-ascii?Q?wWc2txneL5a9iccaiyjMtf7fzlk4cErPhG0esQYZm2p3C+5ric4c8kXfd6ih?=
 =?us-ascii?Q?ST+omBJ/DM4J/tFV/DqM+Z71TayOvTpIPSL4fs7Pqo7QD8RIodjMggssfSf7?=
 =?us-ascii?Q?027T3jx9Yup1jF1nZpfoBI8N6q3G2x5RXalYv/WFp61tp9A5xCYTMSCCAfgN?=
 =?us-ascii?Q?pUI/HoEE6AK+N0PQZzYqXQ3N3W1oqqkolcklLzgID7qORQZDxgZrqSW4midu?=
 =?us-ascii?Q?zLkzAS+/ysWcTtuxPJ2SMKoFLlmtdi0c3KWUWlQCJV0RYc5tf0w2LYmQGSQc?=
 =?us-ascii?Q?ualD6MO0aDhG/EdMEWh2EpkvvzDKaw0Vr+gGmkSY5OHYJpc+9sFnw52ryYgX?=
 =?us-ascii?Q?vV7FBQQ5nIQYtJgZQKHo+XHF+vI58mvJLojtePyEW52hE15bpXiHV0sr1gKE?=
 =?us-ascii?Q?xHEkJXgMghinhA1nU4wO/hPD/aHMs9ydN8K8Myk5yX1//OR3Y5fxjy1RXty9?=
 =?us-ascii?Q?b/oCu2qVqsvwv9FNVqDIzGc5WnAjQp2JPJD8vL4nw7qEyvxHnHWaZ8E2OjX0?=
 =?us-ascii?Q?ucq/68EDQi41QBcPdndrWV4pLhvCzP+WOnyZ/oDessYtjvbB6AUFLXm8q+qM?=
 =?us-ascii?Q?GjrVRc74aKvSsnDDtCDCHQ9vjJDjcmbP8lotwrXMMAbhBxPV2cgJ9AG1jP4U?=
 =?us-ascii?Q?xO6Fhsa4ABA0ph52vj0WwlAbqIpkrBWnIDLYg1VAvwqErhecF41eC2diTtCh?=
 =?us-ascii?Q?9/fNyLeOTLXAL49NYpi8X8aQO5JtcMZOMQTZm4qoeKwbZaGUsxflCBVo3tfH?=
 =?us-ascii?Q?rezjIPaV96U4hRoCnUkWQ4NjOPhmqi8YRQot+4byzEkOc8tWqvLQmDevkcI0?=
 =?us-ascii?Q?0rox/BD6Eyy/eIUq8/jmUd72bwStr9IKCvXjseiKpDh0bS2383Llezpi0LOT?=
 =?us-ascii?Q?GXBrcWQCu0DKJXXnvd3lHGQdXvXtJQfaHkEa+ZJusmldQGkajfz/cyEhUtn1?=
 =?us-ascii?Q?RGLIfW3ezI2q6Ra7C9+o/hgP2XNq8CByzV5ojRTLKgoHYMQOtecLFpAqN/mK?=
 =?us-ascii?Q?CDFdAGWU0/HwSHSkfKsxuSrQjF7CuhH9y28LAxB8Rnms7LU1FXQTbVbp5Neb?=
 =?us-ascii?Q?I++3UhdXX+xpHLfloef3tw8V7sy3//4BLVeAEME373ZK+XxEUBN5jGMk/+6l?=
 =?us-ascii?Q?6sl/50OQInCsrD2AQGxpj8mM1p/b/EeBa+p/mHb8hecrYd85/SLRabQ9RDcG?=
 =?us-ascii?Q?PY00Wwje1T00Ci+CIbieRQ4B14gsgt0Jsu4DTbfhJ2O+k45S0Wnf8Esv4U+V?=
 =?us-ascii?Q?1rpFIsyNWeEbzBrpjgc1q0Uo+0LwrGXcXE6sujnLf8yVXxeKvmMEr0DcliR4?=
 =?us-ascii?Q?MgXwUoKEq7kE9cTCdaWfG0f03XKZR2RPVBYMIlZqZoV6WWwhh0MGdARuobIj?=
 =?us-ascii?Q?KnQTk8XFxxiNET/dMIu+Wx7Tqm3F+1rqYic/rkPl93w/HldODvNlG+tzG4Ta?=
 =?us-ascii?Q?rXg/TY/Yu+4bIjNXTFTMbjY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BxYEKk355ykt75zNG1KZ3JBb3XhlKDepM7qyBvEs1xM1JxWTtJWZzPZ3oB9h?=
 =?us-ascii?Q?rrRiQ0qqhJQxHXPiB5pBmJelAgw86GJuoUXoKTpmeyTN0UomYXHx+XjWubOV?=
 =?us-ascii?Q?9XTQgA37AmdqxWKczLxEMK4AeKQt1a7nqb0ohQkqyfClVaDDQVAyCd69DPiM?=
 =?us-ascii?Q?HH4+eZL/auTd2b5YXyXYRhG58Srr5OuQ1h1lOw2J9xYyTDwIhVWex7+SlW//?=
 =?us-ascii?Q?HZ7NH0QMnKBqYpAXyxTI3K6Xm2FSi3fIFyD8rpji7+ep4PJCJnRo8D1jfVr6?=
 =?us-ascii?Q?vxpiVI/Ka/QFgWxS/OuMswT9utYauIAeLPdK7khJpUA5Y8sL5dc6fUF7TDSg?=
 =?us-ascii?Q?rtF+T9j95cvvh4fKeD9ZjfZW0+QYf5xut5TgUj8iWDWR23IMyv4xQpwjD8ff?=
 =?us-ascii?Q?tz6fgOTaZHvqEcP5QAskZYNepnLp82otexZdp1RDH51zN5FiIgj2RtyZFdS/?=
 =?us-ascii?Q?9+9fpqsJlcmIsuFJ8QYmZxpQ1zRrHHvACGqCzWxar9cCQfVPvL7qAeQVCec2?=
 =?us-ascii?Q?shM+I3Q1MP2LomUPTa2QvvdYBzuBio5UX4/foLy/wEdH35ZSMJb2hPxRlAzQ?=
 =?us-ascii?Q?JATn6r/xCbgqbGlvW1wGZ6P9ZYJ/i+5ioPTuQ6iFNODIAruXXxZyfsdbRy7c?=
 =?us-ascii?Q?EjYl2GWzBoLEfd+gWEGXYuA0JCu1huG/RgFFtr10rQz7m5KDGU1BqjvQZong?=
 =?us-ascii?Q?dSSotabbKyagl8JLpt1OG2hGHJLA4YIvCA/dw2y6ZUqoVVRast5CaM+DhP10?=
 =?us-ascii?Q?vAbX2FN8v1e1MtTuHG3BVQsBIq1+MkJcopJxzdjkGlrLIMfTwCA7ZcjjjgU6?=
 =?us-ascii?Q?2GUCTycLfKCFBZEGbcQOGA+kowDSaDot6vnrJNa3JSC4gpovSJmDzUoj1E71?=
 =?us-ascii?Q?9HsD8WrBzAQs1BVVqVbnnAk8myHJs54n6yA8gWsI+iBFBrkk8tEx+lQqxfER?=
 =?us-ascii?Q?xuKzB5ToanmAo6/pyisC5046PAABWQkK22fu2nyHVJHK0qxgOyZaLePrtje8?=
 =?us-ascii?Q?qcype1Yyc9Gev6DHhJ5VKMuwBx5UeZEiivJZG5PFjjaUkibGBZk6MmIK5100?=
 =?us-ascii?Q?BKiq20mvJRjAK4iSAfX80udwf7Dw7CZxIFqfgsQgk8JXbm/F6ZIAfgzToaXf?=
 =?us-ascii?Q?uA/ffmuZfIyQp2Uli8l27fAdmEIwmH4Yo5lxkEoteUCJ9vovJbOYPpz3hoRf?=
 =?us-ascii?Q?fYTwboKZyPJpNXOZ67D1yEypscyfPFqJ5b/A1tUoQOfsxA/5F3IXaJPI22nS?=
 =?us-ascii?Q?xbhXGZZpoAbKdL2DuQ3pbKWqdyt7urcfYA2EE03r4UDnE5XjRt061WmEQhQh?=
 =?us-ascii?Q?WzA0lVkBXSuOU97iXGs0i2Gr4Wih//SwQRXE/+d78KgEHLd49eNXU+UWWF/l?=
 =?us-ascii?Q?ud40x5KtrTj8ZMEPqsQKdM+GyCbmHGQQXA0J2+Qub+YRZbNByF90yESCdc6w?=
 =?us-ascii?Q?zuXiyOAbijjYJqxt8lc35Trj/xlOGfU9puBxWOcpmzwVCaLyMoT84dwJvwY8?=
 =?us-ascii?Q?hG8l3/HO/F/O9HK0PwFYC/npWrQ5cCoUx9J124zlceL2CO+cQkgOaQCi8hRh?=
 =?us-ascii?Q?9a7yr48UkRurYdZZU/vQtsPOFq1l8NCDtLRpfGhhVd6pqj2VOgPMmT16JvxZ?=
 =?us-ascii?Q?NTzidKRN5l16oA4F2xjHp8dmUnv/6IrwXdpBmZ/h7fWbH5xaI57QIhAz+D7B?=
 =?us-ascii?Q?n1KzOOPhqhttsAyfSSk7rTkwc1t4JWGhS5rT4eVOQJ3l0Qsr5enKXlTziGJb?=
 =?us-ascii?Q?AEP4f45vtFSea5vcFmqEm62XWYrWSXKlOZB1FaV5DtAhI9lqOJn1?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1abdb0-668c-4c29-4aab-08de5e867546
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:01:12.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbj7o2rLYVsPQDXQI3lVInG/4XiunSpNuhmbVkAMLQOBvxu5URSob4zMlbHL7hsNP7odG2IWzQy4ZSWKJ94g4/JjDMuNHgfjMjIJi4M1wQCCpkg0+cbyMBPGFOVRbusD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15588
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 16:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21774

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


