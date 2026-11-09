Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4576.1794226517709602573
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gBcRaJAq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.64, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWjlCzCTz+uvkF2+tSkRWrRh8BoHBq18fA6OtPhR3KAlukOjAY3TP5tgmLPRzYtMn6z4lTrzatV11GW6LW88/9vsbEhA6xCn04GNPx6u61Ch5hd8lR3ZzMTVinV+8EeX88p483t+s0z1Zkqto8s+kEVzHG0QY4ztbpa74O95xEoC2+D58KMHHlICOvBoPpQ4d15hVfvkKuogtAVLuT2KOCdfZJWkAwvxGnL7tnFFyQAlvqjNGkO319nqqe88Vls9miIXLO9hby3+ONy/2RkXRAQaBaf8tJeFl176LOFbBKb8sCkerQF3z3EZOeOuty0cbnhcQfGbmQenQuzthJ2bBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9R2ivHwTzf49JHqBZFfe+UQM+xjFBta9Bq5/4wM56c0=;
 b=Su2kjetSF3WecTU7xvLLi1QIT3JSqBx/jSLRRIKAcy56oFiaJxXZmW1n8uYxPdNzN3VV7I8I8Rd4RKxmPt3vHGZ/IS/mqXvlp/OcqmgNQzjAEkLAsoztNbcqLsZUxfBM+pE3PPlUll+329S05/K4QTH1Exu8ZEwZoF2NDKDHpIj8U2GVOykyXyC0vUx1tDcEN185gSqAyO4Zbjz1dWp2om0+JQcW2k9fz0NE0ymcNOdKN9gqfsvD+gWYz4p1lKJUXdPqmZnJR6p+/Fft5QG1E47auc08dxrhmq42q8SGLg1QbqRzGPpywck/wjZiScQ9lCplTZr3yzg/iEcLSoeEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9R2ivHwTzf49JHqBZFfe+UQM+xjFBta9Bq5/4wM56c0=;
 b=gBcRaJAq/w+PAQeQohTIqJlYOcKw40xIuO1gtrbKlRQEwU6TacGp5vI9W4ZwrPekazWj+lwq1lGfsEya0qPRsKz0k5BBCT3GwMUNZAtPXR1iWb9eXhX9EDYG2wPSKCSkE9vEKDfqzUwyiNNQUU2I2fPk9JPEwKFvQWb9NxHs69k=
Received: from TY4P286CA0111.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:380::6)
 by TY4PR01MB13364.jpnprd01.prod.outlook.com (2603:1096:405:1df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:15:12 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380:cafe::85) by TY4P286CA0111.outlook.office365.com
 (2603:1096:405:380::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:12 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id F141B300022D;
	Mon,  9 Nov 2026 21:15:10 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/24] clk: divider: Fix clk_divider_bestdiv() returning min rate for large rate requests
Date: Mon,  9 Nov 2026 12:14:38 +0000
Message-ID: <20261109121451.6042-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TY4PR01MB13364:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd9daa6-b9b7-4d09-3a01-08df3e5b1ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|10067099003|11063799006|261028144727099003|261102123227099003|261022105027099003|261022075727099003|56012099006|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: jixtEepvx905ewnogyZogTJis6S2AHkh+BpWzeQpNXs1FLhkzZ8SVe39fw00uLIadkZeUTEZV+ffc+PvT6fUnRX92RQI5bSVK5aI82LX31+Pqgzuw4dsZmmCYNFre08UpblJyhv3h5ZCvbMGudXaykFHzDf3cCvluamoraNGMGqH6d30Bt9hyGYZP7/+qkIz6JMFWGXjaukRMVNqyg6p8dFERqHHb2j7n6uq/6bHEH+c1qg1LPYOkz6GlDmE4XiWml7JUSZE3vdPwTprH21JVUARqrWX/G/S+gpi+kqclCXbtEBQkdnmYHUep9ajvbbYNfQOE0KtBqcdFeHPsggLBYzremEwfSuCtKzR9DdVS6mqVrurGkarlcT6f64yDIYp4ZIr2TyTjdv2f+SnJj/rHcuR77ncxJLFRdETKjzB34mmiOfMZ1opRsjAtKLfjWQRa5fCEOXdzZpC0SDnef//OJ+pUm0ZCc6xcG8S2vFYgT+L3tyumT5f7MI90pZ/yvIGpYG0YzUD5n542psUIe/eATRDpVBmTyvNQMSivt+zsooo9SZUivQeBsR5xEpWUEw6bBpbKw6apRuHep8Fk1Lzoa9jDR6FrFKWEeuTkm6GgiHiPTcmuEygOFOdZTam2toIKt9pEY8upZF2F91X41Ugxq3kNsAVuQ4khTnQbETIAco2GL5aGacHM2oRtLMpUl9LxGkkbiVcwxWG37edcYqkEA==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1/VXHJsfr3yHGDQhLplCNnG4I2VUPzcWLpJ3aw/N9zB1Q7d//h5R++IkKvnoiHzbI9F6M/rG1PsgCANfzEinNU+XXKMPMeEdJfQQpM4N34ceQWUhO/IsNepHsoBm9w1BGSebOvHK3u1azPFx1wRX8T+4cBJUF00j1WEcYo6Xnf+lhCYCTGeRwK9NKZmF6Ypqm6KAerJp5J4zjQRU0fKEO6rqjtgDokkXDg1/BpCENgQP0Rp0G0Kb9jUYMsfvYB6LUGM+oUx8fP1RcJVmb0A9SA13pxYmt3WkQ8I2pVuXyST2iF8h6hNDLb+xtBRZBR9kEBDW1bWXGneNMsb3NG5Hm5/ztAQuxueZTGIR+28PkIheUL8D3x7eEj2Nrp0m9J0b7fhyBlAUq8fgBXlBEK582tL0zcbu/BOHlObxC7GzO4v1bdojPN6GvVndQp5NN7+o
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:12.2398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd9daa6-b9b7-4d09-3a01-08df3e5b1ad3
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13364
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24715
Content-Type: text/plain; charset="utf-8"

commit e129a400d8a787e5968e30309fa72859580b263a upstream.

clk_divider_bestdiv() clamps maxdiv using:

    maxdiv =3D min(ULONG_MAX / rate, maxdiv);

to avoid overflow in rate * i. However, requests like
clk_round_rate(clk, ULONG_MAX), which are used to determine the maximum
supported rate of a clock, result in maxdiv being clamped to 1. If no
valid divider of 1 exists in the table the loop is never entered and
bestdiv falls back to the maximum divider with the minimum parent rate,
causing clk_round_rate(clk, ULONG_MAX) to incorrectly return the minimum
supported rate instead of the maximum.

Fix this by removing the pre-loop maxdiv clamping and replacing the
unprotected rate * i multiplication with check_mul_overflow(). Guard
the exact-match short-circuit with !overflow to prevent a clamped
target_parent_rate of ULONG_MAX from falsely matching parent_rate_saved
and causing premature loop exit. Break out of the loop after evaluating
the first overflowing divider since clk_hw_round_rate(parent, ULONG_MAX)
returns a constant for all subsequent iterations, meaning no better
candidate can be found, and continuing would cause exponential recursive
calls in chained divider clocks.

Update the KUnit test expected values to reflect the corrected behaviour:
  - clk_divider_bestdiv_ulong_max_returns_max_rate: PARENT_RATE_1GHZ / 8
    (minimum rate, pre-fix) -> PARENT_RATE_1GHZ / 2 (maximum rate)
  - clk_divider_bestdiv_mux_ulong_max_returns_max_rate: 0 (invalid,
    pre-fix) -> PARENT_RATE_4GHZ / 2 (maximum rate with mux selecting
    the 4 GHz parent and applying the smallest table divider of 2)

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/clk-divider.c      | 25 +++++++++++++++++--------
 drivers/clk/clk-divider_test.c |  4 ++--
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a2c2b5203b0a9..de20082c694f3 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/log2.h>
+#include <linux/overflow.h>
=20
 /*
  * DOC: basic adjustable divider clock that cannot gate
@@ -295,6 +296,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw, struc=
t clk_hw *parent,
 	int i, bestdiv =3D 0;
 	unsigned long parent_rate, best =3D 0, now, maxdiv;
 	unsigned long parent_rate_saved =3D *best_parent_rate;
+	unsigned long target_parent_rate;
=20
 	if (!rate)
 		rate =3D 1;
@@ -309,15 +311,11 @@ static int clk_divider_bestdiv(struct clk_hw *hw, str=
uct clk_hw *parent,
 		return bestdiv;
 	}
=20
-	/*
-	 * The maximum divider we can use without overflowing
-	 * unsigned long in rate * i below
-	 */
-	maxdiv =3D min(ULONG_MAX / rate, maxdiv);
-
 	for (i =3D _next_div(table, 0, flags); i <=3D maxdiv;
 					     i =3D _next_div(table, i, flags)) {
-		if (rate * i =3D=3D parent_rate_saved) {
+		bool overflow =3D check_mul_overflow(rate, (unsigned long)i, &target_par=
ent_rate);
+
+		if (!overflow && target_parent_rate =3D=3D parent_rate_saved) {
 			/*
 			 * It's the most ideal case if the requested rate can be
 			 * divided from parent clock without needing to change
@@ -326,13 +324,24 @@ static int clk_divider_bestdiv(struct clk_hw *hw, str=
uct clk_hw *parent,
 			*best_parent_rate =3D parent_rate_saved;
 			return i;
 		}
-		parent_rate =3D clk_hw_round_rate(parent, rate * i);
+		/*
+		 * Clamp target_parent_rate to ULONG_MAX on overflow. The true
+		 * required parent rate exceeds what can be represented, so ask
+		 * the parent for the highest rate it can produce. There is no
+		 * point continuing the loop past this since larger dividers
+		 * only move further from the requested rate.
+		 */
+		if (overflow)
+			target_parent_rate =3D ULONG_MAX;
+		parent_rate =3D clk_hw_round_rate(parent, target_parent_rate);
 		now =3D DIV_ROUND_UP_ULL((u64)parent_rate, i);
 		if (_is_best_div(rate, now, best, flags)) {
 			bestdiv =3D i;
 			best =3D now;
 			*best_parent_rate =3D parent_rate;
 		}
+		if (overflow)
+			break;
 	}
=20
 	if (!bestdiv) {
diff --git a/drivers/clk/clk-divider_test.c b/drivers/clk/clk-divider_test.=
c
index cb56931456b8f..8ee1614128d09 100644
--- a/drivers/clk/clk-divider_test.c
+++ b/drivers/clk/clk-divider_test.c
@@ -61,7 +61,7 @@ static void clk_divider_bestdiv_ulong_max_returns_max_rat=
e(struct kunit *test)
 	 * can produce.
 	 */
 	rate =3D clk_hw_round_rate(div_hw, ULONG_MAX);
-	KUNIT_EXPECT_EQ(test, rate, PARENT_RATE_1GHZ / 8);
+	KUNIT_EXPECT_EQ(test, rate, PARENT_RATE_1GHZ / 2);
 }
=20
 /*
@@ -133,7 +133,7 @@ static void clk_divider_bestdiv_mux_ulong_max_returns_m=
ax_rate(struct kunit *tes
 						  div_hw));
=20
 	rate =3D clk_hw_round_rate(div_hw, ULONG_MAX);
-	KUNIT_EXPECT_EQ(test, rate, 0);
+	KUNIT_EXPECT_EQ(test, rate, PARENT_RATE_4GHZ / 2);
 }
=20
 static struct kunit_case clk_divider_bestdiv_test_cases[] =3D {
--=20
2.43.0

