Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C70C35FFF
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:00:59 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.48])
 by mx.groups.io with SMTP id smtpd.web10.18677.1742554856700641334
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:00:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=S/WHJEAw;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIp0SJjY9yKE8bJRY9KkhxVqrUCuWdTVRKzqABT6qhz9vMhR38VLvTj1u0dmko/xymo6g4sXv24JCQ+0xzS4Lw2VGmdGFqlXnOlZeBhbBNwlILL6qpol2+i4SPA70ii9MlUJYNaZPUo2BPVnPwrxleLa5RjoegDmMoN69pDMUunY/On57JbdxfQkmhuj+rzEqviMGnsRRLdqXWhWLadNsQNJHuoR0LiGj3uUiVvbFNvGqNZ0If/tcQcVuxBGJ6tTMFKwNuiJjOqD7RDYHlo4H9HWKEYCAmXZPDoIsTYC+Vrp0f25RAALQHef4Pz8mAqeM5CB8q/uHSfBYUbcEwPVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gKwccpB9pYat/EA8bmRjoIMa8NP5AMcgPll/3GOW0I=;
 b=PJNmn/hOq5Oe4mSRo8JnMG9upYYmIDCD6Uc6/VMnkvWz4qdDuZDBQgkchvg6HYmN2uKPYlIHEVL54Eq5GKV6OvjJVSN30YyD4igVeP4xxGi4K23UoWub+71SlpO371ei/Q4EazCYnEMT4Hf1KnrVmoAYzKxiriXvhucAExduAlHaxsNCK9ZKW9pmilBRyuDY0MQfvi/TPRWY3KyBQtVXHyf6+CCLni8SbG+6pK0cHfR06rvABjcH88Zi79UDYVDFsve7JzwGH5Uh+HLb8hCqeeawFRcMc3qXpjjkp35ZUy5/YfvS+cGxGjE2mvvkTYx9OomV8Vy3E8P6+R9hJHd4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gKwccpB9pYat/EA8bmRjoIMa8NP5AMcgPll/3GOW0I=;
 b=S/WHJEAwjKHOU+XA9ImAeZFLS7hCs9jpgRZzwzxZ0a47ml7NkAjgVXsCByAdov5T63wsmzDko08JqnCLplV92HvOR6zrBKGNvDXRGEGDqY4RVsc1iB0XrZgTNi0Q6NzOAz0kbQLPlte6e4HPE+zgRqjvIqlMd5REFfz4jSNEKvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB12437.jpnprd01.prod.outlook.com (2603:1096:604:2e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:00:56 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:00:56 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/21] clk: renesas: Add family-specific clock driver for RZ/V2H(P)
Date: Fri, 21 Mar 2025 12:00:05 +0100
Message-ID: <20250321110021.3612805-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32d7542b-b97b-4916-91bb-08dd6867a79e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xrpDOoexUzLjlolYRvjDT2/n4j9TY1qhXRTbFRPzxsqpkBIYfk6kCDon7QSp?=
 =?us-ascii?Q?oqkNEpfmbs1bC9WQOzxAeJL7EBZsoSYEBIQXLpj1gaDRAPeFtcxuxiEFs5L7?=
 =?us-ascii?Q?PfDJB/f5CBpnH7/Y18zdCTR4MOzRmEUkgYdolnxPGgmaw7a4reGr4b7aknom?=
 =?us-ascii?Q?G6FjORjzI+R01JGeVUto3Ay1DspeKLfjbRHncm+scDviOJLLQU6HBrSHc9Zu?=
 =?us-ascii?Q?GRWNRLNthZUzrJ7DRONrTi79wVF64SkNxgy3w2lSdnbW2QkVSDdBE9SA6tD7?=
 =?us-ascii?Q?cwJ8SSQDP7U+3NkNdAw9KAu1q1ePhGOYcaZplTPX2K4if3UcWaiJNFIbnRvA?=
 =?us-ascii?Q?g8aV29rNgFhD+fCnBqZSHvnAyqKWZVXLMAcyi5y84IwKPEzeI800CZxmSTTj?=
 =?us-ascii?Q?0l9Yla6UATibsJqmPXHJFZboa0DmOU+9o983CrS3MYMp3FtrvH17oV2ukv+l?=
 =?us-ascii?Q?QWDx+v5VnZj+cocSUh2ny8UjQch4AS8jxRCS/0TM4TA9adV8Z3JUK32zV5fq?=
 =?us-ascii?Q?cbr8OUsZLi2EGmdOpOTNa9DyvuZFC4At+GYsN41AVnHFlIIJ6dJycFHkZy/Z?=
 =?us-ascii?Q?H8JV1/+l8r/J+N0CHHkBP5EvPC23rOeW5Wj7IefLpJyTWv6ZuCoDIGxS9uvz?=
 =?us-ascii?Q?6vRHBWmd/6OJIgseolzAi5+/CDOtsBX6KKcnUYii2fLXJaiKQ02TrrVoAXR3?=
 =?us-ascii?Q?WBbUfGGqfr/vgLaFVcGNJeARhOJf0aLgKHYw/5mzoBbmTyaGFzEy3Afe4p2g?=
 =?us-ascii?Q?yicyt8kzPVaENgWL6FQ8aKvUK45HRbXCyWxXYCbIr0zqBVwfK1fqsFiMSbMY?=
 =?us-ascii?Q?8FR4t+PIuFqGpxFL+dfwkvho5HjcDJrhLS0LqNnPuKKrk5/bciAHq2QZCNXO?=
 =?us-ascii?Q?o6STOlr9REbQb1EyvvDP5kSFkkqeg7u0rNMoQd7HmxejObSFFFcpVtAQcWDF?=
 =?us-ascii?Q?1pYxu4Bh7Po1JrTzywDefOYyGt3EBznCCuWPltLjhr65HZ55FrHVgvOpu2sh?=
 =?us-ascii?Q?Nv9E0et08dYo1lRog4/Fo9dpFTL7/MnCZTXnzd4OBuX3Z1htFZqtYyYzlIgO?=
 =?us-ascii?Q?pBe9139l5WPNbXQMN7jNvDhbDd9k7b/0R3f/wW5pS7Z9oaZR8vlFxP6mgOy+?=
 =?us-ascii?Q?ZP5qk+om5E3aJ4idcFH+fvF1lHh99p92iFXlQghTLUoM39KYByujYTqRJrDj?=
 =?us-ascii?Q?sf0JN7plfJ8jyqke7jt3S08q3gMOJCMF1+oUbpmuuOaHqRVHYUMg1u5EWEhy?=
 =?us-ascii?Q?YFw41TfPKY8gkBi3+befGd3l+bj2i12yg8CbfNaTc+12gD3NkGz5CWYhnQ78?=
 =?us-ascii?Q?uOdfyVgLsqPihYd+SENcKxbbqJjPI7vg9fvyx+L4CMfB3z+Vmbq2vF6VH9ZG?=
 =?us-ascii?Q?JobGN8/UrDlZdkUBPBgs1FxM7RFWIKU/vfsj20zo0R9PPVzvjFpcNsAVk+3G?=
 =?us-ascii?Q?liLZAkR9vidC+esRFXxFq8xBVJhtBANz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yEkwjrBTaDE879ne33wowz4OsLkojjqLmJqGUI7y5K0nJC1AskPM6Qtvg5g8?=
 =?us-ascii?Q?AR+tXzgL4BDlI06kuCKar+5UQAmIlbySQ0+ATUHzJYciUXpfrlDZOKT5CyPG?=
 =?us-ascii?Q?2GnQ3uBmt+IikwSjbeDs16RwPTsAuR8SME+BDXa/98cYiHNvQsN5q54BhFoS?=
 =?us-ascii?Q?FHk3AwAPYX9aN0D1jKs7J7Pg9+OY52yB4UkaA6H/43FZtfvWhvxhRDBaDViZ?=
 =?us-ascii?Q?Y7dhk+0/+1+mvTFeWN5NmXs8zV0yXC8uiIOOHsk4T/ifg06SAiVc2c7ACJ7D?=
 =?us-ascii?Q?Da7Me2zbIirWb2t/QApiiJJ/ej4k/aB6Wzylq5LVY3EHvBLqrq1bphEMr8/A?=
 =?us-ascii?Q?1+YpELoRK8SNICDeWGLSF67ZR/fQV7LRxhEZonVv+arsENj8PE5KiV4GQcLf?=
 =?us-ascii?Q?fGRI8gUqDhfLn096xPEmgiKmqD4eARZuHau2Z5BXcIUUYP0cj2XXI8CB5RwW?=
 =?us-ascii?Q?YcDFizY0LfK76TLRHyqZvZHWxOAr8rrrckFfyPTbMo0ilC1R10TDQeQ1mi04?=
 =?us-ascii?Q?IA2h9XM+cHyWCFPW3fffvgHbKcHMawX/+wpqcQz1Rr5bMq0uL4S41jP/Vu9N?=
 =?us-ascii?Q?wMmLuDl0pSsB6sO2XV/bO+NduM1y9vCbuqG/vGoV8X1w9zukd4VIbqw7IqFM?=
 =?us-ascii?Q?l9gA7FfsotMuIP8IOI2vM4CpYlo1bnMuhNx9a5ezAec8kjdjq+4DolGcmItf?=
 =?us-ascii?Q?pfEHZBWoD4szhAu0cFE1vghbSqCNIv9K9nR0ShQLV8IIpmra+6tmAmCe/5DY?=
 =?us-ascii?Q?yigSA46+/TXFccVu40/3+dxhDdl+f+6KGUKe8POugn2h1pfYi+W7JaqRcRJY?=
 =?us-ascii?Q?kTvbMI65s8SbJhwCvgnGm1iUbnYSSoJ1/iHpeejy1jT8mVwS+3cIvu81selu?=
 =?us-ascii?Q?hHU5URuVHe6qGX+pwd3I/8kQHV398jZXzYe6MobQ5Fp/8r04EOPwXpG4OGai?=
 =?us-ascii?Q?tEd4Me+7pHeGlKF/WlJgPoCmY6Ph0kB6MyWJscI4BWPKqs8iqWS1/gvRfsSZ?=
 =?us-ascii?Q?vt1aT84Fyi5NlTEaQc2PlCaCHkj0xzOQdDZsBEFWQEwW6psnrYIZ/Nim9ZeW?=
 =?us-ascii?Q?69mYj9m/P83TV5d2vx9sDzP+mW9s1Id1WXS2Pew1+qEvnDAyBWQzk14Bi1qQ?=
 =?us-ascii?Q?kvAeiJ9XQkNq+rfAxMCCLqsvjv2O1V5SxUaV2FeyA5JdFNvLYPMMdnguBue/?=
 =?us-ascii?Q?oSzvUnBvFv7JxBvNdNi30Z1+OuII5MRhBJt+H2UpWMiTz7cJB93nom+nkpzp?=
 =?us-ascii?Q?Z/2ITjXo/a0ALhvHqcgz3r7COKdxS/ZCB560UVib3BWht3PIqHt6tzICUClP?=
 =?us-ascii?Q?ZWbFSoI1nkmb4Gjd2v5MdYnPkFUHk6cfwEji5Ji3lCqvjcTu8vZKDfqCtQhH?=
 =?us-ascii?Q?+ZDXsEKLb758fzqY3weTnl3I9NOsWNWvIf2fJEpS45EY4d0LBdvB3mj0srlT?=
 =?us-ascii?Q?s2Wrz/3vRuuPKmOIXGTds6+VlzAI+2PLCX2JLKw07VybU22bEStmq5UobaP/?=
 =?us-ascii?Q?5aKtgLPbQot5ap/w5XyPUO3I6RP9aNw8taLEc6Atq/Jz790LINI2XHlzNHpu?=
 =?us-ascii?Q?EI8hV07FGozPj6NwoEoca2OO8gTKv7erFhPLm0dH+jErE8/1Wv8zEK/3Abny?=
 =?us-ascii?Q?9o3lr+Q/sjAad4nvNB2CTaE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d7542b-b97b-4916-91bb-08dd6867a79e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:00:56.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kWcAzmE9nh4cENHW7ts36+gHF8KMrhUDkMcSEBc6+4seWJ55zxmYBbETj+frc4cLwsu8mjMv9qzJYsWac4HBgneCz5uGe6aX51FC/7SOCPl7NKcW1GX7ZRzDEocTW/m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:00:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18312

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit dd22e56217495e2d392ded86a1e11a908e424e64 upstream.

Add family-specific clock driver for RZ/V2H(P) SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240729202645.263525-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig     |   4 +
 drivers/clk/renesas/Makefile    |   1 +
 drivers/clk/renesas/rzv2h-cpg.c | 684 ++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h | 149 +++++++
 4 files changed, 838 insertions(+)
 create mode 100644 drivers/clk/renesas/rzv2h-cpg.c
 create mode 100644 drivers/clk/renesas/rzv2h-cpg.h

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 04593172392e..5bb7ce115d74 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -228,6 +228,10 @@ config CLK_RENESAS_VBATTB
 	depends on ARCH_RZG2L || COMPILE_TEST
 	select RESET_CONTROLLER
=20
+config CLK_RZV2H
+	bool "RZ/V2H(P) family clock support" if COMPILE_TEST
+	select RESET_CONTROLLER
+
 # Generic
 config CLK_RENESAS_CPG_MSSR
 	bool "CPG/MSSR clock support" if COMPILE_TEST
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 46bdcbcbf183..20fee1e834dc 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_CLK_RCAR_GEN3_CPG)		+=3D rcar-gen3-cpg.o
 obj-$(CONFIG_CLK_RCAR_GEN4_CPG)		+=3D rcar-gen4-cpg.o
 obj-$(CONFIG_CLK_RCAR_USB2_CLOCK_SEL)	+=3D rcar-usb2-clock-sel.o
 obj-$(CONFIG_CLK_RZG2L)			+=3D rzg2l-cpg.o
+obj-$(CONFIG_CLK_RZV2H)			+=3D rzv2h-cpg.o
=20
 # Generic
 obj-$(CONFIG_CLK_RENESAS_CPG_MSSR)	+=3D renesas-cpg-mssr.o
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
new file mode 100644
index 000000000000..9a568020f61f
--- /dev/null
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -0,0 +1,684 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/V2H(P) Clock Pulse Generator
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ *
+ * Based on rzg2l-cpg.c
+ *
+ * Copyright (C) 2015 Glider bvba
+ * Copyright (C) 2013 Ideas On Board SPRL
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_domain.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+#include "rzv2h-cpg.h"
+
+#ifdef DEBUG
+#define WARN_DEBUG(x)		WARN_ON(x)
+#else
+#define WARN_DEBUG(x)		do { } while (0)
+#endif
+
+#define GET_CLK_ON_OFFSET(x)	(0x600 + ((x) * 4))
+#define GET_CLK_MON_OFFSET(x)	(0x800 + ((x) * 4))
+#define GET_RST_OFFSET(x)	(0x900 + ((x) * 4))
+#define GET_RST_MON_OFFSET(x)	(0xA00 + ((x) * 4))
+
+#define KDIV(val)		((s16)FIELD_GET(GENMASK(31, 16), (val)))
+#define MDIV(val)		FIELD_GET(GENMASK(15, 6), (val))
+#define PDIV(val)		FIELD_GET(GENMASK(5, 0), (val))
+#define SDIV(val)		FIELD_GET(GENMASK(2, 0), (val))
+
+#define GET_MOD_CLK_ID(base, index, bit)		\
+			((base) + ((((index) * (16))) + (bit)))
+
+/**
+ * struct rzv2h_cpg_priv - Clock Pulse Generator Private Data
+ *
+ * @dev: CPG device
+ * @base: CPG register block base address
+ * @clks: Array containing all Core and Module Clocks
+ * @num_core_clks: Number of Core Clocks in clks[]
+ * @num_mod_clks: Number of Module Clocks in clks[]
+ * @resets: Array of resets
+ * @num_resets: Number of Module Resets in info->resets[]
+ * @last_dt_core_clk: ID of the last Core Clock exported to DT
+ * @rcdev: Reset controller entity
+ */
+struct rzv2h_cpg_priv {
+	struct device *dev;
+	void __iomem *base;
+
+	struct clk **clks;
+	unsigned int num_core_clks;
+	unsigned int num_mod_clks;
+	struct rzv2h_reset *resets;
+	unsigned int num_resets;
+	unsigned int last_dt_core_clk;
+
+	struct reset_controller_dev rcdev;
+};
+
+#define rcdev_to_priv(x)	container_of(x, struct rzv2h_cpg_priv, rcdev)
+
+struct pll_clk {
+	struct rzv2h_cpg_priv *priv;
+	void __iomem *base;
+	struct clk_hw hw;
+	unsigned int conf;
+	unsigned int type;
+};
+
+#define to_pll(_hw)	container_of(_hw, struct pll_clk, hw)
+
+/**
+ * struct mod_clock - Module clock
+ *
+ * @priv: CPG private data
+ * @hw: handle between common and hardware-specific interfaces
+ * @on_index: register offset
+ * @on_bit: ON/MON bit
+ * @mon_index: monitor register offset
+ * @mon_bit: montor bit
+ */
+struct mod_clock {
+	struct rzv2h_cpg_priv *priv;
+	struct clk_hw hw;
+	u8 on_index;
+	u8 on_bit;
+	s8 mon_index;
+	u8 mon_bit;
+};
+
+#define to_mod_clock(_hw) container_of(_hw, struct mod_clock, hw)
+
+static unsigned long rzv2h_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct pll_clk *pll_clk =3D to_pll(hw);
+	struct rzv2h_cpg_priv *priv =3D pll_clk->priv;
+	unsigned int clk1, clk2;
+	u64 rate;
+
+	if (!PLL_CLK_ACCESS(pll_clk->conf))
+		return 0;
+
+	clk1 =3D readl(priv->base + PLL_CLK1_OFFSET(pll_clk->conf));
+	clk2 =3D readl(priv->base + PLL_CLK2_OFFSET(pll_clk->conf));
+
+	rate =3D mul_u64_u32_shr(parent_rate, (MDIV(clk1) << 16) + KDIV(clk1),
+			       16 + SDIV(clk2));
+
+	return DIV_ROUND_CLOSEST_ULL(rate, PDIV(clk1));
+}
+
+static const struct clk_ops rzv2h_cpg_pll_ops =3D {
+	.recalc_rate =3D rzv2h_cpg_pll_clk_recalc_rate,
+};
+
+static struct clk * __init
+rzv2h_cpg_pll_clk_register(const struct cpg_core_clk *core,
+			   struct rzv2h_cpg_priv *priv,
+			   const struct clk_ops *ops)
+{
+	void __iomem *base =3D priv->base;
+	struct device *dev =3D priv->dev;
+	struct clk_init_data init;
+	const struct clk *parent;
+	const char *parent_name;
+	struct pll_clk *pll_clk;
+	int ret;
+
+	parent =3D priv->clks[core->parent];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	pll_clk =3D devm_kzalloc(dev, sizeof(*pll_clk), GFP_KERNEL);
+	if (!pll_clk)
+		return ERR_PTR(-ENOMEM);
+
+	parent_name =3D __clk_get_name(parent);
+	init.name =3D core->name;
+	init.ops =3D ops;
+	init.flags =3D 0;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+
+	pll_clk->hw.init =3D &init;
+	pll_clk->conf =3D core->conf;
+	pll_clk->base =3D base;
+	pll_clk->priv =3D priv;
+	pll_clk->type =3D core->type;
+
+	ret =3D devm_clk_hw_register(dev, &pll_clk->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return pll_clk->hw.clk;
+}
+
+static struct clk
+*rzv2h_cpg_clk_src_twocell_get(struct of_phandle_args *clkspec,
+			       void *data)
+{
+	unsigned int clkidx =3D clkspec->args[1];
+	struct rzv2h_cpg_priv *priv =3D data;
+	struct device *dev =3D priv->dev;
+	const char *type;
+	struct clk *clk;
+
+	switch (clkspec->args[0]) {
+	case CPG_CORE:
+		type =3D "core";
+		if (clkidx > priv->last_dt_core_clk) {
+			dev_err(dev, "Invalid %s clock index %u\n", type, clkidx);
+			return ERR_PTR(-EINVAL);
+		}
+		clk =3D priv->clks[clkidx];
+		break;
+
+	case CPG_MOD:
+		type =3D "module";
+		if (clkidx >=3D priv->num_mod_clks) {
+			dev_err(dev, "Invalid %s clock index %u\n", type, clkidx);
+			return ERR_PTR(-EINVAL);
+		}
+		clk =3D priv->clks[priv->num_core_clks + clkidx];
+		break;
+
+	default:
+		dev_err(dev, "Invalid CPG clock type %u\n", clkspec->args[0]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (IS_ERR(clk))
+		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
+			PTR_ERR(clk));
+	else
+		dev_dbg(dev, "clock (%u, %u) is %pC at %lu Hz\n",
+			clkspec->args[0], clkspec->args[1], clk,
+			clk_get_rate(clk));
+	return clk;
+}
+
+static void __init
+rzv2h_cpg_register_core_clk(const struct cpg_core_clk *core,
+			    struct rzv2h_cpg_priv *priv)
+{
+	struct clk *clk =3D ERR_PTR(-EOPNOTSUPP), *parent;
+	unsigned int id =3D core->id, div =3D core->div;
+	struct device *dev =3D priv->dev;
+	const char *parent_name;
+	struct clk_hw *clk_hw;
+
+	WARN_DEBUG(id >=3D priv->num_core_clks);
+	WARN_DEBUG(PTR_ERR(priv->clks[id]) !=3D -ENOENT);
+
+	switch (core->type) {
+	case CLK_TYPE_IN:
+		clk =3D of_clk_get_by_name(priv->dev->of_node, core->name);
+		break;
+	case CLK_TYPE_FF:
+		WARN_DEBUG(core->parent >=3D priv->num_core_clks);
+		parent =3D priv->clks[core->parent];
+		if (IS_ERR(parent)) {
+			clk =3D parent;
+			goto fail;
+		}
+
+		parent_name =3D __clk_get_name(parent);
+		clk_hw =3D devm_clk_hw_register_fixed_factor(dev, core->name,
+							   parent_name, CLK_SET_RATE_PARENT,
+							   core->mult, div);
+		if (IS_ERR(clk_hw))
+			clk =3D ERR_CAST(clk_hw);
+		else
+			clk =3D clk_hw->clk;
+		break;
+	case CLK_TYPE_PLL:
+		clk =3D rzv2h_cpg_pll_clk_register(core, priv, &rzv2h_cpg_pll_ops);
+		break;
+	default:
+		goto fail;
+	}
+
+	if (IS_ERR_OR_NULL(clk))
+		goto fail;
+
+	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
+	priv->clks[id] =3D clk;
+	return;
+
+fail:
+	dev_err(dev, "Failed to register core clock %s: %ld\n",
+		core->name, PTR_ERR(clk));
+}
+
+static int rzv2h_mod_clock_endisable(struct clk_hw *hw, bool enable)
+{
+	struct mod_clock *clock =3D to_mod_clock(hw);
+	unsigned int reg =3D GET_CLK_ON_OFFSET(clock->on_index);
+	struct rzv2h_cpg_priv *priv =3D clock->priv;
+	u32 bitmask =3D BIT(clock->on_bit);
+	struct device *dev =3D priv->dev;
+	u32 value;
+	int error;
+
+	dev_dbg(dev, "CLK_ON 0x%x/%pC %s\n", reg, hw->clk,
+		enable ? "ON" : "OFF");
+
+	value =3D bitmask << 16;
+	if (enable)
+		value |=3D bitmask;
+
+	writel(value, priv->base + reg);
+
+	if (!enable || clock->mon_index < 0)
+		return 0;
+
+	reg =3D GET_CLK_MON_OFFSET(clock->mon_index);
+	bitmask =3D BIT(clock->mon_bit);
+	error =3D readl_poll_timeout_atomic(priv->base + reg, value,
+					  value & bitmask, 0, 10);
+	if (error)
+		dev_err(dev, "Failed to enable CLK_ON %p\n",
+			priv->base + reg);
+
+	return error;
+}
+
+static int rzv2h_mod_clock_enable(struct clk_hw *hw)
+{
+	return rzv2h_mod_clock_endisable(hw, true);
+}
+
+static void rzv2h_mod_clock_disable(struct clk_hw *hw)
+{
+	rzv2h_mod_clock_endisable(hw, false);
+}
+
+static int rzv2h_mod_clock_is_enabled(struct clk_hw *hw)
+{
+	struct mod_clock *clock =3D to_mod_clock(hw);
+	struct rzv2h_cpg_priv *priv =3D clock->priv;
+	u32 bitmask;
+	u32 offset;
+
+	if (clock->mon_index >=3D 0) {
+		offset =3D GET_CLK_MON_OFFSET(clock->mon_index);
+		bitmask =3D BIT(clock->mon_bit);
+	} else {
+		offset =3D GET_CLK_ON_OFFSET(clock->on_index);
+		bitmask =3D BIT(clock->on_bit);
+	}
+
+	return readl(priv->base + offset) & bitmask;
+}
+
+static const struct clk_ops rzv2h_mod_clock_ops =3D {
+	.enable =3D rzv2h_mod_clock_enable,
+	.disable =3D rzv2h_mod_clock_disable,
+	.is_enabled =3D rzv2h_mod_clock_is_enabled,
+};
+
+static void __init
+rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *mod,
+			   struct rzv2h_cpg_priv *priv)
+{
+	struct mod_clock *clock =3D NULL;
+	struct device *dev =3D priv->dev;
+	struct clk_init_data init;
+	struct clk *parent, *clk;
+	const char *parent_name;
+	unsigned int id;
+	int ret;
+
+	id =3D GET_MOD_CLK_ID(priv->num_core_clks, mod->on_index, mod->on_bit);
+	WARN_DEBUG(id >=3D priv->num_core_clks + priv->num_mod_clks);
+	WARN_DEBUG(mod->parent >=3D priv->num_core_clks + priv->num_mod_clks);
+	WARN_DEBUG(PTR_ERR(priv->clks[id]) !=3D -ENOENT);
+
+	parent =3D priv->clks[mod->parent];
+	if (IS_ERR(parent)) {
+		clk =3D parent;
+		goto fail;
+	}
+
+	clock =3D devm_kzalloc(dev, sizeof(*clock), GFP_KERNEL);
+	if (!clock) {
+		clk =3D ERR_PTR(-ENOMEM);
+		goto fail;
+	}
+
+	init.name =3D mod->name;
+	init.ops =3D &rzv2h_mod_clock_ops;
+	init.flags =3D CLK_SET_RATE_PARENT;
+	if (mod->critical)
+		init.flags |=3D CLK_IS_CRITICAL;
+
+	parent_name =3D __clk_get_name(parent);
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+
+	clock->on_index =3D mod->on_index;
+	clock->on_bit =3D mod->on_bit;
+	clock->mon_index =3D mod->mon_index;
+	clock->mon_bit =3D mod->mon_bit;
+	clock->priv =3D priv;
+	clock->hw.init =3D &init;
+
+	ret =3D devm_clk_hw_register(dev, &clock->hw);
+	if (ret) {
+		clk =3D ERR_PTR(ret);
+		goto fail;
+	}
+
+	priv->clks[id] =3D clock->hw.clk;
+
+	return;
+
+fail:
+	dev_err(dev, "Failed to register module clock %s: %ld\n",
+		mod->name, PTR_ERR(clk));
+}
+
+static int rzv2h_cpg_assert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct rzv2h_cpg_priv *priv =3D rcdev_to_priv(rcdev);
+	unsigned int reg =3D GET_RST_OFFSET(priv->resets[id].reset_index);
+	u32 mask =3D BIT(priv->resets[id].reset_bit);
+	u8 monbit =3D priv->resets[id].mon_bit;
+	u32 value =3D mask << 16;
+
+	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, reg);
+
+	writel(value, priv->base + reg);
+
+	reg =3D GET_RST_MON_OFFSET(priv->resets[id].mon_index);
+	mask =3D BIT(monbit);
+
+	return readl_poll_timeout_atomic(priv->base + reg, value,
+					 value & mask, 10, 200);
+}
+
+static int rzv2h_cpg_deassert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct rzv2h_cpg_priv *priv =3D rcdev_to_priv(rcdev);
+	unsigned int reg =3D GET_RST_OFFSET(priv->resets[id].reset_index);
+	u32 mask =3D BIT(priv->resets[id].reset_bit);
+	u8 monbit =3D priv->resets[id].mon_bit;
+	u32 value =3D (mask << 16) | mask;
+
+	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id, reg);
+
+	writel(value, priv->base + reg);
+
+	reg =3D GET_RST_MON_OFFSET(priv->resets[id].mon_index);
+	mask =3D BIT(monbit);
+
+	return readl_poll_timeout_atomic(priv->base + reg, value,
+					 !(value & mask), 10, 200);
+}
+
+static int rzv2h_cpg_reset(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	int ret;
+
+	ret =3D rzv2h_cpg_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return rzv2h_cpg_deassert(rcdev, id);
+}
+
+static int rzv2h_cpg_status(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct rzv2h_cpg_priv *priv =3D rcdev_to_priv(rcdev);
+	unsigned int reg =3D GET_RST_MON_OFFSET(priv->resets[id].mon_index);
+	u8 monbit =3D priv->resets[id].mon_bit;
+
+	return !!(readl(priv->base + reg) & BIT(monbit));
+}
+
+static const struct reset_control_ops rzv2h_cpg_reset_ops =3D {
+	.reset =3D rzv2h_cpg_reset,
+	.assert =3D rzv2h_cpg_assert,
+	.deassert =3D rzv2h_cpg_deassert,
+	.status =3D rzv2h_cpg_status,
+};
+
+static int rzv2h_cpg_reset_xlate(struct reset_controller_dev *rcdev,
+				 const struct of_phandle_args *reset_spec)
+{
+	struct rzv2h_cpg_priv *priv =3D rcdev_to_priv(rcdev);
+	unsigned int id =3D reset_spec->args[0];
+	u8 rst_index =3D id / 16;
+	u8 rst_bit =3D id % 16;
+	unsigned int i;
+
+	for (i =3D 0; i < rcdev->nr_resets; i++) {
+		if (rst_index =3D=3D priv->resets[i].reset_index &&
+		    rst_bit =3D=3D priv->resets[i].reset_bit)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int rzv2h_cpg_reset_controller_register(struct rzv2h_cpg_priv *priv=
)
+{
+	priv->rcdev.ops =3D &rzv2h_cpg_reset_ops;
+	priv->rcdev.of_node =3D priv->dev->of_node;
+	priv->rcdev.dev =3D priv->dev;
+	priv->rcdev.of_reset_n_cells =3D 1;
+	priv->rcdev.of_xlate =3D rzv2h_cpg_reset_xlate;
+	priv->rcdev.nr_resets =3D priv->num_resets;
+
+	return devm_reset_controller_register(priv->dev, &priv->rcdev);
+}
+
+/**
+ * struct rzv2h_cpg_pd - RZ/V2H power domain data structure
+ * @priv: pointer to CPG private data structure
+ * @genpd: generic PM domain
+ */
+struct rzv2h_cpg_pd {
+	struct rzv2h_cpg_priv *priv;
+	struct generic_pm_domain genpd;
+};
+
+static int rzv2h_cpg_attach_dev(struct generic_pm_domain *domain, struct d=
evice *dev)
+{
+	struct device_node *np =3D dev->of_node;
+	struct of_phandle_args clkspec;
+	bool once =3D true;
+	struct clk *clk;
+	int error;
+	int i =3D 0;
+
+	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
+					   &clkspec)) {
+		if (once) {
+			once =3D false;
+			error =3D pm_clk_create(dev);
+			if (error) {
+				of_node_put(clkspec.np);
+				goto err;
+			}
+		}
+		clk =3D of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
+		if (IS_ERR(clk)) {
+			error =3D PTR_ERR(clk);
+			goto fail_destroy;
+		}
+
+		error =3D pm_clk_add_clk(dev, clk);
+		if (error) {
+			dev_err(dev, "pm_clk_add_clk failed %d\n",
+				error);
+			goto fail_put;
+		}
+		i++;
+	}
+
+	return 0;
+
+fail_put:
+	clk_put(clk);
+
+fail_destroy:
+	pm_clk_destroy(dev);
+err:
+	return error;
+}
+
+static void rzv2h_cpg_detach_dev(struct generic_pm_domain *unused, struct =
device *dev)
+{
+	if (!pm_clk_no_clocks(dev))
+		pm_clk_destroy(dev);
+}
+
+static void rzv2h_cpg_genpd_remove_simple(void *data)
+{
+	pm_genpd_remove(data);
+}
+
+static int __init rzv2h_cpg_add_pm_domains(struct rzv2h_cpg_priv *priv)
+{
+	struct device *dev =3D priv->dev;
+	struct device_node *np =3D dev->of_node;
+	struct rzv2h_cpg_pd *pd;
+	int ret;
+
+	pd =3D devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->genpd.name =3D np->name;
+	pd->priv =3D priv;
+	pd->genpd.flags |=3D GENPD_FLAG_ALWAYS_ON | GENPD_FLAG_PM_CLK | GENPD_FLA=
G_ACTIVE_WAKEUP;
+	pd->genpd.attach_dev =3D rzv2h_cpg_attach_dev;
+	pd->genpd.detach_dev =3D rzv2h_cpg_detach_dev;
+	ret =3D pm_genpd_init(&pd->genpd, &pm_domain_always_on_gov, false);
+	if (ret)
+		return ret;
+
+	ret =3D devm_add_action_or_reset(dev, rzv2h_cpg_genpd_remove_simple, &pd-=
>genpd);
+	if (ret)
+		return ret;
+
+	return of_genpd_add_provider_simple(np, &pd->genpd);
+}
+
+static void rzv2h_cpg_del_clk_provider(void *data)
+{
+	of_clk_del_provider(data);
+}
+
+static int __init rzv2h_cpg_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
+	const struct rzv2h_cpg_info *info;
+	struct rzv2h_cpg_priv *priv;
+	unsigned int nclks, i;
+	struct clk **clks;
+	int error;
+
+	info =3D of_device_get_match_data(dev);
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev =3D dev;
+
+	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	nclks =3D info->num_total_core_clks + info->num_hw_mod_clks;
+	clks =3D devm_kmalloc_array(dev, nclks, sizeof(*clks), GFP_KERNEL);
+	if (!clks)
+		return -ENOMEM;
+
+	priv->resets =3D devm_kmemdup(dev, info->resets, sizeof(*info->resets) *
+				    info->num_resets, GFP_KERNEL);
+	if (!priv->resets)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+	priv->clks =3D clks;
+	priv->num_core_clks =3D info->num_total_core_clks;
+	priv->num_mod_clks =3D info->num_hw_mod_clks;
+	priv->last_dt_core_clk =3D info->last_dt_core_clk;
+	priv->num_resets =3D info->num_resets;
+
+	for (i =3D 0; i < nclks; i++)
+		clks[i] =3D ERR_PTR(-ENOENT);
+
+	for (i =3D 0; i < info->num_core_clks; i++)
+		rzv2h_cpg_register_core_clk(&info->core_clks[i], priv);
+
+	for (i =3D 0; i < info->num_mod_clks; i++)
+		rzv2h_cpg_register_mod_clk(&info->mod_clks[i], priv);
+
+	error =3D of_clk_add_provider(np, rzv2h_cpg_clk_src_twocell_get, priv);
+	if (error)
+		return error;
+
+	error =3D devm_add_action_or_reset(dev, rzv2h_cpg_del_clk_provider, np);
+	if (error)
+		return error;
+
+	error =3D rzv2h_cpg_add_pm_domains(priv);
+	if (error)
+		return error;
+
+	error =3D rzv2h_cpg_reset_controller_register(priv);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static const struct of_device_id rzv2h_cpg_match[] =3D {
+	{ /* sentinel */ }
+};
+
+static struct platform_driver rzv2h_cpg_driver =3D {
+	.driver		=3D {
+		.name	=3D "rzv2h-cpg",
+		.of_match_table =3D rzv2h_cpg_match,
+	},
+};
+
+static int __init rzv2h_cpg_init(void)
+{
+	return platform_driver_probe(&rzv2h_cpg_driver, rzv2h_cpg_probe);
+}
+
+subsys_initcall(rzv2h_cpg_init);
+
+MODULE_DESCRIPTION("Renesas RZ/V2H CPG Driver");
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
new file mode 100644
index 000000000000..ab6beaa50296
--- /dev/null
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Renesas RZ/V2H(P) Clock Pulse Generator
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#ifndef __RENESAS_RZV2H_CPG_H__
+#define __RENESAS_RZV2H_CPG_H__
+
+/**
+ * Definitions of CPG Core Clocks
+ *
+ * These include:
+ *   - Clock outputs exported to DT
+ *   - External input clocks
+ *   - Internal CPG clocks
+ */
+struct cpg_core_clk {
+	const char *name;
+	unsigned int id;
+	unsigned int parent;
+	unsigned int div;
+	unsigned int mult;
+	unsigned int type;
+	unsigned int conf;
+};
+
+enum clk_types {
+	/* Generic */
+	CLK_TYPE_IN,		/* External Clock Input */
+	CLK_TYPE_FF,		/* Fixed Factor Clock */
+	CLK_TYPE_PLL,
+};
+
+/* BIT(31) indicates if CLK1/2 are accessible or not */
+#define PLL_CONF(n)		(BIT(31) | ((n) & ~GENMASK(31, 16)))
+#define PLL_CLK_ACCESS(n)	((n) & BIT(31) ? 1 : 0)
+#define PLL_CLK1_OFFSET(n)	((n) & ~GENMASK(31, 16))
+#define PLL_CLK2_OFFSET(n)	(((n) & ~GENMASK(31, 16)) + (0x4))
+
+#define DEF_TYPE(_name, _id, _type...) \
+	{ .name =3D _name, .id =3D _id, .type =3D _type }
+#define DEF_BASE(_name, _id, _type, _parent...) \
+	DEF_TYPE(_name, _id, _type, .parent =3D _parent)
+#define DEF_PLL(_name, _id, _parent, _conf) \
+	DEF_TYPE(_name, _id, CLK_TYPE_PLL, .parent =3D _parent, .conf =3D _conf)
+#define DEF_INPUT(_name, _id) \
+	DEF_TYPE(_name, _id, CLK_TYPE_IN)
+#define DEF_FIXED(_name, _id, _parent, _mult, _div) \
+	DEF_BASE(_name, _id, CLK_TYPE_FF, _parent, .div =3D _div, .mult =3D _mult=
)
+
+/**
+ * struct rzv2h_mod_clk - Module Clocks definitions
+ *
+ * @name: handle between common and hardware-specific interfaces
+ * @parent: id of parent clock
+ * @critical: flag to indicate the clock is critical
+ * @on_index: control register index
+ * @on_bit: ON bit
+ * @mon_index: monitor register index
+ * @mon_bit: monitor bit
+ */
+struct rzv2h_mod_clk {
+	const char *name;
+	u16 parent;
+	bool critical;
+	u8 on_index;
+	u8 on_bit;
+	s8 mon_index;
+	u8 mon_bit;
+};
+
+#define DEF_MOD_BASE(_name, _parent, _critical, _onindex, _onbit, _moninde=
x, _monbit) \
+	{ \
+		.name =3D (_name), \
+		.parent =3D (_parent), \
+		.critical =3D (_critical), \
+		.on_index =3D (_onindex), \
+		.on_bit =3D (_onbit), \
+		.mon_index =3D (_monindex), \
+		.mon_bit =3D (_monbit), \
+	}
+
+#define DEF_MOD(_name, _parent, _onindex, _onbit, _monindex, _monbit)		\
+	DEF_MOD_BASE(_name, _parent, false, _onindex, _onbit, _monindex, _monbit)
+
+#define DEF_MOD_CRITICAL(_name, _parent, _onindex, _onbit, _monindex, _mon=
bit)	\
+	DEF_MOD_BASE(_name, _parent, true, _onindex, _onbit, _monindex, _monbit)
+
+/**
+ * struct rzv2h_reset - Reset definitions
+ *
+ * @reset_index: reset register index
+ * @reset_bit: reset bit
+ * @mon_index: monitor register index
+ * @mon_bit: monitor bit
+ */
+struct rzv2h_reset {
+	u8 reset_index;
+	u8 reset_bit;
+	u8 mon_index;
+	u8 mon_bit;
+};
+
+#define DEF_RST_BASE(_resindex, _resbit, _monindex, _monbit)	\
+	{ \
+		.reset_index =3D (_resindex), \
+		.reset_bit =3D (_resbit), \
+		.mon_index =3D (_monindex), \
+		.mon_bit =3D (_monbit), \
+	}
+
+#define DEF_RST(_resindex, _resbit, _monindex, _monbit)	\
+	DEF_RST_BASE(_resindex, _resbit, _monindex, _monbit)
+
+/**
+ * struct rzv2h_cpg_info - SoC-specific CPG Description
+ *
+ * @core_clks: Array of Core Clock definitions
+ * @num_core_clks: Number of entries in core_clks[]
+ * @last_dt_core_clk: ID of the last Core Clock exported to DT
+ * @num_total_core_clks: Total number of Core Clocks (exported + internal)
+ *
+ * @mod_clks: Array of Module Clock definitions
+ * @num_mod_clks: Number of entries in mod_clks[]
+ * @num_hw_mod_clks: Number of Module Clocks supported by the hardware
+ *
+ * @resets: Array of Module Reset definitions
+ * @num_resets: Number of entries in resets[]
+ */
+struct rzv2h_cpg_info {
+	/* Core Clocks */
+	const struct cpg_core_clk *core_clks;
+	unsigned int num_core_clks;
+	unsigned int last_dt_core_clk;
+	unsigned int num_total_core_clks;
+
+	/* Module Clocks */
+	const struct rzv2h_mod_clk *mod_clks;
+	unsigned int num_mod_clks;
+	unsigned int num_hw_mod_clks;
+
+	/* Resets */
+	const struct rzv2h_reset *resets;
+	unsigned int num_resets;
+};
+
+#endif	/* __RENESAS_RZV2H_CPG_H__ */
--=20
2.43.0


