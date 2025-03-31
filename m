Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89280C36014
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.63])
 by mx.groups.io with SMTP id smtpd.web11.48815.1743417990206988050
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tJcWfy1r;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.63, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/AmVt8689ibxnOT42WD4+OgLDfLNrV6dmSJemQ9PWo2SIaLTiop1S5hRKlKRB53CAfJfy2N7WzA64KpxyUWmcANvIB2WlngBsSC0+1EZb+LpYCFBIp5N9I93Se8KY5roUKejSzkg5b4CVCOTY2zMFyjJJ/dmBc2SF4DSmTj1h91dHggfDM/jOXrZskdE8qqmSht80ju3fLwQu+luOgJ0816ARfT1I+THPzlP3p6nMNCe/W987QpwRYmFSFaGtLw1K9fXVQ5/6zQHMF7fxizxH2aaiHZ8DXd1Eq78tVtXtao4GlFyQKN0tl07Fp9pdYmgbErOWBRem0r7uRhZ19IBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3GDNQqD7JEkuuTa0wsyqPLVyWpt8zFDwfKY4INbhDQ=;
 b=GvhSWgSHmK9R85J06oo6cf8eauA21yG4O1TIkFyFRCYVl4Eb06g1G1MjuMj0tW6LHeCeRzsJF7mXYxu/4FyFgCE1z4sZdzrTOt5TIkJyF0LI0NfdT6CdAqIDCS45UCJiKQqtg6WxcoW93g7juZSBvgXl4YqsT3JAsMxLbVfHqD3+gBqKFCTBhJvI8SkPq1q1+yj7nfMRPcQai7cHAkYgGZU57rDSYMqKfSSdqQZssaTwjx73hPORRoAoJpAQ5CnbOue7BSF0blKt+k+6Ym89Pxg17ZElARDK2FXaLL87dAbiLCo3nhHot0YkdqFFWT/JPEEbBv4Co4//CVIz9HDQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3GDNQqD7JEkuuTa0wsyqPLVyWpt8zFDwfKY4INbhDQ=;
 b=tJcWfy1rtTobz/k9lUhchphIObvKJRn+zx71GfSHulEDc2rvABKpzRIhSKEaHnnRJak8LybOVfCNbbWZRTb3JMTNesv0ItSmPBLfjnHYhWV2uESB1kSi8fhUhZkS1w83SgxYalyHcQu9OHVnwMIhsd0G+GzkI9ZV9I64qqMRAzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10032.jpnprd01.prod.outlook.com (2603:1096:400:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Mon, 31 Mar
 2025 10:46:28 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 19/43] pinctrl: renesas: rzg2l: Add support for RZ/V2H SoC
Date: Mon, 31 Mar 2025 12:44:50 +0200
Message-ID: <20250331104514.79090-20-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: d439138e-4f97-428b-5011-08dd70414a68
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EhYCpth+ATXSDmzQF52vxEi7NOGK3GbPPSxUt9G/f8avzi4fNN6nkjMpZL91?=
 =?us-ascii?Q?yyhAQVxUeFWuoHEdoH8Cg9XlP+vIOXiblACry28Jhw8MFSEBHe2J39Hq9CUk?=
 =?us-ascii?Q?Lu9y8pD2a7Erhkpn/d/Y9yAvUAk5gpMv7DwXmz/sWrVGN98hXFRu8Y//5eJw?=
 =?us-ascii?Q?2CRAgpNQ+L5Cr0exZgrxSeSW8CW0V07cU7PH2k0FzZKLwCibj/ojcGhsKN2F?=
 =?us-ascii?Q?J2fgvTTUZQ2A8EmwQJpqIQ5oVT0orWXmt2R6vwV5ma4oxVwL696H/S+t9+ji?=
 =?us-ascii?Q?gl+I3cNF3Z5l+qkQeUaZeBgnxsIUhxLcuu+3+1x7BSJoGzEE+MBtvNRzZz1k?=
 =?us-ascii?Q?H3OuaMW+NKPLW3sHAi971oIRlkPLEua6Enm3psjbOk8NNKVlAg3yQ+ZtOMTj?=
 =?us-ascii?Q?360kyMa/bJ+Ej0ZC+S0uYz9VNM0o3baxSs0ks75wtQ+h9wjet5RPWEo3W0fH?=
 =?us-ascii?Q?jlhHHCpaql4CcvRjQrzJKcecd9M4UzGi/ex8UXFqg9kWa9ZmywodNRpqG5JZ?=
 =?us-ascii?Q?C63BT7RYtMHqZFpjqM464KoKM0sLP6T09ShvWA/Gw5eD7aEdYArkkzLA9Uku?=
 =?us-ascii?Q?ETXEcrda461ek75gcur7+9A1O4IHMhQa0fQHXOpqWZdtqN+TH8qShifW8N0a?=
 =?us-ascii?Q?Oh7JxH/LC6RkAlSgKpcXLiQ63h3iDO5FZUYZ/JUZ4pndjNuskF6VELsky7LI?=
 =?us-ascii?Q?45go6vfTsKoKoHd0cDUNPj26pigvBmhl4Df9IH72AL6ZJid3/GNGsRPRifjm?=
 =?us-ascii?Q?VsAIIpZAhBU0HxttaCN+pG6iFBq6HVwTmZKmYPhQNM1eyp0r4hLaJTya/HUa?=
 =?us-ascii?Q?XrnjXjlk5CeIbyDjx5gxZHTflci0ZMWFdkA6YpON/IHDdo6kOPYYkoOlloHg?=
 =?us-ascii?Q?TeJ+L6PSRftT+Dx0FOe02wZR6p0K6C0gJVwehwBLbc6/I2eZ3PTA8n7OHz4e?=
 =?us-ascii?Q?wHmwaESekhAs62t5VzBmwAp5h5E2tTAfy4evPufmQ6DW6YB7Ss00bXjcItks?=
 =?us-ascii?Q?39WdUfb++j++0CP+kwXMNNEgML/wFInpP77ZuVQKni3LOAeZv9V5pQ2K9NJw?=
 =?us-ascii?Q?jPrqtIcKugMSfTDFqhuyQmeboHDPipDEDGVLzqPzRM+Ur0KnUB2LRQzrSRbZ?=
 =?us-ascii?Q?dNI2z+6ofcOlC+MBSd4TzXsdPdqnuSzJ3P75W7sxfZJ+YE9vtEnBs4Fy1ymw?=
 =?us-ascii?Q?eJ69Sqs01Nbl3NAwPpmFv8agmcUJXWjOLFzSxtKiCHxe6e99M/x+cM+3P28y?=
 =?us-ascii?Q?XGB6mpwX6o+PbYrLDXzhQxjE8jyTtc2by7cjSk9gwS8EEG1cZ77phRuUJbyT?=
 =?us-ascii?Q?kBtwNFuYULR9EWwQPc/c+Aw0tb4tsDQwuY1SjCj0WDdKLOKcsWMndJ8JAQ0p?=
 =?us-ascii?Q?NZ+MRfAEgo2vRdNB9XA1pVUMsWwpRGyXmBnM9StDmsukNNa61bNZ1yl9HhvP?=
 =?us-ascii?Q?8VlnOqUCHxzJwZNdyGMG5wsM3ng4huYcEDnjTcG9bz05LVQoZejJwSYfXtEj?=
 =?us-ascii?Q?qboN+nk3sOY5YHU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?etGZSmBtjOnAI+zC8MAMLDoCSLLTlOayGsofF4Kyw8URVg14Pk+4D9yJDoYY?=
 =?us-ascii?Q?N/KeE047NesRTNoU/31btAP/BXZEuyKebQiQZ7B7o2t7aUYN6H1V9P0pXzfo?=
 =?us-ascii?Q?8n36gJlygj9Zz07FFIMapUzmnUb2InjPcPuRZ37Enu7IMBCuWrGdv7fTMv5x?=
 =?us-ascii?Q?TxFsasXjR/zWBNuC6ajmYYObjENoWNd8PhIzUVEvY9EDhgjfP4GSatnuplAn?=
 =?us-ascii?Q?YwQ6JTRMVBNxwIDugoPeyZc/RmUCyN9wW+D+dU3tQUipCBL2vNWL6rdFIUG8?=
 =?us-ascii?Q?qoL088RhsxTw3Brehqp0ISzy4W1Dk0doeZZl2eroDBUK2zPXMI+VhjZMqe9z?=
 =?us-ascii?Q?2ML4zXsGvP6V4yEnA1AOOyFBbLeq2zta0IuIZf67XOQITrqGukk+VeMMpvZW?=
 =?us-ascii?Q?RDORBD1jR23ByNUpAYxAAyaCKU5VgdBgoMVId6eU6j3Lj3agBELy+UCblAdI?=
 =?us-ascii?Q?bfwHhSjGzzLeuapYsl1hLa73VkrQ9OefOuHE8kP1i3dQ317w3iydgSTfutts?=
 =?us-ascii?Q?t+4u5egbqugHlcY20WYbvgtepJ00VdZWmmLg6NnXaLzyxi3TLIWYQU88NM0/?=
 =?us-ascii?Q?AUspkWDE22dvWcdWMYey+c5YLyZRPwiRYj7i7v9PfJks7nnYogXjBCTOAkAi?=
 =?us-ascii?Q?qU28yzA4ifd8q8YLzGRTp5mgGCe348Qylw6twVvcfL1Z2JEQZttzXdwKVHWq?=
 =?us-ascii?Q?rUw0Yuxu2hHyoUNJPefBZAAJ3qAbrlt82bc+919QuLRu4Y28hf0WFaAeLIeI?=
 =?us-ascii?Q?qxP3u2H3It8AebpT4WagsKwNxCsigLD200kudCq9mgIuWEoHp7Z14N2BMhYT?=
 =?us-ascii?Q?UPz1PbhqCfNSdaJw4rVo9ERI3Ct4iKUYyWmcqNidetg+WAuLA9wuBhbWThdk?=
 =?us-ascii?Q?nYrPw6AX6ybcFgHhGoDYwbK7+O+IN/FZrKDnK0jB4p94gRcRRmI5VaUMKS8N?=
 =?us-ascii?Q?BP5XXgyGbCHukXxBIip8c3kCvVhfJm8EqpP17JTci1ynHOGXWWNA8WjJK+pz?=
 =?us-ascii?Q?hUdZLPMt+FjKbAtl6yVeDR3CbpjipPW5bWl0hHYeM5apxi7SbRDJJ/sngmqC?=
 =?us-ascii?Q?SleaPUoRL6oQyT6wBYAGEJw//BFu98Tt8SVH+ZaXJfDz4p5XR8hwNR/JTABy?=
 =?us-ascii?Q?2GgwZ+fdKlynJ59FhZBAQ295/zH/U6G0yW7KkFTj+eDaXRudd9TrlL1QNP/g?=
 =?us-ascii?Q?H/H/Kk2zfMvUY7tfzpwFKLXRh6U46LOFepeDEKcKMnE0QHW8bdnyi8kEr7fg?=
 =?us-ascii?Q?eDvlQgCsfyIfRegr/DE0XNDrEE2hUdXl972QOIsY2mz9wfL3q+R5CMxESPo0?=
 =?us-ascii?Q?YePg2tX0efeRFkhE9wv29E/Nb4IkevWHaSaKL2kuhFJM1Erh4EQv/+Tlcqt3?=
 =?us-ascii?Q?xBCeNvvIzjVCnWFmXsdKVWrLssLmDbCJHFQuJFVZJD+NBSfxQTExlweb750e?=
 =?us-ascii?Q?64tpaqZUxvP5z0N/52MVie0UcyiUv0SrqobE5WZLY2/VMahcXfZXLu+TST7M?=
 =?us-ascii?Q?DFEINrsE/VYUNRudOgRK19Ls3MWiixtB3kUzAG60E4dowCRHPwQ4D2AJ+Vlo?=
 =?us-ascii?Q?bnCEPQlrTjzAYlCT2N+/SPXceg7iqWRA8XidDuITtLwo91smUPUbU9kxuJhn?=
 =?us-ascii?Q?OraGvLfTbKxbPKWEwPKzb6w=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d439138e-4f97-428b-5011-08dd70414a68
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:28.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cZ6TtcoI2/YM1MgsUh37452Hl4ri22DuuIfooNWcXN7RaQ6/whbknpHfabZ/mZDzWGnVXZ042uDlDsEJKEvMcC02cO+uc5ICcDGpjs6GcSFv6S2iYGGYFGj5jpNuWnb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10032
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18407

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9bd95ac86e700ab8b1a6c225685e0e5afe426b4e upstream.

Add pinctrl driver support for RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240530173857.164073-16-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 374 +++++++++++++++++++++++-
 1 file changed, 371 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index d42ce90af83ac..8c29c8d3c5743 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -58,6 +58,10 @@
 #define PIN_CFG_OEN			BIT(15)
 #define PIN_CFG_VARIABLE		BIT(16)
 #define PIN_CFG_NOGPIO_INT		BIT(17)
+#define PIN_CFG_NOD			BIT(18)	/* N-ch Open Drain */
+#define PIN_CFG_SMT			BIT(19)	/* Schmitt-trigger input control */
+#define PIN_CFG_ELC			BIT(20)
+#define PIN_CFG_IOLH_RZV2H		BIT(21)
=20
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
@@ -72,6 +76,11 @@
 #define RZG3S_MPXED_PIN_FUNCS(group)	(RZG2L_MPXED_COMMON_PIN_FUNCS(group) =
| \
 					 PIN_CFG_SOFT_PS)
=20
+#define RZV2H_MPXED_PIN_FUNCS		(RZG2L_MPXED_COMMON_PIN_FUNCS(RZV2H) | \
+					 PIN_CFG_NOD | \
+					 PIN_CFG_SR | \
+					 PIN_CFG_SMT)
+
 #define RZG2L_MPXED_ETH_PIN_FUNCS(x)	((x) | \
 					 PIN_CFG_FILONOFF | \
 					 PIN_CFG_FILNUM | \
@@ -134,6 +143,7 @@
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
 #define ETH_MODE		(0x3018)
+#define PFC_OEN			(0x3C40) /* known on RZ/V2H(P) only */
=20
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
@@ -141,6 +151,8 @@
=20
 #define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
 #define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
+#define PWPR_REGWE_A		BIT(6)	/* PFC and PMC Register Write Enable on RZ/V2=
H(P) */
+#define PWPR_REGWE_B		BIT(5)	/* OEN Register Write Enable, known only in R=
Z/V2H(P) */
=20
 #define PM_MASK			0x03
 #define PFC_MASK		0x07
@@ -159,6 +171,19 @@
 #define RZG2L_TINT_IRQ_START_INDEX	9
 #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
=20
+/* Custom pinconf parameters */
+#define RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE	(PIN_CONFIG_END + 1)
+
+static const struct pinconf_generic_params renesas_rzv2h_custom_bindings[]=
 =3D {
+	{ "renesas,output-impedance", RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE, =
1 },
+};
+
+#ifdef CONFIG_DEBUG_FS
+static const struct pin_config_item renesas_rzv2h_conf_items[] =3D {
+	PCONFDUMP(RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE, "output-impedance", =
"x", true),
+};
+#endif
+
 /* Read/write 8 bits register */
 #define RZG2L_PCTRL_REG_ACCESS8(_read, _addr, _val)	\
 	do {						\
@@ -351,6 +376,15 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct r=
zg2l_pinctrl *pctrl,
 	return 0;
 }
=20
+static const u64 r9a09g057_variable_pin_cfg[] =3D {
+	RZG2L_VARIABLE_PIN_CFG_PACK(11, 0, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(11, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(11, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(11, 3, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(11, 4, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(11, 5, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
+};
+
 #ifdef CONFIG_RISCV
 static const u64 r9a07g043f_variable_pin_cfg[] =3D {
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 0, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
@@ -401,6 +435,17 @@ static void rzg2l_pmc_writeb(struct rzg2l_pinctrl *pct=
rl, u8 val, u16 offset)
 	writeb(val, pctrl->base + offset);
 }
=20
+static void rzv2h_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, u16 offs=
et)
+{
+	const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg->regs;
+	u8 pwpr;
+
+	pwpr =3D readb(pctrl->base + regs->pwpr);
+	writeb(pwpr | PWPR_REGWE_A, pctrl->base + regs->pwpr);
+	writeb(val, pctrl->base + offset);
+	writeb(pwpr & ~PWPR_REGWE_A, pctrl->base + regs->pwpr);
+}
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -1041,14 +1086,104 @@ static int rzg2l_bias_param_to_hw(enum pin_config_=
param param)
 	return -EINVAL;
 }
=20
+static int rzv2h_hw_to_bias_param(unsigned int bias)
+{
+	switch (bias) {
+	case 0:
+	case 1:
+		return PIN_CONFIG_BIAS_DISABLE;
+	case 2:
+		return PIN_CONFIG_BIAS_PULL_DOWN;
+	case 3:
+		return PIN_CONFIG_BIAS_PULL_UP;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int rzv2h_bias_param_to_hw(enum pin_config_param param)
+{
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		return 0;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return 2;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		return 3;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static u8 rzv2h_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, u32 offset)
+{
+	static const char * const pin_names[] =3D { "ET0_TXC_TXCLK", "ET1_TXC_TXC=
LK",
+						  "XSPI0_RESET0N", "XSPI0_CS0N",
+						  "XSPI0_CKN", "XSPI0_CKP" };
+	const struct pinctrl_pin_desc *pin_desc =3D &pctrl->desc.pins[offset];
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(pin_names); i++) {
+		if (!strcmp(pin_desc->name, pin_names[i]))
+			return i;
+	}
+
+	/* Should not happen. */
+	return 0;
+}
+
+static u32 rzv2h_oen_read(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offse=
t, u8 pin)
+{
+	u8 bit;
+
+	if (!(caps & PIN_CFG_OEN))
+		return 0;
+
+	bit =3D rzv2h_pin_to_oen_bit(pctrl, offset);
+
+	return !(readb(pctrl->base + PFC_OEN) & BIT(bit));
+}
+
+static int rzv2h_oen_write(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offs=
et, u8 pin, u8 oen)
+{
+	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs =3D &hwcfg->regs;
+	unsigned long flags;
+	u8 val, bit;
+	u8 pwpr;
+
+	if (!(caps & PIN_CFG_OEN))
+		return -EINVAL;
+
+	bit =3D rzv2h_pin_to_oen_bit(pctrl, offset);
+	spin_lock_irqsave(&pctrl->lock, flags);
+	val =3D readb(pctrl->base + PFC_OEN);
+	if (oen)
+		val &=3D ~BIT(bit);
+	else
+		val |=3D BIT(bit);
+
+	pwpr =3D readb(pctrl->base + regs->pwpr);
+	writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
+	writeb(val, pctrl->base + PFC_OEN);
+	writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return 0;
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
 {
 	struct rzg2l_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
-	enum pin_config_param param =3D pinconf_to_config_param(*config);
 	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
 	const struct pinctrl_pin_desc *pin =3D &pctrl->desc.pins[_pin];
+	u32 param =3D pinconf_to_config_param(*config);
 	u64 *pin_data =3D pin->drv_data;
 	unsigned int arg =3D 0;
 	u32 off;
@@ -1159,6 +1294,13 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
 		break;
 	}
=20
+	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
+		if (!(cfg & PIN_CFG_IOLH_RZV2H))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
+		break;
+
 	default:
 		return -ENOTSUPP;
 	}
@@ -1178,9 +1320,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 	const struct rzg2l_hwcfg *hwcfg =3D pctrl->data->hwcfg;
 	struct rzg2l_pinctrl_pin_settings settings =3D pctrl->settings[_pin];
 	u64 *pin_data =3D pin->drv_data;
-	enum pin_config_param param;
 	unsigned int i, arg, index;
-	u32 off;
+	u32 off, param;
 	u64 cfg;
 	int ret;
 	u8 bit;
@@ -1285,6 +1426,16 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_=
dev *pctldev,
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
=20
+		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
+			if (!(cfg & PIN_CFG_IOLH_RZV2H))
+				return -EINVAL;
+
+			arg =3D pinconf_to_config_argument(_configs[i]);
+			if (arg > 3)
+				return -EINVAL;
+			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, arg);
+			break;
+
 		default:
 			return -EOPNOTSUPP;
 		}
@@ -1732,6 +1883,39 @@ static const u64 r9a08g045_gpio_configs[] =3D {
 	RZG2L_GPIO_PORT_PACK(6, 0x2a, RZG3S_MPXED_PIN_FUNCS(A)),			/* P18 */
 };
=20
+static const char * const rzv2h_gpio_names[] =3D {
+	"P00", "P01", "P02", "P03", "P04", "P05", "P06", "P07",
+	"P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17",
+	"P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27",
+	"P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37",
+	"P40", "P41", "P42", "P43", "P44", "P45", "P46", "P47",
+	"P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57",
+	"P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67",
+	"P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77",
+	"P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87",
+	"P90", "P91", "P92", "P93", "P94", "P95", "P96", "P97",
+	"PA0", "PA1", "PA2", "PA3", "PA4", "PA5", "PA6", "PA7",
+	"PB0", "PB1", "PB2", "PB3", "PB4", "PB5", "PB6", "PB7",
+};
+
+static const u64 r9a09g057_gpio_configs[] =3D {
+	RZG2L_GPIO_PORT_PACK(8, 0x20, RZV2H_MPXED_PIN_FUNCS),	/* P0 */
+	RZG2L_GPIO_PORT_PACK(6, 0x21, RZV2H_MPXED_PIN_FUNCS),	/* P1 */
+	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_COMMON_PIN_FUNCS(RZV2H) |
+				      PIN_CFG_NOD),		/* P2 */
+	RZG2L_GPIO_PORT_PACK(8, 0x23, RZV2H_MPXED_PIN_FUNCS),	/* P3 */
+	RZG2L_GPIO_PORT_PACK(8, 0x24, RZV2H_MPXED_PIN_FUNCS),	/* P4 */
+	RZG2L_GPIO_PORT_PACK(8, 0x25, RZV2H_MPXED_PIN_FUNCS),	/* P5 */
+	RZG2L_GPIO_PORT_PACK(8, 0x26, RZV2H_MPXED_PIN_FUNCS |
+				      PIN_CFG_ELC),		/* P6 */
+	RZG2L_GPIO_PORT_PACK(8, 0x27, RZV2H_MPXED_PIN_FUNCS),	/* P7 */
+	RZG2L_GPIO_PORT_PACK(8, 0x28, RZV2H_MPXED_PIN_FUNCS |
+				      PIN_CFG_ELC),		/* P8 */
+	RZG2L_GPIO_PORT_PACK(8, 0x29, RZV2H_MPXED_PIN_FUNCS),	/* P9 */
+	RZG2L_GPIO_PORT_PACK(8, 0x2a, RZV2H_MPXED_PIN_FUNCS),	/* PA */
+	RZG2L_GPIO_PORT_PACK(6, 0x2b, PIN_CFG_VARIABLE),	/* PB */
+};
+
 static const struct {
 	struct rzg2l_dedicated_configs common[35];
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
@@ -1858,6 +2042,138 @@ static const struct rzg2l_dedicated_configs rzg3s_d=
edicated_pins[] =3D {
 						       PIN_CFG_IO_VMC_SD1)) },
 };
=20
+static struct rzg2l_dedicated_configs rzv2h_dedicated_pins[] =3D {
+	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM=
 |
+						PIN_CFG_FILCLKSEL)) },
+	{ "TMS_SWDIO", RZG2L_SINGLE_PIN_PACK(0x3, 0, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_IEN)) },
+	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR))=
 },
+	{ "WDTUDFCA", RZG2L_SINGLE_PIN_PACK(0x5, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG=
_SR |
+						     PIN_CFG_PUPD | PIN_CFG_NOD)) },
+	{ "WDTUDFCM", RZG2L_SINGLE_PIN_PACK(0x5, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG=
_SR |
+						     PIN_CFG_PUPD | PIN_CFG_NOD)) },
+	{ "SCIF_RXD", RZG2L_SINGLE_PIN_PACK(0x6, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG=
_SR |
+						     PIN_CFG_PUPD)) },
+	{ "SCIF_TXD", RZG2L_SINGLE_PIN_PACK(0x6, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG=
_SR |
+						     PIN_CFG_PUPD)) },
+	{ "XSPI0_CKP", RZG2L_SINGLE_PIN_PACK(0x7, 0, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_CKN", RZG2L_SINGLE_PIN_PACK(0x7, 1, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_CS0N", RZG2L_SINGLE_PIN_PACK(0x7, 2, (PIN_CFG_IOLH_RZV2H | PIN_C=
FG_SR |
+						       PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_DS", RZG2L_SINGLE_PIN_PACK(0x7, 3, (PIN_CFG_IOLH_RZV2H | PIN_CFG=
_SR |
+						     PIN_CFG_PUPD)) },
+	{ "XSPI0_RESET0N", RZG2L_SINGLE_PIN_PACK(0x7, 4, (PIN_CFG_IOLH_RZV2H | PI=
N_CFG_SR |
+							  PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "XSPI0_RSTO0N", RZG2L_SINGLE_PIN_PACK(0x7, 5, (PIN_CFG_PUPD)) },
+	{ "XSPI0_INT0N", RZG2L_SINGLE_PIN_PACK(0x7, 6, (PIN_CFG_PUPD)) },
+	{ "XSPI0_ECS0N", RZG2L_SINGLE_PIN_PACK(0x7, 7, (PIN_CFG_PUPD)) },
+	{ "XSPI0_IO0", RZG2L_SINGLE_PIN_PACK(0x8, 0, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO1", RZG2L_SINGLE_PIN_PACK(0x8, 1, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO2", RZG2L_SINGLE_PIN_PACK(0x8, 2, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO3", RZG2L_SINGLE_PIN_PACK(0x8, 3, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO4", RZG2L_SINGLE_PIN_PACK(0x8, 4, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO5", RZG2L_SINGLE_PIN_PACK(0x8, 5, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO6", RZG2L_SINGLE_PIN_PACK(0x8, 6, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "XSPI0_IO7", RZG2L_SINGLE_PIN_PACK(0x8, 7, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "SD0CLK", RZG2L_SINGLE_PIN_PACK(0x9, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_S=
R)) },
+	{ "SD0CMD", RZG2L_SINGLE_PIN_PACK(0x9, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_S=
R |
+						   PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0RSTN", RZG2L_SINGLE_PIN_PACK(0x9, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR)) },
+	{ "SD0DAT0", RZG2L_SINGLE_PIN_PACK(0xa, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT1", RZG2L_SINGLE_PIN_PACK(0xa, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT2", RZG2L_SINGLE_PIN_PACK(0xa, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT3", RZG2L_SINGLE_PIN_PACK(0xa, 3, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT4", RZG2L_SINGLE_PIN_PACK(0xa, 4, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT5", RZG2L_SINGLE_PIN_PACK(0xa, 5, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT6", RZG2L_SINGLE_PIN_PACK(0xa, 6, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0DAT7", RZG2L_SINGLE_PIN_PACK(0xa, 7, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1CLK", RZG2L_SINGLE_PIN_PACK(0xb, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_S=
R)) },
+	{ "SD1CMD", RZG2L_SINGLE_PIN_PACK(0xb, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_S=
R |
+						   PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1DAT0", RZG2L_SINGLE_PIN_PACK(0xc, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1DAT1", RZG2L_SINGLE_PIN_PACK(0xc, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1DAT2", RZG2L_SINGLE_PIN_PACK(0xc, 2, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD1DAT3", RZG2L_SINGLE_PIN_PACK(0xc, 3, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "PCIE0_RSTOUTB", RZG2L_SINGLE_PIN_PACK(0xe, 0, (PIN_CFG_IOLH_RZV2H | PI=
N_CFG_SR)) },
+	{ "PCIE1_RSTOUTB", RZG2L_SINGLE_PIN_PACK(0xe, 1, (PIN_CFG_IOLH_RZV2H | PI=
N_CFG_SR)) },
+	{ "ET0_MDIO", RZG2L_SINGLE_PIN_PACK(0xf, 0, (PIN_CFG_IOLH_RZV2H | PIN_CFG=
_SR |
+						     PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "ET0_MDC", RZG2L_SINGLE_PIN_PACK(0xf, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG_=
SR |
+						    PIN_CFG_PUPD)) },
+	{ "ET0_RXCTL_RXDV", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_PUPD)) },
+	{ "ET0_TXCTL_TXEN", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_RZV2H | =
PIN_CFG_SR |
+							    PIN_CFG_PUPD)) },
+	{ "ET0_TXER", RZG2L_SINGLE_PIN_PACK(0x10, 2, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_RXER", RZG2L_SINGLE_PIN_PACK(0x10, 3, (PIN_CFG_PUPD)) },
+	{ "ET0_RXC_RXCLK", RZG2L_SINGLE_PIN_PACK(0x10, 4, (PIN_CFG_PUPD)) },
+	{ "ET0_TXC_TXCLK", RZG2L_SINGLE_PIN_PACK(0x10, 5, (PIN_CFG_IOLH_RZV2H | P=
IN_CFG_SR |
+							   PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "ET0_CRS", RZG2L_SINGLE_PIN_PACK(0x10, 6, (PIN_CFG_PUPD)) },
+	{ "ET0_COL", RZG2L_SINGLE_PIN_PACK(0x10, 7, (PIN_CFG_PUPD)) },
+	{ "ET0_TXD0", RZG2L_SINGLE_PIN_PACK(0x11, 0, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_TXD1", RZG2L_SINGLE_PIN_PACK(0x11, 1, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_TXD2", RZG2L_SINGLE_PIN_PACK(0x11, 2, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_TXD3", RZG2L_SINGLE_PIN_PACK(0x11, 3, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET0_RXD0", RZG2L_SINGLE_PIN_PACK(0x11, 4, (PIN_CFG_PUPD)) },
+	{ "ET0_RXD1", RZG2L_SINGLE_PIN_PACK(0x11, 5, (PIN_CFG_PUPD)) },
+	{ "ET0_RXD2", RZG2L_SINGLE_PIN_PACK(0x11, 6, (PIN_CFG_PUPD)) },
+	{ "ET0_RXD3", RZG2L_SINGLE_PIN_PACK(0x11, 7, (PIN_CFG_PUPD)) },
+	{ "ET1_MDIO", RZG2L_SINGLE_PIN_PACK(0x12, 0, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "ET1_MDC", RZG2L_SINGLE_PIN_PACK(0x12, 1, (PIN_CFG_IOLH_RZV2H | PIN_CFG=
_SR |
+						     PIN_CFG_PUPD)) },
+	{ "ET1_RXCTL_RXDV", RZG2L_SINGLE_PIN_PACK(0x13, 0, (PIN_CFG_PUPD)) },
+	{ "ET1_TXCTL_TXEN", RZG2L_SINGLE_PIN_PACK(0x13, 1, (PIN_CFG_IOLH_RZV2H | =
PIN_CFG_SR |
+							    PIN_CFG_PUPD)) },
+	{ "ET1_TXER", RZG2L_SINGLE_PIN_PACK(0x13, 2, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						       PIN_CFG_PUPD)) },
+	{ "ET1_RXER", RZG2L_SINGLE_PIN_PACK(0x13, 3, (PIN_CFG_PUPD)) },
+	{ "ET1_RXC_RXCLK", RZG2L_SINGLE_PIN_PACK(0x13, 4, (PIN_CFG_PUPD)) },
+	{ "ET1_TXC_TXCLK", RZG2L_SINGLE_PIN_PACK(0x13, 5, (PIN_CFG_IOLH_RZV2H | P=
IN_CFG_SR |
+							   PIN_CFG_PUPD | PIN_CFG_OEN)) },
+	{ "ET1_CRS", RZG2L_SINGLE_PIN_PACK(0x13, 6, (PIN_CFG_PUPD)) },
+	{ "ET1_COL", RZG2L_SINGLE_PIN_PACK(0x13, 7, (PIN_CFG_PUPD)) },
+	{ "ET1_TXD0", RZG2L_SINGLE_PIN_PACK(0x14, 0, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_TXD1", RZG2L_SINGLE_PIN_PACK(0x14, 1, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_TXD2", RZG2L_SINGLE_PIN_PACK(0x14, 2, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_TXD3", RZG2L_SINGLE_PIN_PACK(0x14, 3, (PIN_CFG_IOLH_RZV2H | PIN_CF=
G_SR |
+						      PIN_CFG_PUPD)) },
+	{ "ET1_RXD0", RZG2L_SINGLE_PIN_PACK(0x14, 4, (PIN_CFG_PUPD)) },
+	{ "ET1_RXD1", RZG2L_SINGLE_PIN_PACK(0x14, 5, (PIN_CFG_PUPD)) },
+	{ "ET1_RXD2", RZG2L_SINGLE_PIN_PACK(0x14, 6, (PIN_CFG_PUPD)) },
+	{ "ET1_RXD3", RZG2L_SINGLE_PIN_PACK(0x14, 7, (PIN_CFG_PUPD)) },
+};
+
 static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl =
*pctrl)
 {
 	const struct pinctrl_pin_desc *pin_desc =3D &pctrl->desc.pins[virq];
@@ -2394,6 +2710,9 @@ static int rzg2l_pinctrl_probe(struct platform_device=
 *pdev)
 	BUILD_BUG_ON(ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg2l_gpio_names));
=20
+	BUILD_BUG_ON(ARRAY_SIZE(r9a09g057_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzv2h_gpio_names));
+
 	pctrl =3D devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
@@ -2665,6 +2984,22 @@ static void rzg2l_pwpr_pfc_lock_unlock(struct rzg2l_=
pinctrl *pctrl, bool lock)
 	}
 }
=20
+static void rzv2h_pwpr_pfc_lock_unlock(struct rzg2l_pinctrl *pctrl, bool l=
ock)
+{
+	const struct rzg2l_register_offsets *regs =3D &pctrl->data->hwcfg->regs;
+	u8 pwpr;
+
+	if (lock) {
+		/* Set the PWPR register to be write-protected */
+		pwpr =3D readb(pctrl->base + regs->pwpr);
+		writeb(pwpr & ~PWPR_REGWE_A, pctrl->base + regs->pwpr);
+	} else {
+		/* Set the PWPR register to allow PFC and PMC register to write */
+		pwpr =3D readb(pctrl->base + regs->pwpr);
+		writeb(PWPR_REGWE_A | pwpr, pctrl->base + regs->pwpr);
+	}
+}
+
 static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
 	.regs =3D {
 		.pwpr =3D 0x3014,
@@ -2710,6 +3045,12 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg =3D {
 	.oen_max_port =3D 7, /* P7_1 is the maximum OEN port. */
 };
=20
+static const struct rzg2l_hwcfg rzv2h_hwcfg =3D {
+	.regs =3D {
+		.pwpr =3D 0x3c04,
+	},
+};
+
 static struct rzg2l_pinctrl_data r9a07g043_data =3D {
 	.port_pins =3D rzg2l_gpio_names,
 	.port_pin_configs =3D r9a07g043_gpio_configs,
@@ -2763,6 +3104,29 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D =
{
 	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
=20
+static struct rzg2l_pinctrl_data r9a09g057_data =3D {
+	.port_pins =3D rzv2h_gpio_names,
+	.port_pin_configs =3D r9a09g057_gpio_configs,
+	.n_ports =3D ARRAY_SIZE(r9a09g057_gpio_configs),
+	.dedicated_pins =3D rzv2h_dedicated_pins,
+	.n_port_pins =3D ARRAY_SIZE(r9a09g057_gpio_configs) * RZG2L_PINS_PER_PORT=
,
+	.n_dedicated_pins =3D ARRAY_SIZE(rzv2h_dedicated_pins),
+	.hwcfg =3D &rzv2h_hwcfg,
+	.variable_pin_cfg =3D r9a09g057_variable_pin_cfg,
+	.n_variable_pin_cfg =3D ARRAY_SIZE(r9a09g057_variable_pin_cfg),
+	.num_custom_params =3D ARRAY_SIZE(renesas_rzv2h_custom_bindings),
+	.custom_params =3D renesas_rzv2h_custom_bindings,
+#ifdef CONFIG_DEBUG_FS
+	.custom_conf_items =3D renesas_rzv2h_conf_items,
+#endif
+	.pwpr_pfc_lock_unlock =3D &rzv2h_pwpr_pfc_lock_unlock,
+	.pmc_writeb =3D &rzv2h_pmc_writeb,
+	.oen_read =3D &rzv2h_oen_read,
+	.oen_write =3D &rzv2h_oen_write,
+	.hw_to_bias_param =3D &rzv2h_hw_to_bias_param,
+	.bias_param_to_hw =3D &rzv2h_bias_param_to_hw,
+};
+
 static const struct of_device_id rzg2l_pinctrl_of_table[] =3D {
 	{
 		.compatible =3D "renesas,r9a07g043-pinctrl",
@@ -2776,6 +3140,10 @@ static const struct of_device_id rzg2l_pinctrl_of_ta=
ble[] =3D {
 		.compatible =3D "renesas,r9a08g045-pinctrl",
 		.data =3D &r9a08g045_data,
 	},
+	{
+		.compatible =3D "renesas,r9a09g057-pinctrl",
+		.data =3D &r9a09g057_data,
+	},
 	{ /* sentinel */ }
 };
=20
--=20
2.43.0


