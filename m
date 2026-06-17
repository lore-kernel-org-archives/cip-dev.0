Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CFFCD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:15 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10916.1781685071844505529
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ljvz1g9z;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.36, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFtA3bEf47KbfRIche41SYEYp/CR7TCRU2vmVuX1HCxI82lYQlMTQbQVi5qXl0KDS60V/Gq6hHutKwcbTWP/2ESxiOrcK/+Q7boscIditSuWLLOGVhdiknQg8BPy7Ur+tr2x1ggzHFqxEbDjJugCImHFJYXDWwwxzZ6BLB/qtxUPuzXxBiUtShfRTymrOBXGgH7I65ZbP6EOpGvdsPw9IpWRHFBb8wutko9+YwwhP3Y97HWM7JRluJeiarnY2aMd/eHDNWP38DBGWGf5NhzOCQDRsGSDTAjk/LCmjhI3LJDelgiylVpvX3wwANadjTB5Q2z1ZrQOEoJiBskvuaj30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PAZt2zVV7xt7YCrsUAdcvk3JcxascFLa+jQDTuVsJw=;
 b=t3ixlks4m40egC+XymoNsXwWgnNtM7/ShitIUputwXTAYoIMbxJjXUq01AZIW+3VY8LP/QFqbwHxMHM4l+BDlwxS9DwXQVpCecjlIKNj0V3to2wN9Jsi85whTRzTqmWVQvf9SsLYclxqG3Jk0C3S6sTG5XcrP+H8HB/NEdM9PCeRM9glWDdlwyib67RfSOYYYGHTYS/4OPsFtE/YGJMdsjnUe6Y1A0y+6VLCRoOracwzoVMZHoDxJJg1qftXKcEe5xiZ+sg/mEoNfNYXC/XQlqV7GdjBoqIrybSbAxqSTPBKxoHmGPJ2jf160ZhtqH26gyymlTKpouWGiWzg2sMHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PAZt2zVV7xt7YCrsUAdcvk3JcxascFLa+jQDTuVsJw=;
 b=Ljvz1g9z6+q/HfW/Spyfuttg24BbKkxu6lUryrAW7czFE2BjpN/lPsGJSYIk/w2okIQAK448xTlBDD2fqCT/UNPGrL282P3wuGHAlGcYi29JrmdTjUplz9aGPY+G34SHufztOhgYBgXbW8Xo+/MMvU4o1gjS/LkJIhUFHEA815s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:31:09 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:09 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 14/32] spi: rzv2h-rspi: add support for using PCLK for transfer clock
Date: Wed, 17 Jun 2026 10:29:45 +0200
Message-ID: <20260617083003.1071543-15-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6fbcb9c0-a1eb-4a95-3335-08decc4ac7e4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	ibCIAUpaBoPFJP7xK/petrD+lIHY5HR8iXQczLIEnAf9W1JKH5gUG5QcmcJu7C8iwNdrRaKxFq0VpnbbIARuHryNXspFB+x+dN/4ZJN9PGfdeHBEGdao5ig8JyWJrUAtfa17u6EY+kOPNThXqUDcUIAyevmhHTzDwYB8Uptt3OQPE6jgGnsJ3dN+vchgRpIa9u3tDDCY4vGCcHDcT+lYsIxoiUu7LwzZhx5klnwjfEIWPlporfpBjeGfVeL/SwfMiFOkHGvRrPI/3BVkVPhDwKE4vXLeCfHLSyESTThStKIvQhMexS26y7TORRwFl3pl9nUjh41MYrGID8WXQctiOOjurzRsxqQIMtTDVpWchCg17z7p7/MpQut7vO3bc6zuJA5+GRhEjN0IpzAmCWv3N3WVyfhGODSo2jKquSEJnTD98JAzGM/hTUmQ9kNaUdvVAIWe+Oo9No5HEfNJqNYkOmvWBAyFGJm9wRTREGeJcUcJO6RRbXr1+WzwPhGJp3RZFK1j4jj3nlFdigN9NyIouTwDEC0IJSbO8BmUotNMHnLsjq7DtSlYg5qwGtseD0ZdS5ZYXHwuGie8CQoe3Jz1r7VisrfLRxeUap1qgEk3CJWGzGh5E/byTDgw9YnifbLVDyY+LvG2NEddK7DIgt5vly2hoXHZrRFNVk0ZndNpbi5lI5q8g95STagCVOl3zK1TpCbpN652JJhMFIm2UT2SDQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C37NcVK5aBm7zCzlQYUnjrgwI9pdVvVT3bGfTT24+/2gxJFkUMzxNWLPQAns?=
 =?us-ascii?Q?tzkBYBkFeJuILxk69QRWtOTewHMgIT6uqM9o1HtV3WEDtg+/5lROJD9wJTP6?=
 =?us-ascii?Q?OrmFbiGcdkTGbXgEAayeh0KDWpMDUANH8KR4OB+evsEQU0iW9hOuMAXuiPok?=
 =?us-ascii?Q?JYwi7eVQmdGRd+SYALxHt1yYIvrUD0vpE3Ir0jc2Ii3qKqoEOoKtqJrrcGJY?=
 =?us-ascii?Q?HrKJhXZKaq/bo9MLKlazKl6ZzUeH0l/W/N2RHw+VAKomsUPpkLNncxrT2rGV?=
 =?us-ascii?Q?AoXOnUGpVa8tZUhY+aiQyNRXRjm5k6ndB9TJJCDeBxF5G8EI/CKn6D3L2sPx?=
 =?us-ascii?Q?Lg07QIS7EPseXDqmppT6jI4EtytEgs5uARm44TevsqdllputnHiU3frnGL1l?=
 =?us-ascii?Q?eeiDT86CvfNZSw0VN6KA/QpbA/e7+Ld6eACz+/ZcY/rog2YRxw5SJIpPq9Xo?=
 =?us-ascii?Q?s0oIcLx5ly6l5FbABd1ZuNQOCINP2f+RHSydeMivjXYuGrD4cvGaGZmDbWeK?=
 =?us-ascii?Q?JWqP5JsQCg3mvNhmPfkRB7zmvJI96GqBIa2VrNLpILh/x2MmvDEenONwnjFP?=
 =?us-ascii?Q?hnnGfxvj9oXtGtTbeYXBGRQE5FRy/yz9H8rwjJ6Rtw7r/ThVCbgzUJLk4yp+?=
 =?us-ascii?Q?Q4zDj2nH0lo82PdkKg3QPvKvHxi9NFb/2SyUB/Njfihd43pe59+Qz+0EaEhf?=
 =?us-ascii?Q?zzA4BYqTUZvfYwUTK1Y1jontMk9qyIhqMYAGZSrCa3qjpVvCg6q3rb2Wu6nO?=
 =?us-ascii?Q?yD+tR3n0UlR/bGGDjc0TZDlmX/vQTgQvmoW85hN+eY6WdwVtij9OHGUlRUoa?=
 =?us-ascii?Q?pBq5TbrB9rSGqE+LRFi5fpS0uj2DikfckDjfZNkvAzOcnC3P2TyrzqENOdR3?=
 =?us-ascii?Q?eaocYBkr5ups9eo8JfZaHe4w0JS2ryetcfwx3od5xA6U8cZQ/MIirRRxGYnC?=
 =?us-ascii?Q?Jhk4f+t/rmQJ06XmCiHwwPxFLdpkmvpPlKpe81UHJ2Arf5BlqcZW1Ylsv/mf?=
 =?us-ascii?Q?w6LsSqt28DFSaxHqDzs1cEyz0s9F1Arc6jX8vVt9IoK+SygKU3nlNJECH9v2?=
 =?us-ascii?Q?AW305LkSbXDTFyGW/uDm6oHCiXbH0Pw4sVRzAvfGdr6RNFJ45oVTP77DmV3l?=
 =?us-ascii?Q?CrWrL3F990pGboQpT7gvAfS5j4PfKzbQ/wGmTflv1Esrid2n2JvD1Z7jSRHa?=
 =?us-ascii?Q?wMn2icHDRNKN54CJ1U5pMVPAxsSF0CjV8Z4JA587myfLRUmlgJkraO+F0Rtm?=
 =?us-ascii?Q?RjvVkN7RV5sxtr21qrsKtDYpS79/EnMNO44leHsSWlc5hXgKuw4nS5Z190RD?=
 =?us-ascii?Q?RX0uS1NYLeRo+jFOml4flIZsjV187+3it11b/bEgifHdVLWqu8pqEIo3rpIy?=
 =?us-ascii?Q?5+U8dWawyjIIEX5hRn5BdcPIoakpf5LKVGWkQvAbDZ3p2aEga+v5uB4v13ko?=
 =?us-ascii?Q?5OABiphfamX4/mMnURRk95MiFyznH/Hh8aO99WKy6ZWLfm8ttaIXyuDqymPA?=
 =?us-ascii?Q?R8j24LnZHV2SKZq8C6/+A9jQyJcO4dKdarQLZSlg0poVnWBm2M2sK3vM/6UH?=
 =?us-ascii?Q?8E/HRT6myxdt5AVqMEpuW+PXBtgMN7z//PUkRCxv0vYl2jIUx3EVnP9Znsc9?=
 =?us-ascii?Q?gtMgqiqhxHEd5QL7fS+BbRllbgH6q4zSElPTupevuGaHfyAIpTRW6P462Pso?=
 =?us-ascii?Q?3IwVBPtuN5tdMx3kqROQ4UFHAv6D+e6+j4V5loTgPZdAFFYpTD9VX0P9puLn?=
 =?us-ascii?Q?jE5S1FK5UbO4PfGb9RVWXJn+6Z6exMULHsOv/EcGAuYmj5ZV6O4V?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbcb9c0-a1eb-4a95-3335-08decc4ac7e4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:08.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VvDYefbUDNk/oxd4Q4dUhTaTwLDT6EY+Ixj9/YNhE3kuqd4VIJNq8K1S6Etvr2KKvDDloK9DCIEtWi0QzWNpqXt82gfF8vD8SdhefRRL3UcfdYK9xK6D2caTtpegRIf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23173

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 1ce3e8adc7d0038e59a7c9f5c9e5f399ba0db5d6 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs support
generating the SPI transfer clock from PCLK, with the quirk that SPR 0
is not supported, causing the highest achievable SPI transfer frequency
to be 31.25MHz.

Add support for generating the SPI transfer clock from PCLK.

Renesas RZ/V2H (R9A09G057) also has the BPEN bit used to enable this
option in the datasheet, but it is not explicitly documented and there's
no details about its limitations as there are on RZ/T2H.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-8-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index fc0957d2bb2a..786be6d533eb 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -34,6 +34,7 @@
 #define RSPI_SPFCR		0x6c
=20
 /* Register SPCR */
+#define RSPI_SPCR_BPEN		BIT(31)
 #define RSPI_SPCR_MSTR		BIT(30)
 #define RSPI_SPCR_SPRIE		BIT(17)
 #define RSPI_SPCR_SCKASE	BIT(12)
@@ -41,6 +42,7 @@
=20
 /* Register SPBR */
 #define RSPI_SPBR_SPR_MIN	0
+#define RSPI_SPBR_SPR_PCLK_MIN	1
 #define RSPI_SPBR_SPR_MAX	255
=20
 /* Register SPCMD */
@@ -79,6 +81,8 @@ struct rzv2h_rspi_best_clock {
 struct rzv2h_rspi_info {
 	void (*find_tclk_rate)(struct clk *clk, u32 hz, u8 spr_min, u8 spr_max,
 			       struct rzv2h_rspi_best_clock *best_clk);
+	void (*find_pclk_rate)(struct clk *clk, u32 hz, u8 spr_low, u8 spr_high,
+			       struct rzv2h_rspi_best_clock *best_clk);
 	const char *tclk_name;
 	unsigned int fifo_size;
 	unsigned int num_clks;
@@ -90,6 +94,7 @@ struct rzv2h_rspi_priv {
 	const struct rzv2h_rspi_info *info;
 	void __iomem *base;
 	struct clk *tclk;
+	struct clk *pclk;
 	wait_queue_head_t wait;
 	unsigned int bytes_per_word;
 	u32 last_speed_hz;
@@ -97,6 +102,7 @@ struct rzv2h_rspi_priv {
 	u16 status;
 	u8 spr;
 	u8 brdv;
+	bool use_pclk;
 };
=20
 #define RZV2H_RSPI_TX(func, type)					\
@@ -303,9 +309,18 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_pr=
iv *rspi, u32 hz)
 	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
 				   RSPI_SPBR_SPR_MAX, &best_clock);
=20
+	/*
+	 * T2H and N2H can also use PCLK as a source, which is 125MHz, but not
+	 * when both SPR and BRDV are 0.
+	 */
+	if (best_clock.error && rspi->info->find_pclk_rate)
+		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_PCLK_MIN,
+					   RSPI_SPBR_SPR_MAX, &best_clock);
+
 	if (!best_clock.clk_rate)
 		return -EINVAL;
=20
+	rspi->use_pclk =3D best_clock.clk =3D=3D rspi->pclk;
 	rspi->spr =3D best_clock.spr;
 	rspi->brdv =3D best_clock.brdv;
=20
@@ -358,6 +373,9 @@ static int rzv2h_rspi_prepare_message(struct spi_contro=
ller *ctlr,
 	/* SPI receive buffer full interrupt enable */
 	conf32 |=3D RSPI_SPCR_SPRIE;
=20
+	/* Bypass synchronization circuit */
+	conf32 |=3D FIELD_PREP(RSPI_SPCR_BPEN, rspi->use_pclk);
+
 	writel(conf32, rspi->base + RSPI_SPCR);
=20
 	/* Use SPCMD0 only */
@@ -430,7 +448,9 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	for (i =3D 0; i < rspi->info->num_clks; i++) {
 		if (!strcmp(clks[i].id, rspi->info->tclk_name)) {
 			rspi->tclk =3D clks[i].clk;
-			break;
+		} else if (rspi->info->find_pclk_rate &&
+			   !strcmp(clks[i].id, "pclk")) {
+			rspi->pclk =3D clks[i].clk;
 		}
 	}
=20
--=20
2.54.0


