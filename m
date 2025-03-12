Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A98FC35FF8
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.58])
 by mx.groups.io with SMTP id smtpd.web11.34792.1741778662697058548
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Y4UMGHCa;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.58, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psULB4ZuKoahYYj96kMEiSRKwya4D6M+IgKTNU69YJ1/0av6R2MjGPtoMlulSHtgbsovzqZ7p7yVR3+aYwzh2sJfVjwyQaq+Y++D6kE9EtcsZ1BEdcVBc1m8IbvsQDysxFd5TojUU5CwrCVI4GEnr9wO2fxNKo/wdfszRiu0vsNCo91o3CyKHan3OBYi7GqQQ/oQIi/WiGHIP4LOxYvinQNkgrG3SnXOeB54YROC2801mOH1IWU7DlElkr5Yc25rx5zQhT1Qp8WQbflk4Ez9Cf9REnH5JJL8nXxz9WT3GcdsAwg+w+vDq/BskmDS/1u7BKbjkqr6n211aSufLnnxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCnrkmmrJodcOQ1s1EP5iL7gULoXB7bGGtJtZpkwadU=;
 b=d9/gHGYfEGyIi2kimoDA1za2P6CQvp6L+gRz1gcBsotGDOOfcHJI4YRxcdQ3P9T8kXRDLDQ5WGHmfT5szV0+fpgSiaorAF9OFTIHkm+gLTfa+yrwL595FiuNtUoyegqukijTpp4BBqLosVk/HPD6bmWEuT/psRG8r9i6zVjJhy5FJIs/yyf83ySs/ibuHeka4qsBJoXLv55PET6DYSU5MuYynhEuwijM+a117tU4pPFJNX/NIK1pnT99t/DXfCgiagte6yCmgns/cUbQlkGgKxzXCepv7N1lWZ7oEJYDiGGnL1UpBd6JYztnufe447ewTtquJOYbTu3MoxwIHP/b7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCnrkmmrJodcOQ1s1EP5iL7gULoXB7bGGtJtZpkwadU=;
 b=Y4UMGHCauP5jYMYJ6X9XfkVbyFzVXJ3DEnMEvmvqAbh6Ug4deuYCvt/GBQDiey4I71iQ2qnYkmciqOfTQp7iMccr9pDvyLhTmIq+13UdFW09wRdNt1WRzBwOQk4Tzk1BXIyAD54nFa/zqgaR2UAe/np0/bRDNIgtTN3FExSaCjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:20 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 15/85] clk: renesas: r9a09g047: Add CA55 core clocks
Date: Wed, 12 Mar 2025 12:21:52 +0100
Message-ID: <20250312112302.1605750-16-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c719ed-06d6-4777-4be2-08dd61586f2b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8HdQYCNbFHljuWVa70gY1D+H0zOUxM4/bSWEbo+RTr+Z9GJn++qKbxPDXowT?=
 =?us-ascii?Q?xmdo6yaTgzRG01c9pYc45yqJR9pIvg6mmZO2Y7P1iloLMUDP+wq5qC7gCNeS?=
 =?us-ascii?Q?Kvu0P/Y9EGH2RK/+viJAMFupVDmd5gWxEydwYBiUVjlxYs/FFl20+YYbyK7I?=
 =?us-ascii?Q?FUyR6//6iNGRCJfx2k2JwK4hNyx1l6G6DVRy9rcpnmZ7+S7tQNAhw4AMmyJ3?=
 =?us-ascii?Q?F6PcnWsiUOKCFlbq+RHstQy2rR62xExTWZIH1A865BGVP+Unn6X1WARxjJX+?=
 =?us-ascii?Q?3a7MsSlyl2qLjEVb/yRctkkuAkjXcPXz/eWMg2TleMnSc0J4l8BKOJxP+1XA?=
 =?us-ascii?Q?a0Bfz+lRpM7KxyfEfo9DCwzVf+PMPKi3qia2irRIzeqchzbYGlZRqOQRy61z?=
 =?us-ascii?Q?fKtTnIXSCYMndF6qNuNf1rlwigsY5BHofYZWvJrj9TaOBiQOBk8qkCAF+BjX?=
 =?us-ascii?Q?n1ik5hUqdd0NQhw8wZyj0HRyJ2bR7B4NPTrQqLFSfeRdOxQLea4+yYtBq/04?=
 =?us-ascii?Q?sNoKisyPopXcwiaVvou3Y+lVFxtnN0T3LEHwRhJCO5VsX4MSyGH0y9TrlW3K?=
 =?us-ascii?Q?TUp5nlIx9hsnanmGy1VpuxTaEwfUHn2Sq9+IVZggxPmS7qH6ifD8HsdlnF9I?=
 =?us-ascii?Q?Uh7/nrZqjkhG2KLJyunmFsZDWrcXMrmfnzLsAaH8y6EeTFihAKAhoreimywk?=
 =?us-ascii?Q?g/eKa5Edfs1749OjUrlxVlHVh7i0iOG/tHhDDtNugVdfIMAcC07kkB8Iof7B?=
 =?us-ascii?Q?5T0bsMH/ZvEX/wBD/fYVZCiSx0RJKNYiSykmLdjSbbOhWVQTpBZ+k3AExea/?=
 =?us-ascii?Q?NLaf5VhsU4vO2Vqt22AKUWKDOMzsgGf1+w9AJmt9JEI2uJyasXjs6C6rmsvq?=
 =?us-ascii?Q?3j3bVXDUVekbF4X7JxV6qiS7Grz3nXivpsEA3GIltvHfVjFWNM0lCxiv6dgm?=
 =?us-ascii?Q?Mb7huA2fSD19NH2uUPRUuKAciuUS4b0stGx+JOVf+BDpD0+zaTQNtUXHyEHE?=
 =?us-ascii?Q?5icr1QP/gIH5f0SeerU9TNcRuwxxzVhZqsAM1s+bG2N/FZ079XNO6VyKHyZa?=
 =?us-ascii?Q?kN7QDcWPwMXWdEEBw+zKBgTKZH7kPpIjG0kmAASYfhQhHk3s1cVRCauNm7F8?=
 =?us-ascii?Q?c76VTGVWyBCLCIz6/l2cvKBGQUfwQ+g5gpypv4ARrVqfDaxJW+0CBlnG3aFr?=
 =?us-ascii?Q?I/cGMU+JQJzZweHQxKReQ49pqpTTm8BFenZfNVbaEpy8K6ijE/Y3QTWjVjZk?=
 =?us-ascii?Q?BBnyDMHVwAanoA3uK/i9nhinKFQulTDG3UN7bedwdUrJgaOF6keYRhheR/rl?=
 =?us-ascii?Q?MRr1Ua7Ud7it80Vt6Fe0HljBVDMgrhE183HQNEW13hsZP/AnKHniVh1bf/XB?=
 =?us-ascii?Q?sT9/AMfiLjSNLhSv64/88wcX8d1clh+sebmfl2ioTOQx4WQMsUAbTKy+H4yS?=
 =?us-ascii?Q?IiP5VAMbPQ4JghmHM3TIckkN/zSN8SVQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WNfNO+OA19Fgu8ZqeITlZ8yf+ufVqH9Bvkj/GGvb1Kvr+5ZwJy5H14U94I0M?=
 =?us-ascii?Q?BpKMMBrguPkzeo8dJiAZyZis2fcZGHcwceQ2jbtgmXBockRDt1iwbRpHnCBt?=
 =?us-ascii?Q?Q8E++gqz8CrNras+fKZ1WcFAdFojPxVjeFu2EWEqrm45SOFYvuxHmbf/4ssd?=
 =?us-ascii?Q?M+kKXblFKeyJEwVN7Nc00O2N7wZ6DqLT1jowOocvfOMZxjUa3qqy09JZTOPZ?=
 =?us-ascii?Q?pm7/CZJrTGyrenhbOK9TCxY3MH42xb+3XuIogkfjnHC94khFRxgF6oRra/kf?=
 =?us-ascii?Q?rZ65EFT2qinnjetlojKLvlfafsDTUn4QYKyKQSoRg+7nnxM1s26wem1udvr0?=
 =?us-ascii?Q?fHPU2H0ZazFsSXUS1VuBDh+YiMWmwxut/h21TKl8I/69dsA+Y/rBHSmixL4Q?=
 =?us-ascii?Q?j+zrx3h4eEZ86iDQrECEo5iv9H5pMtKKUDqtBeKC4T8kQsaA7ecujr9P3609?=
 =?us-ascii?Q?bYL7UW5sOJeVF6eQMce/KYmIR9FBHWxUTEIYEPMP7UGNgtknLZGUjVzOLrOC?=
 =?us-ascii?Q?UUFaZDz+goGwTptIoaOwAFHwTLUz/YhCiyw36Z+Jc2/OLdSScKw3UEJ3ey8X?=
 =?us-ascii?Q?bN3+fQexPzDl/jUETo1mzLdn8WM88SaS7dtETzE4JOfxjodWCd3olETh+Fyr?=
 =?us-ascii?Q?SqbeJhQjMLV8ielj11+o2AJQyK4NHC2R5TXd8bixdKmuY/dGp9Tnsi0QJqs6?=
 =?us-ascii?Q?oLV54wRkO2RumMV4xtTTxw8IAai0Q/igOsPic1URa9Rb0XBJEjv1OLDqEvdv?=
 =?us-ascii?Q?6ClIt9omEUBbf4sPeoCnRg2faCFJGFHC82xR9mPrjdemSdgW+UkzPdygCKnN?=
 =?us-ascii?Q?QZfecsLHMqqqql9kt9m1hZiXgK34/8aqkS6NcUXqzvZRdbUCMoDw4FQshSZl?=
 =?us-ascii?Q?lSOrwCmoSHqAmC4bn1F4E6BboCz7zDS3AvBx1FZUC7bdWiG0tiPhsgDLnoQ5?=
 =?us-ascii?Q?qCw2aupjc3MFoMtl92jTyrY+NT/J59QUEZTlWmzB3lDNFzahKyPMCgiBNIzw?=
 =?us-ascii?Q?3sTEsWwRhky2uUirlxqcPY4jJQU+q04nkVDSiYNK5KPhSgsimTLnY9GX7fVC?=
 =?us-ascii?Q?QpeMjkBZvKNKRm6+L9FQXD2Z3gGJKoBOXkAQ3vJBFRQkGwhjQqDsl4/Oe1M8?=
 =?us-ascii?Q?sT7nGCF+JW76XKuIVMjPQ5/CmyVs/Lr7sdZeSQqiJGrkBwurCYiCZ3X5jb3V?=
 =?us-ascii?Q?bLTvayty+/I5zY/gRAaj6KWtSweEHgj2MWRxpvPqZBblcYK3J4T5/NZ5rwGp?=
 =?us-ascii?Q?9/grlkKGBLj+M4fNAz0xjJRsz0d54oFcDWRgGYnLEhIqAawB2f/2G6/gf1UN?=
 =?us-ascii?Q?c1MF3Ogayy9d+IhLW/VvreDsXoiXqSbWo8Ptyzz8jsuFboRCjChqQQTp0YrY?=
 =?us-ascii?Q?LpWrzIk/rUFu37+GQnS/5KZjIE2Tp2/yGsuIzbxwfpO6CO+4/rbq7cANnIZp?=
 =?us-ascii?Q?8Ut47ig2ze92XCZljHbNfFz2lJoBrpwGZEkwH40Fkdzo29bvKJd7z78SS/tM?=
 =?us-ascii?Q?Do/izDYtPQ2ejRkRzHQHvoPflEVSnmKL+//aPYD8sYbhmkRw9FKxPNQ4cLVd?=
 =?us-ascii?Q?PpvppXP+DWQnUTDoV6KvzUXPDTPukBUDn6NBqzHSPNXMxr1XVHvOrhGp3lc3?=
 =?us-ascii?Q?/MQCJMHxdi9kWgXXIVhz8oE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c719ed-06d6-4777-4be2-08dd61586f2b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:20.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdanhOuRsgrjSLEOIhdT9AQAI27MsuJ7NHPnztxA/oP47uB1Ek70++jz/Ijiu235vE2VgxBm1nayi7N9BSYplzCcyBts22roUEjBV6zmB2ZG2oIHWoFkF5Nm7yG7gLoa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18107

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3baf0273c0627b7e6029304166df17e07c6796fb upstream.

Add CA55 core clocks which are derived from PLLCA55.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241213123550.289193-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 1178335dbed3..f5966c08de41 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -37,6 +37,14 @@ enum clk_ids {
 	MOD_CLK_BASE,
 };
=20
+static const struct clk_div_table dtable_1_8[] =3D {
+	{0, 1},
+	{1, 2},
+	{2, 4},
+	{3, 8},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_2_64[] =3D {
 	{0, 2},
 	{1, 4},
@@ -65,6 +73,14 @@ static const struct cpg_core_clk r9a09g047_core_clks[] _=
_initconst =3D {
=20
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
+	DEF_DDIV("ca55_0_coreclk0", R9A09G047_CA55_0_CORECLK0, CLK_PLLCA55,
+		 CDDIV1_DIVCTL0, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk1", R9A09G047_CA55_0_CORECLK1, CLK_PLLCA55,
+		 CDDIV1_DIVCTL1, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk2", R9A09G047_CA55_0_CORECLK2, CLK_PLLCA55,
+		 CDDIV1_DIVCTL2, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk3", R9A09G047_CA55_0_CORECLK3, CLK_PLLCA55,
+		 CDDIV1_DIVCTL3, dtable_1_8),
 	DEF_FIXED("iotop_0_shclk", R9A09G047_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1,=
 1),
 };
=20
--=20
2.43.0


