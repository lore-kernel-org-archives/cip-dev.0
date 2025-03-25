Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6584C3600B
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:02 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.4])
 by mx.groups.io with SMTP id smtpd.web11.67725.1742914621179211061
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:57:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=okwjcL0t;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1s8V1DlplEva5jmY7kbeVe/y31i0BhkaNwU+VBo36jVzH3kWWNiKR7pEKo7S9Lh69cVk30lzz0gFcerv8p7p3Gx0yQs+N0sszVgwMbQ1jdxQlz3xvVgd3WEPrQE0d3OkcY+wEcrANQT0dpyQY03lbInke52SIEZdQDaDteQmsM7jahYNA8NGQ77yAXLvior2R9uwU4YVdw+wAPwMwuxxlE823LUILP1YNvTDHWtEPoQSlPFsdPgFgu2lgUV8yYMEIyiu6luAdqKAPr+AldHe1F1m5+p3xW/dIrxx+0JUxUo/XxySSb+QfxSwxCylaiy9TM5W9QhRCfI2yhpaXs7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLqa8c37Qi00woZPj87iV3UiNIAga4S5VZt1I7HF5VM=;
 b=E/IBv18EeqJqIF0+T22CWt5AsUFOW9eMDQ9Iw4ZtTUY8OvGQ4DBIZrcyoHsPh62V/YgePhkjjTnxTHZaGnjAE7ThpWlC6gSKcKYPaT7K6fDRBhBkXrF2Y2uG580qmTXoynJVdblrGYr7COiAYSvXc0g0NZeWoLNsIbidssqv4iP4TWc7F/QrY73BUrnMOsDR0JHRrdNxoPVHqpdfWI/K0gtkjifCVU8a1Zzw9t3/QYBuGWgV+JaHzTlyIfu9CjtgxCJxm/iJ6hcjblUL/ZsQxzoBhRKpRSVD6jrLOsjKfeNoRvpCUhdrK5SUtvphFkP7u4SjKtr78YkGYVDSd4VU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLqa8c37Qi00woZPj87iV3UiNIAga4S5VZt1I7HF5VM=;
 b=okwjcL0tl1U0lbQ30WmhFkWL5gYJPFmrBB27fi0PBY0FUfj3pH8QISPh7vssUyB9gP43KEgD0nMGRQadhWlg5k6KUgXn8RSCzVcI8yvZJnou+KxhLcoqkh/RbGQ3bR1wzi+H4wTwtR4FpGt+hbe+jiP++8fSWU7FiaGgQyZ0q5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:56:59 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:56:59 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 09/16] clk: renesas: rzv2h: Add support for RZ/G3E SoC
Date: Tue, 25 Mar 2025 15:56:03 +0100
Message-ID: <20250325145611.3595454-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: fcf4a84b-762f-4e87-26ca-08dd6bad4b22
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cKQWi1s3LOWWB+HhqPKvR36A7M1H45uGJawHf0odi/dQFtoAJcbn5K5bmiIL?=
 =?us-ascii?Q?eZJqTyil7OU0oIFD7FsAvV06YGoT6dGhKNNmw4bD1wjTiFp3gOoz8TM1O2qa?=
 =?us-ascii?Q?T658cy38JHoSKikrTkkWfUzXimseawWXlvMoOjTWtN3F9UX20t3hP1G7d9cS?=
 =?us-ascii?Q?1tgknqWaIPL94I2WLjmFHmBYXEqz4J+BKnHN5yJc2kho60Zm0Qy8YC+DJszV?=
 =?us-ascii?Q?CK+y5zQ3pZXStpBXIYX5M4wKweDSB0fLQKXFaa9yY5R0keMqKlrjg0sfLrtB?=
 =?us-ascii?Q?quCYLtLUDG1dK7w6FcDAP9b0oLWGUIthvwUVls2L8A9lNbniTuH8i8zztiiP?=
 =?us-ascii?Q?wCA+hYsWJJTiyWevfVMlJJ4EpM+orsJgjs9wMx9ApKfguvDY9nmIUHofZXpK?=
 =?us-ascii?Q?SXpgrPu/zPm51osCzQqHcNUMTcl0ioA7rvrys/jwoRsTMfDnTuQ/vcd6GG/E?=
 =?us-ascii?Q?DKkSnJT1k4xiMOTcV6ub53ttNqKo6kBVsPaFO6WTgRKSx91dz+JUdAt2D5LW?=
 =?us-ascii?Q?Cb59CGOkYWQvZLYMEfNj33vGKhzwTG0EkHuvtqxgbfXBBoVJq8E2/gHFE6va?=
 =?us-ascii?Q?quDmnzq4yndnEWBs5IeLu3jnhKvJupvFunznWWnzcyvxHsZbZap1BW76F7uG?=
 =?us-ascii?Q?8d5eZk/rllZO/ykBnKBEUVdC8biP3jMNPjqmOxZV8PyzvkotTO2cbOqBbcRM?=
 =?us-ascii?Q?0MUSvayFEygEjNN12APuPQTUMbzcDlyr8hKOP0C9a3lmTZtjvbNEADzLlxof?=
 =?us-ascii?Q?54AWFd1HGBu0Ouw0/w8+vIY/ympQ70QB2rFJpTDxXR6/L9AykipVDnUsRRCk?=
 =?us-ascii?Q?LIo/UK5PIkzdof7oteClktYKStBDhYBLfDIBIcyGpkXA2YeeXRcLvcX27Htx?=
 =?us-ascii?Q?rcwgKAcFePEz7hb3ukrKtY3SoiX1e0ohOXxrPZfC6fyaNn6RsaZOBvh8z0WH?=
 =?us-ascii?Q?UW3nhFK5nIOERZAkho8QKNp0RBEqJgRQwOfn/RsFtSeeoe63Idg4dppUh5yi?=
 =?us-ascii?Q?H45Ec1OqadKDYr+xOTX05KqouVyUXSpWTb540SKstw/5xb2NR9FStFzSXZTm?=
 =?us-ascii?Q?1Ada5SrT9AN2tCa/w+4hfsdhA9eEvzTk1bGG7hO+DSTBXRyh/U28m1j/pRJq?=
 =?us-ascii?Q?9HtOaEGIrRCjUJSHzbvN8NSc/5/6kUYKn/nkS3BGz75UQl0BgLTIxBTfNSqu?=
 =?us-ascii?Q?4m2ZG75O6lA487ERnIuaEl8OFboIEgdxYBi7aBX4mqBoqlbx11NUn9vjjDti?=
 =?us-ascii?Q?NmvUGTgHCcI5rYLKyTRupAz4aQwEkTDJ/185Qfe9Ym8subS6kWfhY1o+Sra5?=
 =?us-ascii?Q?6HCLv3Olfh3ZzvBYjBpquPPbDHZf9ZCJZjA1C1bVnUqRhQONJoXm1UtjD4u2?=
 =?us-ascii?Q?Ku3NEH5K67IaHDLzBDCAPGW2FhnhK0xuo5zlI3vZy0xJKF1VrstoenFPM98h?=
 =?us-ascii?Q?ZPSRWHZEHolwvvdu8DaAayKYUUNf4YWP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WjtBtc351G7Q6UZQgZ7oIzXLwYl8stfHM6C5Mopdp6nBffHuwtWST1PlkYeX?=
 =?us-ascii?Q?CM88/Yfde4DXPV5Ye/oeLdGVWBsUM4YJ5Y4XgdJirpiLDPne9CvcsLI6+bqp?=
 =?us-ascii?Q?8zp/C4bIDrqf9BVBKzru1+0ner0ahjBWn1F+wreUfpNMnzkkQdvzgBGF5aeY?=
 =?us-ascii?Q?AdgxpGiFhZX8YfqBeV2+VGyvVdeHWmztnAVpfhM2KA2rIK9x6FIN3VYEnsT2?=
 =?us-ascii?Q?+X5xDmj/wLOnwD/+V1D+XmWhVWuZZPSY3d/XmsRdp7ed0xPxlIQf9eTDT7/m?=
 =?us-ascii?Q?Gdonqpu70aUmx6OwTSZZid9OQxXDihfELnn7mEvoWtkhPir372kM6kKT7HJd?=
 =?us-ascii?Q?6GPjNARpMslA/TCpmLIe1Y00O7Wwt6qvaotcjQt8lsPBlVR7FYmWUvSLy9U4?=
 =?us-ascii?Q?O6P/q8d7JZqEXOgYnD6uLCbBts+//XWKh9sbmuutnYi2Bg+ceUoaBykDGEFe?=
 =?us-ascii?Q?j8j/5/zNTT5Eh36qX78x/lWUsSjBO5OC4V9O4mrHFiGmuhwsiB0wmzwPVpY9?=
 =?us-ascii?Q?817HmpqsLLA5PioHKt4e8LizGm3uJUX6iMs5+7D0xYlli9zG6CaYihLPX4L4?=
 =?us-ascii?Q?j9HnAhJSjd0RHNbk5op++otcbvwrJF1sBYf09bAhAjWFENfyXZRhQ0UXi1q/?=
 =?us-ascii?Q?CJ5K/08q5U1AVnYe4kSvoZ6dxvaRVWTAP2W8JdHMUcM6HU0U0GLn45gL9sWA?=
 =?us-ascii?Q?9jdk77HVcT6jTqDVq3TSo4tDmXpBem5rAqrCCa4G8ANEMXhCs6zgI8osi8Dn?=
 =?us-ascii?Q?QHE2A/4raMFveUpMw6HGDUYj8oFuO0xRfPtEVGXadPWeQ7d/kS/bKjJ58prX?=
 =?us-ascii?Q?vyIvm6i5o2sib93vNu1qbn63+tw4nZR/rrDHt13ye+Hkt9/pKPGWadJG8yEL?=
 =?us-ascii?Q?bKorXqpWCQOa8GaeE7QqcwGAG90nJ+Oc2WtCCnDenUTsEs7WArCDdKI7qjg8?=
 =?us-ascii?Q?ZdG+AnbF0Qsn3wkrNsOYg8qT9ye0scoi1nv9BxQT2y2/vEDf0I9hp3OdchBw?=
 =?us-ascii?Q?3M+8qZ1WmSMwukrDaYRh13CqPtehL5KZPOu6ES/l0beB4F0P8YizPsWClwsx?=
 =?us-ascii?Q?9G3+S5avHc3mAAPbkDEw/8pafjOTVGRD+xLYkWHyT2EqxIqXOb7g5ofPiQnW?=
 =?us-ascii?Q?jQRTQj06cYiXsgI+wYIe+OodAgaYvy76zdRagkI4q+r1Pg9L5VvfrSFpkH1X?=
 =?us-ascii?Q?Sx28pKMZNhSGquyG6IrMNiDBCDX44pgTHemowXOYS4ym/3Ri9bcGSKcaxQiG?=
 =?us-ascii?Q?rbr17rSug2vRQGrgnHYBs4BhIY4gp1vEe7EWzwc1/JfWg6dZcdq54KkIU7Nj?=
 =?us-ascii?Q?ye0AKDNIBGwjqAWVrdXLD8m5onLDYbT7TF2y5qNScqe/AscRY29Jayxt4+6c?=
 =?us-ascii?Q?AW9CGR0ywPhG1yWtHXnSZJ1ijAhuzVHzvPanREMoIYJ7qreoC3G8et3fP8WM?=
 =?us-ascii?Q?iXXtJ7sLVVPFxoWu9jcn4CyIZuXdfWwR/uRhoK5PUlZ89nrGnmgYhuDwjZ2S?=
 =?us-ascii?Q?N/Ase44/HXfU2xOf/0vMiy1HT2G0J7m5dnuJ73nDuNfm05v+yk8HcurXiSgF?=
 =?us-ascii?Q?DMh/KkQHcezpIGMT8RjY4BSCXkcFn7jdvVZknfyU4yliicEIRohcmpINtYHf?=
 =?us-ascii?Q?+ET6aNAFSp1+JYmpwI9Gobo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf4a84b-762f-4e87-26ca-08dd6bad4b22
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:56:59.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gfz8Fdt0j/x3I0cAQN5+NFzn6UdJqFGwsEirppTX+rIA/KKYq8+1uDxqH4YWOu5OmSJJMdP0YeNhEEr3EfTnf5lf6v9A1/xQ3GHMoKcVPNHl6do2J0jT7/43032iWSNL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18359

From: Biju Das <biju.das.jz@bp.renesas.com>

commit bb6a9aaf670735d6583c76073ec41190f5404dc5 upstream.

The clock structure for RZ/G3E is almost identical to RZ/V2H SoC with
more IP blocks compared to RZ/V2H. For eg: VSPI, LVDS, DPI and LCDC1
are present only on the RZ/G3E SoC.

Add minimal clock and reset entries required to boot the Renesas RZ/G3E
SMARC EVK and binds it with the RZ/V2H CPG core driver.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241213123550.289193-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig         |   7 +-
 drivers/clk/renesas/Makefile        |   1 +
 drivers/clk/renesas/r9a09g047-cpg.c | 102 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.c     |   6 ++
 drivers/clk/renesas/rzv2h-cpg.h     |   1 +
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/renesas/r9a09g047-cpg.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index ff01f5f0ed207..5a4bc3f94d49a 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -40,6 +40,7 @@ config CLK_RENESAS
 	select CLK_R9A07G054 if ARCH_R9A07G054
 	select CLK_R9A08G045 if ARCH_R9A08G045
 	select CLK_R9A09G011 if ARCH_R9A09G011
+	select CLK_R9A09G047 if ARCH_R9A09G047
 	select CLK_R9A09G057 if ARCH_R9A09G057
 	select CLK_SH73A0 if ARCH_SH73A0
=20
@@ -194,6 +195,10 @@ config CLK_R9A09G011
 	bool "RZ/V2M clock support" if COMPILE_TEST
 	select CLK_RZG2L
=20
+config CLK_R9A09G047
+       bool "RZ/G3E clock support" if COMPILE_TEST
+       select CLK_RZV2H
+
 config CLK_R9A09G057
        bool "RZ/V2H(P) clock support" if COMPILE_TEST
        select CLK_RZV2H
@@ -234,7 +239,7 @@ config CLK_RZG2L
 	select RESET_CONTROLLER
=20
 config CLK_RZV2H
-	bool "RZ/V2H(P) family clock support" if COMPILE_TEST
+	bool "RZ/{G3E,V2H(P)} family clock support" if COMPILE_TEST
 	select RESET_CONTROLLER
=20
 config CLK_RENESAS_VBATTB
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 82efaa835ac70..2d6e746939c40 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_CLK_R9A07G044)		+=3D r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A07G054)		+=3D r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A08G045)		+=3D r9a08g045-cpg.o
 obj-$(CONFIG_CLK_R9A09G011)		+=3D r9a09g011-cpg.o
+obj-$(CONFIG_CLK_R9A09G047)		+=3D r9a09g047-cpg.o
 obj-$(CONFIG_CLK_R9A09G057)		+=3D r9a09g057-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+=3D clk-sh73a0.o
=20
diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
new file mode 100644
index 0000000000000..1178335dbed3a
--- /dev/null
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G3E CPG driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+
+#include "rzv2h-cpg.h"
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK =3D R9A09G047_IOTOP_0_SHCLK,
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
+	CLK_PLLDTY_ACPU,
+	CLK_PLLDTY_ACPU_DIV4,
+
+	/* Module Clocks */
+	MOD_CLK_BASE,
+};
+
+static const struct clk_div_table dtable_2_64[] =3D {
+	{0, 2},
+	{1, 4},
+	{2, 8},
+	{3, 16},
+	{4, 64},
+	{0, 0},
+};
+
+static const struct cpg_core_clk r9a09g047_core_clks[] __initconst =3D {
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
+	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
+
+	/* Core Clocks */
+	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
+	DEF_FIXED("iotop_0_shclk", R9A09G047_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1,=
 1),
+};
+
+static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst =3D {
+	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
+						BUS_MSTOP(3, BIT(5))),
+	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
+						BUS_MSTOP(3, BIT(14))),
+};
+
+static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
+	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
+	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
+	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
+	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
+};
+
+const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
+	/* Core Clocks */
+	.core_clks =3D r9a09g047_core_clks,
+	.num_core_clks =3D ARRAY_SIZE(r9a09g047_core_clks),
+	.last_dt_core_clk =3D LAST_DT_CORE_CLK,
+	.num_total_core_clks =3D MOD_CLK_BASE,
+
+	/* Module Clocks */
+	.mod_clks =3D r9a09g047_mod_clks,
+	.num_mod_clks =3D ARRAY_SIZE(r9a09g047_mod_clks),
+	.num_hw_mod_clks =3D 28 * 16,
+
+	/* Resets */
+	.resets =3D r9a09g047_resets,
+	.num_resets =3D ARRAY_SIZE(r9a09g047_resets),
+
+	.num_mstop_bits =3D 208,
+};
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index d4fd52b0a24e9..a4c1e92e1fd76 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -972,6 +972,12 @@ static const struct of_device_id rzv2h_cpg_match[] =3D=
 {
 		.compatible =3D "renesas,r9a09g057-cpg",
 		.data =3D &r9a09g057_cpg_info,
 	},
+#endif
+#ifdef CONFIG_CLK_R9A09G047
+	{
+		.compatible =3D "renesas,r9a09g047-cpg",
+		.data =3D &r9a09g047_cpg_info,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index dcd65e9c09da4..fd8eb985c75b2 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -218,6 +218,7 @@ struct rzv2h_cpg_info {
 	unsigned int num_mstop_bits;
 };
=20
+extern const struct rzv2h_cpg_info r9a09g047_cpg_info;
 extern const struct rzv2h_cpg_info r9a09g057_cpg_info;
=20
 #endif	/* __RENESAS_RZV2H_CPG_H__ */
--=20
2.43.0


