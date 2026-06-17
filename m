Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA68CD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:32:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10936.1781685119226560205
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dO1Rqrr4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIzDQeiplwuMgEMPaVuMhwv8IXu2oK3P1wYVeF1Qnpsj9j7pYUmAfGXWii8nKeS27oCkv2XrcZ5B6hUZn+sKnu8dqUnbfUc9IyEMaBo5rdZF6hch+pIaVP+8s1Zx677dntDGO3MENLr7IS32C3lXKSz4z8Eo3/5kffItCYVSu4OKslEZDwAFYGmnN12R0EScsrT/vt4f8n8RV4WVimBEY5WmbHUYAv2UhIQsnG9H9fzrnGSs2Y169n/TDbshfcJBrroSjh82bxpdZgvH62pDctj/p1xHG9RfnhUb2FNnYO5LD/1GyyLMb/rcJ5Vzy3+Qb2cmmJsAxzkuPUgU2DDy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7dh9cMjg045KPHwpgX463asAlC/qRqp3KxYlkAZUFQ=;
 b=ATq8S3UqtaIhkB3CX91KCJTz1iwWMQwH/Igd1fo22arhTjZinvoKivEhYZz5uHWfKbsGW757cM5CPpAleoC43yTtC1v8uoL5ay3KlyLO3xtzmIIgO7HGycL6LNmQvm1iNurMzxJEylOnN8g+fHBwgc4BY7vmbBfC8iIlgN3Oj0bmyQbmvQL1emSeySMpzyma/mvmcxh8O/6AoV59wx0klV/qRDiR0hxL/TPAqlueZbfWY3gvDBCX5naH3dL6BAdvMTvcSxxdZHbBTxeB8vF6GKy5Nh1OwxhHF1YfFMSE2TCqVBXHvxoBu4NqXvNju04wMt4BgpWecIQAOh2Z2+/jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7dh9cMjg045KPHwpgX463asAlC/qRqp3KxYlkAZUFQ=;
 b=dO1Rqrr4yTDkvcJKnCL/0r80rYkG+bkyBbRkHJJ6og023mQn5vM0vgx8uSUc7K0rU/Sd26ljVzisk+U1vgihHJdPYOUafAC1Aduc7D9qzGRK1i8dH9Vrb3DdiWHl1bLvauKHGNhWgEKDaqP0/9IC6RoMRy63A8hITzGo0lPEr/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:57 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 29/32] spi: rzv2h-rspi: Simplify clock rate search function signatures
Date: Wed, 17 Jun 2026 10:30:00 +0200
Message-ID: <20260617083003.1071543-30-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 7567cad9-e389-42c6-5e9e-08decc4ae40f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: 
	S3S5QGViuSjbHA0fKNZBoCdfyiwNC+u5hLgFmaWY/I2YQxgGxvqyVICAl3zC/TBeW+oBxGTp/OHp049ZO2bjpS0VM27Lpo0RBQgG/zkkH4V8RFwaNPYVgQoKAA+hRsKA9IDO5s3EYlQdODAyjxUw7ORuQwwnUhSRM+eVBAnSPM2mRVt2YVVYutLXlFUbb/mAl84DyYDjBCrE6QP28qcgBAGOH62meN7n1v9jDCPynAgiNUpQPWb2NHTeE7Ydk+8PpOg5jfYEvL8lOAd0xaTCslrwGjkjQPNJCsSDq1SflFPZZieeHYYrlaVVqSdVwILPeKVc3167db16qLI/mJEYnImD5mcNg5l4Gub/ieeCsagbAfqUIqokqTWa6IoVI/jl0KTaYW6ueEP6jz2PMe+l1IqGLl4vqGwLjtblFM7TcTxQf9TFbEyHd01gB/AM3DN2GMU1Sp6p+vg0jZ6U5fnKfco4W3HQCcDPSxShVwpuZF6OYiIEzJSmaHvdF7sLZQC8Nwm6XNMuqQ4pRWACMwpHK8mpi5QuI1MZ3BxqfwEyd5BDT72LhdzXjZWx6oDISLBV4SqcOhMzhitgAkMVhRTzQxeqgoDu9KP6Uk/Lc1XFTo5cpsXNARCr43Ia2zclZDbfTaAJvONT7xgMeSDTASJuhFeT3+kTQ0vtv8I6YoKL0OPitZpjZ6nea0+aVc4akTWIbk02DVstvYFWyqqhcZnjlw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vxsWYVsoyPATAXuVFbH10umxnKOlbgKWtUakAk41KHY0ZyDQ4AvyGYjHxG31?=
 =?us-ascii?Q?5UOEDSavundKOhiwVsYPr+JSwBDBtZy9NyQg+Ymlq0PNhN0BCAonrlrKUPe1?=
 =?us-ascii?Q?+tRjIlBOrdlZwb4S3eQ6rc1smFX6/c4UF1IOqwbSztT3VSiZPAuzSYZ2/Upk?=
 =?us-ascii?Q?I+zMhxWAHwXDdtGFh+tYCs6xEcns7JfhFFiTkhVDQMdYCdph9VdIITUffFSY?=
 =?us-ascii?Q?xsPxS3feZijbEHeyDnKXa7BHUbnXWk03IKExf/XGNk6tWNXGFhtjpIGAiAOB?=
 =?us-ascii?Q?sE5E6T0Fli0eq71difAmHGf47rZizNYcdx6K8HYqaxmZXyAL5FrWjBSu8/mV?=
 =?us-ascii?Q?++OIiD0qoIrr22ResKyJnADDG/sK2+EoD+UUzjBIR0965kKFjRCjgWxpyLtc?=
 =?us-ascii?Q?A/hwbRif3YqI+5enEZ6Pzg6/edkqqPQjuMLdRMbJ9yTuO6AjuYyEFOtirzL5?=
 =?us-ascii?Q?+K3QdJQRRYSw4qv5jKQzjp7KMZJWKyXTL79v86gHB4Rq3mvuI77MyeSMzZI9?=
 =?us-ascii?Q?WUs3Z9j5QqLoACyiv35XJIlqVfRw0xSXB6s2q61RqvjAHSborRKK3aGwxGRZ?=
 =?us-ascii?Q?S/z2MD/w7mOKA5CsXEXzyr4iTzkBWFyefLuNvwVVjtbAQDZptzXBiPGe28hB?=
 =?us-ascii?Q?DbyJQJpBn3r9z0RxuhXduBcg3F1DLCDxhYdMtMmklCtMC1Ahsjluily/uUgd?=
 =?us-ascii?Q?L34Flz0UF99m7oyCGNW2XRPst42ZUogrCsHjYyTpyZYQOyRVlU1hy9Ic8C17?=
 =?us-ascii?Q?4QBE1mQgVix50IgN/qoujAPWYM8ARpouSnaZZoHyTiKCbeu3ZPWmPlILcOcU?=
 =?us-ascii?Q?n3MGfFvsmeQv+cJWADPyPFWUesykURd5v9vOHDjSDFMY5BnYu/1Xbt60Dywt?=
 =?us-ascii?Q?CKHeIKski+cxAhRIAOIcNV/C2TVN4WE4qFBtvsIdokYZ9JIQWRPXSqKOCvW5?=
 =?us-ascii?Q?5WytuRqZoOIRjrJuN3jwGAzYNR0x5Mxvgh7G6Ce0vc3AtmrTl9Fs8e2JlyRh?=
 =?us-ascii?Q?gXgSHt6HI6Xsey0dGWqn3iWSR8azPISYeCeW0w6OSJjEAJzMwMCNiC5IKO3I?=
 =?us-ascii?Q?c1SGd87va8jQWvTWQf+EZfhZuzuAZ6QXPXfbG6MDUtXkNjC85u59iVkJHUOD?=
 =?us-ascii?Q?umDv8UqeLf3xfl1/OBiuFQxWhcvYOebuCwMINatTgeEvnNEmCeYtB5/qBXun?=
 =?us-ascii?Q?uzwxTLKuRqsLMpmtZDZe4a+oAe7bANY92xxeU47K2ZZAgEUenjKBFITvXenx?=
 =?us-ascii?Q?Rv+9vBOFm0KJ6aDS1QDnh1zHp40KFkBQHqzlJYkAAqIXO6o/iBqUGx2qOVJm?=
 =?us-ascii?Q?sYIwMC+s75zq9RSwu/v9VmNRDKP0GJgYwbPCIHRZTDZV8PpT6aCOswOP+IUA?=
 =?us-ascii?Q?oQlnM/NOkJf6uGqKsLgJ0YjBOtcZxdI80yd3sEaOc6KnQK69G0gbqvvo7Xj1?=
 =?us-ascii?Q?B9ZoPSmOi8DY1uxEBot8ILz3skqzh5OeZZ9nuUXcNTvzil9lUnb/64Vawszw?=
 =?us-ascii?Q?sqn1r2KC3rNLYjjC9ZphbA400LxOLV67oEssRiWI+ddZ5MvweYUoNN2K4ugT?=
 =?us-ascii?Q?wrRDVafouWLQclsD+ceNPiPv5KUiaVSlZRJW1gKdgDgnVhJujDtFcQs2QW/i?=
 =?us-ascii?Q?pqL7nEMCB22KcONw5BLdjOZAQH2xZ1qtf4KDarUkO9p4x5zZOX0tBb29KOv+?=
 =?us-ascii?Q?O5rjFZ9P+EzhX7hQb6JEANs+0UTGrDMZleR97hL8vFZc0S1bMQYUcH3mRlm5?=
 =?us-ascii?Q?SCmBktTeOlSSpKvrErh4fu4t+CrAM6qxCiJ+gJlSPQk+T5t0mj/7?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7567cad9-e389-42c6-5e9e-08decc4ae40f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:56.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ngu6Lx3XWzZOKY6GVgXntvmw4IRNpZ/u2nvXiUyDqhzdGmmFJwOHlAAfhYS2yvK4SirSmyCRpWYF1EQ0v/9rIxfzG4zoITjP8WenEWruD/ibYz61dIWhj06vwy3SL57R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23188

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c958bb67b2dfd87b09d725a60162d13674fc5fd9 upstream.

The spr_min and spr_max parameters passed to
rzv2h_rspi_find_rate_variable() and rzv2h_rspi_find_rate_fixed() were
always called with RSPI_SPBR_SPR_MIN and RSPI_SPBR_SPR_MAX respectively.
There is no need to pass these as parameters since the valid SPR range
is fixed by the hardware.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260410080517.2405700-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index fec389233d42..09d80a31ed4e 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -88,9 +88,9 @@ struct rzv2h_rspi_best_clock {
 };
=20
 struct rzv2h_rspi_info {
-	void (*find_tclk_rate)(struct clk *clk, u32 hz, u8 spr_min, u8 spr_max,
+	void (*find_tclk_rate)(struct clk *clk, u32 hz,
 			       struct rzv2h_rspi_best_clock *best_clk);
-	void (*find_pclk_rate)(struct clk *clk, u32 hz, u8 spr_low, u8 spr_high,
+	void (*find_pclk_rate)(struct clk *clk, u32 hz,
 			       struct rzv2h_rspi_best_clock *best_clk);
 	const char *tclk_name;
 	unsigned int fifo_size;
@@ -413,7 +413,6 @@ static inline u32 rzv2h_rspi_calc_bitrate(unsigned long=
 tclk_rate, u8 spr,
 }
=20
 static void rzv2h_rspi_find_rate_variable(struct clk *clk, u32 hz,
-					  u8 spr_min, u8 spr_max,
 					  struct rzv2h_rspi_best_clock *best)
 {
 	long clk_rate, clk_min_rate, clk_max_rate;
@@ -464,7 +463,7 @@ static void rzv2h_rspi_find_rate_variable(struct clk *c=
lk, u32 hz,
 		 * minimum SPR that is in the valid range.
 		 */
 		min_rate_spr =3D DIV_ROUND_CLOSEST(clk_min_rate, rate_div) - 1;
-		if (min_rate_spr > spr_max)
+		if (min_rate_spr > RSPI_SPBR_SPR_MAX)
 			continue;
=20
 		/*
@@ -474,14 +473,14 @@ static void rzv2h_rspi_find_rate_variable(struct clk =
*clk, u32 hz,
 		 * maximum SPR that is in the valid range.
 		 */
 		max_rate_spr =3D DIV_ROUND_CLOSEST(clk_max_rate, rate_div) - 1;
-		if (max_rate_spr < spr_min)
+		if (max_rate_spr < RSPI_SPBR_SPR_MIN)
 			break;
=20
-		if (min_rate_spr < spr_min)
-			min_rate_spr =3D spr_min;
+		if (min_rate_spr < RSPI_SPBR_SPR_MIN)
+			min_rate_spr =3D RSPI_SPBR_SPR_MIN;
=20
-		if (max_rate_spr > spr_max)
-			max_rate_spr =3D spr_max;
+		if (max_rate_spr > RSPI_SPBR_SPR_MAX)
+			max_rate_spr =3D RSPI_SPBR_SPR_MAX;
=20
 		for (spr =3D min_rate_spr; spr <=3D max_rate_spr; spr++) {
 			clk_rate =3D (spr + 1) * rate_div;
@@ -512,7 +511,6 @@ static void rzv2h_rspi_find_rate_variable(struct clk *c=
lk, u32 hz,
 }
=20
 static void rzv2h_rspi_find_rate_fixed(struct clk *clk, u32 hz,
-				       u8 spr_min, u8 spr_max,
 				       struct rzv2h_rspi_best_clock *best)
 {
 	unsigned long clk_rate;
@@ -545,7 +543,7 @@ static void rzv2h_rspi_find_rate_fixed(struct clk *clk,=
 u32 hz,
 		 */
 		if (!spr && !brdv)
 			continue;
-		if (spr >=3D spr_min && spr <=3D spr_max)
+		if (spr >=3D RSPI_SPBR_SPR_MIN && spr <=3D RSPI_SPBR_SPR_MAX)
 			goto clock_found;
 	}
=20
@@ -575,12 +573,10 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_p=
riv *rspi, u32 hz)
 	};
 	int ret;
=20
-	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
-				   RSPI_SPBR_SPR_MAX, &best_clock);
+	rspi->info->find_tclk_rate(rspi->tclk, hz, &best_clock);
=20
 	if (best_clock.error && rspi->info->find_pclk_rate)
-		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_MIN,
-					   RSPI_SPBR_SPR_MAX, &best_clock);
+		rspi->info->find_pclk_rate(rspi->pclk, hz, &best_clock);
=20
 	if (!best_clock.clk_rate)
 		return -EINVAL;
--=20
2.54.0


