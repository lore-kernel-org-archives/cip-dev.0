Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C61C3601E
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:01 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.60])
 by mx.groups.io with SMTP id smtpd.web10.6098.1743752336007445269
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:38:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=D++Nuoq8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3JzdY2jUH2fesNYFpWxyeKDY2C8nfmVv1fACSOan2f+FeolbbUzn2L9zXe0iOwhX4wl4jh1CgXlTeFWBIlqDaHD4OdUz7/0wUQ8jbnQcoSEq5bWQKtrIGDG39Vx+7C0Hl9E0/FmFUq6zWsNgCuE6C4NgRotLSws2OLWGps29GAzg6k+lnD8fuBI4GzwvOcmTuk4zlyNTbcM13St5YRcGRcLoIHNUZB39rISNKwlHC2JnWGd7lqk67IiPaXcHkhr8PVPAFizHqfMTINNkvuSalbcCIYpQtqSidlYS+UuijRV0AwXSWW//kfn3KkU8SNxK2PZrHR3jR0N3m24FM6MQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTMKq5KHdTnXp8k8ahGo410NIFwTlUEzNKSJaCAshBc=;
 b=lXZ9tDFKu3uvitw4Ej4QpqBJGsbDas3u6PPkqlEoqXabGLWgdaXKuRAA4Dq9GqIxtSEKCbCkkb3Q9ANzi3AIxaEFsQZrnHWzNQNLauWpP8qLJMdoT6yIUpVUW3Ga6TwG2FPPQfa3WfeZ9UXT3p6xmD9HnPb7PnrE1n0qKX+LfUk/PPeySlCd4pDoFrjVRofzf/quuFkA5K6sls8OYGdTE96H3yJaEU2z69MmB9RlWJOcqwQFlJYifVK8/dniEask4OmhYaqQL41zYmtY6cya56CTiEjGjr8+06PMR0KW6MHlXukQPmXsLGWwSuavNoz2To9FofKoj3EEugBVuRNkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTMKq5KHdTnXp8k8ahGo410NIFwTlUEzNKSJaCAshBc=;
 b=D++Nuoq8HGhHiJAb5XCJzbyVG1msLEXjOC9zcDUdkdthJwBV+rZmerNhB+ELSMZHrJxqSXinR0tPkkhqj++uu4c9rx6K25b4QivyJyuwkB7qEzfSHG/0Qd+eBWhO7YJC2qbaGs1kmFixqVc5vE2KSS8xhvL65x8fXMzs3DLLa7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13254.jpnprd01.prod.outlook.com (2603:1096:604:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 07:38:46 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:38:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 1/9] clk: renesas: r9a09g047: Add I2C clocks/resets
Date: Fri,  4 Apr 2025 09:38:11 +0200
Message-ID: <20250404073819.173272-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13254:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6fd8ac-5106-46a2-0478-08dd734bbbc7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Jh795ZicHaU8VQCn+V++9lhQvZdNC5LTkTQ+a9DZyiVxU3Q9qMSWmystoaiF?=
 =?us-ascii?Q?6kjDUGnaa/2KObJwLngDihLsId5XH/gZ4xNFIigJUdfQqomGfj9j9J2Fxy/4?=
 =?us-ascii?Q?+5xHMZeOxmCMmWJEIhBH1EpexYcZn6uR0LfElUGE2mA7Bthp6O3iUaROiHOB?=
 =?us-ascii?Q?xjEApzWvd1tGRSZLB1Ug0hhSXlYqhNJHAK3VdAV2S2Bq1dr0IpKTzkByKWr2?=
 =?us-ascii?Q?Mj8bk6ijvm2pmc+e27GbV3p/52mT7QiQKqxO2LZnALcjzmkq/7rdOAiY6BTp?=
 =?us-ascii?Q?4UmISkasMqKrA9hYVOTomEirfmXVWhC8+xeJzPQSuRYSKI+ae3da3o55Aad6?=
 =?us-ascii?Q?czLPypSbOw4s5aab8jJjS8HJW/jeOcVf457EcxDICKei/Mxopj+faTEEzegO?=
 =?us-ascii?Q?GzWfZmfgzTHs+aDBziH1JAZKRj0bySfYgjS5Q0WsqjXPysK9Jvr+200nT+Go?=
 =?us-ascii?Q?86oHMvuzdIxgMB4M+/kY7rQIHhVgOZ6ciSmtMGZ3NS0jQU/ZnsrOeIkjrWGU?=
 =?us-ascii?Q?GKyE8rFKWbbJb2kSzfLqnM139vjJBJMugDLJr9Hs9DBBENskt4CWzEUbcWOm?=
 =?us-ascii?Q?R4jk9zRaWTCH9uXJPzf1kmlP3wiOclLBmdKDzmjX6DyrZRdnQ2J97yNErGfo?=
 =?us-ascii?Q?zfqj81OgHOTkbGLeobdeJxiK49K75CFSJJxHzQHBxr1jPvcFWRytGqoCgm+6?=
 =?us-ascii?Q?NjB25KfPlzgAqIC3Qa6/ahCTUm3mRJwpUVnCcebLv6LTrtcB9Byvm06HNEdP?=
 =?us-ascii?Q?uyShYgtr5SySG93KSvFkfs1pxzg0liEOnj3s+yDfPrKWSFiuaaFS5UFjwACh?=
 =?us-ascii?Q?F6cAowdkBPHA3sQmErOER/sDCL3Z1qM4zxhbtZwdgA2qSQ8yJpHgE3OXrbhb?=
 =?us-ascii?Q?IS318ZQrBr609eNaBdGxFyUsWOaxDM9oaoUe1e/06apcQH8EQWeQSGgbOhXP?=
 =?us-ascii?Q?hhTiEV38AO8TepFZm44IczTyfpWlKJqZAsk/ozvbnLc9nEFozoK1R5E0wD4l?=
 =?us-ascii?Q?4bZ7i7bGsZZgjP4e2yeXEroh23UNJnOLpWyeEsxMSk2CpMSVIJnxCvWDbvMI?=
 =?us-ascii?Q?5RdoWFMl/vjRBHlUhb7/TYB1JzhP8TchYvzAEWsVUX6Yt4ml9F6YlFJ3Qxdj?=
 =?us-ascii?Q?otAMzvp+LCEnZGQGg0K4GVAyuThft5pC17Ckw9bg966IPwz58ATZCeuaio/1?=
 =?us-ascii?Q?41HVhNgraB8HxOS+uTuS8JWgeQUvVdeAAzCyEOxsCbPxIGR8e2b4JXbLHpYk?=
 =?us-ascii?Q?uOQqdrNXLlXxRZ3kJevoqBnAypBZ2DOp22wlK8p49nshrJgrVcU4AC5ou0eU?=
 =?us-ascii?Q?lMZlFe6996Bwt4qPxJ2W/AvZCwJFDHRJ07fje24g7ooQQKmI8HHKMasbGIP6?=
 =?us-ascii?Q?uS+K5lZOkUSIM3XZNzZdsWPlQOjbjtx4EDhlzCr6bNG0NMYBNtQoVlw++jCp?=
 =?us-ascii?Q?1rkxzg9ITetl9sFi8XCaSj8hBrXDps6R?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jKF9rKnDCieDo8n8ftNW4w0pAzm87ILBknZHd25tqxXQI1iIWtUreoIHbO45?=
 =?us-ascii?Q?NuYTBJSR+kK1yYiJkx7gO4CRG3+KgYcqwXnCFp2nZpmla0xvcIBfrt2bn6xz?=
 =?us-ascii?Q?d2LQv7K8G+gVKy3ZzNqC9Xe8nFbxGd6vuaDWoPsvD+mzhO88LtK4QLhEV/0A?=
 =?us-ascii?Q?zoVrT4UhGJQhVRqXUebjscRB0ArJFGAFYCf7witEtUays6v/dwQrA0YFmmWB?=
 =?us-ascii?Q?t912tLBhNW6jqspgml390KIoz+6+T2mUh1PApAfic2kPHIuk+CUt9HspPFap?=
 =?us-ascii?Q?tottyuMy8NDxh+ufonaF1p+uiYrHiysA+CwDJ7rVYQdyZG2hvDZwAuVk9uXm?=
 =?us-ascii?Q?izB5JnxGKZatnNp6oLOcLRGQT80QjU0F8CGrUT//pzLc/a6QEr16eJ29bzKh?=
 =?us-ascii?Q?vYLIIDvp90YDWBVunscDgS9Y0FNz7E6NoKgI4V7LrXeHDX5AS0N5t8mDC2Ri?=
 =?us-ascii?Q?E+AjtMkIC2kU4nlYutlpLB1FSeFe5cWIJFvT2FaSUsgl55GUFHT1HAUpjhz6?=
 =?us-ascii?Q?cNgKnNLJOr034/xTehcLLGhOgi2sQsMMvmXbKgWrzDUqfRVNQi8mJsHVCs6w?=
 =?us-ascii?Q?VROOmEf8bcXq85QPZF6lL5U35zzu8JxFjL6MPETNgOe3FgIXuK+mqM7Umo5M?=
 =?us-ascii?Q?WOtrPX3LQWia5yGlHfOlZm18VAzdmc+kVlF2drdZirrZj8x4LZc2uk0aK5/o?=
 =?us-ascii?Q?vLhkQ7b0/Dr65tLnydKqrJXMLbnsGFS7h5pyLOpPkeqq9VF7I82LDSsXvJzN?=
 =?us-ascii?Q?SUB5j7Jj6IPQrKdFwnwX7A2eRnqtvtyHD43LheiRctLSaLgEWZ0zIu+if/F2?=
 =?us-ascii?Q?Slqb8igb7Rqm/R2IkrgJCZ4JWorhrGqWd7PMjque3gDWZvJvVHWU+Q6+zuHD?=
 =?us-ascii?Q?qcvmbVpugEvnQkd9fwUWmXgAIqEjEfGK1dFNH8X60U3ufd+QU0WXHsodaYM4?=
 =?us-ascii?Q?sCrIr9PSf2bixQMTKt4/jB2rdKBxRC6uHNVFdr9PmHzhBVkLIR6fN2Xh4Cir?=
 =?us-ascii?Q?wVH2W/b4GEUJ9WpFCSyL8pYkvXzG//JohFg3vypghRCM6R3WfcowsCv0q7a+?=
 =?us-ascii?Q?27yOvE3m1BFLeizZ2/wEAnHT2l2FU+zNW2wm40pteoCFqlOVcTDy4kaU4ZTz?=
 =?us-ascii?Q?OekWBzldIOsnGeYxqA6WDPXbOd5Fb+bm5FJ1T84QGakYpwY7waYcXFMxq/3H?=
 =?us-ascii?Q?qhgBzK20q9mDuDYNkwUhWf7k/zc8EQZC9ySeiTbsscXfctKfn4biLJ/hyI4P?=
 =?us-ascii?Q?WZ58bfx2sOkAJWXO2iJXdHGPyhiqtX23EmbHJ3DMSEZjf09SJsI7nGc8giRW?=
 =?us-ascii?Q?E0W626u6Im4TduHdI7SjHDXtyBTkjppk62nY54MKNeN28ShL9ESg7OCtzyWo?=
 =?us-ascii?Q?BkIXeQdtmcX4QAQMvCHOGbgtbX7/MG4MayVqSzHAM/dTWE4/dNkED1Dx7OWi?=
 =?us-ascii?Q?oNa2PFXSd2lmsRcz9s/huzODKohCTu+oK2NT+s+AhED2QhJ2GP/aiazC5WFq?=
 =?us-ascii?Q?tT38ohQJoJkktODaaMkZcrOSJOlFasOTi+0bBNVJB1iSaLle26aAkcvHgqCe?=
 =?us-ascii?Q?x93Gf94iAQFXkewoGUTQSUIrkEpW6oW3/zwg8bIM6ii51WX0zcLlIn2mBXMb?=
 =?us-ascii?Q?GwTjzpp5KquR01QRFaSlodY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6fd8ac-5106-46a2-0478-08dd734bbbc7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:38:46.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38LGT2cl+bxYSeOlJPJdd5rtIj36dW0H9Hv+g2mSMRm1xglerKWS63PilXw7BJsT03IpFrHVR0kJLsRve2OLVZUaJJPiHS354hVLfPAFQFdifKXbHG7GKwfmNtneBiPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:39:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18464

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 29ebc6197403c643f389b59ba334e5bb53457103 upstream.

Add I2C{0..8} clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216120029.143944-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index f5966c08de417..536d922bed703 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -25,11 +25,13 @@ enum clk_ids {
=20
 	/* PLL Clocks */
 	CLK_PLLCM33,
+	CLK_PLLCLN,
 	CLK_PLLDTY,
 	CLK_PLLCA55,
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
+	CLK_PLLCLN_DIV16,
 	CLK_PLLDTY_ACPU,
 	CLK_PLLDTY_ACPU_DIV4,
=20
@@ -62,12 +64,15 @@ static const struct cpg_core_clk r9a09g047_core_clks[] =
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
+	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
+
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
 	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
=20
@@ -89,6 +94,24 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] _=
_initconst =3D {
 						BUS_MSTOP(3, BIT(5))),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
 						BUS_MSTOP(3, BIT(14))),
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
 };
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
@@ -96,6 +119,15 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
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
 };
=20
 const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
--=20
2.43.0


