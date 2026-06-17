Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A2FCD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:37 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10842.1781685389271984480
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=H46MbPR5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2dozHsSeNeBcOnQlTVHAXL1NrRA1t4DYl1DS4SJJkQX26d6mStF4PIRE9spkPv9h6UV34Mj5T8HN1k1cvpV+3X7qQg0USpRqy88gejw9ZT/KduMjFwLJ62wLlOmDPn4QFnqqvydkWu5DwoY7s9oW2n+8LgWyMDAHdrFWWaCnS5/rT7dUX6iR9od9/R9dTsZCjksQSvCWexBDjtISSUevasuLL9ExqhDO/GkEliYv4QXPtu6uKMZSCOFQTO1q57Ccq7HoeMP12sr74iMsOiYAQECn0R5B3O5wp2x0BXbvIRN2r4ai6Wfm75A3Jys8Q9rYTsMKLMLqfxBsoQwtQ/soA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHWTZ0hB/8sT955oVENE4InuGKKg5IkFoPAQM1ARTpk=;
 b=V8OhgRxezj9oLH9tMTLbSA4KOB7OE3Ryf7a5JaIOAqxfozAMlOQ9K6vIK1w1lrSfalh8No2r+FZ938ZOGAYiqD6lpP14ElL2PTY9EkhfOTzZZ9Tna8nqeVZA1rfm+TDTDDJiQbex4gLOyrDN3DEP6haiEaMGme+5aR8XHTJCZr+RJzDk9PZCHy7B50CPyLLyXp2Kr4A4g/6DotfW3nxdOVI4M5AfgH2Noyth5Yyn6AR8g69ZOnMNPBfSylR/3VHLIVUsSJKOyaBaqp4gHB2qtym4H3rO6cXX3A4/bmvhaaSuyC0/5VQY11npyFuJ8dmXcJrd3UaqVcDUV9W6cTyWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHWTZ0hB/8sT955oVENE4InuGKKg5IkFoPAQM1ARTpk=;
 b=H46MbPR5xzBxKJJVqY0JZI2c+wSgr+ybD+QHwi1VakA1bueKPdqJQIBJedS0O6404NnTmPHcnhFGmH9x+M1nfIUQMFKYf6eaeybHAdjtI61ZBPtTTgIa13qwlbdk0o62+WgRs8Pi2iLDpzidQGCr+VjknfeRbKUWZYLumfGnjx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:27 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:27 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 21/24] spi: rzv2h-rspi: Simplify clock rate search function signatures
Date: Wed, 17 Jun 2026 10:34:59 +0200
Message-ID: <20260617083502.1074160-22-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB12634:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2a96e6-158c-4080-9c43-08decc4b85a7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|56012099006|3023799007|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	jBtIUNE5WNG0vTCc7NTSIFAyH2BswEro7ig5WVw/AvR02lo3OQdvrhaH1z6vR0zbIRe+87X4aiZSr92duQsGbQu1Jb4oTZjdFREIEzIA1KDp0M4xDkAt7bSNxcckEk5S8ns/6E38K9ocmlh6kzr9ghkPnmUwmTiAPYT38hlAr3JKl3se60cCTBfEJAendMzPtCX+41MGwVnJXisKvys1qXvb7tm/hyEDnapuIyQmGPs884OBYKj5LqBko9AZGRuyaY65td+g3K78N0LMMDxp1sjgjMtXxiXKVWuIzYaKXCbsvufusFwM6giHE6A0GnddrA4SXOP+UycfkRgm6HSipDZnBNNAulCcbAlOiZlRLyh6l3kFgRL35PdR7so3bNzLDtaFthoTg3p2os8sH9TF3HafBYQp2jV7xWXZgVoiyBhEFrxP71Uiqxo5f8tV/iEb28t2CCakc3vDHWdM8bMdeXbdknXeLyUw1Rg1aRQ5lQzf9n2xQ+o8uWtgdVBZwdn9MY7LbPSYWPAlCcZZWBrLDWkw3skjhG6Tdya5x38qvAzWNZele+czL881n9AOHQ0QKKSoaEKA9lLUPXckbP1S3AsYQm6cXxV07trQYEfvKlbqVxAa+W+q6LmyqLtLgpnrLGXDyN02yfK6ubdd527lpx5oHVVCzLKR9nU9LqgEgo490zZr2Tif9rO/UNt5ViwxIWLRaIcfd3GbtjncFTzzOg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(56012099006)(3023799007)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JC+djeriHg/ybSz7TvjukGKaKRCQX1Fk36feJKn8q+rDM7s8ln4kGYQk+jLQ?=
 =?us-ascii?Q?l5HgLldbpx1v58b0bWAyyUxWlPj4S2IeMTYa7F8Kw3ia+nSB/6D3QN/Inkr+?=
 =?us-ascii?Q?SocH04hPGRZGfQnSByTWbFT5bFcRcLiAA42Wnd3BvKp/f2hkSiq0V7qL/X4Y?=
 =?us-ascii?Q?xIC1PLINgDVunjyi/6XLtl5wixddYrdSlXWPkD2t9tXICY1Htm15vhrNukaH?=
 =?us-ascii?Q?Gz2htR9k9rptk6MPuXEL/SV9P6PYdo/1t8VAFHOZhnvbQR3iPFGu0eDKWaHC?=
 =?us-ascii?Q?jluhXNgc2EKFXXDB7k0XExkTZTyEON0NGavgfaQRmR/AN7+gAgfACYc9dQ5G?=
 =?us-ascii?Q?hepd6TEZokDyriVYakMC2BXt+XJzfzNBwHrUxz9e19/ltyi9pwzkjJ6gUrei?=
 =?us-ascii?Q?25+PGINHPtXNwsB+4k6ILnVQc5i197Y9LrR4D6lDsq9hW/blVgJXy/NxyVRF?=
 =?us-ascii?Q?ZxZ97uGCj6dVchN3bhSAdlVWpSEmKUICDIsXqf68OlZWayrh6HIrUgGr6dPB?=
 =?us-ascii?Q?tCdUO0i3F2wugFboOEu67iXvexu+D6NsXYdEEnDneEbE/ckrNuZ8anugLqEJ?=
 =?us-ascii?Q?zQDayPHm2RTK9g4fXg2pc5dY7uxprAGT7+/ohm2MEqh2qqg/pPepvU63jElK?=
 =?us-ascii?Q?8S/PLuEgqmlMNm70WQwV6NSxRGF9n41aLYw6yLAAwEIq57RRdKYqm/k2DYjn?=
 =?us-ascii?Q?CvWVF2WdrrjB1Ixz7qDzcQj7cW7aS4DGmcepdUKTQ7yaX97iaR34dJ45lCu4?=
 =?us-ascii?Q?8G9W9YgTVafiq6sKH/tBgM2os4EsNEEDf1w2lIe2AS51K7ROhwX/U835qsF/?=
 =?us-ascii?Q?ft5b4yMqYdgQ2r2F1GrcBbEGmxgRSz7tp0tUikiuylrBCqsLmP1TcrrFxRaF?=
 =?us-ascii?Q?D15DM2qKnxJqa1/DVMEnRFQOKVJ4wZ07BoHXGUjXDvwxjWgGvG9g/P0PwY2R?=
 =?us-ascii?Q?X2kEz4d8MSLddetNbZDkT8V/rv+2glIG/xQW1nDJVbGC9XZ1auzFkEhL3Ov/?=
 =?us-ascii?Q?jBdyfdkaiUBshjy2PiEuV/qZmbUY2P0+NZQbDT4UcyO1W4Ij6XchVqAR13Jg?=
 =?us-ascii?Q?qJw1+jvYnA2hK4400mbnf/+tDKV++mC/mbLYtpOs1k2gL4h7h7i6A/GbbbcK?=
 =?us-ascii?Q?7odpqtM1JqC5NALstxZuIFMdt6XD/qRkbN4QTj+973RuDYRqDigT2II1YkdR?=
 =?us-ascii?Q?8g/95WslSVHfGFWpLrhrN9Jj8U8dgqk/S9cBR3BDcquTAqTbBmjIxtAL5hBS?=
 =?us-ascii?Q?2gu3TTv17X7K187ryVaLObFCrQ0IWGbULVLRz5Voc/kAzHGz0WRSb+qBv/1y?=
 =?us-ascii?Q?qnRYVD4DIgDQL++PTgh7hYwo3RwkdUaCx9+OIr6kKZjiW8H8l+xZA4PdPGjI?=
 =?us-ascii?Q?gYzMeo6efMsTO4SQYEcOhfA5LLqg+NUFeQPcRwYjXwPZRrWPYxpucDJpGX4H?=
 =?us-ascii?Q?V1M4ztzMjlz4c9fg10A+bTFfrkLDpb/cOiphq8T/L+gJ9QJ6AvspbjdyBT/n?=
 =?us-ascii?Q?zQqnM37qlda9XCNV3SSJhNOuwyK3AvFBGbbEbxXaKSpKXDQMlv6P9UKsd6NB?=
 =?us-ascii?Q?oX3k6MA0fuAZtP5TiQxnsnUOSjmCDEC5n1CZ0GsxJpd6rwp9+czbQBb+g5hP?=
 =?us-ascii?Q?MaFXqQHELVV2DbIa3sgNgdqalWHWjJUOHBHW22r5atru7fnGvtpHTC8/fvoS?=
 =?us-ascii?Q?NaXq78Q3DSJ7XEjSFCviaM+IILC1aOEwfQJwuhllELt73mM6BfqxJCSZCpCC?=
 =?us-ascii?Q?VM/U3Qo98gvq5PYPON/Zy8uO5PhZCBbM4IkKwND82HnnTWAYdo83?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2a96e6-158c-4080-9c43-08decc4b85a7
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:27.1844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rNWTOGqe8rO6AwekGt7z0KkWYPqavyhC+IEEVJaSTxTCnGd6yjuGEXKoS89zsNE+tlCVP/SyGK2FGGgz1X55eSmWknkw8wtqaxR5iDD0nS0Doc3Oi9HP+h3qQMXdC29
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23213

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
index d8a7a0a36ecc..c60002f2b026 100644
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


