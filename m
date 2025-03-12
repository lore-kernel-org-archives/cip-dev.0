Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B646C35FF4
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.26])
 by mx.groups.io with SMTP id smtpd.web10.34432.1741778649916902406
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=JIxUPmrS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py60587lG/ziRDAtkup04K+Z5JegXo1XPu5TW5C+0XfVnIO+UXRhElf/PWG+IOzBdo2B8NSgkCK1Y0ENW0hR+1o6DlfThNHoScXAZ8HfZpmr+p8dv8qe6d+mO2oJ3gklBtg3bbARQVLkxG6guSojxhW0OzVfUdbUQlWYkLQEd8D/jQdqkkoXYxFhxtIIuODW6Wwt75RbKeFmebqCbOSxTbZuEwrcJ/5wtXyYkIzVVYZgWjHHh93TUFbB86yilGzMshCAnQ2iiQKTNtVnmI4FUhx3nGEgKkG7oM1X0MZ2g5wUiUGnHbEC3vngaKk9brW2PIcEc7FlRA/LVr6z9Th/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUPcNwWjVd4iC6uQdkQfOmfJ1o7o1doz+sPoVDz2AFE=;
 b=Y/Gh2X5qt4xDwEqNPaxygTJPjiwNmO20I+RF4m56TEROp/jFIZ8Jzcau0QGE4abwX4Rc0OMf6VF/iis4WkNKLgeTNMLteHzJJziGpT0zK8Ji3JOo8pDAwVZEbMD1Jmp5XTJD4dYVlWRMkCyumfZSACsdClnuF8FrtFATVW4m4x/ycJcmdxD11Lo2XVcn8WErrXZ9eTUWiknFxSOcZ73nbrsqHUSZhVchBIzOG3IyGRib7fuQoy3Blvt+PJfqmzqLAUN2cV3RRP4puQTqShg6cL3UpSl+R2AuURWi3cfpuKDX1jSrckMPfv4Xqy3X0fUQSjX2JxjXZTOYTXTNeo1img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUPcNwWjVd4iC6uQdkQfOmfJ1o7o1doz+sPoVDz2AFE=;
 b=JIxUPmrS+HK2I23C47vDOfuQLgJG/EoE8FzN7M1XOQ4+l942EdkG+/08aWErFLy5iXb3PnQH6XCkr5sokry70YJj5EElU23dFujPDG6jYRULaG9naVbZFL+cFhvDDB+ykcIJOh81tkP5CLdFIL+GQoAEp4DDYnstpau/G68PFwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:06 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/85] clk: renesas: r9a09g057: Add CA55 core clocks
Date: Wed, 12 Mar 2025 12:21:47 +0100
Message-ID: <20250312112302.1605750-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a48e60-352d-492d-9740-08dd615866a4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?E7HhJ8hkiTghobQXlCcylciQ1z3Z7HsR+7ZIH6AHQb67LzVxS2SQz0T3/4ZK?=
 =?us-ascii?Q?RC1y/w4xxMxzni8otBR2EZ+beNPvJbaOdMZNXx+IA/yT3AcNykNTkF4RRHYz?=
 =?us-ascii?Q?rOOe8lc/RKlusA0JGjRZNr2/zeafgySeKfMDSUhNaNfGyNjA7WVWSbP6J3hF?=
 =?us-ascii?Q?TwT1eNVEmvmslgc/Zh0BguZorw643Z8uHXa7OTDR5O1XmBaxssbSeuiogcvG?=
 =?us-ascii?Q?igYI6tsg4D0dM6HeMjYvMSiGtosEtSZoFXoPE3n26ZMeH7d+Tkx2CoPXNI1d?=
 =?us-ascii?Q?twD6e50E1OzsYKhs0EtYXMvi0VVZsJsZmVejSzmd0UdaDT/tpOAGOLOpxEPL?=
 =?us-ascii?Q?FxQoVxw1EjumxFI56FCxVdm9iCqfeWFA55rXD/9dUhGNfY12eDmq9xPvq6cj?=
 =?us-ascii?Q?AMZg++JddJe4LUL66BFX6X3CIVF8wTXGPYoRw0obh8fSAI4bQTt5M0bHLMsk?=
 =?us-ascii?Q?fLLyOWiIkAru5Rx9eIRn36tz5YLI5X4BP0NAT921uxwLyRp2jMbts9ZqjXq7?=
 =?us-ascii?Q?M11fMp1m+b2ENWQ7TPesq1sUg0dnr7D5vXEw16IpiJXFCO3FYKxvFTeGO8Kr?=
 =?us-ascii?Q?ZGh/2TOuPVefVAsHpfMdroDWwXOrazA/D72pPcb8g6QWCakfEZiy1OE2qb47?=
 =?us-ascii?Q?9jXZzdap0r23SX2rv4+Ey5AlUDoUCHQgpmvU8C8AnikcExHZ9A63FOvrnhE7?=
 =?us-ascii?Q?LSTcdA/5PSnGRXvg5AKq1C2mc1lpDRj3NLUcy3Rn7hl51pd1ANxYFIFwndtd?=
 =?us-ascii?Q?ojBz9NVZGjw1qhNUZVzjLhU/YcBONpKIfC3qxaHxXCLMwOx09LnXYBfKuXOP?=
 =?us-ascii?Q?miC0Gjqu6z4uxoYofgsH/ulvNlH7OR/4atCt9uy0zhMOOd2ZswncAy6mJvaq?=
 =?us-ascii?Q?v1iOpIawW+rlPnD816qx3csGB/KFIV97rWnl0Fe/2NT6tGIMmttSQm5WVSQM?=
 =?us-ascii?Q?jdoZPB+Pvg/VnRHMAZHBeSBpVZych9VwILJZEAxWVP0J5g1W9uSRYjbFkcdZ?=
 =?us-ascii?Q?CYKuO7VKqS1dk9dgwQdE5mXJKOMx9dFoVEsniTdALg7TwiU4u3MC8tRGx/2B?=
 =?us-ascii?Q?OtDW1iTASWEA2OfXgWR765U3Jj5N1U1mwKMlhoD+pneCmuGcqItalEeMxywW?=
 =?us-ascii?Q?sywOwV9/5p4gcVTz1001L3RTgoyvvRJVse6nblUqSAnajvoxnSiQNZAo+Wxg?=
 =?us-ascii?Q?U6B+WcQjGvgW9BSJPKFL2N91ae0G1tW4j3QO7rX4EpRojEX4GXRx6AHAQGNZ?=
 =?us-ascii?Q?KZnFY5dSd5Od8MQ2bi4HXczYTVB5kuxt0ufG1TNz6IeJ2+Lh/ILQyTl5Vjsu?=
 =?us-ascii?Q?YlwS7QQ3AvLtkuAOW7BBHav52iYbMYiu/qZ9aePL2h0MSaZeVuhDuDadaQ99?=
 =?us-ascii?Q?gxYIO1mCSRNJ6jwpG4uE6U/nJEWK55pkuRiC3NzvtQImFtVWZmJwYfbsEbLZ?=
 =?us-ascii?Q?S/urpM6HWRdHJtV96UDx4xNS6tVYulAg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EcVV71RTX+XRZtisiSHK8QkaL/6rn70/nrXsMu7YSmSeMo8H3yQYKlAJ0OOv?=
 =?us-ascii?Q?RVSyc0+TPQbnTN3Fgnj0sFPFW4X6aCwqUTolfyA750W87mFdb1pYscCuOG7V?=
 =?us-ascii?Q?OxMDWZAbue7tARlGL8xNzbb9mC96291PGwDQWl9JS4UqW/ZHCtk+AiFPPQiq?=
 =?us-ascii?Q?oa6WdokAgQrds1H+7nNl+GImiy2uiu4vu4ADV/UgmyNsCCiBn1B63GG7KR0P?=
 =?us-ascii?Q?ML0E+wkHNRJVy9ZsqcWl78EYEFBB6BXWpzsYIoo2LUMmypWbKHWqbmlfRXzz?=
 =?us-ascii?Q?1L4CHkXuGQ0c9s6zEDRh0us/MQqRFijM6RUxB+aM3FLtoUwg5izRd5J97/59?=
 =?us-ascii?Q?/lvLRqwjGx4II31QpsOs0hMrhhuvqw66wnIKRH21Yh+LAzfHeH8UrTIrrHKO?=
 =?us-ascii?Q?aRodixNMTjbv2/f1XrcuhvgdszIOjqUZQglllfDbcZfGglILCKbYLfpmHX9O?=
 =?us-ascii?Q?sgLmJDIsro+r4FXIMnjQ98MHf/9L73HLppe7BlwaUkNE/iH9yxKiKb7tzmR4?=
 =?us-ascii?Q?Q1yK2rKkIsOL7H/b3h2ophSlcqMcMLP64Ns5U5RqVH/+XzW3o7G+PYQUbzzU?=
 =?us-ascii?Q?7HJuej2EndHipSr2JumpxEQj1RYAHzupC2nkgv3/Fe8u1Wu+FhEkyak4hDwq?=
 =?us-ascii?Q?2xdeKE1znnJNTtVQc663/3fHjAbZmJ0cWaNkupg6BKbGgbdpWK4mQmx90X4A?=
 =?us-ascii?Q?0toon8bfSPQpuTNLtvZO7JhQWgdU0nT2gwske9K6ghztRWDDxBPk/E7uz+kg?=
 =?us-ascii?Q?vsOn11eQGhIAQXfzmNfKJnfM56T24R8RYa5IL+iOh5Lk/rsJ0vHvkT/sZzGz?=
 =?us-ascii?Q?UbmCRnpdGcg31lwBONjsgGWxa9j3sK3wvplJOLlfVQWQ5EcfxoYnqTSIgm7Y?=
 =?us-ascii?Q?qo1X5NLH/wEe+hw/Q601N2rWw5EeW+jth+Qq3fnIlXa1gNpfQGMYiAXZ1Qas?=
 =?us-ascii?Q?Z3WAFmvl+fkKPWIb3VepgaJbw48RIt+7jk9Tj3f9bBH3j702WjtWsmyIV3sK?=
 =?us-ascii?Q?pbixS7uTG3XFXvP/5IWSr/IIqN74WMPgMXQPKL/SQfwpC++E1sgmcW9bYa/+?=
 =?us-ascii?Q?rbrfQ2NGWI+VHObCe6exF8/9nKwihIvRMzbI0zzRIESFkOkxPNuLoSCgMJzL?=
 =?us-ascii?Q?6/sK93AUo5hfQfIA7iQNygWkz8g5o5tLDYU6CReT6ZjZNlV3DDhxDxn33xd2?=
 =?us-ascii?Q?+sxi4SG6o5IQbe01vFQErxZbUH+VSvhcppZP6luOrk+6Jp4mmttz1zZHKOR2?=
 =?us-ascii?Q?OmJrgJ8lNht8AaxHzIovMs99qO85eVlMf3TunUm3H7iOwI5gnzYA19Hsn08g?=
 =?us-ascii?Q?FEdUUv3yBRLhjjL1S3lvB7ihnVjU6oUHSxbPG9E3mtxR/V7W+hmSAXUoqBeL?=
 =?us-ascii?Q?VfXqdnVIIhrCHACPlWRhP53pG5YKAxZijRSKdcbr1J7/Cuq2EfHqGl4+R3/J?=
 =?us-ascii?Q?3rutTxfVS2FHc7lO9f3O3bA5x30wj6CEPD6pMW0sm3ZbXAMZ80sEK+9Yehjc?=
 =?us-ascii?Q?h+DRpZPMc/SL+i8a1Ej/1dwMPIIj0hXyUPJY6zmEYtfjwSOIQs/ilXmIgq1c?=
 =?us-ascii?Q?bNPufY3WawC/sSuw60tDWxfUbTvu2ZleeS/6jREl7aJMD6YASXHDS4chnDZx?=
 =?us-ascii?Q?Mc3Wc4aXQaulnQZ9FdxxDQI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a48e60-352d-492d-9740-08dd615866a4
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:06.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gq+s6urdJ4THVHzPJKxVfV/L/AlLYwR1esWKexrA3FdB8686FYb+SP+TOZ3b3QYtrmq0Py2bQXrPTAPtRavIRudlmLEfBAjilYXxWh+qUKAQYNAczrBLrzv83+kg8A5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18102

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8cce33aed0b6383e91bb9d26dae11b1293101381 upstream.

Add CA55 core clocks which are derived from PLLCA55.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240918135957.290101-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


