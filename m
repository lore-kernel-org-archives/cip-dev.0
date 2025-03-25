Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0020C35FFC
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:12 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.25])
 by mx.groups.io with SMTP id smtpd.web11.67729.1742914624262880156
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:57:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lOT/k9oq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inj6taX88+zMJI9bQwvmx92lxkjY40XM8dmSdmN7Cw4Je6oh8rucHNsHiBbrmeLnbZFAUWxCgACoUFk7DRMjeeyPA/yLLwsYx/CjVN9ddei9IX5x9k2AyERoyC8z2XXTM8kWgGZtllfISdDfuS8+w42n+rVvG2wnGLQT2rs5Al1CrOvSQVemHxgarJ7162mNazhW+yQ2c4+7P4ctp13mW5BZ8UpRCwSpyTiSNqJEAn6XmyOIyuYRWKcwoVzCnNTbMaVE3aIUndfNseQYYi2DoEWFDivzKKa2OHUrNjoQXCvFrfM2waBiy4ZcSPcFUmPKpgqVnqPk15Gmy1ZCzKZcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J8wFWiTvbtTjl/r7nAsO462XLdrKPg1+vOA+eq9ftM=;
 b=fcGIWIHL7TSsWZXfWm2I7pYKvoK4tiNtbO967HiU+NAVlfAYoqK27tAydi7w4Zqdskwe73hpUGAe1pIbeLmP5A11FwBzosyra4f7J+k5M0MURHBwB27i+uoS59sSlvBVzrhY381j+P4HiVhyYNqf6Z8WEm6Wp3Y03dVc+vRJqBn+e1RPDvkBDIlVjcjWWSz9BRvzVpm3PRnh7wqWGz7DZhuod8MfcjRoss7A3mdur0S1M8ht8hDXdvnWBmwK62AWzIDkl14ZT2AzwdfBxSF/0CNYzqQFaZt2FieeiYu8nsSa4LSM4szmAOablSBgFLLxXoFduBODo1eWserwIriokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J8wFWiTvbtTjl/r7nAsO462XLdrKPg1+vOA+eq9ftM=;
 b=lOT/k9oqA98qjUoX0HdzkVyIhnGf1Rb2pam+IXgGG5wRgPRbQJZVR5ekzgvbjaEJSa8mCDLg1Kiwn+WPKtwtSta3+ozbMECReR7AMQwox/SaXodotHvr3a3It0r8wLclUpFs4022TtJMGkV+D1LeFPSxIl5euAoy+LrbwByfUSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:57:02 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:57:02 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 10/16] clk: renesas: r9a09g047: Add CA55 core clocks
Date: Tue, 25 Mar 2025 15:56:04 +0100
Message-ID: <20250325145611.3595454-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: be46c911-518d-4328-8597-08dd6bad4ce4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y8vkrgUcb753ODeD8pVpWnUyGtefj7SaHlpKbX84MKOQRK9PDr8hWbAzJHBw?=
 =?us-ascii?Q?XvcqIQXaz+BnRsp3YtTuDN0H8p0rvxceJUIWtf3uXTm9dG/7Nl/5XQeoDIUf?=
 =?us-ascii?Q?UujVyLJx/u5W9lgw52VpIaSGwWyry0HjCImgt95AYrtyfouGNgqBwC3vRoaa?=
 =?us-ascii?Q?R6jamDpR5jV3VMhmsd8bvAkzwwVFARGVKGJhiwr35wR66QrRUUh3EzP6u2sL?=
 =?us-ascii?Q?GR3VQMJ4DCu/PwgVx7k8JsvzY9G93VamJQ29I1p6FF1dfkH7PI3xUIRcJB0e?=
 =?us-ascii?Q?6zGqmHSp+dX5KGSSIZxqx9gJVtsmSlovn8AjjQTwmhDIDnXU0t4VA5imebnr?=
 =?us-ascii?Q?v2TKRGURYnZ8fKEgpVBAuk/ZF3hLOb4wN+4PWU3ti4DguXJRNH1O2vx+YmlY?=
 =?us-ascii?Q?tTDsAqYMrcjVKCiPP1Y98HWHUvzZdYO5P1V5mV+pS+mvwKnHeGHaRhmyfb0L?=
 =?us-ascii?Q?GSURCsQupo8eSGDGLPiTQGoEFVFzOG2WvSNBzVhe5S2amFtYEM/G1nyhVabn?=
 =?us-ascii?Q?GYOcxz2yZvvNSeYEXhn7RgF1uEsWvcJY1vwUF/XwVopXhE639u1vFc1M4t7C?=
 =?us-ascii?Q?nKdg6o9SYwIzMIr713HDyXB8BAm5DF1FOEuHxl1F11iOuxVcTeiNdTYMRMss?=
 =?us-ascii?Q?57+MsY0OUWtgia0VHaaxCOdtgiaI/gko7pm+kkVLYOxtY3JdFByo9dg0aApq?=
 =?us-ascii?Q?2d3XtdUa5CRR2M2GQGNUodpKnHe0pNrY0z0x6MbbxRmHmBJqiR40lUfpyhhv?=
 =?us-ascii?Q?KtMKZa0NAEdUVJUS3ef6b7psVxxvqm5rQpNVWDffwdUqXwKJKgRO+ufqaoSy?=
 =?us-ascii?Q?XBogyMw2WQOmsqaTZtLRph+SFe38hXjrd2ZZumPJKz5QwU3E/SPOKH0on2Tg?=
 =?us-ascii?Q?lo4W8PTPvzcflTn9vY9jaqdoyahsJ3QzTtpirueHalZPUTVB/TDqJhJmOuqP?=
 =?us-ascii?Q?3UgaLKB8QHdn1VrFX8Dr0vkqmBd2ZPIDLz9s1d7WVf9+xfNYvCwvWw9H72Uk?=
 =?us-ascii?Q?ft57hHp1AWznTu+IqzpTRqknhUjasKutnbOhu36b7aQbkLMr1DwERC0PFIvi?=
 =?us-ascii?Q?pCstNgz1Wpko818V5+3zm3oDCPaM/fROuz35kAFZO0PDFXbc4b7/jpJ3ji/L?=
 =?us-ascii?Q?lKqb/cMPT6R3A1qU2MVFdABVtsl9ZiZR3DGi+YAQqAo88rSEolA8zLl1h2t/?=
 =?us-ascii?Q?xIqhbCgIIHb3yT4yjnnkyo/bUiYFaMc3xoJf5P9wal7Z+8dvRuUyWeZoOF+N?=
 =?us-ascii?Q?qxHmvcdpzsQh2oYPN4Ym5T36XWHQHeXU1IPgnkNkidWXhRK6v8XGNqSF1QGW?=
 =?us-ascii?Q?RXX8DbI9pH6AJPeWcSjZmm1xCoZIK0p+eNsWpKyrOi5AYRbwYW8lhT5v2Fo8?=
 =?us-ascii?Q?cQI7A4rjuYmqh6hWKIgOgkbuZrqhfo9PaNZrNQuh9MK7cPHSbQSpgm0Ru03Y?=
 =?us-ascii?Q?MYgWB/9GgzzEXLz4ws15GC/CG6SDIVAV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JSB0IqO0qz8OUTku3aqgLw8AihzokfDuf0d2n1YYeOlQC+TsLTynYjSSq2xg?=
 =?us-ascii?Q?4vrssv+EDDitBoRwyV5J+bSKi4Bi81OiM6Od920g3ZzbWJYKSSULX53wuFQB?=
 =?us-ascii?Q?jzrkzfWq4NKQ8l+QBYBy8oT9wBiH167i+4g0OWrNalZXRUFkXT1UlSwtMBW6?=
 =?us-ascii?Q?GZm7BG3h4eLIhWjiXMzGeB4eD6C6o27/rjPW/HzvRexFJSdDGTOdt57zly44?=
 =?us-ascii?Q?A4axw0JiI2i0ochlJfAe/PPi3zpKZdgfqMqBr0Cno1bJr3o3VYgtenjKfwCE?=
 =?us-ascii?Q?Lj/MOH40u2WwHVyXwAiKjxdOWBL0l39dnaZZVe3HzwAIMxYax6/ws+YVpDKe?=
 =?us-ascii?Q?+BpDfiVRJaQHrbslVlWMsNjFtYvsmwKYLcXLBqCL1FVlVbPpeEYJOD4L5H5B?=
 =?us-ascii?Q?vU/v2XipsyJZk+V4ENW95k2bMO9I7yXRNqwfpQgs+geRS3VTvxlT1VY771z0?=
 =?us-ascii?Q?+wxTcMWdDIp6ZWOqB58FsW8J1bnzV8TBvC5cWXfQMP+Tnidaorodlae3Tun1?=
 =?us-ascii?Q?HBlXH2oy3vqHTXVmk1hOis7Wn4Mp0iTZUsjvIuyXKDwiyYfQPe1anFoZRtOb?=
 =?us-ascii?Q?VB21Iw0xSPWPWbxMuUV2B3G38zZU3VEHMgeQQtBCPJSJQsMStuDqbELtXnS/?=
 =?us-ascii?Q?GGz0sfK71dXiJz9NCSf7eubt0OoGIBRXGQWXek1wo/BM5uoHasNPQQ7RWqk0?=
 =?us-ascii?Q?+LA0p+hf9Lmbbl5ptabUcD9dpMrsN2ilVUxXcMpfj18SZH8iFGvLQAQPe1Ok?=
 =?us-ascii?Q?mlF3V9Gps7IJWB3ed4LtmS6UyvbXWFEv4Ccvnjl/T5qTX2EsketyI7x3nzpJ?=
 =?us-ascii?Q?MdDTQmpATwk8YWpvz1Z269IL9/qYCvgvZqpii9+1nAkbhXEGN63vItg1CHhR?=
 =?us-ascii?Q?/JmXUMbBnai9ze9oWRhYWk6GX1nt3G7L94UjLPfPNME7mlFvYAk+uepPcZuq?=
 =?us-ascii?Q?hZYnzQIvr0fjwqgarhx9+GCJw6clzgXxI4toXsYHq4BB/m0TsOWK/FKgH6pR?=
 =?us-ascii?Q?BBiqzBkjaFqL7MAiSmkDLDY8GdzOs3SbMylGvkn2LDtkZ5Iz2/hLk4fbZuh/?=
 =?us-ascii?Q?gykp35+MetGGdKpQ6pGfHW098RHVCkI9NodxvsOmHpLYBhqFf4jt+mx6g4of?=
 =?us-ascii?Q?xp076j36WjQA3jb96bpBDtLE1wA+oRxNNsnNtP7/DStpp5z5dfn/c8Fq1haw?=
 =?us-ascii?Q?Z0SoReSpSdIM9W3pR4PNCpezMq2hM0ITPv+uAgC8tSxFwGFno1PUS/jyci0R?=
 =?us-ascii?Q?StwX0Gm5rXwN/5zaK7Nd8hFvPzXKsD1WUonlodBmfV1AJSK5/NJa07gy5i25?=
 =?us-ascii?Q?3i3Yk4GPiD9x54KwsIrxxKTpkZmzbEmgXLnjFhtsEOFWvHh3R7YNHTD2VDSt?=
 =?us-ascii?Q?5EnjYcb3/e6IfS7XmXICsXPoU9mbNQu/LZajwN91qNjVj0Pwm2NWD/vMGxpS?=
 =?us-ascii?Q?ooD5bvrPI6SiLEJVtEU3LjpRMictcJp4kW7pP4v6GHpPiq9Rzo5NjIsVqbrx?=
 =?us-ascii?Q?oIOTHcwPoPl9r31jHNzt+hmUoRurtvc6I/5QNKpGNEZmpYUgsfYGl7VvwaEu?=
 =?us-ascii?Q?cZB6g9WoidggB0t/pLUG4DyEQGY+2TY2aIWnC9laZ2DMFMuJURQ8vKz62RL2?=
 =?us-ascii?Q?X4tCvPHAekh2VPbt2WF6sB8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be46c911-518d-4328-8597-08dd6bad4ce4
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:57:02.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nu8dcIW8/FnocZDuSaWuMeb2maO7ghYWjPva+f8sMDbIEGyQ4IZEtw+3VrKm9C/CLrUbPYUHTyvPhb5ClJABFhE9rInioFumiJ6XgOCBJ1pJ/DfipJNtdjrIZP4zlUJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:57:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18360

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3baf0273c0627b7e6029304166df17e07c6796fb upstream.

Add CA55 core clocks which are derived from PLLCA55.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241213123550.289193-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 1178335dbed3a..f5966c08de417 100644
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


