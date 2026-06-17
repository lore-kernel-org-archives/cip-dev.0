Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E962CD98F4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:15 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10918.1781685074247994174
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kMPSRumI;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3a9+wz0x5OUZAjWlFfxPDvKRYcjdkeGdqYYB2p3KEDn3U+dJS9cNKO5h3FOFtydPOY/nirZ4qInM1O7pCvQBYTinKcNAznFRU3YC95Zt2QkBZrKcbR9QZW1zM8UWmwa8hCrgdgiLnwvPabGqOfQBhToWNP09s2rKNQflGMfzNUSZJ5YikmGpRFcx4WjQuw9jwswd+Kizx1vw3dKAAN5uWCd5mcfxPTnFqxeKnx1H+7JkwJqyAONzUN+hPaRU56Sy6m2QXpFHbfuCUAGWp6zAi80O2PrY8/ElwZ89rMU3LeNoy2hWECGCJoslXSAblwnNbjHQpDuaoPJLxc19Dxcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJeJEhFFUcwsNIRGExVVnzatPj9bwpj0fkIvIbFn/Cg=;
 b=dafJAOY4ZJejleNNoIxayB0BhR0sIv0bAeQcBX+s85DuQIfdrnJg+SYk2+ynNwABzTHUt7n0Lp1FQjz1ANPg6oZnx0PQD0iok2hQ5eLBVLAa2ThQZEopwM1coZn7vCP2vv+tY366h68S87CpYUZyarko6KRXa4ER2+V+c/5BIP/4tz4Hr539682Y9oxpnuj8cJoyUaeqrItSo/QrEMxKB5xEtH3bbDjUIwD/3FBCDNaMI0lhz5p8QG2kXuQClSKFO9J065pxtlE3X01AmgitLcCmsmRPnDOMCTjToZakO9JBx2ZaKkvkFofwjwHKGhXk+Tfxd3R8pUwT3g8vEn8PxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJeJEhFFUcwsNIRGExVVnzatPj9bwpj0fkIvIbFn/Cg=;
 b=kMPSRumINyWXWIPYHqUixg2gbS7yI/Ev3dnsMVVsr+3MKss4xNfYcNmWUpVJ6zLekohzE5msBP1W7gl/H30aCLF+JhGV9sIstXC9ooEo9WjoPqHSrd56PnKKNTtzQhp1dXoCxqAVAaSAEBfKZzsQLe/nhqOOmVd0PbMN82jc/mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:31:11 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 15/32] spi: rzv2h-rspi: add support for variable transfer clock
Date: Wed, 17 Jun 2026 10:29:46 +0200
Message-ID: <20260617083003.1071543-16-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: c7f4d534-e709-48ba-0725-08decc4ac9b3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	dSQg1hlhmMYS1MkmUsx8DkhpGOXakA0Q3j0MHso5yxMcOHBPuMuepgs5xt8UVNQR9IR7aibLSHLz0zHGuBPyWgNmC1kzIe2VoEFYNFO6iXHWlO+NwFnaNGMcuGcQafolhQjzHZx3RLiUdqgoDPf88h1sN/pIss7TA8GOPpY0WRWSFIMqhcuPPFNvjg1fOjursW8y7Ar/5yfy99MoNx9v45tKMvTQtrUoZ6BmCPFio/WzCB+s9L2+WcPLdKjzkOFbgQ5nNQcu9nfdYrRup8RIugBknBaeKSnxI2B3eeSCDn/IedxsO+RhkKDRVCi9GHHofUVCiJ2NiUW95G+hYpGQK2FXlAiw3KPzd5ayPt+3ygLX0O985bxwIIUbEwn2vO7scuiBfIAREOcbwzkElwQ/uE4eaJRp8eHQvOB7BtMcyhZAFuPZskD5zFPiGMp4RwF67bBwEN55TSZOLXEiDxZRzuFDSB9tnVrVXZYnoUHpkyqF+W8Jnf7oN+nQec49G2C9xybGCI4riAHLlPPERt8LC3JOHrhgaY25njz9iwYjgM6j6P+vn79lT8esd8HzCv5+mcMOOkFqFabYWdwRF++ZmX5wsjeW6kDeN3qUH2zs9EGNKE+xR1n1p/blvjnEYRlSr2WNQG4HoB6flSMsSIdOeQEWcYwpRSAqg7iZk4OYpyXMDAn+y+45tmAA5GkRGjzNtqOmm+P/iCudctjVje+pPw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hTnsRKPo4KQWmGVJ2Gt2cq/Ct7Fh+svJYIScYakjLK4nuSuqhB/CzPinBqPT?=
 =?us-ascii?Q?2a2/Ttg74GupX17WOKvy84J/R5ypHl9lFAyCH55aJ8LS3usPzVQDzgFi45j8?=
 =?us-ascii?Q?AYl/zsCzAkHYZPU6vrKSgl5540ogUd2a783MDTQGzaUyOC50y/yzD4w0aOLg?=
 =?us-ascii?Q?vjknWUk9Nz5/3wOxmzK8g7UgwHvk/FKbW4YjI3Oh/Xqi0OZMrYh2+LPRDRsO?=
 =?us-ascii?Q?AOSXRPUvpP+2vK5V4GMQ99xoKn+OOpeqoqqNH4jZpByXifIxOqngLJPO7ob/?=
 =?us-ascii?Q?ZEgeLMS+ZA8Vc60obU6MHWA8gbggXtE0XDlRWdK1jjYnKba+LZh+4AlQXvZl?=
 =?us-ascii?Q?uR7QId5b00XyHQEnZFvKJvE7f+WeU1SpKbgx9hqSUA7295Gdq93oc3F5JJP2?=
 =?us-ascii?Q?KthkY2b7zO1roaNBjHOQXVLQ3MzuadOnzZUoS9g1HMi4aXQOYahxqhIPaXor?=
 =?us-ascii?Q?J08TwS2HpbmSYVSit1sXeXdou7Es5RyWRtR9REqCr29drN+j/h+4edRpxfyg?=
 =?us-ascii?Q?kAWckTtR5ZK3fQMHVwQdlzeh05CcTYEBzqwZj9+3e6L9cwgTdAIm7Q8ZXGQZ?=
 =?us-ascii?Q?KgHccJUQ1VFAd8wUGy1FxQqgBMBmJ5y7Z5bvtCYWH2OhfwQq3bbUHWghqIsO?=
 =?us-ascii?Q?GFTFLk3XoMcm8xWdCCLMK/JVx/r+c4PQbw1vDgA9GAd4THiWF+9JSRg6QjT9?=
 =?us-ascii?Q?L6mkUoCsMrmrSR5XSm/S07OeDzD8JF46KaoGXyAwg3Z624aJjMEoYeVHyJuk?=
 =?us-ascii?Q?rZrlT7nt+Z+ivso8glURhivmA0JcjN7nfZuKhUdzEpsfTP9+1wZQAiHwdRsy?=
 =?us-ascii?Q?bVD3lfbw2oI+RRP1aSeBsMeSD1ggLp/NRgGPeKZ7gN8S4HN7giFpWH80n5z5?=
 =?us-ascii?Q?wji62un8FmExgefH4pR+pBAKsbINaGAZP+zNnFaiz+6xy0gVKEp8j9PGWMTz?=
 =?us-ascii?Q?SO4iBsTvfzgjhddaF6HqvB7dGW7MNUFibZlsHnovHhh9HWVflg+mGq8SUhUw?=
 =?us-ascii?Q?Ob67JkBGAZ81K5n2Gu0CCZb+sYHt4jy94rIYKm/NW/3prfxGhV/sqtKBik20?=
 =?us-ascii?Q?36BnrznDf3EVZZj7sNQ1Ttm8DQy1fDWwljQuTj6imi8r4EfIxUrBXMdnFa5v?=
 =?us-ascii?Q?rNH6aaNFUe1LkVCryR9/6ISiUozZaL3N/xxzadQf5aHXaHE82zH1mkJbWlPu?=
 =?us-ascii?Q?ExspDU6i/djknhWuDngDuZTW8getLgaRwG2wqQYpKyZeCv8Evr7OZ9FHB2C0?=
 =?us-ascii?Q?cZf2yWl5SpI9gTODt5Yg/Li3lTYqg84/viiYX8nutGpSSnjBJ2OAhlIuxj6j?=
 =?us-ascii?Q?tlv4HvysVJ6IRr2VnSJ6uBU1p1fL31JzfrUnNHbG0r6toA9x+4y+ady977v2?=
 =?us-ascii?Q?Ru0Gv8+xgaC/YNpOlX7q1HTI+i1k1jQq1fRAMjZhZAnKDzMHk0KWLXZYIQBC?=
 =?us-ascii?Q?dN23LQLKjHic1fONeKSI7UpcC+ShuAfODzVgWhHTiBuL6+KacZHOML15/Jk6?=
 =?us-ascii?Q?/i/OKg1RR6ohfGJ99s4xyA+DSypzN+aq0av0IwpDErTzxcswQWFHd2ebmL/D?=
 =?us-ascii?Q?Wn3PFBlkykB8gJ48Z6U/MAiLpFeoXONWEEdZANjf6ZAtxyjP10mj6Cac86px?=
 =?us-ascii?Q?8lUZMh7EtDT8EthyBDW2Xfl6WbJiCPssBldORye9EdtvSrGxgm2VH7pXecXc?=
 =?us-ascii?Q?ZYGKeNaiiFsOnaZiHF5Ycg8MAWZnLAnKSaFTDdzkamGM8zS/JfCnpkUJRC3s?=
 =?us-ascii?Q?FmFKOlEY5e6FR39NlzGkFL8O8/1GtR0CN69mZH+0jFxz88kcD643?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f4d534-e709-48ba-0725-08decc4ac9b3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:11.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CAmffNK61OGAjzFaGb2lL4Qp2zt1ZNgEhmy24bAQ4icHxy+B6o6nlrK8h4mVM9IFeI5L3MwDFQlTJQQhKXT3jwd0kf7NW+9mQKKMaI8jctdA9hkwDESRo15V3JAcyql
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23174

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 9c9bf4fdc5e5d09d5f4280ed2c582df6e1f837d9 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a more
complicated clocking setup for the SPI transfer clock than RZ/V2H, as
the clock from which it is generated supports multiple dividers.

To prepare for adding support for these SoCs, do the following changes.

Use the minimum frequency of SPI clock to calculate the SPI
controller's min_speed_hz, and the maximum frequency to calculate
max_speed_hz.

Apply the clock rate found by the .find_tclk_rate() to the found clock.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-9-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 786be6d533eb..11721a1c75e5 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -305,6 +305,7 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_pri=
v *rspi, u32 hz)
 	struct rzv2h_rspi_best_clock best_clock =3D {
 		.error =3D ULONG_MAX,
 	};
+	int ret;
=20
 	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
 				   RSPI_SPBR_SPR_MAX, &best_clock);
@@ -320,6 +321,10 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_pr=
iv *rspi, u32 hz)
 	if (!best_clock.clk_rate)
 		return -EINVAL;
=20
+	ret =3D clk_set_rate(best_clock.clk, best_clock.clk_rate);
+	if (ret)
+		return 0;
+
 	rspi->use_pclk =3D best_clock.clk =3D=3D rspi->pclk;
 	rspi->spr =3D best_clock.spr;
 	rspi->brdv =3D best_clock.brdv;
@@ -423,8 +428,8 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	struct device *dev =3D &pdev->dev;
 	struct rzv2h_rspi_priv *rspi;
 	struct clk_bulk_data *clks;
-	unsigned long tclk_rate;
 	int irq_rx, ret, i;
+	long tclk_rate;
=20
 	controller =3D devm_spi_alloc_host(dev, sizeof(*rspi));
 	if (!controller)
@@ -457,8 +462,6 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	if (!rspi->tclk)
 		return dev_err_probe(dev, -EINVAL, "Failed to get tclk\n");
=20
-	tclk_rate =3D clk_get_rate(rspi->tclk);
-
 	rspi->resets[0].id =3D "presetn";
 	rspi->resets[1].id =3D "tresetn";
 	ret =3D devm_reset_control_bulk_get_optional_exclusive(dev, RSPI_RESET_NU=
M,
@@ -490,9 +493,23 @@ static int rzv2h_rspi_probe(struct platform_device *pd=
ev)
 	controller->unprepare_message =3D rzv2h_rspi_unprepare_message;
 	controller->num_chipselect =3D 4;
 	controller->transfer_one =3D rzv2h_rspi_transfer_one;
+
+	tclk_rate =3D clk_round_rate(rspi->tclk, 0);
+	if (tclk_rate < 0) {
+		ret =3D tclk_rate;
+		goto quit_resets;
+	}
+
 	controller->min_speed_hz =3D rzv2h_rspi_calc_bitrate(tclk_rate,
 							   RSPI_SPBR_SPR_MAX,
 							   RSPI_SPCMD_BRDV_MAX);
+
+	tclk_rate =3D clk_round_rate(rspi->tclk, ULONG_MAX);
+	if (tclk_rate < 0) {
+		ret =3D tclk_rate;
+		goto quit_resets;
+	}
+
 	controller->max_speed_hz =3D rzv2h_rspi_calc_bitrate(tclk_rate,
 							   RSPI_SPBR_SPR_MIN,
 							   RSPI_SPCMD_BRDV_MIN);
--=20
2.54.0


