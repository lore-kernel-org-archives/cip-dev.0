Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D54C83F0B
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:36 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.58])
 by mx.groups.io with SMTP id smtpd.web11.8449.1751619987702495651
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ralkFHCL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.58, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV/fYoT7hud9PtAkyBwfehi6z5g5RnSF/YelS2d9HTVn7FCFuQ9uUUe8oyUfpz0So3OkEm5DNxiN+JOopxdrZkhauNrA12GpjBMbpKnsMt9Dx+VR6h8FLANfL7sv3fdLKCfiOayAKlY4ban6L4L5TSHxlTqq6a9H5JX/WvnpOOc1pGIDguth/+9VgeWl7MEn6dtmdmpgH4JSKjaeD8H0zPMqE7kfIlPIrC5q9qnvsQqDJlVcowgWXfwWpKIMVQp7pYGuWo+1bKdMPqRzQYvuVjJYDjRMAibbybWOPEcV3ZAIzgVFiYkFPTSgs7Bz4Bsh/B+1Z7zEyhMTnnT3n0ecEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia0XSvCbpRFcL9LOpcwwXIDvK6xE7VkVfhXana5DjDA=;
 b=MXMmXR2LAeeX2yS97iZAHa17Kz/NmPFSwzr7YIOWhs/9H1Pjpe0XyU1PBHhozRe9mv7kvEQg2hYmUnI4SW07UegjiqOHKgA6+eWvuk/LHHEMc7wjf8bdnQU5Etk/LgBamyK7W1D55ekjra+WMj+JoNbM/LcQ79ADaV14pW2yO4ZQJ4NRuggFRFipUMtK0ZRXyF8SXW2+fjqMxqISGNLf/vRepqcj9fR2bpVrsPPAC/YnjeNKRm7EDbtrc4j6PeMIgd7JtJxmbPYorhPClT8ebpwqCxUbXABJcohkiq6I6qTuDPK73KnktQ/lG4luahbBR2JabmbBNKHHLgH5qFKH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia0XSvCbpRFcL9LOpcwwXIDvK6xE7VkVfhXana5DjDA=;
 b=ralkFHCLBIUN0MvBk6pXAFxx0jN5+BsPxFnyt4PUFm5Fhs0PzsYuJs/+ZHsVZfrq17qObBR7+bEcIGW2+J7P9PnUKrJCra0m5alreicAgV7A15M9884fSScQGqefYoB9FaND0rdh2yLtMwgDFAMCg4m5Zk7Dt0iFaeWI/gDmbn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:25 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/14] irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver
Date: Fri,  4 Jul 2025 11:05:45 +0200
Message-ID: <20250704090556.669652-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB13039:EE_
X-MS-Office365-Filtering-Correlation-Id: 682d8211-e422-4ae6-729d-08ddbada0dc0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?m+MtfZwE44gnSabT6O3OMyFdVWqVuFjDmKAkIvg2+f00yBa+8I2LrhADKQRw?=
 =?us-ascii?Q?RE6+RnB9+l/cMWlbcz/wkRN/zRpyohRFx6441rfvMW1q75EefuQ4guBgnZx2?=
 =?us-ascii?Q?nzYCtTTI8A3zvZdoSTZwtt5hph+9u6l/hdZX6vInUoqHPCrkN5HfORZf2NND?=
 =?us-ascii?Q?afe/b8vNixPNZ+EAXcrgluSZk5d/M5ifQN2gY7wBYWvgSTqL25lW2uf+i13F?=
 =?us-ascii?Q?NU7uduVVloOdrhU1FM3CDOwd9WVuYB8o7ISSr7rsFM/kvoHX3JsBFEZhyuc3?=
 =?us-ascii?Q?qAyqQZYJfnSm051307mjy5X7wZERi/QGQ+Eqc9dmNYyTosJRAKwLPq6m2vuv?=
 =?us-ascii?Q?D7UB/0pHWamp1hyToUyEaOYqqFxyn+AMk3qUb/zeXrhw2aiaJhGQuYjjuG1M?=
 =?us-ascii?Q?pLJchMBXzwFrUJhqMD4kc9lk9p0PbDQJbzT13hjABudcRurjY3nu3UK5SyP0?=
 =?us-ascii?Q?XIy/Wu7uHpEjPzCIwEra5LQwThKhIOZBKQafKWBquXT47kJHryj9f6szQXNg?=
 =?us-ascii?Q?s/wt25TLuL5IIg2DXoIU6glackah7sXuOiv97tev1myJ4gXKREeu2xOGS5Jj?=
 =?us-ascii?Q?OTwbuTEDPZ7PGLyck83EKXzqDBfkZPK1b1Q35lAf4/Hyei2e0lCqlWnS9ZT4?=
 =?us-ascii?Q?iN2PE/ncqFAOFvmkoXV1MbcOxt71jQwhkC6mC81XAkGhD5GrLXqYbel71++i?=
 =?us-ascii?Q?8AfE5DPork4X4IxVY/VYD/jRUg+TXvEVJY15BzWkzHq6u03183kfQkTpAQuo?=
 =?us-ascii?Q?KrhMDoz8c207iugqeLDGjP3cmx6X8MMUD9ib94UDPMsM7lMu3hmmn5rwhMPY?=
 =?us-ascii?Q?sWoVCbhU4UlQUyNo5IVg1SDIZZW7V1f+EXparxasd/SMN0aUqZdnL4ixTkpu?=
 =?us-ascii?Q?jya/9GEcKWb3wrjnyj+toMRIJgPosSyWUa5o44mKPGtWFwVV7cZ2ZbQLYyU2?=
 =?us-ascii?Q?jEwLY3HrMc0G7gkmgO8RJzADJqB1N4Y0P/S73Y1V5aKIANfVMFq9mj/CGL5y?=
 =?us-ascii?Q?rG0UHB37BsMb+4jG5awp5v6drBH4wkimlXCb8yHbGwS8N+WcAW3BXRq8SnN2?=
 =?us-ascii?Q?u1zGT7xeWV6Aa4PJ7oUZXI7N8H3VuwK8nMIT0Vmhfdat5l5albPZzeTX2Mkb?=
 =?us-ascii?Q?2dEdcQ2WN3NunRlJ1jGaNWRo7BXv+sfnA2DdAwfl4WBNT8QL21ir50XmcbvM?=
 =?us-ascii?Q?p7/7C/TMF1NU0VVgiV2cC3BSsK61VIm3H5F4Qw7FgqjuWNIVNLCEFlmD7ZBd?=
 =?us-ascii?Q?zA283aTYQ2zawTTCoVId7w43mCMm+LV+SmBlvQjfwen+usAHUmuICShPmHLQ?=
 =?us-ascii?Q?zIYZcyzIW/QDxZKM7TZCBoJu+B3vtB9BQjhqWU1fCVltdkx7Vmb19gkjX4mE?=
 =?us-ascii?Q?LnWzm6/F3YnaFFV7pdKoClY754z3daUFasacn3X1hKjPkXK9ywT+KhMXgN13?=
 =?us-ascii?Q?swz+CvaScrXeVRzoezfVCs3gMi5GW4vvK+syit5mjCn0sJ0Ow/NNYz8CIwQR?=
 =?us-ascii?Q?I/u6A94rTsP7h5I=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cHVwO7FqeKitzkwzgtGVDJYYy6rZTJEFtRWevE1dEm6fe648RcT8nz3AEDRr?=
 =?us-ascii?Q?g7al6e06NalYEDNbCeTd3ks9Z0SsXi2ysipNbGyOzh/E4YbWg0OzIO8tzQy2?=
 =?us-ascii?Q?ZmEteJowvD9FjZQLVKp6hgk3CygOFhOevqYD862WNQ3QtnZ415lMHOWTciUf?=
 =?us-ascii?Q?cl7pezCTPNjxV3Qw7eSKETBANzdE2bjhwvyz5phFiBdFIL4bDJnaXDPVK3Hr?=
 =?us-ascii?Q?z970zCCJcEgUYgyVchaukp0+CQ6a3x6b3q8SGyzjI7QISPlTVNVgWoI2gXty?=
 =?us-ascii?Q?ZWQ0vbX+4cq97x+WQyJ+spY5qlGgM9qvq5vXmeHoHsFEWi4E6GwoL33duvxu?=
 =?us-ascii?Q?nnPOBkbpA+d6mSOeqwsUwOG2/Ql5yS9LFVYfm1Dr9PeGh707xlBiwiOLnsVv?=
 =?us-ascii?Q?ZlkjIRD+aESdKJwvYqL/o+f+uUCK/KzdZX0qDsYcoRG69uhuAuuBd22rEQjd?=
 =?us-ascii?Q?E8SATbK2YXjj23015r9mgt956C0buG0YyzV6kVnylGP2WFFZaMwnGh3SqI1v?=
 =?us-ascii?Q?VUakrw4DBcjdvicHcw+Kim1VGXg8qKHWOeHOiMMtnOxYa1YNeJ5aih8ae1w+?=
 =?us-ascii?Q?d50AbHfCnZeGjkbGTkgwc7qpFaqGXQ1CdZZwTgQAbtsRn00q2AgkIyVwwaVt?=
 =?us-ascii?Q?RpR4JFLfvgURpcUmuvoSIOjCY/Rq2/VBpyiAEc2E5rmKMpZRGM7QI9jGAfng?=
 =?us-ascii?Q?eJe9n5zKoFdP7LYteB5wEjP67ebv9IgArorJeOTyf/io1E16fyayrohgyO5X?=
 =?us-ascii?Q?wND9b66xYLfH9pKly3uAyCG0xQB+7jlNWTG3TfDYpBKBRRt83aGTp+L9hmJO?=
 =?us-ascii?Q?yx85RZ2Nc1n5fv6jVAMdbuyWacrgLw+QHFih0S3P4s5mbhzSS5w3z6lqvXol?=
 =?us-ascii?Q?JjMaOeDiaLJOUgTOg8HG0GSq3Vhtd65zin0CJD03MAf3m4fWdoPUK08wMRYZ?=
 =?us-ascii?Q?TIs5uft83sSPWyslGz39URaFUkN8J0rVz9kr6VWmGeuEyOyz42RLbTY389G7?=
 =?us-ascii?Q?YXeliR8XmKUwVzQDBB9vMhWf1S/3PSf/mnQo0cfln/FcvRbr7Ctpgwg5/+Dz?=
 =?us-ascii?Q?nyeGkLaEUGRCBFclVV5lOPHzUjpEsKRBw3YMeonwQcB1CuOZEIsJBKLAmarI?=
 =?us-ascii?Q?RnDESz+kM7kfT9ille574+Ml5YpQEKGNog8milapFODT3bU0H+4iU2hbHXIT?=
 =?us-ascii?Q?K6FLex6sU8JpwdeWz+wRC5wRYU4I7mNWWcYcm8JsoxrMGqqgNshqk8Iu0Dd4?=
 =?us-ascii?Q?HVckgtYhVCFdraFYwmLg3TdHA6NSAmRF/CpaomJzXj2Wid9u5wK0sITEYVHH?=
 =?us-ascii?Q?I6KCkzcO+Y8Et1ln5BuFJ9lWGdm/WZBAji+OGQaE/CNruLm3yjr0mv2IvCFZ?=
 =?us-ascii?Q?w/3+kS+vKhE8F2OpN7ERxDtU3km+4xoNb7F4MJIjMFypNj1iO4UnV0B2IWap?=
 =?us-ascii?Q?UwrLvo5VJNJaqlEABdZ5ZjAS8mwPJBAcTaSIcy2oIo2/9q5L3Vgy9lfpwCpR?=
 =?us-ascii?Q?bQIuf1JbeD1OqtYVBq1x4NVaOIu2fg0azIGQNSdncBq+Ls9bIWAKk1sKPpa9?=
 =?us-ascii?Q?8WRH7FUdBgPDwGVI6+TMkFvPl2goMIIma6vjljFYR1XIfYbU+LIosTLdSVBc?=
 =?us-ascii?Q?//688RQJBuV8L1AX+PIjfZY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682d8211-e422-4ae6-729d-08ddbada0dc0
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:25.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmcpiguZN/Alq2ByfeQvsdn9vu8QukJxaQ3x7tU6DC//CLs/we9CNePqZ/GzCb3qp6YXIHnj1BBYx3VTkmhYFrgSZEJbZbT09NQC9JP+qFJzMOaV8P+OBaiTP46eSeAj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19332

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 0d7605e75ac2d8620929148f932cde54746c485f upstream.

Add driver for the Renesas RZ/V2H(P) Interrupt Control Unit (ICU).

This driver supports the external interrupts NMI, IRQn, and TINTn.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241009230817.798582-3-fabrizio.castro.j=
z@renesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/Kconfig             |   7 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-renesas-rzv2h.c | 513 ++++++++++++++++++++++++++++
 drivers/soc/renesas/Kconfig         |   1 +
 4 files changed, 522 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-rzv2h.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a29a426e4eed..8cc4799a1771 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -251,6 +251,13 @@ config RENESAS_RZG2L_IRQC
 	  Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt Control=
ler
 	  for external devices.
=20
+config RENESAS_RZV2H_ICU
+	bool "Renesas RZ/V2H(P) ICU support" if COMPILE_TEST
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Enable support for the Renesas RZ/V2H(P) Interrupt Control Unit (ICU)
+
 config SL28CPLD_INTC
 	bool "Kontron sl28cpld IRQ controller"
 	depends on MFD_SL28CPLD=3Dy || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 87b49a10962c..83bc93084c40 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+=3D irq-renesas-intc-i=
rqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+=3D irq-renesas-irqc.o
 obj-$(CONFIG_RENESAS_RZA1_IRQC)		+=3D irq-renesas-rza1.o
 obj-$(CONFIG_RENESAS_RZG2L_IRQC)	+=3D irq-renesas-rzg2l.o
+obj-$(CONFIG_RENESAS_RZV2H_ICU)		+=3D irq-renesas-rzv2h.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+=3D irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+=3D irq-zevio.o
 obj-$(CONFIG_ARCH_VT8500)		+=3D irq-vt8500.o
diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
new file mode 100644
index 000000000000..fe2d29e91026
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/V2H(P) ICU Driver
+ *
+ * Based on irq-renesas-rzg2l.c
+ *
+ * Copyright (C) 2024 Renesas Electronics Corporation.
+ *
+ * Author: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
+
+/* DT "interrupts" indexes */
+#define ICU_IRQ_START				1
+#define ICU_IRQ_COUNT				16
+#define ICU_TINT_START				(ICU_IRQ_START + ICU_IRQ_COUNT)
+#define ICU_TINT_COUNT				32
+#define ICU_NUM_IRQ				(ICU_TINT_START + ICU_TINT_COUNT)
+
+/* Registers */
+#define ICU_NSCNT				0x00
+#define ICU_NSCLR				0x04
+#define ICU_NITSR				0x08
+#define ICU_ISCTR				0x10
+#define ICU_ISCLR				0x14
+#define ICU_IITSR				0x18
+#define ICU_TSCTR				0x20
+#define ICU_TSCLR				0x24
+#define ICU_TITSR(k)				(0x28 + (k) * 4)
+#define ICU_TSSR(k)				(0x30 + (k) * 4)
+
+/* NMI */
+#define ICU_NMI_EDGE_FALLING			0
+#define ICU_NMI_EDGE_RISING			1
+
+#define ICU_NSCLR_NCLR				BIT(0)
+
+/* IRQ */
+#define ICU_IRQ_LEVEL_LOW			0
+#define ICU_IRQ_EDGE_FALLING			1
+#define ICU_IRQ_EDGE_RISING			2
+#define ICU_IRQ_EDGE_BOTH			3
+
+#define ICU_IITSR_IITSEL_PREP(iitsel, n)	((iitsel) << ((n) * 2))
+#define ICU_IITSR_IITSEL_GET(iitsr, n)		(((iitsr) >> ((n) * 2)) & 0x03)
+#define ICU_IITSR_IITSEL_MASK(n)		ICU_IITSR_IITSEL_PREP(0x03, n)
+
+/* TINT */
+#define ICU_TINT_EDGE_RISING			0
+#define ICU_TINT_EDGE_FALLING			1
+#define ICU_TINT_LEVEL_HIGH			2
+#define ICU_TINT_LEVEL_LOW			3
+
+#define ICU_TSSR_K(tint_nr)			((tint_nr) / 4)
+#define ICU_TSSR_TSSEL_N(tint_nr)		((tint_nr) % 4)
+#define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
+#define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
+#define ICU_TSSR_TIEN(n)			(BIT(7) << ((n) * 8))
+
+#define ICU_TITSR_K(tint_nr)			((tint_nr) / 16)
+#define ICU_TITSR_TITSEL_N(tint_nr)		((tint_nr) % 16)
+#define ICU_TITSR_TITSEL_PREP(titsel, n)	ICU_IITSR_IITSEL_PREP(titsel, n)
+#define ICU_TITSR_TITSEL_MASK(n)		ICU_IITSR_IITSEL_MASK(n)
+#define ICU_TITSR_TITSEL_GET(titsr, n)		ICU_IITSR_IITSEL_GET(titsr, n)
+
+#define ICU_TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
+#define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
+#define ICU_PB5_TINT				0x55
+
+/**
+ * struct rzv2h_icu_priv - Interrupt Control Unit controller private data =
structure.
+ * @base:	Controller's base address
+ * @irqchip:	Pointer to struct irq_chip
+ * @fwspec:	IRQ firmware specific data
+ * @lock:	Lock to serialize access to hardware registers
+ */
+struct rzv2h_icu_priv {
+	void __iomem			*base;
+	const struct irq_chip		*irqchip;
+	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
+	raw_spinlock_t			lock;
+};
+
+static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *dat=
a)
+{
+	return data->domain->host_data;
+}
+
+static void rzv2h_icu_eoi(struct irq_data *d)
+{
+	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+	unsigned int tintirq_nr;
+	u32 bit;
+
+	scoped_guard(raw_spinlock, &priv->lock) {
+		if (hw_irq >=3D ICU_TINT_START) {
+			tintirq_nr =3D hw_irq - ICU_TINT_START;
+			bit =3D BIT(tintirq_nr);
+			if (!irqd_is_level_type(d))
+				writel_relaxed(bit, priv->base + ICU_TSCLR);
+		} else if (hw_irq >=3D ICU_IRQ_START) {
+			tintirq_nr =3D hw_irq - ICU_IRQ_START;
+			bit =3D BIT(tintirq_nr);
+			if (!irqd_is_level_type(d))
+				writel_relaxed(bit, priv->base + ICU_ISCLR);
+		} else {
+			writel_relaxed(ICU_NSCLR_NCLR, priv->base + ICU_NSCLR);
+		}
+	}
+
+	irq_chip_eoi_parent(d);
+}
+
+static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
+{
+	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+	u32 tint_nr, tssel_n, k, tssr;
+
+	if (hw_irq < ICU_TINT_START)
+		return;
+
+	tint_nr =3D hw_irq - ICU_TINT_START;
+	k =3D ICU_TSSR_K(tint_nr);
+	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
+
+	guard(raw_spinlock)(&priv->lock);
+	tssr =3D readl_relaxed(priv->base + ICU_TSSR(k));
+	if (enable)
+		tssr |=3D ICU_TSSR_TIEN(tssel_n);
+	else
+		tssr &=3D ~ICU_TSSR_TIEN(tssel_n);
+	writel_relaxed(tssr, priv->base + ICU_TSSR(k));
+}
+
+static void rzv2h_icu_irq_disable(struct irq_data *d)
+{
+	irq_chip_disable_parent(d);
+	rzv2h_tint_irq_endisable(d, false);
+}
+
+static void rzv2h_icu_irq_enable(struct irq_data *d)
+{
+	rzv2h_tint_irq_endisable(d, true);
+	irq_chip_enable_parent(d);
+}
+
+static int rzv2h_nmi_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
+	u32 sense;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_FALLING:
+		sense =3D ICU_NMI_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense =3D ICU_NMI_EDGE_RISING;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(sense, priv->base + ICU_NITSR);
+
+	return 0;
+}
+
+static void rzv2h_clear_irq_int(struct rzv2h_icu_priv *priv, unsigned int =
hwirq)
+{
+	unsigned int irq_nr =3D hwirq - ICU_IRQ_START;
+	u32 isctr, iitsr, iitsel;
+	u32 bit =3D BIT(irq_nr);
+
+	isctr =3D readl_relaxed(priv->base + ICU_ISCTR);
+	iitsr =3D readl_relaxed(priv->base + ICU_IITSR);
+	iitsel =3D ICU_IITSR_IITSEL_GET(iitsr, irq_nr);
+
+	/*
+	 * When level sensing is used, the interrupt flag gets automatically clea=
red when the
+	 * interrupt signal is de-asserted by the source of the interrupt request=
, therefore clear
+	 * the interrupt only for edge triggered interrupts.
+	 */
+	if ((isctr & bit) && (iitsel !=3D ICU_IRQ_LEVEL_LOW))
+		writel_relaxed(bit, priv->base + ICU_ISCLR);
+}
+
+static int rzv2h_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rzv2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+	u32 irq_nr =3D hwirq - ICU_IRQ_START;
+	u32 iitsr, sense;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sense =3D ICU_IRQ_LEVEL_LOW;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense =3D ICU_IRQ_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense =3D ICU_IRQ_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		sense =3D ICU_IRQ_EDGE_BOTH;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	guard(raw_spinlock)(&priv->lock);
+	iitsr =3D readl_relaxed(priv->base + ICU_IITSR);
+	iitsr &=3D ~ICU_IITSR_IITSEL_MASK(irq_nr);
+	iitsr |=3D ICU_IITSR_IITSEL_PREP(sense, irq_nr);
+	rzv2h_clear_irq_int(priv, hwirq);
+	writel_relaxed(iitsr, priv->base + ICU_IITSR);
+
+	return 0;
+}
+
+static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int=
 hwirq)
+{
+	unsigned int tint_nr =3D hwirq - ICU_TINT_START;
+	int titsel_n =3D ICU_TITSR_TITSEL_N(tint_nr);
+	u32 tsctr, titsr, titsel;
+	u32 bit =3D BIT(tint_nr);
+	int k =3D tint_nr / 16;
+
+	tsctr =3D readl_relaxed(priv->base + ICU_TSCTR);
+	titsr =3D readl_relaxed(priv->base + ICU_TITSR(k));
+	titsel =3D ICU_TITSR_TITSEL_GET(titsr, titsel_n);
+
+	/*
+	 * Writing 1 to the corresponding flag from register ICU_TSCTR only has e=
ffect if
+	 * TSTATn =3D 1b and if it's a rising edge or a falling edge interrupt.
+	 */
+	if ((tsctr & bit) && ((titsel =3D=3D ICU_TINT_EDGE_RISING) ||
+			      (titsel =3D=3D ICU_TINT_EDGE_FALLING)))
+		writel_relaxed(bit, priv->base + ICU_TSCLR);
+}
+
+static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
+{
+	u32 titsr, titsr_k, titsel_n, tien;
+	struct rzv2h_icu_priv *priv;
+	u32 tssr, tssr_k, tssel_n;
+	unsigned int hwirq;
+	u32 tint, sense;
+	int tint_nr;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sense =3D ICU_TINT_LEVEL_LOW;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		sense =3D ICU_TINT_LEVEL_HIGH;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense =3D ICU_TINT_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense =3D ICU_TINT_EDGE_FALLING;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	tint =3D (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
+	if (tint > ICU_PB5_TINT)
+		return -EINVAL;
+
+	priv =3D irq_data_to_priv(d);
+	hwirq =3D irqd_to_hwirq(d);
+
+	tint_nr =3D hwirq - ICU_TINT_START;
+
+	tssr_k =3D ICU_TSSR_K(tint_nr);
+	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
+
+	titsr_k =3D ICU_TITSR_K(tint_nr);
+	titsel_n =3D ICU_TITSR_TITSEL_N(tint_nr);
+	tien =3D ICU_TSSR_TIEN(titsel_n);
+
+	guard(raw_spinlock)(&priv->lock);
+
+	tssr =3D readl_relaxed(priv->base + ICU_TSSR(tssr_k));
+	tssr &=3D ~(ICU_TSSR_TSSEL_MASK(tssel_n) | tien);
+	tssr |=3D ICU_TSSR_TSSEL_PREP(tint, tssel_n);
+
+	writel_relaxed(tssr, priv->base + ICU_TSSR(tssr_k));
+
+	titsr =3D readl_relaxed(priv->base + ICU_TITSR(titsr_k));
+	titsr &=3D ~ICU_TITSR_TITSEL_MASK(titsel_n);
+	titsr |=3D ICU_TITSR_TITSEL_PREP(sense, titsel_n);
+
+	writel_relaxed(titsr, priv->base + ICU_TITSR(titsr_k));
+
+	rzv2h_clear_tint_int(priv, hwirq);
+
+	writel_relaxed(tssr | tien, priv->base + ICU_TSSR(tssr_k));
+
+	return 0;
+}
+
+static int rzv2h_icu_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+	int ret;
+
+	if (hw_irq >=3D ICU_TINT_START)
+		ret =3D rzv2h_tint_set_type(d, type);
+	else if (hw_irq >=3D ICU_IRQ_START)
+		ret =3D rzv2h_irq_set_type(d, type);
+	else
+		ret =3D rzv2h_nmi_set_type(d, type);
+
+	if (ret)
+		return ret;
+
+	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
+}
+
+static const struct irq_chip rzv2h_icu_chip =3D {
+	.name			=3D "rzv2h-icu",
+	.irq_eoi		=3D rzv2h_icu_eoi,
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_disable		=3D rzv2h_icu_irq_disable,
+	.irq_enable		=3D rzv2h_icu_irq_enable,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_set_type		=3D rzv2h_icu_set_type,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.flags			=3D IRQCHIP_SET_TYPE_MASKED,
+};
+
+static int rzv2h_icu_alloc(struct irq_domain *domain, unsigned int virq, u=
nsigned int nr_irqs,
+			   void *arg)
+{
+	struct rzv2h_icu_priv *priv =3D domain->host_data;
+	unsigned long tint =3D 0;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	ret =3D irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	/*
+	 * For TINT interrupts the hwirq and TINT are encoded in
+	 * fwspec->param[0].
+	 * hwirq is embedded in bits 0-15.
+	 * TINT is embedded in bits 16-31.
+	 */
+	if (hwirq >=3D ICU_TINT_START) {
+		tint =3D ICU_TINT_EXTRACT_GPIOINT(hwirq);
+		hwirq =3D ICU_TINT_EXTRACT_HWIRQ(hwirq);
+
+		if (hwirq < ICU_TINT_START)
+			return -EINVAL;
+	}
+
+	if (hwirq > (ICU_NUM_IRQ - 1))
+		return -EINVAL;
+
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, priv->irqchip,
+					    (void *)(uintptr_t)tint);
+	if (ret)
+		return ret;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[=
hwirq]);
+}
+
+static const struct irq_domain_ops rzv2h_icu_domain_ops =3D {
+	.alloc		=3D rzv2h_icu_alloc,
+	.free		=3D irq_domain_free_irqs_common,
+	.translate	=3D irq_domain_translate_twocell,
+};
+
+static int rzv2h_icu_parse_interrupts(struct rzv2h_icu_priv *priv, struct =
device_node *np)
+{
+	struct of_phandle_args map;
+	unsigned int i;
+	int ret;
+
+	for (i =3D 0; i < ICU_NUM_IRQ; i++) {
+		ret =3D of_irq_parse_one(np, i, &map);
+		if (ret)
+			return ret;
+
+		of_phandle_args_to_fwspec(np, map.args, map.args_count, &priv->fwspec[i]=
);
+	}
+
+	return 0;
+}
+
+static int rzv2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
+{
+	struct irq_domain *irq_domain, *parent_domain;
+	struct rzv2h_icu_priv *rzv2h_icu_data;
+	struct platform_device *pdev;
+	struct reset_control *resetn;
+	int ret;
+
+	pdev =3D of_find_device_by_node(node);
+	if (!pdev)
+		return -ENODEV;
+
+	parent_domain =3D irq_find_host(parent);
+	if (!parent_domain) {
+		dev_err(&pdev->dev, "cannot find parent domain\n");
+		ret =3D -ENODEV;
+		goto put_dev;
+	}
+
+	rzv2h_icu_data =3D devm_kzalloc(&pdev->dev, sizeof(*rzv2h_icu_data), GFP_=
KERNEL);
+	if (!rzv2h_icu_data) {
+		ret =3D -ENOMEM;
+		goto put_dev;
+	}
+
+	rzv2h_icu_data->irqchip =3D &rzv2h_icu_chip;
+
+	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, =
NULL);
+	if (IS_ERR(rzv2h_icu_data->base)) {
+		ret =3D PTR_ERR(rzv2h_icu_data->base);
+		goto put_dev;
+	}
+
+	ret =3D rzv2h_icu_parse_interrupts(rzv2h_icu_data, node);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
+		goto put_dev;
+	}
+
+	resetn =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(resetn)) {
+		ret =3D PTR_ERR(resetn);
+		goto put_dev;
+	}
+
+	ret =3D reset_control_deassert(resetn);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
+		goto put_dev;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	ret =3D pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		goto pm_disable;
+	}
+
+	raw_spin_lock_init(&rzv2h_icu_data->lock);
+
+	irq_domain =3D irq_domain_add_hierarchy(parent_domain, 0, ICU_NUM_IRQ, no=
de,
+					      &rzv2h_icu_domain_ops, rzv2h_icu_data);
+	if (!irq_domain) {
+		dev_err(&pdev->dev, "failed to add irq domain\n");
+		ret =3D -ENOMEM;
+		goto pm_put;
+	}
+
+	/*
+	 * coccicheck complains about a missing put_device call before returning,=
 but it's a false
+	 * positive. We still need &pdev->dev after successfully returning from t=
his function.
+	 */
+	return 0;
+
+pm_put:
+	pm_runtime_put(&pdev->dev);
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(resetn);
+put_dev:
+	put_device(&pdev->dev);
+
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
+IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
+IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
+MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2H(P) ICU Driver");
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index a0d17933e410..276abc89b347 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -347,6 +347,7 @@ config ARCH_R9A09G047
=20
 config ARCH_R9A09G057
 	bool "ARM64 Platform support for RZ/V2H(P)"
+	select RENESAS_RZV2H_ICU
 	select SYS_R9A09G057
 	help
 	  This enables support for the Renesas RZ/V2H(P) SoC variants.
--=20
2.43.0


