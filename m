Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D1C35FF3
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.26])
 by mx.groups.io with SMTP id smtpd.web10.34432.1741778649916902406
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=rBttaT8y;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKZ0oOFJuTAtQ7KFVaIEpl0UDEiXe8V/l15KdmK0RCwNBO62WZYGX90NHDZKl1otXQAEVz6Mu3Z6O2eqbFj5zkxNWt6gPuBpzKStH/2tSW2bEPLbJaXHZqfitdd9u1LEdgUuca/tfrNaaMhYBjnh5eAMIahlMkEeJ2L+SZPB8WuKPuHYODC1cPR/+oqUPRTu62+r5GJRIHB/asZw6W/Ybxa1bFLtAbpnWHAWoqbKsM2aq7I43UH52NyGZHhRy2bRRah/ZaJSeOuJL2d2hM/VMQ85+PHkFevkohn5qhgBb5N3RfTmtPAcOQJaw59tHVhQTPYZ6D9+Vmd+UC2lbAmkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj4Ie56MdZPW8ut4I7JuCFXy4SiODBgrHdyYbC6SC9A=;
 b=qK7du0C4WeU5eHR1pcFnYiCFiMQ3RbCidZvd1ggEL0qdUl2+CtZjK/QkCdroCy9eR39+GxuLJ63CDSpjoHWsWFLo48kZXNcrIFfqld8Ae/gVxY2bhHn/0q8bGZ1QQeNHtzuYFcbNjnUhvDaFPMTrzDPCRSc82MvSSta+0iZ8nsA/FXs74QuwVwoSuGPp5Im6IBYwrADUL74hF9izkG8N51LqDewZjwF72SOGusIzsNibBbSaW1vt0fAxvOzZUfjv/iz90C1RdUGBtM3niBm/LhWkaAs9WavoQbpwUpEwzlWrpBlbDxTMcno6bPDWrevK/Lrzt8DXO+5ESyIntfBrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj4Ie56MdZPW8ut4I7JuCFXy4SiODBgrHdyYbC6SC9A=;
 b=rBttaT8y5SzB0DL3JpMTnW1CNe4eOLd9nIYNAfvtSo9fobVCKq4S7vh7o1KhI32+HIBry57bOZhz9UzsUYPmcA8W7a9c1Mpr3fcsvZfSO8beCgpevBJqkBVvw5fXqVmCwfACJkTZ3BrQRd4tkSn3LG5fnK2WkkpvtnzafzliJXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:09 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:09 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/85] clk: renesas: r9a09g057: Add clock and reset entries for ICU
Date: Wed, 12 Mar 2025 12:21:48 +0100
Message-ID: <20250312112302.1605750-12-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 228aac28-bfeb-4148-265e-08dd61586869
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hwhdYYVLjNkoeKewTdFnveFvO6/+xfHOnhUFkiQ3LNG2koqa+BaR32avizpn?=
 =?us-ascii?Q?90ewWKiPV/6JyuH5zbOcYC3QuT5X3Q21mlwXIAWV9cGA++8HD3oFtR2+p0G7?=
 =?us-ascii?Q?jlvQUBHyaFX9A3V0cmtzwe0szoVE2egwM5TWtOcu8gibQjiYxGzhvmUeXTa9?=
 =?us-ascii?Q?oOfD6awE/a+5L7bcYOO7PpuPTxgKFIRr68MTjIbbLYFmfCJTOOpTjuGFeMLk?=
 =?us-ascii?Q?X9qjVVmyJuYN523Vq5N77chZWY8X5t8yka/15yFuqpseZAMmyED+6BhpV9OL?=
 =?us-ascii?Q?NGhP0TFtbQSJ1RLEgQf3gRDt9k/4fadx9uB7wKciyXi27pXfTnyt/D64nHBv?=
 =?us-ascii?Q?UJuMPvbXXHnTc0E4KOGGdp+lkWW7BlXCQiZsLPWtcUCUjC1KLEQKnOQo5yCP?=
 =?us-ascii?Q?w7tCrvg+YhYDMDXuCWY2ygUjc0+EHdjSdGc81zJawFWFzF6dXejrfg8KFjQR?=
 =?us-ascii?Q?Yit6guLqShd8wzZR9tpjdDLa2U74YbZc/S1F//9xFHqba1tibfR3GYZDRmKk?=
 =?us-ascii?Q?AdYsOon7frki7VnfLPg30UlFwcGUWitJeUh94BQWA+nwP5UKbIQ2dZecswyE?=
 =?us-ascii?Q?uhIZ5cX8ioCyojw+AzLVSlHQboM4KRD7pcDHPBcb5XVLBA8WRyzYQaeurY0R?=
 =?us-ascii?Q?O/1dkE8fuSNoQwJUR09jL7w6m6jOo1P16+lnnXSu/g1xY6vKheXqnKqG8Z7o?=
 =?us-ascii?Q?yRJMoNES8+EfqNFlAPezNc/dHb3dCRczF9sRPKftBTN/A1X2Vw4WPBrwMa0V?=
 =?us-ascii?Q?FRvPazLTvYGjtuCP36NU8++Gc3TU6Ck5tC+LpHn1vVYJF8Lb8jfrmyt9ssTx?=
 =?us-ascii?Q?l2dca+0BVKpiMBvwTMAn6sewqzafN+UNcQS1hFf2UCA3UVB5IwneUTWCpmmx?=
 =?us-ascii?Q?Mo6mzB5aGh6xfvFUgyHz+H/gyfrzoqunsyz1ZcOXeBEaxHlg9PNufQ11CFBb?=
 =?us-ascii?Q?o9/RPHjFVrTkdFDbuFs6gfPlCcFu3fgTbr+mB9AnCwscEuvRTL87kV8RL/sn?=
 =?us-ascii?Q?Y64AnS14iQVUdSuACgIKfp5pmWmeEn8E6lGlW4/8PbJdgLB5ejWukkykX60B?=
 =?us-ascii?Q?p5j1G/FeP17Tq1wvubJDTs5Wx+6Q0Q81u9bxbZnJ7hXZX4QIOPlXA/9FuJ7p?=
 =?us-ascii?Q?Iz8S5QaGHUOl73UM4aPYa38BfCqHQ2UmEGHW+aG8lMnVZt+pXVhvXaus+VVf?=
 =?us-ascii?Q?KMsYBTYRcjh62txeWVY5B9g1sQ9NQDJcLbiEL9od3ksFp0iRSZcga7qOhLtK?=
 =?us-ascii?Q?AechZ/lLMGmMl/sXc8/Tx+AMr44sO77DFJhHeKLp+inWrA9mXtvdPQQST0dZ?=
 =?us-ascii?Q?ZcPVsOBDKd0ymLITKKNJiVujwNo7uaRZOAxX8auZEmrPRDOJT5bFziOfaizv?=
 =?us-ascii?Q?HlPRIy4TqY9M7nOysH27L10c5DwHR6DY4hXRsCuZNoVoSOlvI1pjiRNRfc71?=
 =?us-ascii?Q?FDNOBC3AH9APQZEW6BcmfZ+0im+JuO3R?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tXI37qNahyR3OGJLGEPIYXIoyoAwBmk/Dir3oFBZGEL5ZlOvzQbrorF10M3/?=
 =?us-ascii?Q?ZNIrCKbm2iLSf/CYJ1GZXoiqFgIj8Qx0aRS49rUn7occJei2g6GdnZkVBcSc?=
 =?us-ascii?Q?9jzyQux+UNGIvvErNO6YGL+yN0gukH952V1d3NvlNeOG4X7dJoePUedvjX9i?=
 =?us-ascii?Q?9eE8/G0w99lKMHUGT7KI1oxPTkOqUIZqJQLtsw06Hla05nS97Swm8hpBFfCZ?=
 =?us-ascii?Q?PqckygJ+2jAsWIiGG6wbTqEts86O7gaqD4lKvfm8cTkSbg6gmqL/hPMu+ki6?=
 =?us-ascii?Q?98wIcJx8KSIVKhp1OQzp9b+H65+JW7IeKq8je2k+kfD9/kkeXX15E8fV0G3H?=
 =?us-ascii?Q?q/SLapzJmHCBmZodNBHuM2gqk+T97P8gKus7Z9UCzuncVZoX1pOOQIYRwJPU?=
 =?us-ascii?Q?zX31kKUPZ8m3lOZFnb4yF/9yLT8BbzGfFIyfE5nqubIEobbqratgMQpIyma8?=
 =?us-ascii?Q?f3LrPPgQOUNP5OLM5z2DBFlWJD3Di5ed1uIhoOc4Din4Ci8y5oFvI0YU3TjP?=
 =?us-ascii?Q?45P04ewtv94pQ85vvcwh7snhmLwRxqTpW4IBTWI/GmF/XwOFm/90LsxtrD5r?=
 =?us-ascii?Q?E98xQXxGZuMVjYQwz9mXoQwitl5Roi9Dy8gNB8Kpn2RVuzIIZd1bLYibhmtq?=
 =?us-ascii?Q?JIRO+WbJiQP/CfTVAEQJn2anrV27MR/J9KnALah1CfOxZWLS3GSEBtUxGSrY?=
 =?us-ascii?Q?GbE6NtU5q6WdkmHkBFkiVJhmS5U145u5SmZ9X5dpXFCDOmp1qHgmT7fNtlJn?=
 =?us-ascii?Q?I4/i9Lh409wmduWkF5iay5EeP0exPXYpnHUI0d0misNkSYnIumX8OJkG2VWs?=
 =?us-ascii?Q?UKDbcJF+eSq2pLDjCoLfHhMB+mpzTE9YmUyaQMuTggpVDE0NTHALQvl9+HgZ?=
 =?us-ascii?Q?3UtqebleJvEwjd5C4r5neZC6jB0HKVCLhG91FRoUcrx4LoC04hjt8uATIZTR?=
 =?us-ascii?Q?aMnAhW6a7YpqpkcNQsbVju6/W7kEvPLKMZaIlcJ9zc7RlX6OqUe0ByLBqTxN?=
 =?us-ascii?Q?1/owii97IEsbDRlJs34wS08u+mJz/VDyUTIxl3tyoz2woAZkaYhYBmt43kS7?=
 =?us-ascii?Q?vhQfUdeV6KDNGuz0/xBaqHrzTHgPMxJM4UydtEBjQ/F8e2bkCqYVKpQhElQl?=
 =?us-ascii?Q?70IFLs5+glS+xu4vyLI8gqaraln0J5sFR+PBCfU49fMNpnMNHekUARxt4Y7L?=
 =?us-ascii?Q?1+4Win4dys2j0o00y5586wW1EBzs2NzBRZTUXS3Mi7Xhxl0Vm/mSLHGLLMSp?=
 =?us-ascii?Q?PyPbVwggcHA6DpHATqd8sn3spLjTcivW7M9n7SNAxVXsETvabeErG42g+OST?=
 =?us-ascii?Q?sV/C+iyrZOzL1wWpLFOWGGd1ZX1K/0u/SXSXZc/XiKfdiLZ9QsgsqpCeJPrM?=
 =?us-ascii?Q?/XzR5vrZphwLpkmfQkCZ7vZaNvM+R8ripPhIFOmnd+OPnQQq9RlW892Sogr3?=
 =?us-ascii?Q?mdJfZHeau2qI/lEQDYbwTHWMN5jz2F1TRSfUwjKHxOjMaM/7h3Zvyrt2HgdT?=
 =?us-ascii?Q?vgTQo0gpNwQ8dgSi09R8jPc7wjFXL9NOQpc456+yxDt8ViyxyndsWzNY6dkE?=
 =?us-ascii?Q?J70G58Vld+jDkjlyu20rtyW3K1izlWexJ/8zP7DhdJbN9eIApQc9q79jnvyE?=
 =?us-ascii?Q?rj9TaMkQkK2XWCtblX7r8g4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228aac28-bfeb-4148-265e-08dd61586869
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:09.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjsWiHV2H+07fduJ1gLVFkbMG1QpH0C65XG8GI9Wv10i1+rEFuEuM+5wPToefxW5fJNQhAEWvtwXO1JoynbaXI5PDnzaICkCHysNP9cSd0EPTKt2+HE9rWCXCNddQBVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18103

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 44d13e198cbf031fdb8cb20b6bbbe82adcb951ca upstream.

Add clock and reset entries for the Renesas RZ/V2H(P) ICU IP block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240930145244.356565-4-fabrizio.castro.jz@re=
nesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index a426d0aa4592..7c4507fd34e6 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -94,6 +94,7 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __=
initconst =3D {
 };
=20
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst =3D {
+	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5),
 	DEF_MOD("gtm_0_pclk",			CLK_PLLCM33_DIV16, 4, 3, 2, 3),
 	DEF_MOD("gtm_1_pclk",			CLK_PLLCM33_DIV16, 4, 4, 2, 4),
 	DEF_MOD("gtm_2_pclk",			CLK_PLLCLN_DIV16, 4, 5, 2, 5),
@@ -135,6 +136,7 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[] =
__initconst =3D {
 };
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
+	DEF_RST(3, 6, 1, 7),		/* ICU_0_PRESETN_I */
 	DEF_RST(6, 13, 2, 30),		/* GTM_0_PRESETZ */
 	DEF_RST(6, 14, 2, 31),		/* GTM_1_PRESETZ */
 	DEF_RST(6, 15, 3, 0),		/* GTM_2_PRESETZ */
--=20
2.43.0


