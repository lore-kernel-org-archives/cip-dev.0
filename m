Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A263BC7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:37:43 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.17])
 by mx.groups.io with SMTP id smtpd.web11.20585.1751452654129427249
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:37:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ma8bBYfQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.17, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObftBalgmKLOXHnDCeTeP3eOCccC8JkrK+s9ynU7j6dtf1J1cWe6OO6eqTWYzxZnDvSjL4oDkU07lvlEy4s1uotGfTZT8VTsvrNBQK4l6SSPv4+Fh83zGL7uCPLS9egjTyQFuezhaPSTJOunMl2zua0ktXUVI50aL13EuBpBZcwR++cL6FDniR9zO48iFCRGTMWDQB5acVM7/XCcu7NAKBUEdCBwBXOPhoyOdMAcfxBHBt4xsV0MevmKDynDMM/mWSTvRLSnikeq5p4D+XjodJB3EZlEU/0nr72H24m+31k87PS4N2Uff9WYoMhZuKHijW24XZw3ijUB3z4YSYU8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfEwFozWOXMtxQqrSwmPu5I7AJPWuUeUjZZXbFYJqcs=;
 b=WtBTpsqvWQRrLhHtewvYuoA+LSJ03llNGyrjpWo9R3s1DfziDQdR99DzKyI4hEPgcrNiHBd9+JJBFDNfz3PUInZHtGLuDZzCT/C+/55sZuggE9CSQpT6Fnyn23SvNABY28idYXDaUOe60NUPQTcDQRL/ut8+6FM70pHQEiOhf/U0RcDx0IFpfRAmSJ9x8oO2U2XN1lZs9PWpgNhKrUWnK8eIGW3KaXwxSOrSe+YpVMLg9jn9xwrGh2kDa09Z8Dz9vS6qYiOwvUk39avjJdg/1qBcGBpAHE2glI98v2rQIsWiGiEpFEvIqvi30rVmsOUIoogfAPYZamnmfalLYPDA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfEwFozWOXMtxQqrSwmPu5I7AJPWuUeUjZZXbFYJqcs=;
 b=Ma8bBYfQIRYFJIrwKXDZc4J5wZBX06/Lf5ZaB5S18JshAIepnTDHXJCU7r6T+T8rCDh+CY2KC1ejePd1IgfWP60YlHsWDu6QZPku8kqyCcGn+LDMY6wMjtILX9lRrvRzKka3gKITpjrT9+WRAPA4pdnXantXbTOTiAX7HY1kfic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13822.jpnprd01.prod.outlook.com (2603:1096:405:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 10:37:32 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 01/12] clk: renesas: r9a09g047: Add ICU clock/reset
Date: Wed,  2 Jul 2025 12:36:59 +0200
Message-ID: <20250702103710.117760-2-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20f16f1b-ca65-4f66-7030-08ddb95473b2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?K0WmZ436n47BhdKifMRB+GJhDPCIXHA54AVqtrGWz8IsyFRj8tJsyrWKKj3u?=
 =?us-ascii?Q?bCtN6UVRRtlXV0mPZbiKiCBIC9cl2JwXrxnEv4oTMwX6375PCs+RdS2fji6l?=
 =?us-ascii?Q?+fewgFldcfGbn+PA04fJ/AbQSIL9uT6kh9m3kwBmoTHqdfvTmOeTac3W3qCp?=
 =?us-ascii?Q?kV1/7vL0WuRks2DFsYpwz71j11yRURV5jyfoShQar3nP4gJHBf/tzlTzIsoM?=
 =?us-ascii?Q?AwQrI1pYEE5+sc3ud2G87CacW881bWM0l5j9PSbVEYG/YWIhU3gObmiLGpU/?=
 =?us-ascii?Q?7Tclk8yfFdJ97WzkhcxIYIGJx7PETNM+iAFhLzI+wl+BJLH3m2E1/GJi5daR?=
 =?us-ascii?Q?uTiUlVw0jw11Or6lheu53aKzjXVKYiifg957gPTd60ZuPZIJhzJh71PUyPpu?=
 =?us-ascii?Q?9+WXq8yJhgYQojaksv9BvDf1ZHBsaa5jj6B8fZ6BgiY/1xbdSOzQfIX3NUCZ?=
 =?us-ascii?Q?K88glmS3XDkMBUDSPFjThR4MHpU3rrPkBs7mQpduNlqQDX5BnxmXyzqOSSNE?=
 =?us-ascii?Q?OC2uCYEOnU0fOmeOhKBWNZL+SmaYOMLraVnEJIz27Rdwpj8Edi7jWgXE9pKK?=
 =?us-ascii?Q?5U2xe0fhd/vYhwpvfxzPX03ks6SkcES1fcwCs+S1mS08t2ePrDMfMVNX7LLf?=
 =?us-ascii?Q?BvyLw0/y0aD6zZftP3nK/Sn0tpkZdBTT9t33oA2geSSWhklJCdoQ86rlN5Bz?=
 =?us-ascii?Q?F8mPct/BwC6GfLrx62lT/PNtuwdJZCc9Csw2fYcYy3gUZVdLVQo1Y7KpJZNq?=
 =?us-ascii?Q?QEL9rNQQM331rFU/3XHF/LkOrjTb+wkqmGWY23saNARqbxqbxnbEFMxCYw7U?=
 =?us-ascii?Q?OnmSxuaWk8rBU+B/19iokHctQ4tuKCNKLnsjmSYYmQTXsMPRFy+uqdzPNEmy?=
 =?us-ascii?Q?wbCvnXz8ATxWeuyhYjQ0OgfJSLT7bofzEv5Y8uWiuOHqdVaHmn/wKG+01I1B?=
 =?us-ascii?Q?KWTsDRXv9MIlqvyjQHNaPtaGM4LJ8ZlgB0UTF89pnad5Vk+80SYzraxzVha0?=
 =?us-ascii?Q?653BKRPsU65UVIGyf0elkiPoFl7jZyBdOSgumkF9g6+ddov7rEFiS1pTG6ov?=
 =?us-ascii?Q?BqOUCMaNqte4PiSDAJqGPFRe1C/3CU3kySFZuaiLpHw9OPU62FSEMdQU0Woy?=
 =?us-ascii?Q?JezxZaB4CgHFgNVPYPTDc98+ZbA2x/4h53EqMncslvN3JYYNpINEEWFC7I7A?=
 =?us-ascii?Q?JzzZfzYxepOWfYD1cRPwNFpp2oBgf/8KP/q+SWBoLgSux0u9QglUsfbl9mEx?=
 =?us-ascii?Q?t89MOtZz3loO1cUjtFUVlFtSGS1k2EzfQSlZLmI3YGWbdmrNqwRqCHOiX7FH?=
 =?us-ascii?Q?rFcwZc9taqE1cSlPIJwklHQD8xCozlHy4KwstZl8gtcxuYJuX00spDdNLEJj?=
 =?us-ascii?Q?tncinFTv2SHthJSSE562I1R9VlS198dIFJED2v8yFD3MgCNEv8Slc7NkJ7zW?=
 =?us-ascii?Q?kyfHH3y0xLJpCURX0WENBMoHz8xQwovX7m0GUIoLBtoe+3ra2na0EWN/zDeM?=
 =?us-ascii?Q?6Qs9+LRVkxovPlM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7M0502QUgH69Kcv8E9/hxc6hBNKpQCyQ2qx/JJT4t8NS0Gqy4eCZjv48Bznm?=
 =?us-ascii?Q?88SYINFrYy5m9tUbRYM2pe7cg1PKY36igUDCiLIQ4FoYvopAG+2jCy3m80tg?=
 =?us-ascii?Q?ZOIZUakok4T8BQL6mn08SonaM0fC5U+BX0A+FH1ubVXOMC5tJLrha3/BhPg2?=
 =?us-ascii?Q?2IhytARTDkOKtuxGVVSPkRuk5C6VYfyE4kJIdYmTHOGAdmRSXVrFzA2Ub/2d?=
 =?us-ascii?Q?sDsr7NC6BWtM1WbnuXnCq89J2yJAqVYpMCeZt2RZzh2yDRVzKRv2RIdG6w/Q?=
 =?us-ascii?Q?bNA3jgZox0RwRNkqfiCJxbGCKDtV/Q71KfBO1LI7OcM/T8icEDw6htCbNfMe?=
 =?us-ascii?Q?BoWEXUc2hqdkk8fJ+oUozmYDmC6vBDsbG5VYo2omvVJHK4c6dY6EwsJdRb5f?=
 =?us-ascii?Q?P1vVu3C1BAj5MjGNsuvtx1Mu2DFINmegHxjmFJDW4HulIaF2JXR2l5P+xI0d?=
 =?us-ascii?Q?qyeK97EjphGg2e4MPgptBtgAj4YQUDyiSmV8TgA6LVBf+/uORDYRpLim/v2I?=
 =?us-ascii?Q?mPz0HHR3BI66t77X/EJ2GjboeJcVXYP3cGQ4/CybXC6QtkcXbxgrZ54kV2IJ?=
 =?us-ascii?Q?XPHFxJj9t6Yj3fyPzETmJ7kWzbaK2RatcEmmAbN0LjRuWJyzXGLsC15+BGKX?=
 =?us-ascii?Q?oazW/PtmBGuY94Bg7Sgu9uqPQXGaFXVFD81bLG7nfZ1saQAsVurBZ+TCozWA?=
 =?us-ascii?Q?PjAErOPVAPLpHgzdn2hOZfilUV1faqq+6NbMjV/qyU5qcXV/1WQyal/c2Hwq?=
 =?us-ascii?Q?nSuumrCBy3HU4XRHJyZKzKnYc8pSzUsHhc31LI3gd56mhXb0poCOOAgw2HxN?=
 =?us-ascii?Q?SEwMUHqUL8ggkE+uom84+3tfrCIt4Lq2RDB6vGAruoep/+N5X0cLtFK6xv3V?=
 =?us-ascii?Q?qvQr3MChV9/6xaazvnWg1bFUQs3ZyBJr3WZYwGkbO+XAp8gYJRshvYxDZrPY?=
 =?us-ascii?Q?/qNBFiHsZySt9XKkSkepuE5tv3asGBmjh6uKVU/sKNrcchdWWF3SmlnQVkXK?=
 =?us-ascii?Q?XOabRIOATvsPGBOssGrPybk4GNVchhhb0tV78p3jO+0NoTBWnPCG3YEpfcxS?=
 =?us-ascii?Q?TF2FnSheNZWCNip9BI5Q85lxLo5S0X/Crtb2nnbEVDKj3PAYwaCK4CwUuDXB?=
 =?us-ascii?Q?/uCbQ3FswimPJCxRZEOWXfuIeOLLmu1k1X0hudcSm+a6adU3CGoGJDy98xNo?=
 =?us-ascii?Q?wxnDYWgmdhuuXdRcgL4pEcRMlgoePKTRICECg+OPbUrmEjFsDJ9IRy44Wbmy?=
 =?us-ascii?Q?qo7k/bU2EFzZERj2Z4c++RUe1XkxAzkAyfteW0iBMRUusYryebxHT3y+2pLP?=
 =?us-ascii?Q?YS64b6HmbW/Ho9HREqNyTreO5riCPpKIq2zyO6xwTHRi8CycBsW6f7LQNhwe?=
 =?us-ascii?Q?FZYx7eGSeT4N9zRskjdRMCjeJb7BAH0vTew5GIw8gc3mHlAOQK4JV6SIEqjv?=
 =?us-ascii?Q?ExChB7khRe1iR+3aHAbjDrMMa5y71PVuydSplX16rfssyPjVoKXy4p7BM+V5?=
 =?us-ascii?Q?RIxbPoNTm5DXUEP5M38nKUlMOsjHXqtQYMueBHlALqlJw4zAAGvsgf+elBqv?=
 =?us-ascii?Q?k5h1oCl9LVvnEUSEwAUCbujTUQby4bBQoDUa4MRac+UEK1ITvgP2dTjsrhcB?=
 =?us-ascii?Q?6+vkl772+/dP0GMGTa/4WbI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f16f1b-ca65-4f66-7030-08ddb95473b2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:32.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttO78I5LdNDOXEX6ArhFqSPLKhIGQZKl5LonsWsGcKHrISQ6kcTjBr0oOAYzXS6XEvcIRyqx2YH4ZQF1lvRWDn54QmsOxdIJw1VgGcE1nZOCEDvscE5XeZo320IlyVzd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13822
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:37:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19299

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 5a1cb35ba37ada76ae486fbac7b249322dd1a5c3 upstream.

Add ICU clock and reset entries.

Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250128104714.80807-3-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 133582317490..51fd24c20ed5 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -94,6 +94,8 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 };
=20
 static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst =3D {
+	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5,
+						BUS_MSTOP_NONE),
 	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
 						BUS_MSTOP(3, BIT(5))),
 	DEF_MOD("wdt_1_clkp",			CLK_PLLCLN_DIV16, 4, 13, 2, 13,
@@ -156,6 +158,7 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] =
__initconst =3D {
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
 	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
+	DEF_RST(3, 6, 1, 7),		/* ICU_0_PRESETN_I */
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
 	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
--=20
2.43.0


