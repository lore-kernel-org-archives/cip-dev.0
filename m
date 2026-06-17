Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25470CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:15 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10914.1781685069769535559
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=H9g7d6WN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKmFKsINFiV5ndLzl2Wqppoy0bS+Ab16VtdaLXOuC/mdRIu27FkQ0Fh60avycf+Z0ZGIXlEPrY1K1jw5G+h/odeg8jR5upO7+L5QTGFO2SsD5ywrd7P8LdfjRsjXnLOGph13ZVsrLCHN6cJFOP2/0Etvf0/befdl4DVUtQtus9CjNNLAWDNQGLYj1dl3WQNGvFhO08B/3ot2HyqqHW7DqYgi5qUK/OXN2xoxQOhu6g0h4SMLsabLW8dWNQ+SqhPS3UsLz0y2ZcLLOkjE7HlSCIV4j++miT0bNScmLnIAD05bn++++rLKCejKAq4f6rEibgGmtupZ9GVWeREEx9aPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUC4b+ok2m0I8PcUEBPM0/XTVBHUtpL0N30dMGbgaWk=;
 b=U15FW22la2QrAXIFRSK9iFubKjGihT1p0bujYPhdsOh7i+k+1kjr3bDxSrytj5uHhV66T9ApFTJLXhIoCZG1Fdd2DJWJFXFKBPiFgFbwd+ssI/q6OYwJfKENm8lGPjsB2d5QZUxI41HsL+I6Yb25h1QTPpXYvUGgRcoOgWlWwmtWxA5UGTNXIdOy5lJGI8eJnUPLY5EmMCcwv4tpXF45DFgDsKH2wAR7M1dOSmIMKVBzRk5GeTQpZDPLXKfrOEtFD2VpVGU+VP7QwLd13vdRuq00Q2VypS3XXfaDiA8OjbelcXlh58CjTmphGJRbZgIyb8e8DOZ/DFB+qkixjXQdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUC4b+ok2m0I8PcUEBPM0/XTVBHUtpL0N30dMGbgaWk=;
 b=H9g7d6WNSp4LI7wUK4i9T3m2TZRUenkiYVDIrdpjstGFD/Djs+9mt14Dig4g+yk5VvjdA0dWFxwRq2rMZwD9PUTv5eeh3HidAjNf7DlsmIcOEJ8Qy+2HWuc7gTAF5/JJO/1RrWl1zT+IvGlE8jo+yDfkkxwIdSeXJEFB94PM4cU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:31:06 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 13/32] spi: rzv2h-rspi: make transfer clock rate finding chip-specific
Date: Wed, 17 Jun 2026 10:29:44 +0200
Message-ID: <20260617083003.1071543-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 18934758-4973-457f-de44-08decc4ac615
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	1smkZrfWHZ10MfHbcZjE+boCPnGhsRngIp6/KBo6wNcK2LuXG+CgZYvVUqTWV8zR9ZFAiCybU3zGg6PyoOwwheIO29fa3NHFqUMX1yOmO5X6CtJp+eINr4Niav6ydtut2P3HRRzO/kxL0r/EnWefBrfSFZD5mbJ0kTMRUxjFK4WieFaTyh65BQCqooLKAX8d6LoLS9f/KSRLIiPmcrXK+j79NM1OB+mwtoOM4MwT6Gf08DAwhkbHcVEcytfAj/0nd9Kvb/hUnw6L6sIrJoCE0uhlX7OhsofZ6mvariydjT/VAEoGNyWqzuv6zDxGTv32bSM3g6zAmOCYUP7jiPZgJnvlqhubdAo5sYxfkaXeZqVeYFB8h/K65MpkCzp4yH8r9ngJUZOMeViv59OCR02QRCd9nVxmiVFVln60QOsWTbkWMoOKxY39aG1L21XEITICN2w3hJMYXYz2Snwrpvws8q6rPxRGOK/gTbbRFx3JRNhFGLerD29wLuR0N7LWYdXWRyNBE+jxy5O996MOcmP5q1uUJNK6d3dgp2R18f4NYiKtmjUvqnPyf8DDx7UFopgCb6nbsEjJ+H3EEAk+Pg2CLLFWxIyLIbxlSgQaU4fhC/0R9+829A2UzqccwUnxZYiL+EAcpk+l4QKR8RYVnvOvekdViLsq/2kDF+Jo7KI0lqJ4tSty9AMqSveVHahFogAbuGlz2/CxNzQUxsgBx8DPRA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BCSWDuB3mTaoMjcB7+KjhvRa0hjrhWFla6PT+4n16lnclg86Pm+9All593tb?=
 =?us-ascii?Q?OOV0fGjqJc3Sr2HiS5oZRPvgjGebfPn650VPkrC1z0rsmWDR+fC7y8eReb5P?=
 =?us-ascii?Q?r8AHdV0CixhdUrGdTqT2U+x0kdrNVsZNczye57OCZ8/Rbdx4/fojNEyoc9lS?=
 =?us-ascii?Q?yBTdXex5tOdo1Me5d6ZhMTQFM9hYI+QQZL17sBYp7jdh+NCU2QKLw30mAAzG?=
 =?us-ascii?Q?JbTUe83Fx+B/izMJ22kIl4P+TTs/jIjly1V95Bg4NCc7+E2whmvpNA5oy3M+?=
 =?us-ascii?Q?Zuvgz6y3HH5hDVEklzwPcUtyvqrLElQG84iz3X/vKEbOYX7Nvuc5rvmrcUAb?=
 =?us-ascii?Q?uY6FZ/D2Q6r4gUlDTUrh3y7JB7VsA0OcCdFbCuzheFW+FjiJOD3HnTgxffeN?=
 =?us-ascii?Q?S97cq5YB0tuWaRQUV3KJlppRmOlf/nNblankH1K2zrHEnGX788a1A6uVaYTe?=
 =?us-ascii?Q?qLLqzdf0nh1wjeCTfysXypueclskZ5PTkYHt6ovKsRrdOOKY5as56/2/WdYh?=
 =?us-ascii?Q?vR6n0/I35TwkDNeI43zgiGt9m0EFEir35lAFVg2fMJJTm1Knn4vZdBighTFa?=
 =?us-ascii?Q?lLd0RJURzVXFNPloQoPsUIiN57YWeELYPRLA4eVVADYyPQMB71maZkrYaoa8?=
 =?us-ascii?Q?mte8ZO3KHahUzWoKoy6rEoQbeDZAqXhV954v80TeE+p39ntkl3yzvf+1ch+g?=
 =?us-ascii?Q?nMl2AnTsCP+BBdFEHr+L8vX0I7LyiFVTqtVglOZ+UPv6Sd9nZQRHfpv73lHc?=
 =?us-ascii?Q?3/DniaOlEujz5QoZYYXxRKo45EBe3RYaxIGsFv3M7GntEdJytbbts8wsS6/Y?=
 =?us-ascii?Q?Xqp9cs1y9TTEcwQc0pCE4Q+BFpywx5bVL+vhouJEM3xXN8RX9uNZPgd2xKwi?=
 =?us-ascii?Q?LR6EATA2gk9gQCjHUnZrqA6cTdTHkOdQrm3jHF5EhWAxTvenKSRkVoa1u7ZM?=
 =?us-ascii?Q?nvMtM7D7Y1iHQ7oVDGBn5e7iyUVGd9OPMoOlOvA2yzV/4OBpEyOgpiskrfca?=
 =?us-ascii?Q?i2V9NWyYz5rV/Tn9fVXgq/eUb+xYNLqGLT9b/n+J9Sy6/tJmCKtVNCbPlJ2e?=
 =?us-ascii?Q?HyeTYoaqjHM7ojrqywj6P0J6ko76CVt/V6FJYigHP357ZIu/pj+Yebp7B1XS?=
 =?us-ascii?Q?ddwrR7ksv/sMW0TbU7tgxbIAOa18vRKnSWKH3bYrWcIKunsrTPWmzxY8gnlJ?=
 =?us-ascii?Q?9iORXxmSUkKFm5NK1Siyvz9GjvXiQDoFMyPCAdrDOVgl4C97+8CqNiOoKjgC?=
 =?us-ascii?Q?aCsZ9OPHeVlfS1yu1o7Q+/MFXtUdghIj5qfT5jDv0NWh8O8FcTATbco7yFTb?=
 =?us-ascii?Q?8wvu2/ce33Yki0RTBtrDmL6kSWu5o6tguZ2Ic1JH99xl9YgmlA6W9H3AjJvF?=
 =?us-ascii?Q?XYwRSD47UmdL4rzZ7WbUGi4CAU2HtrP4FfdIhwRxSeAxNMV0cfmjH/pdqgQd?=
 =?us-ascii?Q?c1bQqKCoDIgn04IUFvmE9he8Z/QVfSvLufh32EGdq6p0/CXriLG/AQqF00ol?=
 =?us-ascii?Q?4HJhUgQ461cBIN13go0aF/EQJFpfZZsKp4k1raHN5CrtxvhYKGKe/8git4Fu?=
 =?us-ascii?Q?SnuQnTt6bHSAly7mK+F26L4CkYwKyYOBhDSGdq0oTFopNk50c1BanvEBiaT8?=
 =?us-ascii?Q?mX6g60DgmQ0ZEm20iij3+DQLmvkgiXuGMX7kKmOLsWfZY1GWY84vQYOikKa7?=
 =?us-ascii?Q?dvzLM8tNyo6yHQDHgWfUnKLO66nO5yNSf/5BLgTR5O2bnpfPzBMqfsaxgZfe?=
 =?us-ascii?Q?FZjU1M3A+sLOVFSW4G+xmU6YN0ZYPVhguJbbW6zHorwDClf2z4kD?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18934758-4973-457f-de44-08decc4ac615
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:05.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3klLXba4nl3lk7g768+E43ti6fErRYAR4AlA3HcWcebqhmGhUOmqTAwUhBfw9TelgJDfsPahvCz8M89gAZiOTomaMhABysc8XW4bF8EUCZKwuBOy8DonpNcBkpYqyQMC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23172

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 77d931584dd38916b66c65320c80a65cbef4b122 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a more
complicated clocking setup for the SPI transfer clock than RZ/V2H, as
the clock from which it is generated supports multiple dividers.

To prepare for adding support for these SoCs, split out the logic for
finding the SPR and BRDV for a fixed clock into
rzv2h_rspi_find_rate_fixed(), and add and use a .find_tclk_rate()
callback into the chip-specific structure.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-7-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 62 ++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index f22f418325d8..fc0957d2bb2a 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -67,7 +67,18 @@
=20
 #define RSPI_RESET_NUM		2
=20
+struct rzv2h_rspi_best_clock {
+	struct clk *clk;
+	unsigned long clk_rate;
+	unsigned long error;
+	u32 actual_hz;
+	u8 brdv;
+	u8 spr;
+};
+
 struct rzv2h_rspi_info {
+	void (*find_tclk_rate)(struct clk *clk, u32 hz, u8 spr_min, u8 spr_max,
+			       struct rzv2h_rspi_best_clock *best_clk);
 	const char *tclk_name;
 	unsigned int fifo_size;
 	unsigned int num_clks;
@@ -237,9 +248,13 @@ static inline u32 rzv2h_rspi_calc_bitrate(unsigned lon=
g tclk_rate, u8 spr,
 	return DIV_ROUND_UP(tclk_rate, (2 * (spr + 1) * (1 << brdv)));
 }
=20
-static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
+static void rzv2h_rspi_find_rate_fixed(struct clk *clk, u32 hz,
+				       u8 spr_min, u8 spr_max,
+				       struct rzv2h_rspi_best_clock *best)
 {
-	unsigned long tclk_rate;
+	unsigned long clk_rate;
+	unsigned long error;
+	u32 actual_hz;
 	int spr;
 	u8 brdv;
=20
@@ -252,21 +267,49 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_p=
riv *rspi, u32 hz)
 	 * * n =3D SPR - is RSPI_SPBR.SPR (from 0 to 255)
 	 * * N =3D BRDV - is RSPI_SPCMD.BRDV (from 0 to 3)
 	 */
-	tclk_rate =3D clk_get_rate(rspi->tclk);
+	clk_rate =3D clk_get_rate(clk);
 	for (brdv =3D RSPI_SPCMD_BRDV_MIN; brdv <=3D RSPI_SPCMD_BRDV_MAX; brdv++)=
 {
-		spr =3D DIV_ROUND_UP(tclk_rate, hz * (1 << (brdv + 1)));
+		spr =3D DIV_ROUND_UP(clk_rate, hz * (1 << (brdv + 1)));
 		spr--;
-		if (spr >=3D RSPI_SPBR_SPR_MIN && spr <=3D RSPI_SPBR_SPR_MAX)
+		if (spr >=3D spr_min && spr <=3D spr_max)
 			goto clock_found;
 	}
=20
-	return 0;
+	return;
=20
 clock_found:
-	rspi->spr =3D spr;
-	rspi->brdv =3D brdv;
+	actual_hz =3D rzv2h_rspi_calc_bitrate(clk_rate, spr, brdv);
+	error =3D abs((long)hz - (long)actual_hz);
+
+	if (error >=3D best->error)
+		return;
+
+	*best =3D (struct rzv2h_rspi_best_clock) {
+		.clk =3D clk,
+		.clk_rate =3D clk_rate,
+		.error =3D error,
+		.actual_hz =3D actual_hz,
+		.brdv =3D brdv,
+		.spr =3D spr,
+	};
+}
+
+static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
+{
+	struct rzv2h_rspi_best_clock best_clock =3D {
+		.error =3D ULONG_MAX,
+	};
+
+	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
+				   RSPI_SPBR_SPR_MAX, &best_clock);
+
+	if (!best_clock.clk_rate)
+		return -EINVAL;
+
+	rspi->spr =3D best_clock.spr;
+	rspi->brdv =3D best_clock.brdv;
=20
-	return rzv2h_rspi_calc_bitrate(tclk_rate, spr, brdv);
+	return best_clock.actual_hz;
 }
=20
 static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
@@ -462,6 +505,7 @@ static int rzv2h_rspi_remove(struct platform_device *pd=
ev)
 }
=20
 static const struct rzv2h_rspi_info rzv2h_info =3D {
+	.find_tclk_rate =3D rzv2h_rspi_find_rate_fixed,
 	.tclk_name =3D "tclk",
 	.fifo_size =3D 16,
 	.num_clks =3D 3,
--=20
2.54.0


