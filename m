Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F61C83F04
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:37:53 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.38])
 by mx.groups.io with SMTP id smtpd.web11.20594.1751452672352793971
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:37:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FYG/bFOR;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXzTrXo4mpnMZsr5IQ0QOfz7RZ3HV/tmMIjzlndkjVLf0jbGME0A/hdO94k6TtQR+TYzR8dLQNoTyYTI77Fi+oLgbsaYAW2gfS1M9imIesFWwiZsBaLFabGSeZdaPd2nFEtGlRUZyTDT7HJFlB8uh2dvxCgq2Fkx3MmjuuUNxjtXp/cxUL5YKV2u2YL8Gex5I9oFk1xqFYlgBRnJJhTxY+icHMQfv5C7Ef6pXzzW/dT8s6x8LAp/KEQo/dj+5UZ3ZpRTNrXCYZoOv07aF3s88l032idJDe9/h7mN6xbEaxfzxd+lKBT6VE1XGjwYhPiOflmLI5Gooufj+g7zhmiERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vnqx7GDogiXwCN8YdhxZeSD6w75IBgFf6G1JpKm2vwA=;
 b=y0FpJ42iAmDphC2CqLhdT604lRWvLkPLPckufgZ9/l3M0G28WgqlPae1r5ONI0gbC3+rqOjewwRknF3Xyj3wXYjW0NtRIZKs+Hf1vXSjcVkh9vD789Fex2U2bDIVh56ljFlzrXPfoj1IqYtJ3TnFJHphZiSFo8JVm+QU6EG8DW08WebfsBRuQDKMtmr97EGWnFQb5+rzftgt1KZeaYQ+Y2uYQGCL5U0V7YuC0W7pZBlR6AuhQX8u4LxP7UvZmlpEZa9arVuB/noIk3iUAJs0+FJN7cCVvKmAeA7FmzOxNBZnVXNsry5tIm1+cq54jE8gLpuHP3FtylwUUBxVf49A5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vnqx7GDogiXwCN8YdhxZeSD6w75IBgFf6G1JpKm2vwA=;
 b=FYG/bFORT0ovHMVM20F36YyFbfWet3sZtW5mQzLluYghsbQU3k/ObjN/ji+Yc5vUXlsZ7P8zLi12FgTDZq9WQS+EPnvKMHAAUC2btXuys5dufEFONiNXFRanM+AW8aID75sMd+U+TCyZzVOTNwjp+M4OJ/D/ntzurjztR3n5z1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB10187.jpnprd01.prod.outlook.com (2603:1096:604:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:37:47 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 06/12] clk: renesas: r9a09g047: Add clock and reset entries for GE3D
Date: Wed,  2 Jul 2025 12:37:04 +0200
Message-ID: <20250702103710.117760-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ae9378-704d-466f-1a03-08ddb9547bed
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Xk8uUbXtsVnCVlHs1Qs5U36qJr7JrXbFJ7sxeJvFgoCiNGhvGdJrYcAAcPyy?=
 =?us-ascii?Q?GJevCuQ9xIcAegu+X3nil8nwipBMKfdtwekExQXi1vzywaMGaRuBJp0r058W?=
 =?us-ascii?Q?fwV1L/YAd8C63EMgaU8n3YVxWleF4VNgN3dSnXrNFD4kIkVAdGqRgXARgnMR?=
 =?us-ascii?Q?0DxKlDhuMr7Mvj39zI0NgJCgjKnDwx8ALxaJiH+bfTf0VcHaHQfYk1qMp9LG?=
 =?us-ascii?Q?AdoZDQYJp5szrsi3i+OjsOOulXk0LFmKkqQvgpqkEYrgsAesCKHjn1BKCd8k?=
 =?us-ascii?Q?Clu4sJXFXBWB284apZe8yabw/lHYWdVcE9m87C0glo1emstRJS4nwlIbJkqH?=
 =?us-ascii?Q?X70ZRo3NK2hWVfb2PTF92XgIT5wReW7z13E1n/c/4hTm/EDhVo+Uy1bR8Rwz?=
 =?us-ascii?Q?8szvCbN7MC7MBIYI/wNgA6DdCDppDhSLsZBVw3pYtBWZwR/jmKSucCtHOINz?=
 =?us-ascii?Q?m1a+LJwHIYgUTI/HELTZxDtpBQHgpOpnu/br3IdDI0aiivrNOB+Os2a3ZyTv?=
 =?us-ascii?Q?ZPhqttAN3ltpiYqmJAJ+7YoYQbA5y9Wpw+HCc7gtE3072k7oJ8+G3zh1CVYU?=
 =?us-ascii?Q?L1Bd+1IgzyNp5nFjEfh+sg+865C2BhboGfoRcqRXACZNg1GSFd255w+Mr+86?=
 =?us-ascii?Q?gWECR6I0QR+8B2BafqEunVkVMqSdQuZz9xkf1wc+vlrDakzvpL5DyQ9QMjDz?=
 =?us-ascii?Q?5iyrHhTFz7KsgZ+G7quN7Lj+oTOCsUzmzDVPZEWSBP5yEZ4TgPQPafIINZVh?=
 =?us-ascii?Q?blJE1ZFQ0y1RdXxe0s7lqYwJ8enkFRh9SL5+UMoBXyVFt9JNCziRiUeCYCaq?=
 =?us-ascii?Q?CANGxJnhS+/HPlLB9A5lFknsbUmjqs9Th06p43SmoT9zoEz40cbicwQf2zZV?=
 =?us-ascii?Q?sFdQXByYfe64Noy/nzprtUcw6jBaNq/nyssIX9oNug86qMBZ422piAgj4G9s?=
 =?us-ascii?Q?y1W0j+uSeqgdLLSAq7wSATQ/fW4J9nb2f3lnKGr8MPwMujEi6LPekExv/7Ec?=
 =?us-ascii?Q?hjj2Wv34SBxf/XYkKHCoimuQ3Lre9b+nK/JjR+XLotylvMdTRxg9PrRPdAqN?=
 =?us-ascii?Q?+rhCSVk6jOlk2BYetypc+pg+IUItt1QTpz0wLpn361y1qW5Y5ZFLj3F/M7Xo?=
 =?us-ascii?Q?jdeHFQPApWID3Mznv9T9LXaYF6XqChvnDzW36ToL91ecL9jHUedyhUdgCRCe?=
 =?us-ascii?Q?Wq5Ut/sBv+C+bu1x7wR+m8dr9gQr3IMy5PPatVyA4uUtek0HcS/7B0Wy3ziq?=
 =?us-ascii?Q?7EkZFa3jim/YMOhp2WatOyVJ1ztcnjT0iMMbsGcJiPLGQ1aZT7y1YMZjIl6j?=
 =?us-ascii?Q?xUYkQ48VuyhEPFpwiXepzhUmOxgYzj/D18QDn7oBsZ0n2wv5nXw/Pkft+jMT?=
 =?us-ascii?Q?gW1u2mJIz7SxFtE9b5HXkbK6RxYnBC+dTLz/myXwo5fYPdMBPGzvkY9jpUI9?=
 =?us-ascii?Q?gssrAjgT8aEw4m5Za2CqF4RSVYiBm8XI2NY8f6Y7sLVma5dv/aSOT//vhCmh?=
 =?us-ascii?Q?ludbBxHE1/QW4G4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?izPo/V3BfXGgOzyg0u5umraO7kx9LQzzGHyA/Emj8J12X7fbFZAxGe3UeW8Y?=
 =?us-ascii?Q?pmueJOnB/iSeWudDdnKMQR/8bPiJStKFj6vBcFI19Ngf1X6GpU/uaTJhhgx9?=
 =?us-ascii?Q?KQ3dVZc4w2WqwfRVSZLfYJO3ZgYGYev/MzWwazpCyBFJ8jeSRD181j1/uQe8?=
 =?us-ascii?Q?vi2pK+YULg8ICjoRH2W3ua20YCqwcpfDDgBtaf+p/QHlGvjaBrDyFBW/kggH?=
 =?us-ascii?Q?UhH5HHBRZaOKTX/FeFLnsCDoKSY4psyoohYPmRPuYVTabkR8HqZ7KsnVPMbe?=
 =?us-ascii?Q?1Pfh394x8u3lK0HijEfHjSgrQtcAlz0V8beEn76PpTMevMSAlXEvGpn2wDqE?=
 =?us-ascii?Q?MMJof0ZW/uOESExWDhLb6wfDeTF45+gdLyrFTw0UCWSYoDNc/PhoXlW72C8i?=
 =?us-ascii?Q?nBqzjynzC8lxzVOQGbIiXVSw7cjwHpCGdpH0foIAk7lBmlKJfktSAix8v9G5?=
 =?us-ascii?Q?PAlxL/y8tTak28h9h80bq6mxSKDrZSSXGa3RLAThT+BsvBOTqW6Fyrugp0dv?=
 =?us-ascii?Q?lgKwy9vuyuxJRNBQb3ZQ+M9i/Lgs9mTWjZZIGLZAaqf1kJmRLJ7nEcwmHcqZ?=
 =?us-ascii?Q?bpARnHfukViiUCAlK7UcDmcWs+RCbj7lNgjRuB8YV6ZTqhk7VvqEsHqyb8x2?=
 =?us-ascii?Q?l+znthooG/picjXdBqGmxfD85idyKtsbUDH2dgm4pyBKDxiIDTBif5rAxU9+?=
 =?us-ascii?Q?BaC2TdS1ATLB+rSxsHgNVVGnC7cA02GiefdE7n4EDSKTKYEVv0gXcPPL9xvI?=
 =?us-ascii?Q?FWR85D7H0VnjTFTCdXP6GiujjWfh/pTYWzntp2S+U3JtjUiDYkq7xnIdYQP/?=
 =?us-ascii?Q?QTkdFjaIl7C7EWXQU/tsaKLLPe91ZZST1P1be73FyIyvoiGicUN6JBRJXeay?=
 =?us-ascii?Q?d/r61Pz2SwdYMIRhnIm9w0fACx9qVy9Jnwu8EOLyS7Nip86SbStclH+Dn4qx?=
 =?us-ascii?Q?CwWgBlXwnhDl4pI1vlQ5NVsoZNlCsqjy60bOg6KvB6E+upVGOrFwnp7i9vNv?=
 =?us-ascii?Q?uNx6W8iESmKhFd0HwDhVv72hyObsaXSLnZy0GbV4P4UfUBORXrDsHapabSQN?=
 =?us-ascii?Q?XexvXoPYjLOutQTWJIrQbh40GFHHzjNilPbXeqkjYMj16D7OmcGNvFE4RZpT?=
 =?us-ascii?Q?FKN3vI3DCyf0zNdXYk7RR8/KWlPe7gF9L2xh9ObewrqAeRauW+ClWG5BNuWq?=
 =?us-ascii?Q?/a8j7kU1nBzYlUFbyjCEzgtIvQAD5KwHnVrdicVBK3Mn/x/xE9ZnDJHc4w+X?=
 =?us-ascii?Q?o1p1WzOeWc9dRDWz0H/HG8nihR5zPLAAz6QnDR/EdyV4z9VfJdsZBBG3LrAu?=
 =?us-ascii?Q?nUJRABfyugBM1oO04fIwQRMbzgVgMJvJqLCaRK5h5MhVIEhsqIbTFpMWFbwl?=
 =?us-ascii?Q?7GfmurzTFPxA4papFE1Kg8T3C5oyhxL4vs/LfMIXWRsXfjtYMSqtsrnN/9f8?=
 =?us-ascii?Q?EK2O5wI4G9rWcd/ZOnvhRvy30+KYXGDiByxODtHQ6JZp5K5kHE7zuakH4tgA?=
 =?us-ascii?Q?LmtfcoJhdIYajbZCVToLKwtjbXwgqApw9YBJSbYwh/mr2ubbMpAKJjmtR9iW?=
 =?us-ascii?Q?PGTDxxxRv+Of68LXHSLp37cbl13Ju3kaaLAWe6SPuD0DKy9uPxWSEwkx6OKm?=
 =?us-ascii?Q?Mv6LyghFQ+w4GfonPRrgSwM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ae9378-704d-466f-1a03-08ddb9547bed
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:46.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vc/1hYwqygWzymiuwcBvezBMopfIPPk4OMNNd/1RflbdlCVyZlAHJjqvN3UilZcjaxaqgbref3jNKPpUUR/43MNBmXUoSNu3a5ji2ZLWC56gL/upUYDpRfeM2XzBLBby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:37:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19304

commit 9375d704d219006cc97b09ea0e93076655cf77d8 upstream.

Add CLK_PLLVDO_GPU along with the necessary clock and reset entries for
GE3D.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250402131142.1270701-2-tommaso.merciai.xr@b=
p.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 7b9311af603e..88a5a1c24ade 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -41,6 +41,7 @@ enum clk_ids {
 	CLK_PLLDTY_ACPU_DIV4,
 	CLK_PLLDTY_DIV16,
 	CLK_PLLVDO_CRU0,
+	CLK_PLLVDO_GPU,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -96,6 +97,7 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".plldty_div16", CLK_PLLDTY_DIV16, CLK_PLLDTY, 1, 16),
=20
 	DEF_DDIV(".pllvdo_cru0", CLK_PLLVDO_CRU0, CLK_PLLVDO, CDDIV3_DIVCTL3, dta=
ble_2_4),
+	DEF_DDIV(".pllvdo_gpu", CLK_PLLVDO_GPU, CLK_PLLVDO, CDDIV3_DIVCTL1, dtabl=
e_2_64),
=20
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
@@ -183,6 +185,12 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(9, BIT(4))),
 	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20,
 						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("ge3d_clk",			CLK_PLLVDO_GPU, 15, 0, 7, 16,
+						BUS_MSTOP(3, BIT(4))),
+	DEF_MOD("ge3d_axi_clk",			CLK_PLLDTY_ACPU_DIV2, 15, 1, 7, 17,
+						BUS_MSTOP(3, BIT(4))),
+	DEF_MOD("ge3d_ace_clk",			CLK_PLLDTY_ACPU_DIV2, 15, 2, 7, 18,
+						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
 						BUS_MSTOP(2, BIT(15))),
 };
@@ -213,6 +221,9 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
+	DEF_RST(13, 13, 6, 14),		/* GE3D_RESETN */
+	DEF_RST(13, 14, 6, 15),		/* GE3D_AXI_RESETN */
+	DEF_RST(13, 15, 6, 16),		/* GE3D_ACE_RESETN */
 	DEF_RST(15, 8, 7, 9),		/* TSU_1_PRESETN */
 };
=20
--=20
2.43.0


