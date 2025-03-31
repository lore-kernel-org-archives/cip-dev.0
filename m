Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F7C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:11 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.46])
 by mx.groups.io with SMTP id smtpd.web11.48835.1743418029168307384
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gzbFaKcF;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.46, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+uRD5TXL4gjsX3pRqos8EU8kS8Zg8AnLtRQCTgmWAo6S0HmP6PHkonSKmzqzmvgfErM/L0zDt1ffuuc183bmstNCzgmtgqYCsutbpkeBFVNk451YCn3RwHz4UkgxeuPJPS2/VAuJaet+d6NirVFPjoA6JgKkmTHZt6H4raelWeAb4IMj9U4Q1u83RHkHAkH/lmJ6fTi99Br29GFKzpmT49qzoi473QZ3F4AShDcYoWsT1gWM85FTd70k6dx9Iov8AUeA7xaFDD1GNSTzL29UKkQe1KGn4Xt0s+QBenhltPnPKkmKwitJygcpQ2XUuqexpw5soRVPePdKv1ZxsTaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5G7D3ftyRAD6Kt0cWztWC6Z8BkNh1+ffXhDYo5oZQE=;
 b=C6G29lvcExaC18W0ndRcZDDuYvOAO06XM+betKhspGPGiPKqWqLM/HXM7FBZmebbm+YUsUbkHTBPTasTptRzNlnw2IrFl1f4OZb8N/k26aEfLDAP5XXCOsaSG53LvTYmZ7FFBSPBaSaFjZ1bRKd9cE+aJHYwhU0oTW4YsAd/3VgOBvB6sRwoJT/rP+dKe3mVMXK3Si/5jjMIA2LFv9bX943cmiMlBU3M+lw1hNP0fP7Df1lCQABSN8CfI3u+idYm/tC+Xo6xWWvj1UDgYvSihF1AnIUGPvXeQanWdp/6VnOWx/Ak+Xm5/J/Xto/PSQof4xRVRA1RHO/0kuJHeCNh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5G7D3ftyRAD6Kt0cWztWC6Z8BkNh1+ffXhDYo5oZQE=;
 b=gzbFaKcFe6q1e0SyHnnDklXNKfVT5jEe4ltwxzCs+Nlqifo6yMaSEEPlBj7aTnmaGC8REdde3DduQ69rWExlTjLGgDPvTFSMkisctTY1GD77/sLSrgWDj63SVPXMTK7BNRIFwET81qNhfLSdCoo6lgyIpC+/E/ECjRyMnO/JA80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:07 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:07 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 32/43] pinctrl: renesas: rzg2l: Introduce single macro for digital noise filter configuration
Date: Mon, 31 Mar 2025 12:45:03 +0200
Message-ID: <20250331104514.79090-33-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY7PR01MB13744:EE_
X-MS-Office365-Filtering-Correlation-Id: d67405a3-a5ff-488b-dba8-08dd704161c2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+mfB3fH7wnVt72Eit6dzO/zy0nXNfdi8rWz84OnYaEkRpoF9RjZCurWwUOs1?=
 =?us-ascii?Q?aCcvcdkVHZJWU2CXdufyVaf+1k1QcA7bK25fflHdY2vomaDdDGRsEikrdiT1?=
 =?us-ascii?Q?8ipNMhHWJ39yamuT6ausN3vPK8zVPrw2Gyuc4nH23sqacIfRig5rAzZNW8Tf?=
 =?us-ascii?Q?Aq/IDVpq+v8NhcNIfxQUzB8i3i7nPvc46ZUASGLbmwN+nl5z8x55mCYjIj2m?=
 =?us-ascii?Q?MyY8g35bIQ77QgQ8pXt01V7mojdvNP8VCaf8brDkh+okRLxuycGgfEDpq1EH?=
 =?us-ascii?Q?yZGbq8yW41H5CktGfqHie7lt4/L4JgV3RXMiHNgfNdqneT5mnCnxMQh7WaXi?=
 =?us-ascii?Q?OUsF2vuFQekmujdtA3qDZoa3gnYLdIKKoJP8Ei/DDa2Ic34y8YRFzdFi8BcQ?=
 =?us-ascii?Q?hRXI3vTwDP4s0E8UDqBYDEOvwO2pKhP12PYO7XLGg6LG0QyALwTPwD2AEQVL?=
 =?us-ascii?Q?ABKU+11bHSq7BTQEfgvz7p8Ge7/ByAF7ZgdhtKUH+60+YYrvBOnx1BWClsdb?=
 =?us-ascii?Q?xZEDslVD2CuCTUd49kXYg4CJ6AdSnokyrlrKY9Ifa5f9Y3QCp7uMj5tGbrEW?=
 =?us-ascii?Q?OJQ0qwNUYSLeyKhIX6Jfjth1YM6fhrBg0p66zpwUPNFE4YMnPXKpDaA11+3+?=
 =?us-ascii?Q?N16zuAG6hWxqNO07FKn9sg2ngCU25KqPQMW2yigCAonF9h+Ycm6YSs9uzT/J?=
 =?us-ascii?Q?lomcMurKp3QRRSEQZjIzdflii2pbHMKxPMDFa7KaNHx1SAdgsiTvIx+5XZlC?=
 =?us-ascii?Q?viHnlr552ulwWDD77vd82y3a4UkB/TA2eRZUhiRciVPSdgOHTa5yeMhuxitp?=
 =?us-ascii?Q?BC8L5YgQ9oofA2Km+Ur3Ln8pXiHJc2tORNTZ3N6yv2l2EK3oZ0ykogweLOUU?=
 =?us-ascii?Q?mA7voeTgWXs7ETb7hA23V3f44q921+VF0jLJa5Ci+qYmO/Cx70VrdHKoMCpi?=
 =?us-ascii?Q?EpEJO+8OC5oLYnZ/qgeiGtCzVIu0+EKeo66CHWrve9XTWiObED82mW88Y7W8?=
 =?us-ascii?Q?XLg84hKcQKdkBF51rVnrFQoMFUrAGElXQ9X38lg252f2IN7LRI+9GMyTatzp?=
 =?us-ascii?Q?s0RYWloegFfW8LoHJkR+N5Y9n3Rv3AG88DxkEJWtxhS9bm87/r8pEFLyAS42?=
 =?us-ascii?Q?A+itRWUZAx8E8shmcg471eJaVSWbbnNoEmgaRkCl8+DRL95pb1jSWmYR0KYA?=
 =?us-ascii?Q?NKzBz0xjd4Xuj4OPcM0hzKkgGbXoCnZAFpD8sWxL8evvCmRNwgoPATE+mmJC?=
 =?us-ascii?Q?vbK5r85ZMhASPhDx30ayJiWlOCNM9MQuwAyFFs97T00rVl7ADeOu6vs6uP1i?=
 =?us-ascii?Q?gjQnm91e9L5FOaYV16zt5bmwUr4hePtoGNJleXgFFNBMLxUil5I1xav8cZ8w?=
 =?us-ascii?Q?pcoOrHmq6nShVeooDOfv7Ym9MPMqAmvHpkLpJh2B6l1dGTjuH8gIonB/uvUf?=
 =?us-ascii?Q?QQewCH7psD/bXehQ/8MOyOcTKX3Js7a0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hPMYQ9SGmPefCGhLVrNZyCjf2sBRYYW+jP7rDTKBd4LDDia+JjKbCSNv20CP?=
 =?us-ascii?Q?FBhBxN3dPSceaX+1xcCqLLYZZhE4lTrUscjYpBTTY7eUJFhrKJQpNG3+MK3W?=
 =?us-ascii?Q?HedDKQO4TKSvoJqSxX1FVqwXTWd13yIjx9/OwsH6XHpV64UWDFv223KMhGGN?=
 =?us-ascii?Q?9Rlhc0EVblR3+NFMrcMXPsiv1LfPbjzPcdvcIzxNK87JqpzXH5KqQu1tx8mR?=
 =?us-ascii?Q?l8fZr9gzF51B8HjZpZMPkbQKIzMoC5hAPwkTuDkfaXMxKZZ8pQh7m0KhL9yJ?=
 =?us-ascii?Q?6+PSWJOjBA3Y0irfOrx933uw5LipP/wNgeDDPoGkyq1naKWF5O7JCYICJxOF?=
 =?us-ascii?Q?fctHuK8rNpexoK+7pH2LpBN9YPrhYo+sd/54ADD845SwxOK64AlTc6c3fzpS?=
 =?us-ascii?Q?dmcsCVMAZUH62JUYuaApsHHvrOVVgjMIuHKrWiVg4Gw/dtuw7zfS+lXWdzKZ?=
 =?us-ascii?Q?lYTzOsQUm0bUk4hIao9XlF1x1oYo8DVDs5PAQhmfQVcKPNpRVtegAguDzic3?=
 =?us-ascii?Q?i0XyEVyn98vzOHvroDyBQnaeNayZ1IhZIdt20R4hilm4n3RLHDntiNcgBsCo?=
 =?us-ascii?Q?kQzD0Lg+TBUxaKclVNwl1UkefQZ9ulWQ7IZ2VTfbKne2d9lhn32SujPcBh9a?=
 =?us-ascii?Q?5VIhfjN4jaTISWoOp+WANdKmW3g7IsQgj9y+Xl7Y3cK4GSFRircmUbWh5Amk?=
 =?us-ascii?Q?mW+KTCIBSVDbVBIU9dGBEKqTU+UQfCXMDe6UctyDooeEgq61LQtsjFxQ2B3d?=
 =?us-ascii?Q?oF2SEf1+NGCI8yZQv+Q579WTRqYzxn98vY5guGYYYF8QlZrTcaXKm0Dbj7fl?=
 =?us-ascii?Q?YHS3sTrGLPxORuYOLuJwY5zUsy/O/A4Cxtp0k0qQ+I+yrN6DTfUVIxgRLFmk?=
 =?us-ascii?Q?Z7hfpCJXbXxHhq+VasYJUhtPTRsHaf8H9dC07z+sHzedl7xeKr/CrS8AWxPE?=
 =?us-ascii?Q?5VXKvptf1fCmtixnyxfHNue2BrIcIP2WmhDEqIGBZKg+lKrY4Bqkwt9QCIRs?=
 =?us-ascii?Q?Lt4MjgL7QlOqYCdz5/sjgs069wDU48u2iIhzz3hpCTrw0ViCVtyMu5O4Wt30?=
 =?us-ascii?Q?5gYYIdSeoTu6qBSZpDLBzFGLC66f2/9wUgN+PBuxMW3p3MWhtBugnL79NKvE?=
 =?us-ascii?Q?lNrhUJ5YWIFyRTWqUHwM/U7TvgE1F5mJgsAGq5JsB9PFgKFYwVLeiobJ5QhC?=
 =?us-ascii?Q?CYC70/RA0PNMr39nUdalBqhlmCrW/UyyN+5Ga2nJFHFMIhbmTVKh2QNrRbmx?=
 =?us-ascii?Q?rEvddPFMoWtkf5AWdrMZOLBMBaRR+vmIgv4chynZXe3kK0sGwISr9ylBvIYX?=
 =?us-ascii?Q?XnFoHmhWq+L3H6Po7pdPBvEsabQ7TZIUHgzdbM4Iw/wtRlpv+iZUhW0L6uYF?=
 =?us-ascii?Q?3Kszl/lzKYCjj69BxBdbNnPDq+YSk02OXtUmSVLPI0NIJux6uMopO5ZMtaIF?=
 =?us-ascii?Q?p6tXJTxbShIEe7jXeh+Fb46hodAQMj3y1ubkJB0bjKwmLml63qXIdOO5llgF?=
 =?us-ascii?Q?rzhqPFl4JykY5a+hOsLmpVQ9oEEy3mwlOd9HqCPsK0SLjJaLg4i9ntQ41OTW?=
 =?us-ascii?Q?40b7s2TqdcRCA0+zfmPWBm5HNjkZAZseE0g0V4B6OA60mGQMaSn4iDfw8RNw?=
 =?us-ascii?Q?xdjKsU7/UtFv4ECM3w4AmPs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67405a3-a5ff-488b-dba8-08dd704161c2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:07.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/Xv4ODDUPZe6SRPkGMWzw8yNAggZZbxuKVG4T/FxvsPKQTv4yEZ85JTtP/VfF8S+Mad+YEOjdVj+UgXuifNP2dLc9QuorXu4ProhonG7s53mdZ9eGHoJpRLAtrHD6Cl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18420

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit befcded23454825ca2cc4c24626b68c75fcb1528 upstream.

Support for enabling the digital noise filter, and support for
configuring the noise filter stages (via the FILNUM register) and the
sampling interval (via the FILCLKSEL register) are related: a pin
supports either all or none of them. Hence simplify declaring digital
noise filter support for a pin by using a single feature flag instead of
three separate flags.

This patch removes the PIN_CFG_FILNUM and PIN_CFG_FILCLKSEL configuration
macros and renames PIN_CFG_FILONOFF to PIN_CFG_NF.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240829194841.84398-2-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 52 ++++++++++---------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index bd739879055ac..d5249955c9a49 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -51,17 +51,15 @@
 #define PIN_CFG_IO_VMC_QSPI		BIT(7)
 #define PIN_CFG_IO_VMC_ETH0		BIT(8)
 #define PIN_CFG_IO_VMC_ETH1		BIT(9)
-#define PIN_CFG_FILONOFF		BIT(10)
-#define PIN_CFG_FILNUM			BIT(11)
-#define PIN_CFG_FILCLKSEL		BIT(12)
-#define PIN_CFG_IOLH_C			BIT(13)
-#define PIN_CFG_SOFT_PS			BIT(14)
-#define PIN_CFG_OEN			BIT(15)
-#define PIN_CFG_NOGPIO_INT		BIT(16)
-#define PIN_CFG_NOD			BIT(17)	/* N-ch Open Drain */
-#define PIN_CFG_SMT			BIT(18)	/* Schmitt-trigger input control */
-#define PIN_CFG_ELC			BIT(19)
-#define PIN_CFG_IOLH_RZV2H		BIT(20)
+#define PIN_CFG_NF			BIT(10)	/* Digital noise filter */
+#define PIN_CFG_IOLH_C			BIT(11)
+#define PIN_CFG_SOFT_PS			BIT(12)
+#define PIN_CFG_OEN			BIT(13)
+#define PIN_CFG_NOGPIO_INT		BIT(14)
+#define PIN_CFG_NOD			BIT(15)	/* N-ch Open Drain */
+#define PIN_CFG_SMT			BIT(16)	/* Schmitt-trigger input control */
+#define PIN_CFG_ELC			BIT(17)
+#define PIN_CFG_IOLH_RZV2H		BIT(18)
=20
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
 #define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
@@ -69,9 +67,7 @@
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
 					 PIN_CFG_PUPD | \
-					 PIN_CFG_FILONOFF | \
-					 PIN_CFG_FILNUM | \
-					 PIN_CFG_FILCLKSEL)
+					 PIN_CFG_NF)
=20
 #define RZG2L_MPXED_PIN_FUNCS		(RZG2L_MPXED_COMMON_PIN_FUNCS(A) | \
 					 PIN_CFG_SR)
@@ -84,10 +80,7 @@
 					 PIN_CFG_SR | \
 					 PIN_CFG_SMT)
=20
-#define RZG2L_MPXED_ETH_PIN_FUNCS(x)	((x) | \
-					 PIN_CFG_FILONOFF | \
-					 PIN_CFG_FILNUM | \
-					 PIN_CFG_FILCLKSEL)
+#define RZG2L_MPXED_ETH_PIN_FUNCS(x)	((x) | PIN_CFG_NF)
=20
 #define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(61, 54)
 #define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(53, 46)
@@ -394,13 +387,13 @@ static const u64 r9a09g057_variable_pin_cfg[] =3D {
 #ifdef CONFIG_RISCV
 static const u64 r9a07g043f_variable_pin_cfg[] =3D {
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 0, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
-					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_NF |
 					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 1, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
-					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_NF |
 					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 2, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
-					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_NF |
 					   PIN_CFG_IEN  | PIN_CFG_NOGPIO_INT),
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 3, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
 					   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),
@@ -431,7 +424,7 @@ static const u64 r9a07g043f_variable_pin_cfg[] =3D {
 	RZG2L_VARIABLE_PIN_CFG_PACK(24, 4, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
 					   PIN_CFG_NOGPIO_INT),
 	RZG2L_VARIABLE_PIN_CFG_PACK(24, 5, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
-					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+					   PIN_CFG_NF |
 					   PIN_CFG_NOGPIO_INT),
 };
 #endif
@@ -1887,8 +1880,7 @@ static const u64 r9a07g043_gpio_configs[] =3D {
 #ifdef CONFIG_RISCV
 	/* Below additional port pins (P19 - P28) are exclusively available on RZ=
/Five SoC only */
 	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x06, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_PUPD |
-				    PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
-				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P19 */
+				    PIN_CFG_NF | PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),	/* P19 */
 	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x07),						/* P20 */
 	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x08, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_PUPD |
 				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P21 */
@@ -1896,8 +1888,7 @@ static const u64 r9a07g043_gpio_configs[] =3D {
 			     PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),				/* P22 */
 	RZG2L_GPIO_PORT_SPARSE_PACK_VARIABLE(0x3e, 0x0a),				/* P23 */
 	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x0b),						/* P24 */
-	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x0c, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_FILONOFF |
-				    PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x0c, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_=
CFG_NF |
 				    PIN_CFG_NOGPIO_INT),				/* P25 */
 	0x0,										/* P26 */
 	0x0,										/* P27 */
@@ -1975,8 +1966,7 @@ static const struct {
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
 } rzg2l_dedicated_pins =3D {
 	.common =3D {
-		{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0,
-		 (PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL)) },
+		{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, PIN_CFG_NF) },
 		{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x2, 0,
 		 (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_IEN)) },
 		{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 0,
@@ -2057,8 +2047,7 @@ static const struct {
 };
=20
 static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] =3D {
-	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x0, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM=
 |
-						PIN_CFG_FILCLKSEL)) },
+	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x0, 0, PIN_CFG_NF) },
 	{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_IOLH_A | PIN_CFG_IE=
N |
 						      PIN_CFG_SOFT_PS)) },
 	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x1, 1, (PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS)=
) },
@@ -2097,8 +2086,7 @@ static const struct rzg2l_dedicated_configs rzg3s_ded=
icated_pins[] =3D {
 };
=20
 static struct rzg2l_dedicated_configs rzv2h_dedicated_pins[] =3D {
-	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM=
 |
-						PIN_CFG_FILCLKSEL)) },
+	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, PIN_CFG_NF) },
 	{ "TMS_SWDIO", RZG2L_SINGLE_PIN_PACK(0x3, 0, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
 						      PIN_CFG_IEN)) },
 	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR))=
 },
--=20
2.43.0


