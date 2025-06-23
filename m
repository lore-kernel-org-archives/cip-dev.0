Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C44C7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:29:29 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.64])
 by mx.groups.io with SMTP id smtpd.web10.16493.1750674561520239487
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:29:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=u0ZaK42I;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW0ENkM90lGct96SyWcx4KBUOivYbAl+o/mVlHygFdHx5p+bmHDFeguFOhPiSshPoZfqO1GfwA3eVpYndQ3GosNZ2a1EuzPsokQb8sS9tXxc2kKKrB9ZFN7ORFvTd1LxYeNGEiQ2bsuwDm4dYo7TN6wZX8DeNacLZJCAjjYZg1euEe6zMCa5PzbJ3kJO6me4ko8OOs4RQYD39QdlomLG6thHvBQxRzw96XKjUyokcTUviMQl2NdP8tBxVxmYpZSlC085I7O0yUjpl26EffDnfyo1HGy1FTDojfNo0azkOwwTXiz8l4PsN+wle60tlhpldg3f1h0qeZ0bEPw+qIn8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpTbtUKXsjuG+Fj+J/Ud3Pn9yzRylIAzwWcf/0pYaJ4=;
 b=q+IlzcS+3vGDNebcrvS5DIg3ZqWkeR9N2owwYwqow+pOAJ0EzElJE4hwqHFUdu1Ig5nnijBx4TcRVhe6N1EwGYOuzyi69nzZnKGVJNJm+PvEep2kq8++dHdCIEtY3VIKl3JYpZVO546PsYgYwg3jCpaYfC1ashw/ZlQ9124TLOML/SZ9Ay1iRtmuH068MdpFmFMv+E76qDVh5PS24Tui08HesqBjUN3Wgk+rBAYMYTkFZLq82npBiLhWSegQFDHd7kR1ROqsLfgIepNmS1abj8gdGWolWywo+97s9Rl2ce9KO6qNevJbMKfytg100AhBiktmWKWKwyxHtILaVKwkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpTbtUKXsjuG+Fj+J/Ud3Pn9yzRylIAzwWcf/0pYaJ4=;
 b=u0ZaK42IC6WETIvFbWrKSSkPP3tyMDcXJOdS8iGE5rovXO+jJxvKexg12KadCnPFBz7zANUrOilLVE5Kb9BH4Kfqmt3cKyC6K+LfW5TvIffwmQESCMVreS8WYReHduZTt/ilBac37WOdMKsr5WsBrdRRtledi4eZ3X+BmiTKf6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:29:18 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:29:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 1/7] clk: renesas: r9a09g047: Add WDT clocks and resets
Date: Mon, 23 Jun 2025 12:28:50 +0200
Message-ID: <20250623102857.1493371-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS0PR01MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 86036764-c0e6-45ed-1347-08ddb240cf51
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gR4U86gbSTjsw1r4mqXqWhkz1Fq4GoD7mIvBft7eiypzwTJck7jmxyVqoB0r?=
 =?us-ascii?Q?qoZKnMPlorDFayyoaTQKbfwMFlZmBtS0gQMcCUtjla7hBkCh3CBaG9N91ddJ?=
 =?us-ascii?Q?o8qfaiPFFC2+K7+v530+om4lB0yWGYx5r8xEJInaqOruYnm7MB2OPDPDWWSw?=
 =?us-ascii?Q?71dHc3mbwO/En3ot9I59a4hlSonc/GRYCu2NChwDHeOrOKaDHoeayf4mvATR?=
 =?us-ascii?Q?TgMG7eyyBpj+6ERDxNhDXZoDHXMOo4471LkLKGsALiL8ktx1dtjgKmxK/gVz?=
 =?us-ascii?Q?W2TvmqtiA/iFuWnULPZvyQH9YDiFF3iA0Q6jrGUcTjByKlpvI2EQb5S/BYGy?=
 =?us-ascii?Q?FEUyEveHyz4Dzqr5wmJV5gSAsKmfkyi28VmdkcF2+TdRl6/DIYnEnbwmPDyf?=
 =?us-ascii?Q?s/aBxf1hqYxDT14nonWgWVWkgUej2sOSW3KdmSjv1fkfm4fNNeRmSaL34VXz?=
 =?us-ascii?Q?QdAkqPpN0Sz5Bcd7ksRtGC9T8eHxoudCvOfGrtl4eBHatMhtU+dDNUfzXaUO?=
 =?us-ascii?Q?mobc3jIsRi+SR7rLgzxR6nNBSQ22MkOveI8TzcWdwWPmXwnxauETl4kaZlnG?=
 =?us-ascii?Q?Ic78aOhBJSDrVblm8ALKp+rDLszIcJeRUrKtSkzBV9goSVx8aNcOcJUf8Fxl?=
 =?us-ascii?Q?kEfWyXnJwUB2CgLZTRcokpe8EzL1Ycmj25EjolC8i3LksXLN2p4tQJikDe+k?=
 =?us-ascii?Q?BIGUawbjxfq/y2ywzKZjEAa17TiU0Q54QoD2awcNlhjYGtrv6LTOmJXQIQD2?=
 =?us-ascii?Q?FjSN4bYEQw3YaG4AP3ALahjGDm9ndDYGjuD4DMC3ZnziG8WxdwIhEG81S2wQ?=
 =?us-ascii?Q?WL1JZgPfcUDkAyc6x/YRdHetyhko1FxUiaOMjCXgUjcEAWtIxxk7FyGGR6WT?=
 =?us-ascii?Q?2cqvBJqc+H7hQq/fexsMhcn3+L0d81aoLEtQgtavhJ5560XLRkEHT4+uKrPi?=
 =?us-ascii?Q?xM2x0ro2Wr7zt0AkNxHHKP+6yZ4e2ojFwGooQUKpRfXR4IuEY9zmmsaQN7Hd?=
 =?us-ascii?Q?dKIpc6X2mmL88Tb4xbdVEGT1O+usD5AIu/zn1Pkhhki+cV7zT8BLamqRm01h?=
 =?us-ascii?Q?SdOgXtTb7BWHCMhcLv/RcklHVsMrYuJ9ud3kLfSKbS5MqPEWt98oMifCEdXz?=
 =?us-ascii?Q?BVjMj6tLXx7mPsVT+sRYKK8PsTc79WVcsTqF7On1OU6UX8e3xfwnvCEjJJY3?=
 =?us-ascii?Q?+IMTgMVu9YEBfpogujtX4TqmDPdmtzjKTnjgGrbLe7uBMpflfzVYjXA7Tm/C?=
 =?us-ascii?Q?FKr+vF5TkNORYv+GuI/NkimIHP++McsLr8F0cq7JZpH1dpOdqKRERSswkTjf?=
 =?us-ascii?Q?dJ0km1IyTLAyLgpj6KUFN3i1N94DZERWN3Wbsi6/ARJ9cxR3v3azpxM3jAXN?=
 =?us-ascii?Q?Ld1oDRyDRZtlgnpbSBqCk+U525ypIsKr9Afeyqy/SDlcz2BYmlwVfC3T+DIS?=
 =?us-ascii?Q?gip388B1Uxc/juAGvVhrAWy5Tr6QUIHF0P4U6nGN9Z70rL7rwG9UU4xDgacg?=
 =?us-ascii?Q?2rN42TYHdE4sXXI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HoVdBJZB/3P2SM8n2yzloMHjv4qi1BaPUDXHRs/vYirwLlSerGbLja8J3xU0?=
 =?us-ascii?Q?3offtM74a9yAMvpKPvzHNZi2WrqHggvN2uuHYsYyszSpl+RlO3DUHNlkKhXI?=
 =?us-ascii?Q?dPNewNOAODPalQpbDgbZh9ml8tD+j3LH+vpbrSEi1hMkHTvaWMX9+z0GQgT2?=
 =?us-ascii?Q?Auab0l9KSvLoOeR+TLw4K09R6sEoy+oPYNK5bQO8jPMwGBgDyOK/IGnXmHgT?=
 =?us-ascii?Q?+eBzL0kISO4g5N3WCmbOVMV2hR2YViqQWT09tWSCxDsu/xdfJf31AeQAvYla?=
 =?us-ascii?Q?l17JqZekiMoCi03zQ/6g4bJEUROyD8kzHQoQsP9dAaHwAbjm8yu2CGSASN/l?=
 =?us-ascii?Q?qt9eBEN7j/2DpgzKBYNt4gYQpPPcRh7dlMGqF3o9KnwXOnR58SM4G2KGLyLW?=
 =?us-ascii?Q?qADn6VZeYTwtefJm/o3CjZDhqxo5rNBWNCT3ZutThmJjwb0r46ALjSqcf7AY?=
 =?us-ascii?Q?fGtJ2OF7Xa7xdBflQ6dk0oYHIIuOa9I1F0sjrowZtkqNXbgVBxXThcEMuDWo?=
 =?us-ascii?Q?gRmGxDiFdDcTOnpp8FfXCtNyvR48Xi98RvqFw1GoICnrP/mN0/6/OQ8Xikym?=
 =?us-ascii?Q?WoNBY13j8D1YSMdusib7eZtDAbVNDgIg4dpohWZ0AnCuFAnexbwj9JwQS38b?=
 =?us-ascii?Q?P1BgqxljxrxyuVHeTHrO0GTMA7rcHEENKgdPWk6VwLAdfCqxIe4EDp2Rfmb6?=
 =?us-ascii?Q?2vNkCMq6rRMo/xCHFc9mc5aLWsZXwtu0GyvlNY3RKfCKtEgXB7hxTlOCb4d6?=
 =?us-ascii?Q?3YUMGgv8R06p7kOiBHqFre8qC3BvHdeoG1Nxk40XcS+tJgZxye1GISpbrfDW?=
 =?us-ascii?Q?CNQ1mvgzC6y4MIZkQJEaFEq51xeLPMLnCX9HTQ7/ZfBSLi/lgTdjHPe1P0L1?=
 =?us-ascii?Q?VNFP11x294O25D7Vrooanw2DHULCpM50umKLyTRD7FgAXypniKvDknv6vLJ2?=
 =?us-ascii?Q?S15F9I+9eSK0pYLEjymYYDAwQARhUUx++Bc+MH7HnHvMK0wm4DX80GY6jZvN?=
 =?us-ascii?Q?jIg8wQhE2dc2CckpSXu1PKBgEhSJDkDlsNKmkLDgnnmWaP4lPcCQFAR1xUrx?=
 =?us-ascii?Q?yXnrgjUFHMGYb3NXx0cmp1kyofoq8T4UIaYpVykI8GfaZk2HkWADwoXjKe3E?=
 =?us-ascii?Q?sd9tLV4mUxNQ6thkF3C+hCw+HHGjFQid2dDMfB5Os3NVoed/hI39JkXkNGiX?=
 =?us-ascii?Q?LAGJUDE3OrcHdHoHcBxYKxUk9MpzjIvICIX3aZpxxJ6rxi7j5ty5vLRaGMj+?=
 =?us-ascii?Q?a36xDgikPqg3ks91CpfLwEd4R03Ba5ntpzdoaRDfapDsLjpgnK8E6DYArlzS?=
 =?us-ascii?Q?ikKBiyUCsZyYv3iiLWAWrmsg/ieeoybin4OR4iHsoJQeL9NF4ZDvWki4VB3y?=
 =?us-ascii?Q?qAtLl0sfriNIhBbO4g6uK9CyQblMZFSSXkDK+3lQ6EBmJmsMXAsCoj4ouOyB?=
 =?us-ascii?Q?pIMdp+UzXynqJEarW2HCOddb/C8rprVQLW4MxgShjiD7ykR6KkrsIzqrP0eK?=
 =?us-ascii?Q?XfIxmfWquuoRgcoQ2xaC7WZ+Q7wXdr0x/AvWaFbZAu55k3i3FSoUcJNjOX3J?=
 =?us-ascii?Q?bho6oq+r7AbcSP2vDJzjq824dv065j4BEIh++FgPjdcIlT/ylXWbK7XiISSW?=
 =?us-ascii?Q?iLwa+9ySqTLizqkt4Ey98B0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86036764-c0e6-45ed-1347-08ddb240cf51
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:29:18.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pecPSUt+4/x2MN217JBjUyt67stiIy9E0XiI/R9fyu760LN5EptvtbGbI6QdRhorU6642jjCWRC/IfWBemRk1y97UsOfkkbiEKDSuIWT59DN/den1P5b98ZCcoBCt/aC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19175

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3c437d906f997a4e1495f59773b9a2544fff69ce upstream.

WDT0 reset is for CM33.  Add WDT[1-3] clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250115103858.104709-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 536d922bed70..1886eab9ef9e 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -92,6 +92,18 @@ static const struct cpg_core_clk r9a09g047_core_clks[] _=
_initconst =3D {
 static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst =3D {
 	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
 						BUS_MSTOP(3, BIT(5))),
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
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
 						BUS_MSTOP(3, BIT(14))),
 	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19,
@@ -118,6 +130,9 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
+	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
+	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
+	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
 	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
 	DEF_RST(9, 8, 4, 9),		/* RIIC_0_MRST */
 	DEF_RST(9, 9, 4, 10),		/* RIIC_1_MRST */
--=20
2.43.0


