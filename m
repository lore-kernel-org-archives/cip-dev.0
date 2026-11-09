Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4575.1794226515309783725
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=s5/An5dq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.16, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUfdTdokpJ1YxtyR/SD7OSbL4uhDTNETmF0O1fpRfHEuq8SKLmUrvyb153oG+8i9uHd4IZB8sWNhxKvdiyoIfaNIGmcp/sI7R7HqMSMBwY5RMT00LAoyTyhigbyU7cW1YhdKyIkViCNQiusLfssZADM2EQoUAKf2hFonbmXY+waUcqkWSH3RN4ySOZTX5dVmaLPim9ptYpTNt1pIMvLEi4Q4+nMxbCI35FzCwZR8WMCYCWna6nxGeLGBWdIF8/A1ecdsCLM84UpRurGzuhHELIaWOb8K918kGV8cka0hcYYtv/YTuNzZ/4Fwnh+7tAb8OBN/FiVHlJ/IeLMWZ1k3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiZ83TNVlDNtPuqpmOUyzi6OBd6BYVOv/CuZjWtQdzE=;
 b=lRz7NJNowC8mofW5tWwbFRTj3MLGuiIbq64S3fzPUbAYfnSfGa/x4AXzJaocT/shVGyvpRutMvg7nFWp/HO5lefDyBsbJsUdMG9jOIR/oJC4pliSyuHW1yn08Q3F8wAbkv9zIBBE6pwa5RoEorOYrheaWPgCWxEeaYnUu5HHPMj6Ke5CQfjcjK1Ozms4NaYeVJNe7SZytV+hGiSk5vQLOHun8HWZHVaVkOpZK3iH9Lsluia1LcInmzwn3KzTrpMbF0q8zkYhlsdc8zrbnXBrijAXvOaSEW74pIlVaJ3SZE1KxSQJiuA129Mrt2VhbMTDYrosEMtagKe7LCkgSGdumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiZ83TNVlDNtPuqpmOUyzi6OBd6BYVOv/CuZjWtQdzE=;
 b=s5/An5dq9JgI0Wku62qXILhSls+RNCI7XBTPox6ML36ppXLri/3uS5XziSZMpt4v2THtXYYqxh9ToQrAntn3ulIRof8RQAamkIMS+QVoe31deQgN/h8te0ZQsqjPAkg5FVDXdyZCY0bDOEhsobWz/m/g2O61TmLk6WC23LPDUo4=
Received: from TY6P301CA0025.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:3bf::7)
 by TYRPR01MB12775.jpnprd01.prod.outlook.com (2603:1096:405:1b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:10 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bf:cafe::74) by TY6P301CA0025.outlook.office365.com
 (2603:1096:405:3bf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:10 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4E12F300022D;
	Mon,  9 Nov 2026 21:15:09 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for clk_divider_bestdiv() ULONG_MAX handling
Date: Mon,  9 Nov 2026 12:14:37 +0000
Message-ID: <20261109121451.6042-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|TYRPR01MB12775:EE_
X-MS-Office365-Filtering-Correlation-Id: e23300d7-6476-4625-2927-08df3e5b19d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|261021121427099003|261021135927099003|261022075727099003|261009223027099003|261102123227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: xXhjXV4TU7JAHohymhg1upAiGFT0fNbACtrG5hYsWuSmMKi3J/qC6plJf98VbHEHb7QbdiebvSNUo7M4ZQbX8Nmu+BF6ZV216OgcvrwupS6vdMQx/hFodqi4iaUwn5QsEnlgjBduHPfduU8n9EyF4KMmlF08cgVfYQwjBZukrkTOCmtq6OJ24fOcyJ80Bi/tYD3LFQ4/kJnXIa7q76NbOvvI4dZ0sk8mF+cEgkHjGCrMjjshzoiZlszAXvIjFkz67JyzcpVSfyjcl0MJYokiR0WdjX2SXqOQod9blHBMBEQbU+DLLzP0NIXNNBUpdzIVhPRLWQ6qzRVAd2ntUY2YbHH1c94Eca0cMJYIpXEqtPvxndwMUN6FeaNk4l1KacuQkdB732SQMCbMH1mS3S/D3nFm3SdvG6elCkfduWlHwXtlIvr6QYgENdV+E2XOed25L/qFS0YZGvQduFgKYDmJAJcvWpJ06zojt5dJ/sr8xUMxVNyFhtRGTjH6YZcDba3cQigCTc9uWzPb+2h4XgYSDZ13Rwrtuh3UiWS752GGgiPyRceEdCbqCO0drqaAFSW1mtL1iR2gnNhI6MKrmOJkEzs5RxQ+vOnqg93fIQ2f7Q/J+iztvZVX4l/piI7PpB763g4QFz+p08WY/RUa0PsrYqe6ChHYJzMc50KOWi9HJgFYGqADRN78/WrDV4oRXo7oaIMUFPGU6Q8O1eHOR5mj5g==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021121427099003)(261021135927099003)(261022075727099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7DB46rbRvh9Y1n1GnlkWJdz40dzxQZpriiCy1gwjXMu1Pha7cs579RrRm3Q0OrPvFctuPECyuBUHL45xhg2iuFtiTEhZR+ciBHVpGn0UwuFpKlHjtpbPpIKCNrs+yR8gKPWsFohaKuSp9Ti/tJJGdfut+XtsBE4OPDz5a10os6RiTDFM0oiPfziDU2rqwVpfb25vALDX0PLdIL4yhe1hPQMDHkK2ZQ3eBQ7lIQdvgi+7TXga7z+ovbioVNY5czNigkyCQidSOUFPWKbT1uqHzLWl/uD9FA9B0mK6tgkceTFIEVIN7yB9Cac2GC/5F/fci5UE+E0ugQ6iyIh04YHNW/fzCMjnbrZW1bA8n+Y8jZVv/5Z8WCvw9V3Dr+1FCIyoUvFJusGouj91bOo4vHf/kZiTNT5kynZiHoK84Pb8XI2Nir4XzrT56KKGR5wJiuna
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:10.5810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e23300d7-6476-4625-2927-08df3e5b19d6
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12775
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24714
Content-Type: text/plain; charset="utf-8"

commit 50ca555d6ae8205374e406b411ae0e8e9447568d upstream.

Add KUnit tests to verify the behaviour of clk_divider_bestdiv() when
clk_round_rate() is called with ULONG_MAX, which is the canonical way
to probe the maximum rate a clock can produce.

Two test cases are introduced:

- clk_divider_bestdiv_ulong_max_returns_max_rate: registers a 1 GHz
  fixed-rate parent driving a table-based divider whose smallest entry
  is div=3D2 (entries: 2, 4, 8). Calls clk_hw_round_rate(div_hw, ULONG_MAX)
  and checks the result.

- clk_divider_bestdiv_mux_ulong_max_returns_max_rate: places a two-input
  mux (4 GHz and 2 GHz fixed-rate parents, CLK_SET_RATE_PARENT) ahead of
  the same table-based divider to verify correct parent selection under
  ULONG_MAX.

Both tests use an explicit clk_div_table with a minimum divider of 2 so
that the pre-loop maxdiv clamping in clk_divider_bestdiv():

    maxdiv =3D min(ULONG_MAX / rate, maxdiv);

clamps maxdiv to 1, causing _next_div() to return 2 on the first
iteration and skip the loop body entirely. This makes bestdiv fall back
to the maximum divider, returning the minimum rate rather than the
maximum.

The expected values intentionally reflect the buggy output:
  - test 1: PARENT_RATE_1GHZ / 8  (minimum rate, not maximum)
  - test 2: 0                      (invalid, loop never populated bestdiv)

These will be corrected to PARENT_RATE_1GHZ / 2 and PARENT_RATE_4GHZ / 2
respectively once the fix to clk_divider_bestdiv() is applied.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/.kunitconfig       |   1 +
 drivers/clk/Kconfig            |   8 ++
 drivers/clk/Makefile           |   1 +
 drivers/clk/clk-divider_test.c | 153 +++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)
 create mode 100644 drivers/clk/clk-divider_test.c

diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
index 08e26137f3d9c..44c7cbafc03bb 100644
--- a/drivers/clk/.kunitconfig
+++ b/drivers/clk/.kunitconfig
@@ -3,6 +3,7 @@ CONFIG_OF=3Dy
 CONFIG_OF_OVERLAY=3Dy
 CONFIG_COMMON_CLK=3Dy
 CONFIG_CLK_KUNIT_TEST=3Dy
+CONFIG_CLK_DIVIDER_KUNIT_TEST=3Dy
 CONFIG_CLK_FIXED_RATE_KUNIT_TEST=3Dy
 CONFIG_CLK_GATE_KUNIT_TEST=3Dy
 CONFIG_CLK_FD_KUNIT_TEST=3Dy
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 0fe07a594b4e1..ad43f7e8473bc 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -544,4 +544,12 @@ config CLK_FD_KUNIT_TEST
 	help
 	  Kunit test for the clk-fractional-divider type.
=20
+config CLK_DIVIDER_KUNIT_TEST
+	tristate "KUnit tests for clk divider bestdiv" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on !S390
+	default KUNIT_ALL_TESTS
+	help
+	  Kunit test for the clk-divider type.
+
 endif
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index db202b614017e..4c78cdd7fa773 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_CLK_KUNIT_TEST)	+=3D clk-test.o
 clk-test-y			:=3D clk_test.o \
 				   kunit_clk_parent_data_test.dtbo.o
 obj-$(CONFIG_COMMON_CLK)	+=3D clk-divider.o
+obj-$(CONFIG_CLK_DIVIDER_KUNIT_TEST) +=3D clk-divider_test.o
 obj-$(CONFIG_COMMON_CLK)	+=3D clk-fixed-factor.o
 obj-$(CONFIG_COMMON_CLK)	+=3D clk-fixed-rate.o
 obj-$(CONFIG_CLK_FIXED_RATE_KUNIT_TEST)	+=3D clk-fixed-rate-test.o
diff --git a/drivers/clk/clk-divider_test.c b/drivers/clk/clk-divider_test.=
c
new file mode 100644
index 0000000000000..cb56931456b8f
--- /dev/null
+++ b/drivers/clk/clk-divider_test.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for clk_divider_bestdiv()
+ */
+#include <kunit/test.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/limits.h>
+#include <linux/units.h>
+
+#define PARENT_RATE_1GHZ	GIGA
+#define PARENT_RATE_2GHZ	(2 * GIGA)
+#define PARENT_RATE_4GHZ	(4 * GIGA)
+
+KUNIT_DEFINE_ACTION_WRAPPER(clk_hw_unregister_fixed_rate_wrapper,
+			    clk_hw_unregister_fixed_rate, struct clk_hw *);
+KUNIT_DEFINE_ACTION_WRAPPER(clk_hw_unregister_divider_wrapper,
+			    clk_hw_unregister_divider, struct clk_hw *);
+KUNIT_DEFINE_ACTION_WRAPPER(clk_hw_unregister_mux_wrapper,
+			    clk_hw_unregister_mux, struct clk_hw *);
+
+static const struct clk_div_table bestdiv_table[] =3D {
+	{ .val =3D 0, .div =3D 2 },
+	{ .val =3D 1, .div =3D 4 },
+	{ .val =3D 2, .div =3D 8 },
+	{ /* sentinel */ }
+};
+
+/*
+ * Test that clk_round_rate(clk, ULONG_MAX) returns the maximum achievable
+ * rate for a divider clock.
+ */
+static void clk_divider_bestdiv_ulong_max_returns_max_rate(struct kunit *t=
est)
+{
+	struct clk_hw *parent_hw, *div_hw;
+	unsigned long rate;
+	u32 *fake_reg;
+
+	fake_reg =3D kunit_kzalloc(test, sizeof(*fake_reg), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_reg);
+
+	parent_hw =3D clk_hw_register_fixed_rate(NULL, "bestdiv-parent",
+					       NULL, 0, PARENT_RATE_1GHZ);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_hw);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, clk_hw_unregister_fixed_rate_wrapper,
+						  parent_hw));
+
+	div_hw =3D clk_hw_register_divider_table(NULL, "bestdiv-div",
+					       "bestdiv-parent",
+					       CLK_SET_RATE_PARENT,
+					       (void __iomem __force *)fake_reg,
+					       0, 2, 0, bestdiv_table, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, div_hw);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, clk_hw_unregister_divider_wrapper,
+						  div_hw));
+
+	/*
+	 * ULONG_MAX is the canonical way to probe the maximum rate a clock
+	 * can produce.
+	 */
+	rate =3D clk_hw_round_rate(div_hw, ULONG_MAX);
+	KUNIT_EXPECT_EQ(test, rate, PARENT_RATE_1GHZ / 8);
+}
+
+/*
+ * Test that clk_round_rate(clk, ULONG_MAX) returns the correct maximum ra=
te
+ * when a mux clock sits between a divider and its parent candidates.
+ *
+ * Topology:
+ *
+ *   [fixed 4 GHz] --\
+ *                    +--> [mux CLK_SET_RATE_PARENT] --> [div {2,4,8} CLK_=
SET_RATE_PARENT]
+ *   [fixed 2 GHz] --/
+ *
+ */
+static void clk_divider_bestdiv_mux_ulong_max_returns_max_rate(struct kuni=
t *test)
+{
+	static const char * const mux_parents[] =3D {
+		"bestdiv-mux-parent-a",
+		"bestdiv-mux-parent-b",
+	};
+	struct clk_hw *parent_a_hw, *parent_b_hw, *mux_hw, *div_hw;
+	u32 *fake_reg_mux, *fake_reg_div;
+	unsigned long rate;
+
+	fake_reg_mux =3D kunit_kzalloc(test, sizeof(*fake_reg_mux), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_reg_mux);
+
+	fake_reg_div =3D kunit_kzalloc(test, sizeof(*fake_reg_div), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_reg_div);
+
+	/* Higher-rate parent: the mux should select this for ULONG_MAX. */
+	parent_a_hw =3D clk_hw_register_fixed_rate(NULL, "bestdiv-mux-parent-a",
+						 NULL, 0, PARENT_RATE_4GHZ);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_a_hw);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, clk_hw_unregister_fixed_rate_wrapper,
+						  parent_a_hw));
+
+	/* Lower-rate parent: should not be selected. */
+	parent_b_hw =3D clk_hw_register_fixed_rate(NULL, "bestdiv-mux-parent-b",
+						 NULL, 0, PARENT_RATE_2GHZ);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_b_hw);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, clk_hw_unregister_fixed_rate_wrapper,
+						  parent_b_hw));
+
+	/*
+	 * 1-bit mux register selects between the two parents.
+	 * CLK_SET_RATE_PARENT allows the divider's rate request to
+	 * propagate into clk_mux_determine_rate().
+	 */
+	mux_hw =3D clk_hw_register_mux(NULL, "bestdiv-mux",
+				     mux_parents, ARRAY_SIZE(mux_parents),
+				     CLK_SET_RATE_PARENT,
+				     (void __iomem __force *)fake_reg_mux,
+				     0, 1, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mux_hw);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, clk_hw_unregister_mux_wrapper,
+						  mux_hw));
+
+	div_hw =3D clk_hw_register_divider_table(NULL, "bestdiv-mux-div",
+					       "bestdiv-mux",
+					       CLK_SET_RATE_PARENT,
+					       (void __iomem __force *)fake_reg_div,
+					       0, 2, 0, bestdiv_table, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, div_hw);
+	KUNIT_ASSERT_EQ(test, 0,
+			kunit_add_action_or_reset(test, clk_hw_unregister_divider_wrapper,
+						  div_hw));
+
+	rate =3D clk_hw_round_rate(div_hw, ULONG_MAX);
+	KUNIT_EXPECT_EQ(test, rate, 0);
+}
+
+static struct kunit_case clk_divider_bestdiv_test_cases[] =3D {
+	KUNIT_CASE(clk_divider_bestdiv_ulong_max_returns_max_rate),
+	KUNIT_CASE(clk_divider_bestdiv_mux_ulong_max_returns_max_rate),
+	{}
+};
+
+static struct kunit_suite clk_divider_bestdiv_test_suite =3D {
+	.name =3D "clk_divider_bestdiv",
+	.test_cases =3D clk_divider_bestdiv_test_cases,
+};
+
+kunit_test_suite(clk_divider_bestdiv_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for clk divider");
+MODULE_LICENSE("GPL");
--=20
2.43.0

