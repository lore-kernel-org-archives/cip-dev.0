Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EC2C36007
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:09 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.39])
 by mx.groups.io with SMTP id smtpd.web10.18681.1742554862145207140
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Fjhps9QH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBQ2LhcNHQXzxg5oqBqbn7JoCWonJmJDxO8a2gCrGTIqscGxEdgD1dVDSGZOB+ieTUV89ryAQCVwUESMQgIa63kwEqSl1owI3YhOB+tO6uVyBCkgHTnzZuqaOmyBEjJWEXxPfecxVL7/fg3k5YaEBym4t91Yk697smhJNMU7Y9Ix/prWZ2am0y989iEZ2TW0kM1KFxbpdiPPzK7q/pg2Ys0FbtmjZbtdl20vZchnUsCVrvwloFUXJpS7WcqaehuLn5fRA4fSYbX+WZRzINlJ/VflF79noi+blhRIqiwrJCf88rBTr4/SwjHiXDDuwVbfOKO2WZoA4feq/Y/BYBg9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPnjlWHSLHS3pD2+7IsH6+QbiuRFsybMbbFYPsqcO4M=;
 b=yA2qBs5UsIU5YjPG8w/9XI7DdGMu7H6NPJbA7dm/ECnDvzYyEcH38i5uRK+oVQFHGOTJSydE0U31tLUVbRSvdO4q5KoVWSdyoTiFiN7pOdh0gbqHWQa9WLirgslKlalK4EOqR+XPwQ1+THX3nMh20YUtDGNMFeE2hQbqi7ieLgUWRYThvwXp84096lrGLow/2hKAxcmZOCuJGvIsDsd3PSWsmAwKHDwnTOf0WriWjHZ5ykPdgP7l70SZTzlcEtMcmx8jrPrljJ++ixrtqbCG0t3JEhOQ32l1PWJUVa0HTfJJbkQ/oM8BET+Mebt27JngMddJizDWUu0eR6BA3cjYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPnjlWHSLHS3pD2+7IsH6+QbiuRFsybMbbFYPsqcO4M=;
 b=Fjhps9QH6S2p0c0wy2uJC8wqp+Z/zMApNB3TEOnCOUN1VqiBuxzZE8/Pbzn0jwLYQGLOTrez8CVrYntKtFTieC70m5ZmxyoXZLvUd5m1ms0SCTrfQldwInaf0k/WJCxmDL3XjOFCiCl+dBKrAB7p+ocerXn7lNJ6rJYflt7l2mI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB12437.jpnprd01.prod.outlook.com (2603:1096:604:2e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:00:59 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:00:59 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/21] clk: renesas: Add RZ/V2H(P) CPG driver
Date: Fri, 21 Mar 2025 12:00:06 +0100
Message-ID: <20250321110021.3612805-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB12437:EE_
X-MS-Office365-Filtering-Correlation-Id: 57dd9442-e35d-4f1e-1863-08dd6867a95c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rmpOs4fyWPb+PqbimFN3AG8taTcO06x0uepb6G0YwuMWS/MJRYNAdh4Q7zgY?=
 =?us-ascii?Q?YnZfR0bhKgupY7MVTi1uJbb6ytOuL9Nv/hD/KYHBy3VzCJZ6pUEt3on7miHn?=
 =?us-ascii?Q?rL4wIxbBYX1xn4KeWK6sTonfBonhpDDb/JIC2e78hkk7Boxlbd3nUHp3Naz9?=
 =?us-ascii?Q?3CH5UEC7kTOTyR0GWJUxK5O4ygW+FuSd6SFwkVRLWd5XsC/5hH2B8dlSq5r4?=
 =?us-ascii?Q?mesK9/ZV5qZtGLHwBPiEWxFf9Yq3tlmiftFJARDV9JQPfHHlM77qgCGr8v2u?=
 =?us-ascii?Q?y6IBuIAvgH3WLC0Vk4MZf/lbbIS+AXJSWsHIUkPvFYBQPaXQl75v/U/3BzPd?=
 =?us-ascii?Q?6CWn/mEgZ+XvhGs3Cp8SZjeLsmYx95IjwmpBn3XTdEwPhHWH1viQgOuWgr+0?=
 =?us-ascii?Q?gYTY5QEmg/2ff4OsyEmFpIjAwaaTs32O2BmHIlmxc8O1KsTFfplLYzaGxqFR?=
 =?us-ascii?Q?sC5M0ICGHoVB9mkWV8JD75ptfO8iS3AxsTCQjcy3xUy06MlJKo4l3EAyGCdX?=
 =?us-ascii?Q?iTJ6FkKX7UaCLlkpWs+/3VCZ3gCOGCfmLc49jmEtpE4HhzzBfSJ2lQEEPHPE?=
 =?us-ascii?Q?OTeZkmNBGm4M3VOlRNBFZKBFIgtXPXsAun6wh2Ubw8FTragMXlwujpXXCv7G?=
 =?us-ascii?Q?36W5mS9yha4KEh3/JBugQh1oezsabfBu+Nv4gQv2DifXta59TmuPurbeUkbw?=
 =?us-ascii?Q?LfXlroHuHumaT9Ak8i/4IgwscW7kfuyqKpuxSA/ApuqNohtN+AN1yZXSECuZ?=
 =?us-ascii?Q?nwSGhZgDJllnBc8oQGjLiC9Bd5MUhohL0tR0oteCBQ+i+DXiibJiR0Q49L5O?=
 =?us-ascii?Q?A5lTcsX4fbkQ1VFF/hLq8vUESH6CrZX+id3u5IJZR5HW/emAJwPjIOZ9QjtE?=
 =?us-ascii?Q?mMtD6/MnYk5OAQ0tPAmR53tXD4/nWXWm2ADN7YfqnpxrG7LQNMA4bfs4WiBq?=
 =?us-ascii?Q?kTrbq5vURz7qeDL5V8gBi7Xezdy3e1JjK8ebK5OV6lYC4HCV3UrSTccUu34G?=
 =?us-ascii?Q?nkSv6PPmVA1WL9w0XSsmIbQhlA97aKatQsAiaQXgFQhqh0pTkZRjWeiQaCRk?=
 =?us-ascii?Q?y6dvRnoDLPShnsHWC9NtB9yQlGpYUbh7wKm2fup9H3V30irG42PnB2y5LV3U?=
 =?us-ascii?Q?MjKAoaX/T1zlg6th+MO8K6ZOBfUV/MoF4vmEy1uPBxIsCYJOKuIKz0IR/cPA?=
 =?us-ascii?Q?jMt6AL29blU26gAccVeT6yu5XMcIoUlVno0gPuEjqLCbLsrNSJ2kJIzal1MA?=
 =?us-ascii?Q?90LJfBXnYm4tp/AQ6r1Ux7+O+sKCoexNlCo7e4uM/GtrOzyhcZmiCkl+9Ol1?=
 =?us-ascii?Q?MdsK9hAOEQ2sGaA/LDEWRwNcwPBEVjWSmeuKWhXoYyz4torv3U87otW9CP01?=
 =?us-ascii?Q?fgRdqWLg05us4fxoTLeF67akFZNU+EsgGNXLyF+8NqLudIEUFrB+ANIbM+d/?=
 =?us-ascii?Q?3Hr5QHMofW3hDgf4YvgHo3k3AooNmT84?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V53qRi9qlh/h1ST60fdoSPuCZqYRIBCrTdIV/Fe1E1LytntQFh+nPMkWXR8/?=
 =?us-ascii?Q?v66wtXmLRZX8hrWhMnbmdQODT51dPlhqeCoiTz2cimJu25BGU+B+rSzKlajA?=
 =?us-ascii?Q?FRFts35FIB8AL0aBUTh7VONPqj2orZR9upxjzIJFql1nvz6Z7IbO/D1Ew3j3?=
 =?us-ascii?Q?nQ/4FGicqMGwATB7FweDLnvUGFenAAVbSKewEmB0MOg1CCale5J0/QycMxx0?=
 =?us-ascii?Q?Gy9qsreqtClNz1hxciqyyPDyFmVQ6p1bKY6zEZaPzHVZP9Ll3CY0lNJyWofo?=
 =?us-ascii?Q?+s0ZgKQ59jgg9i8hulf5QgMOkFALNG8rDPvSeJNv55ujSdcDUTcKOc+E90OC?=
 =?us-ascii?Q?sE1+zks8j1PXFVTJ+cIYfUPzSoSKpmzH3CywivgDYMnNy7Gr2qwVQE4DhmO4?=
 =?us-ascii?Q?z6FtuKsyiUakJ1OAF6WX+SctUIlxMOoD+eu/VVLusV47HHWENk9v69+XiZO3?=
 =?us-ascii?Q?CvXDri+9BQLJKGzKW7Q/D4MdkR3TbdcRBdITFJUwvC1uJUQNfGhpl3LVaI3g?=
 =?us-ascii?Q?M96ljo6yNFuFyYfRjmjSFLAZocbGpl/njNj54TT0vTupXQ00xRcyG9V4ztBY?=
 =?us-ascii?Q?O6mvRbdd91k7xp6LI88uPJ+i/135UwILsHiZKVZnSWV16O3cigP2MQGYVD6B?=
 =?us-ascii?Q?mYDMtdzGLEF1hkoJVpbjt619RwnGATre7n+5KyzivBY8XDfUG+vQj0SxO+vh?=
 =?us-ascii?Q?8o+gzWmVkaD0u7+eksxsX0ReWwGEt3/dCtghVqwh+zJNKu8IIR/G0leccSzx?=
 =?us-ascii?Q?7iqE7zaCLVmHOctvawnhtqdDUthbrLTV+S5xoAeQgDr0M0Z8Lk+7dnaJn/8n?=
 =?us-ascii?Q?awasGpjULoyTRF9/zbPD/I0pmvUJpWHoj+ejc1IGq53jY9+Qq/KCf/nLUXqp?=
 =?us-ascii?Q?d/xaLwzencf9hMckOLSkFY4i1FRMpjzecjBA/Uvb657FQILUEyfWjfOb8lXE?=
 =?us-ascii?Q?Ky8NoWqNpBh1jc8CYmqp5hprNMD/lojJeoP+4lXkOVgOF6JB2Avk5EhDncWs?=
 =?us-ascii?Q?oPYtz1jF6svk30rX1a5FTIBPS+jMSDUfGz/e/gySCo8z1CXhBDZBRf6zY2L5?=
 =?us-ascii?Q?AOp66+C8CdY5u5jBqAS8pq5H5/qdagK8z7ObVx5o7lmOaC8IRlqOIHo6p75R?=
 =?us-ascii?Q?F2m4M9j9ku6q6jgRGNQQi7A7rr/VGoWEXNON09yV5+8jPUD9czO22keemf0Y?=
 =?us-ascii?Q?eBmuBNfPw0pMp3NpbOSBPYkvkCDuSjmq1znFnXQW/dLMNVrhDQWQXpVOjcdA?=
 =?us-ascii?Q?bbguyX7GHxzW6tFaR5aCFV3XfB90cgDqD/dXEmfaTkizw5AERGwwm3kFy+pW?=
 =?us-ascii?Q?335IoGLGCJ++267GtgtzKnEEsOea9Amnavw80gw+p+HkFqW7LpV3SoQPCDuk?=
 =?us-ascii?Q?RGF2plKGyheDXa9+zxX2UbpQbG6vExZIKwAzBy/KjaKIXoFG6gRbpXYyo8b1?=
 =?us-ascii?Q?MddNoDk16QMdyk6USWaNij0RMzBBt9GAk6wq7E8toGPGg76RIcSv0L78L/18?=
 =?us-ascii?Q?XGmXuuMK31m/uRHw/2xX7hZ9d6FD2MyD6xCLlGk7C359NphC6hBj1hBc5Ejd?=
 =?us-ascii?Q?0fT/igLh6tNZ1KLssz3QdMJbWvfO762SdArNuvoCrKHUo/gKAqPstwHHGOEh?=
 =?us-ascii?Q?K0joAR/7qdBjOmsDVoZdfgs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dd9442-e35d-4f1e-1863-08dd6867a95c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:00:59.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ge1GHr935StJbwTHkrOygANAYzA6smsJM4BhVwoBoIXnkefvm0oIfTfoCkEK3e7WcHAsecUd3HS3K2KN/vRwAyLzSJeL2hFe2uzPKX9bPUYb6YdiLhgbZvgyrier5u7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18313

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 36932cbc3e6cc95a681568c28bfadd72d7c2e7ce upstream.

Add RZ/V2H(P) CPG driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240729202645.263525-4-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig         |  5 ++
 drivers/clk/renesas/Makefile        |  1 +
 drivers/clk/renesas/r9a09g057-cpg.c | 80 +++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.c     |  6 +++
 drivers/clk/renesas/rzv2h-cpg.h     |  2 +
 5 files changed, 94 insertions(+)
 create mode 100644 drivers/clk/renesas/r9a09g057-cpg.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 5bb7ce115d74..688c088a68d9 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -39,6 +39,7 @@ config CLK_RENESAS
 	select CLK_R9A07G054 if ARCH_R9A07G054
 	select CLK_R9A08G045 if ARCH_R9A08G045
 	select CLK_R9A09G011 if ARCH_R9A09G011
+	select CLK_R9A09G057 if ARCH_R9A09G057
 	select CLK_SH73A0 if ARCH_SH73A0
=20
 if CLK_RENESAS
@@ -188,6 +189,10 @@ config CLK_R9A09G011
 	bool "RZ/V2M clock support" if COMPILE_TEST
 	select CLK_RZG2L
=20
+config CLK_R9A09G057
+       bool "RZ/V2H(P) clock support" if COMPILE_TEST
+       select CLK_RZV2H
+
 config CLK_SH73A0
 	bool "SH-Mobile AG5 clock support" if COMPILE_TEST
 	select CLK_RENESAS_CPG_MSTP
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 20fee1e834dc..e7ff58c0a480 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_CLK_R9A07G044)		+=3D r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A07G054)		+=3D r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A08G045)		+=3D r9a08g045-cpg.o
 obj-$(CONFIG_CLK_R9A09G011)		+=3D r9a09g011-cpg.o
+obj-$(CONFIG_CLK_R9A09G057)		+=3D r9a09g057-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+=3D clk-sh73a0.o
=20
 # Family
diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
new file mode 100644
index 000000000000..9722b810e027
--- /dev/null
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/V2H(P) CPG driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/renesas,r9a09g057-cpg.h>
+
+#include "rzv2h-cpg.h"
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK =3D R9A09G057_IOTOP_0_SHCLK,
+
+	/* External Input Clocks */
+	CLK_AUDIO_EXTAL,
+	CLK_RTXIN,
+	CLK_QEXTAL,
+
+	/* PLL Clocks */
+	CLK_PLLCM33,
+	CLK_PLLDTY,
+	CLK_PLLCA55,
+
+	/* Internal Core Clocks */
+	CLK_PLLCM33_DIV16,
+
+	/* Module Clocks */
+	MOD_CLK_BASE,
+};
+
+static const struct cpg_core_clk r9a09g057_core_clks[] __initconst =3D {
+	/* External Clock Inputs */
+	DEF_INPUT("audio_extal", CLK_AUDIO_EXTAL),
+	DEF_INPUT("rtxin", CLK_RTXIN),
+	DEF_INPUT("qextal", CLK_QEXTAL),
+
+	/* PLL Clocks */
+	DEF_FIXED(".pllcm33", CLK_PLLCM33, CLK_QEXTAL, 200, 3),
+	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
+	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+
+	/* Internal Core Clocks */
+	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
+
+	/* Core Clocks */
+	DEF_FIXED("sys_0_pclk", R9A09G057_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
+	DEF_FIXED("iotop_0_shclk", R9A09G057_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1,=
 1),
+};
+
+static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst =3D {
+	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15),
+};
+
+static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
+	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
+};
+
+const struct rzv2h_cpg_info r9a09g057_cpg_info __initconst =3D {
+	/* Core Clocks */
+	.core_clks =3D r9a09g057_core_clks,
+	.num_core_clks =3D ARRAY_SIZE(r9a09g057_core_clks),
+	.last_dt_core_clk =3D LAST_DT_CORE_CLK,
+	.num_total_core_clks =3D MOD_CLK_BASE,
+
+	/* Module Clocks */
+	.mod_clks =3D r9a09g057_mod_clks,
+	.num_mod_clks =3D ARRAY_SIZE(r9a09g057_mod_clks),
+	.num_hw_mod_clks =3D 25 * 16,
+
+	/* Resets */
+	.resets =3D r9a09g057_resets,
+	.num_resets =3D ARRAY_SIZE(r9a09g057_resets),
+};
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index 9a568020f61f..4e10cc835c63 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -664,6 +664,12 @@ static int __init rzv2h_cpg_probe(struct platform_devi=
ce *pdev)
 }
=20
 static const struct of_device_id rzv2h_cpg_match[] =3D {
+#ifdef CONFIG_CLK_R9A09G057
+	{
+		.compatible =3D "renesas,r9a09g057-cpg",
+		.data =3D &r9a09g057_cpg_info,
+	},
+#endif
 	{ /* sentinel */ }
 };
=20
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index ab6beaa50296..6df59e041701 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -146,4 +146,6 @@ struct rzv2h_cpg_info {
 	unsigned int num_resets;
 };
=20
+extern const struct rzv2h_cpg_info r9a09g057_cpg_info;
+
 #endif	/* __RENESAS_RZV2H_CPG_H__ */
--=20
2.43.0


