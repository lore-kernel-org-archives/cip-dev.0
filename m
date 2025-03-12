Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E574C28B28
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.54])
 by mx.groups.io with SMTP id smtpd.web11.34783.1741778641190208736
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Pqyn1qXU;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m02qS65ZTxP3f9ZIZDuA40elNIgk2Llj6uGcwBkntJ5Je61VocvzvGmTteuPs4rKCSy7QyRGd57SfgVxtmBmXSeB3ArlrJg6OAUuB7bNHxt/SKS8ui/uuh0m1J+5KKkm9nRl5Yu/D2XBKiEDbjYJnUkpiC9enghAghB1L25cLG4v41vFcKM58E62gMLQarEUWncSYVFjO4n3EyRdmG28iVDrbDg3WiKop3RwcKRsjKvqJoTU6G0SrXpL5jOHqvzJJmHZh2f4+RaYlRNDbKM1r4HskugAqqG25yQfO+hKTY4EB4uwgy6p5XMKASHlC05uHj3npSoguN8kJkhOm5SLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WElt/o4hVNAkmVHy/ceB1HKkWtL7VvRX+tpksdQZlJE=;
 b=T8GaGUbHKXf03reEQI1K5zhT7ogNvDCLKWIjyvT/8kNi9cDzTFrZneadCrhOl2Qq0ATwSqBIcZta/UvfA9IkZKVGYc9I/J66L92GpInUPaFWIIqRINPheydghG5x52uGpWDrUocei9/CvW/lVoO5WM76vSKJHuF/h4YPqIXtyRBgRor1LEnBEx8A1YYUdyqJavR/kVAR6cIsmW+lt1/EMuUMiv0166+302s356otN3pnlLMhrSlQhlfRt9H8Otf935oRgQIeE+XHto3wV/JuIdlb7yIY+JKBxkeTWjYSUAJuv68ZjoMK4JuJM+lG/xxGcL6E0PbRx+rQt2QsAr2WHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WElt/o4hVNAkmVHy/ceB1HKkWtL7VvRX+tpksdQZlJE=;
 b=Pqyn1qXUvv8Tcm05ka2OLRdn3QGT2fsjdU3lN+OKkBtbf9HFV5nL+OgKr5KtDB+ema8nrXp4oUhe+jPqdM0TQqcfCeblsuPMF2kANbZ4UstgsjNBD39HMcf1VenuC2GUhqmhUsyVoTWIJ9aGELqUVYZWls64HegTGaeje5svKv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:23:54 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:23:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/85] clk: renesas: Add RZ/V2H(P) CPG driver
Date: Wed, 12 Mar 2025 12:21:43 +0100
Message-ID: <20250312112302.1605750-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e776cd-6b5b-4bae-0024-08dd61585f8c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uUL9QEuscPbtZOcTXBGTPl4e4dVuB8TFXT1fe51q2zwuayl9y7ske3X8tH5X?=
 =?us-ascii?Q?Q3uvDQ4ILZELY9lKuIRSdEQ4t00Ibq4155uNPMor2B4fAtNTBr2ouCdSHBD7?=
 =?us-ascii?Q?nRGUkm2KJd0bBFdR5DenoNf/ev4jbNeVvkZR3LN4WhEs8pp6YC+2R5uRQpu3?=
 =?us-ascii?Q?USjzdgM64fXGEIM6ERRI2kf+QmbZhf4G78BpxjCyRtyuiYd6qZx8qUGeCSTP?=
 =?us-ascii?Q?dl+jUWqlS5zwSVuPBUmym2ktHxLGeXWqZqJjC65VlDRG6Dk1Oa5OMckDbkQ+?=
 =?us-ascii?Q?qoyeuFLxeWjKqPyMPNcAnxgQ6ujrT0HDCbv7Wo43QqYeopTystzT0GhuErsg?=
 =?us-ascii?Q?U3lWiJ9yR8rYX5yKYtQdR7MhWOAmh4DrjBrQ7KsiXCm86Rbcs/HfrjVJxgZ8?=
 =?us-ascii?Q?qXcO8SgU45mRsx06edKjhqYYWL8vbQFf8LCaBw5TYBp/9WWUxMNVW7c+qvPv?=
 =?us-ascii?Q?7b7Bmp1BXv6rFdAoT7Xebg+3OcNdBzrc5l7QoYlYiXLf3vjUTDtY4/vEHS8A?=
 =?us-ascii?Q?sj6psfULntMQjiA8p1VgnGgmNdK6LkEkNSsGspF0jvvMkY9vIlS8DwsznDIc?=
 =?us-ascii?Q?4yo0G9rOpyRh101PbuaSpFm5rP9JSV3z4YBWf5uTwbLbgrBUPqRDpXkZyxpa?=
 =?us-ascii?Q?nqJA81ZPP90k5tgMhh2X+vHVur2bgJq58za1lstC5CiadmfSA1h5zcSw7byX?=
 =?us-ascii?Q?8WVdEUsP+01ZB8wPelfRqCf73cpBngvWYMF33OPFObot6FBSy/lDppmFONCW?=
 =?us-ascii?Q?r1Btfyb0/dPaacyQdhfxyYzKFcXtOwViCbZiE2mzzA5WwfXkucTe23IFgbrM?=
 =?us-ascii?Q?eXl+6ezDwk48JOtFdMg1wbwXjnnXXsf7y9wJvymLFEatirvkCGSipHpOAPko?=
 =?us-ascii?Q?v5Iopda1oQWc4GA1WsXZcnoNpwMI39YeKXxMAQ/tYCxLwcdpqo+MSpMd6zUo?=
 =?us-ascii?Q?cqRNmz8GLFl2TGCD2cV+ZcLx0gJqL/hLlNZla5IdbR6jsctQKVJwEG8/QnOc?=
 =?us-ascii?Q?QL1TfuZREUpFHlNod1dAMlxk9SarAdy3P+vD0o6C0PWZpO5BwqhMMpnBL+e3?=
 =?us-ascii?Q?X55HNYxrCLnvDiW6jZ65GVSRQmaLghNW2RtRtHzFr+xpQC52qpEEJqDDUJHD?=
 =?us-ascii?Q?ZCeO03//3jhgotsb+06hhu8qPF6QlTXa6D7h4RQNnP0FSawKwygYi/1OqWxT?=
 =?us-ascii?Q?MNvH/4qFS6Mw7XtzXg2NpVlX+krZeC0vVeVtSyEuGHZEdnHBgE9hdI+YxP8U?=
 =?us-ascii?Q?D92pk67q3kbu5Kryo6EWh7QLeqwajwU5uVKL5Fz6hspdatFGmafUGKLjwEtE?=
 =?us-ascii?Q?y2Q8X+ObUrY6nayXQdkP3fp4yRtnTzBtRbZ+GfCm/zRbONjGffHXnSWD2giB?=
 =?us-ascii?Q?v1bI+Vnkvaq4oOB+UOugKGJEFtJXrIJfQPiXKs0MKAWlCsBBXS+Klqd67Oa/?=
 =?us-ascii?Q?0tOSYPtuAnxky6I39XCbha5OS/h9KYTd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+R3hE5ywXlioQI94y0k3Dfi56faDLt9FszPF+Fr/pAJI5iMbBJb3Kzikv0Ol?=
 =?us-ascii?Q?1MBs2iItejqAVtKnPZnjPXGWHmWObyZtv2fjTkw+taZ4E9jtOvYRsNqi83Ez?=
 =?us-ascii?Q?v4M/6RkDXGIQqkDltUtoGZWM/p55dTe5KMrOTckT/yb3BpdoAZBjGLHT3ZVC?=
 =?us-ascii?Q?qrFoz4OZopTUQZWdT3DlThH1Gtdw90xr0zWYibtBDw3S+Q5S7xZr42XatZqp?=
 =?us-ascii?Q?fFrgM0ubZ6ZfV5Tsu05az3sItnoBwlZJmwR9t/0rhB9/GpM30qF4ZIWzjvS+?=
 =?us-ascii?Q?1/nkm5nYPks4ElJhkP4M9mRvVpOgpvV/AZtrqWRCRbkgsPWt0vmtneMS+gCi?=
 =?us-ascii?Q?PZFraVn1moMC2lZuXyY9K3Iza65dgqzClluWkY59Im67EiOsdnybOaMEVgQ3?=
 =?us-ascii?Q?kgNLnSqLuDgsJdwEIbFZzHr4Ap4uSAvo0nCNgMwjo6dDVEj6TrVITtoXIYTL?=
 =?us-ascii?Q?cyvFLBys0eUIUSI0rCcqrTfTXZ0I6YwdPLGo9J5X8pna9m8Lc3Nti08Gk4YR?=
 =?us-ascii?Q?OnOdptVOP3YYBr/AVuN8RVoBcYHjrJpXsq9Dcc7cRxqjZM1kn+wZq6Ex+UrD?=
 =?us-ascii?Q?yG7EQ28KFmhi0/nvZgmTSTxpip4vmHebyzWcRDfBf5czRz024Na9MPm68V3n?=
 =?us-ascii?Q?a5MVSwqFB+S243kyrMXEmcpbUNBrslZfkBgp7sqSgPsenDkUmgoGoMKatgJB?=
 =?us-ascii?Q?QJA9nVNuHrdN/W+JiXsRxaU58aICsA6fDu39MWFy1aB8W2AFoBKk2iOdwMAX?=
 =?us-ascii?Q?QbnrWVzwAbgc8V/Ddmf6lgy+TffYDSKSWn5j4tzIpEKIskVLOxtj9d50Uwkx?=
 =?us-ascii?Q?BR+OJ6A1dLS4sSFSD/zOtzPtXOgprIsimZul9IbMqVEBzWNuyl3fGCPhuCIH?=
 =?us-ascii?Q?ie2ompTZlwIMAgVL2U1duvrRR6cc+bPH7IgyoRN2AHRVz1mQmx6TtfiZOv00?=
 =?us-ascii?Q?PYw2pRvIX2YbIM9irE8h4X+KJH94ageHNFEhTEcNVPEdUUYzzG10kbIVjFf5?=
 =?us-ascii?Q?RD5GMKX9MoX6Rg0g7RxAhF5tHuADYC6PGsJ76cfvkg6v3TcRfLNfPiRRsyMl?=
 =?us-ascii?Q?6mBKsH/8MOs+CCLO9NHkmJONL057fHV4gvT8431PDoMtk672Q3JUdZnfhah3?=
 =?us-ascii?Q?podiq6btuJkOlhSlJdSKQV8etVGZwd5tA/srUnUcj+Jo6RfgAJJD589IELUE?=
 =?us-ascii?Q?w5XmmS0mdyMV8VvK9ovtb0DMfYy1+sRz3mZJ402KDrueCFzCl/hCz1S3omqN?=
 =?us-ascii?Q?lcDhgSbWW7gHqphBVpLZGUInSY89p0xyrxXVGtJ58JjjDCvD5jBLmC2x50MJ?=
 =?us-ascii?Q?qLkhUbn//tII8/vJE1G2i9RrP0irB1r/CE/1lz18HXydgGgv12ZHhlRlLmG1?=
 =?us-ascii?Q?0FXkE+LN7tSp+tH0yhhwyCOA/4zQaXH1hl7STyCnycYJoSjjdmjw6+bBQQET?=
 =?us-ascii?Q?Z2IAm/s6Q0l6abGsB+XzfbkimZzxNE+dqJLnXX1FHOYT0HFgqd5otCE772B/?=
 =?us-ascii?Q?/FzDNw4J0btcUvVUXBsgBKguhcqkYlDcAN/bvksKjyAXwEwDEVCmEgccAZ97?=
 =?us-ascii?Q?L6aH+IIL0GaMN5SGPJQu1zbf88lL8g8YwyHDNs19+G8nWiufHeS5qgErB/eI?=
 =?us-ascii?Q?t+b8PmA8DCXR2HNNj5izczg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e776cd-6b5b-4bae-0024-08dd61585f8c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:23:54.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYDwYtQbI8PiXPlVfbnukMJHPY68E2zxFAPL+6q+8F+HenZ6CW+Q46NSHwzMpRIh16Bo4DNQeOIIYsnvzPdzIOKKvI8EGHYRP9rrxHIiWqi74F/7Q8SSiQacbf5Fg1iG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18099

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 36932cbc3e6cc95a681568c28bfadd72d7c2e7ce upstream.

Add RZ/V2H(P) CPG driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240729202645.263525-4-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


