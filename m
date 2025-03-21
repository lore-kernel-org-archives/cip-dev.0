Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70BDC36002
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:19 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.62])
 by mx.groups.io with SMTP id smtpd.web11.18699.1742554871293291496
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Q6LcVJm4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqJDnW4Qen3bQ9tVnaQlZUTRAfjZ4Ajd2DJnx9ta8VJBAWonj85EdLLMEFpreZoEe363gZTqTFr3DO87EsH361gR4j3FRLN+ZSt8MlTGZyIsha74Eqp05atRmlZDmBEa1tBnMwNFbo1Y7ePffaYRpuvBqK11Vc8TTnZc7zZCab0EvgtIY3c6Rit1rTiDQp9gLiYqRYOFH5QOpXjqhmw0PlcrKEfNpjnj30IrDC7hHPAYNt6j0ozzUYLXaKraIiR/4HDDt6kumQwCU6Qxknlm3+uLdhJN1lPXziLHwxACRlT6CDJfazQtcoSKKtzScH3LgBMyRMH2WN4EOf/QDt7leA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiOzVxFqw9rIgw1eiEkE7MEhhnDmkz05nESDGRf1AUE=;
 b=rhdx/m50GYgx/EBFUrLMKLCjAkEGygF8MEoi4k3wiFM5sR8dFRaS7e7bGfasrF91D/08xCTHRsDQNZzSRMUCJYcWST4gO4kSrWbjJOR+jCfKpmfAm0xutwPC0qCYAcPnORnoW/2+5IHLUcodiQXy7Dq15KxB37Z7GvpgD5GtjSKbP0cJQt6fZwdRPzsnUpp8rVwSFp99bezUymX7d+4vNhtnaD9mXHLjvgwHHCon9bdQKrzjXVrBDdkP41obEAwd5eDMhlIecrhHla/zEdLjCS8eobt9LS6tb7gi6d4VG2oIIUxNJBpRS0zdGbyyc/QGo4tNvse0qtt10SCWYyxiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiOzVxFqw9rIgw1eiEkE7MEhhnDmkz05nESDGRf1AUE=;
 b=Q6LcVJm4Ajm9tsrJq+iMz1iARBZllchnx6bZSYk55KGBZcHNQFGmpw/lmR/F5R2PoIO7YANvYC904YlLSQHadlxTwA9k3b8YbS8Az4IzUJehrrjzYtuohAMcjkTJ1OUhhod+c2pbhLxINaYvl5BPgGkoAZtRr8gMTADi3PDUFaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:10 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:10 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/21] clk: renesas: r9a09g057: Add CA55 core clocks
Date: Fri, 21 Mar 2025 12:00:10 +0100
Message-ID: <20250321110021.3612805-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 818e41ba-c75d-48a7-26a5-08dd6867b02d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jhGURHsjjV/w9/8+kizuhqPZVPsRr4kACvwrtjbuE3K7p8t3L3se5B9E4Hof?=
 =?us-ascii?Q?eec1XMxgEeAlGMIXKWZdku2+pFCRB5AcwY/yLhbnBPgorl+7xiSV/W9aJnki?=
 =?us-ascii?Q?yS4JkNpIOFxjwk8zf1l3gQV22mMQcNBkoABouVit+Hykm4bd2GmdEEM27ets?=
 =?us-ascii?Q?32HAzhw/ZIg4RPHJWUzt7Ui0VlhlM0hF89pgCnV8gbJG7HdhEB/VWxuEmTWI?=
 =?us-ascii?Q?uI4oZcOLU+PRjYuSLDtGvT96bSQ6Ep8PpSpDW1w+FhMNPwWbyetYuakOVxW6?=
 =?us-ascii?Q?IcWxCjtFowiFBBgAi0lS8x71DroY9QShP6jHUQIbK0pv4ymcAYUdm0OrzII2?=
 =?us-ascii?Q?6uEQ8i2KaAhR55ya730rBgpGKqQaba1O/IfH2333aFvM+rBCFfENp8oMPPye?=
 =?us-ascii?Q?bd8Qw4KsfM+oKKz2DqQeav/ohiVg0WI4myAlqTCGvSmwIFkTV9/kZQhRIaa9?=
 =?us-ascii?Q?98CX7cif9Fr/Fg4wJS5E9NcQVh1I+lVkjXLyY3QxgqH9XTk46GrntPtMurpo?=
 =?us-ascii?Q?foJKxnyAPa2fuPcjKxj25SUw9WuDIo1SNFI59PzE7avHyVkATnHGW5fzw92N?=
 =?us-ascii?Q?QJAikJUrtXolY7Q56pbe9MyL6k+pFeuYQQZwgyJTrN6XQRWJQwbsm+huE0Sf?=
 =?us-ascii?Q?Zg9lZNWnEARtgMkx4O9sgtan6Xa8NPOqaMwctDYZb/IEoq7clUkguC1fyHAU?=
 =?us-ascii?Q?8NSU3t6lq9bzoiQ5AHY4C9Su5iULcKfmZxTH345+zC/txFNlw1+8w/r7dqZq?=
 =?us-ascii?Q?QFy4BPTWx6e4OL+RVh296t57KGLuDbuiDbHnR2RMpqeqCbitZAiGF9fhvRT4?=
 =?us-ascii?Q?nIGeSwlBLN2GpsPTJyQfSm6Sz51MJI1cTLZfEETDXPs2lJ+U1eFP6bLJzxOk?=
 =?us-ascii?Q?4uM7/PSB9iygfOanTZHaRdCNwHOpemM4oVqlm5bZUgEhpIxSz5S4XoBA6oiM?=
 =?us-ascii?Q?siUVL+wXgBz9z8wYp7GYimaTj+Ju5g5PaF47Q9pxUYr1PpKPbFrpvZ4SAj5x?=
 =?us-ascii?Q?KIgp5PeUosO/rXIC3xxSjrQoKmR2T0B08QZqV3/2ZheVQ0x3ZcuHNuzdQEL4?=
 =?us-ascii?Q?j51R43UNlD/xeNXmo40TI9wkAvNq9A9FF6aXB2No13StZz3M22vsK5Q7cXFa?=
 =?us-ascii?Q?A+TpkpGv2yj56+134hbDJZuOvs6u39lzVgoXqtoI5AsdSRMVvCp6FyaAUmAj?=
 =?us-ascii?Q?NmQQribBwdaf6qySxpY9ChTLXGhtOL70ZZZbr3fY8zVInzQEpxOVS4QS4VAM?=
 =?us-ascii?Q?oeFxjV4yEbNpAiRCMFIzbvpjBGjXebUzeQFJ/4gJ4ZJ5I4Z84Nv+Z5ETHvca?=
 =?us-ascii?Q?JAbSW2lHqhy/TyNzJlibqOxXQPQCMhZCAkQ8uH/Nio/35UVak4mB7NDUwsD+?=
 =?us-ascii?Q?D827JmN4O10FpRNVP+juHnHybjrnqbR73n5mpNce2IIwnFVL9MGXuer9URlB?=
 =?us-ascii?Q?pMNz9bY4wnf8E6E1BJwAySPBDBf/mg10?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9LbiHDB6Gq9ySnkGPkHECjutWx5n5esTaM7bKJIzCsow7Ld6xo2/4J3Kb48v?=
 =?us-ascii?Q?IfxJ75lNT9vmnrP7MMuii7JnUgGLj1fBeaH4pil9iGqB4v5P/wLnhymmfCTz?=
 =?us-ascii?Q?woTNLbc1IH7Za01KLNSSwYR0kl9QTHy/rhf6twdEC0LuOUM4K3vJ7JDilGX6?=
 =?us-ascii?Q?CMNa9DpoCXuBkcZCTXoN6Ja3RdoWzXRCykgJTYg+U/V4ZevQ1Ph251pKmyBk?=
 =?us-ascii?Q?QsqI9/JD4ENA/9JTWah0ITI9Rj8X3BPTLuSfQpwCpsWBBse5i4T57jAROzuC?=
 =?us-ascii?Q?teJP4GhNU0lgh8LA2lNHHRDrSbAh8+phK1ho8Rqo4jOF43GZWX8TMJ+MeXe2?=
 =?us-ascii?Q?e1w8mx63WFPPRmmAkmJC+hiByvlm6839hK2/yuxKbRzozpkW1V4Tw9vbS4dD?=
 =?us-ascii?Q?tPsH4V+sVJYnN5WoeQbD5UE3M1RkQ7ZQ6ZqQiwzM+a1JGmrso7aELxpdL6+O?=
 =?us-ascii?Q?ybemc9HHUoyH1dwMe3sOwur8Tip82GGoXoA3g6k9Qrl390udKvpG6ZIzuR/Q?=
 =?us-ascii?Q?vcC8CeFNZRt4/DSZljgbHo4xCqZ4kv6a+HOJBiY7IZleoAjzUYcC3QR1XRRx?=
 =?us-ascii?Q?VPSdcTCMFg4esTpFT/pppQe9rVoVlG9AsPSzNsfKeJbjwRkFX5et1FLjBi9Z?=
 =?us-ascii?Q?MwlT0IHnmsn4sLfC9QHALlOFpLYwMcq2cSKQkPrhK0zGWuA6Fe5dHJexWkU+?=
 =?us-ascii?Q?KhNxkvudQglGOb455tKILaOTSJJccWJfKYnUtIZ3zRfzcq6Q+buwLIbtaZ+y?=
 =?us-ascii?Q?Xlp7CLXUS4xPI4J7T0bbMiETkShd6tzwayRjaNsWW1zRO4Mnpxhytx0/3Nwj?=
 =?us-ascii?Q?lrJEMZKp6eWyiAlpo5p+cvhdXUI60f99zRJjgcLYWIvj9bDiVuU/plDsEIZW?=
 =?us-ascii?Q?56Txy0pWXQSeJ9Y6o1aS8FtRuGebcMkPY48CLKDRaDcSKMQjoSJpUeyLcF1f?=
 =?us-ascii?Q?m6qTbQVSrQr+hY5pq3upr7yqRlLLGkCbeizB0QLqDs+t6EXvd06lhutMnKer?=
 =?us-ascii?Q?iEjQ7xngSNMelfbpW5ocAj0RweU8J+sd6ap/kZlj/RNVq8Y8SXgvhb0WxgJO?=
 =?us-ascii?Q?MvJbtkqJCIokETAIEmLkjMGoWVYURgaV0QN32sa84P7aR3d+fNiHuRP6ysii?=
 =?us-ascii?Q?i+gHf2rbK5B/9HLTIYMlqGFf+jDYeE8aXbOwzg1VoK/D5zE73fws4VjjkELv?=
 =?us-ascii?Q?iSnYY2qEoBNKwj75np1Cf/DiYuz+h36W/4byawIgtnMpmB3gSqD+ohjW4FW2?=
 =?us-ascii?Q?u1/HoGvz0XOfv9u8iVeTWavH5Uhm7SsFZa5cehKmxqQsSARyRCbiv35OJmsz?=
 =?us-ascii?Q?YOCh2DmP2QRHSZZoficZU5HYpq/B6C6Y6cEsDj8nFPIv7ZNKz3maZDSjzkpx?=
 =?us-ascii?Q?JlEqBY3khbobP3A6DhSuTZovH1wugl8gQi5Ulec6X+6WZiLfN3cfF8H5DR8N?=
 =?us-ascii?Q?AnKNdqy7hX8135k7B1RxoZuDnObeL8MPOcBIvy1hl8t7DJYs/MaYiVMP2RBO?=
 =?us-ascii?Q?s4BUiJfBimLW5+jjiLYJzB3Au9wG/3rrj2CbddI8/wYAMGfTg00w6xXC3SsN?=
 =?us-ascii?Q?8Kq9Blmf6GGxH68znSRVBN3/1/xFYk6atFlnsoMDjRTXz6l3LELhuRSH1gup?=
 =?us-ascii?Q?EPjRcgb2hVr8wb3+5hGSZj4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818e41ba-c75d-48a7-26a5-08dd6867b02d
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:10.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mC1LHx9TpGL68FKQJffuqJS9WSn8oq1FTna7JPvf025XKb1mjxLe68cAnJn4YMvguAu/g8lzKAvH0jsYbUD7FHPllB52ZUVqht2V0u9ezFmZho8PFwc3b88sGLptDKA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18317

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8cce33aed0b6383e91bb9d26dae11b1293101381 upstream.

Add CA55 core clocks which are derived from PLLCA55.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240918135957.290101-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 16 ++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 3ee32db5c0af..a426d0aa4592 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -41,6 +41,14 @@ enum clk_ids {
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
@@ -74,6 +82,14 @@ static const struct cpg_core_clk r9a09g057_core_clks[] _=
_initconst =3D {
=20
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G057_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
+	DEF_DDIV("ca55_0_coreclk0", R9A09G057_CA55_0_CORE_CLK0, CLK_PLLCA55,
+		 CDDIV1_DIVCTL0, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk1", R9A09G057_CA55_0_CORE_CLK1, CLK_PLLCA55,
+		 CDDIV1_DIVCTL1, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk2", R9A09G057_CA55_0_CORE_CLK2, CLK_PLLCA55,
+		 CDDIV1_DIVCTL2, dtable_1_8),
+	DEF_DDIV("ca55_0_coreclk3", R9A09G057_CA55_0_CORE_CLK3, CLK_PLLCA55,
+		 CDDIV1_DIVCTL3, dtable_1_8),
 	DEF_FIXED("iotop_0_shclk", R9A09G057_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1,=
 1),
 };
=20
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 60016b6122a9..0723df4c1134 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -32,8 +32,13 @@ struct ddiv {
 	})
=20
 #define CPG_CDDIV0		(0x400)
+#define CPG_CDDIV1		(0x404)
=20
 #define CDDIV0_DIVCTL2	DDIV_PACK(CPG_CDDIV0, 8, 3, 2)
+#define CDDIV1_DIVCTL0	DDIV_PACK(CPG_CDDIV1, 0, 2, 4)
+#define CDDIV1_DIVCTL1	DDIV_PACK(CPG_CDDIV1, 4, 2, 5)
+#define CDDIV1_DIVCTL2	DDIV_PACK(CPG_CDDIV1, 8, 2, 6)
+#define CDDIV1_DIVCTL3	DDIV_PACK(CPG_CDDIV1, 12, 2, 7)
=20
 /**
  * Definitions of CPG Core Clocks
--=20
2.43.0


