Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A30CD98F3
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:06 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10828.1781685359721235038
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=MmL9VvOA;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.16, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orjCuJezfZL04VtDn6vQqItF72KvicK7u0E8tTKxiNBqw9ArrhzuV5UvG7XR9kZ/7UsD2kJhpSNoEdZYmlZCzPpmOhpkD+Hj5MQmLPsXVCzPp5aRst76Ikn7b/tM223Dh1wMz8befa12CWnRKs9tkz9YpoAIgkRg4Ihpti4ur7sHVcZyoMh6Xf8bgpjCBM2QU96XsC9YRehzdNnF+MvlrowfWp9jQVe1LHkVww2uOOSNW9W++EdKNIkTK1CKnHYEI/CPdiDc+G1GcYZOvFM7lGDjdRdPxnGIor0h8PwOg0MjuNT20A1L3tWz9UyHrYUzxa8Sy0CwJpzTWJWbOADfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYwCsRGuFLg7aRHigPmwjmk2/canazSH2uz8hsffLpU=;
 b=EukMXhkuQpIKEDsAZ9GFNMo/EhCUs2zNAcI14JmMbw61MimvNrdRT5YgCdtTsOpAdO87qzbspbDDMopaN7KrJCb1uS585fh2P3clISANVjyaRh4G3vzfcn40vKyWUg9xKxK3lx+dA0cE1tdgidJ8b8v7K2HRNkBERVd+m4LIJY+EA+AbzXQ3j7f70sO+jfePoza49owSZxLrDygeW8hWE7HcT7BQoOFTyLXCe7gyZ75ehEka3JOiperjXayVDxs44GU7HqqHncDVCEpzae9lD6i3vPit37cNtCkX5RdAsKeeqttqWUtu6WbRSYjHHY+608rtg9UnypxbafcRmxw4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYwCsRGuFLg7aRHigPmwjmk2/canazSH2uz8hsffLpU=;
 b=MmL9VvOAP5MRJGYtPNGk9N0iD+bOKJJF4Qvq7fVk4Tu9bSiy43zqlg5hWg9aydQDCmLrUuSwerawzHCVYO7sVFNFLwNSTq5NBq2z9eraBUlkbBLWHBm32sBhCHjjn4dU25etOHI22Jl0LM+1Iu4PlsbUL/B09hNHhFmY9OJGjI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:57 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 11/24] spi: rzv2h-rspi: use device-managed APIs
Date: Wed, 17 Jun 2026 10:34:49 +0200
Message-ID: <20260617083502.1074160-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB13245:EE_
X-MS-Office365-Filtering-Correlation-Id: 788776c4-55eb-4757-9b34-08decc4b73b5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|6133799003|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	+7DWrYwtkXvUlrLgm4co5+IaxN5MEq4NQF9wb+6tTBUWpsprkjQRdnzO+2qxxEOvAEygCRZDF1GR3LY+NXirta5Ty4bWjIvefN9a1zW5+VULtK181ThKsGNg5V/iULIFklxtmhtlx1h6kPRyQ3lisOiF4moutzsYn6fYQEkEtJqG7/ZDbNONRKDi/hISQQgU+livtIpfvSVaN+BSFui5kQAb68/5jHqNpn8rsfb0u1pL82+ub9FO2wIUeAbdOage7Q//O2ZPfV6upaec69XhnAmNr1InG/AyHP+osYzJ0ZJW/PRgSANmmYpnCMiE/mSG1lb3DkHurZL0P9dg0Ia8j6Lk1QcDUXaZT5x4aX46Vh/H49ZmU/qm1rPWDRjag/pd1ZvHox/45WmLLaE/FjG1musyArB3yhTRgbi0+bl64urSKkFaToWXXP3TMUn4sjB/nL7aNqZgkMVYxmtGHkyVELyoM4A30LNOiTQwx6zjhFYGAlysQzr3W/1xLJL3YzCmEOGFEi4CanKa0pgC+Kuk/h0fVg5pthPD0JEWgTa8IUi+6o5zXsYy/RmpYmNh2QfUgn1+EBq+4A2FXCRg1N/YRCSTjxP43/JufK2lrK6VcvUxFIhvpTjhagwmjIg439EYINH9LB79EITNNZ26vUWxeI+Uii0eedCd8AXQ8FnUo1dj4cA9YrIP3aIpLX0PtWsPP3wAru2sA3AiLKSETbpvXw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dIp+xWNpK43he6W6y7STzjBLA/gusfqxxAk96TwFes8z7gVhtsRTgVfAhvF9?=
 =?us-ascii?Q?KiwIVKcYtvnpmjId95uJJK6vWQerpMgfUjxjkghRXLHqJ4pS+eTK301SmxRm?=
 =?us-ascii?Q?wVyDlDlM/lJW+wFNNxmVAiml6nwn0MS5sOxqr0yZ6ukHPzeLqG7y7cS+TVWO?=
 =?us-ascii?Q?1zHZFKHfaO/29X00Upi0TdVJj1iVMmJAwQjBFcZh8ZxuGOkAj1Z+TDwokBh/?=
 =?us-ascii?Q?eTkikgr9TDhbkH7dQR7XdXYt0RELUj56o5kWiZUnWsdLtSgV4rAU+j4Iaqt1?=
 =?us-ascii?Q?4Tw5kW4X2GZy0V8gHdPf+wZJ1vFqFJEgbFgRlh0dL6nK6OyvMHOI4Vpx1wgl?=
 =?us-ascii?Q?b/LchxYM9bWmAnUae0D09A3GUJNvPyrTusjvuBpMR4g/TuoMWaTifbEWvJdn?=
 =?us-ascii?Q?rSc+8jvuTibZ3onFg8PcCJ93puRutDPJv8r8J2TIhEUXboVhCZwuryIiMw7o?=
 =?us-ascii?Q?+bBhn08FGAkPxucoxYGvQP802oxRZ3n9qf8keI3ldnHc6sLBFppugbgzjf0S?=
 =?us-ascii?Q?YhCiRjK7aJAWcvT2uCE9SSy49Z+uOjcO3kamW4mLGRu/CQVtclGMhM55rbAf?=
 =?us-ascii?Q?JnelTlX5vAiA1bHUTppcFoiHqs3C1M0/nHuPc9FRSO37ufZwT1Ce8OyNyQ5F?=
 =?us-ascii?Q?CItpyZcGRw0iPFswN7Eo2eVyCOzjw5eapYm8AkewMv4SaB/Lm5Tu4Y4dvwr4?=
 =?us-ascii?Q?LOgstnNKnZblDqTDF1lxijf9d/Bj+voKdcd7djAvnd/u8g2iEu6mxBNb95s6?=
 =?us-ascii?Q?hmO6gFetM5PFUbH/4Yi6ik8UDLZR4gCK1kPFp1bqdaFenUvS26hruxjvMwVm?=
 =?us-ascii?Q?2JkVnMTYNwA81HjPGRE9YN9MrYmLFuukf+fQKF/Ii8Ee1VCL2+ZRnwLvmo4T?=
 =?us-ascii?Q?qSEL+JX3PNAe8TcVe3IGsHUjvaEnw1cVlUT4cdthkBmRUVeKXj3wEy5Ga0PJ?=
 =?us-ascii?Q?4aCknYlfmAoh9G/Kq6RZJA+aWLhez2ToQnsQ8SWHrxRiEJJPdgN4G/eXwdDy?=
 =?us-ascii?Q?GZxsAIOG/xCpEqxBsgkbXiPM2X2Rg+m4rjVUD0AEFJ+wZeApHLrWMyutbbQD?=
 =?us-ascii?Q?5ha8L0G8TXLxHtqidptHFyhfgVC+qokm/Oe8YRHj8YB5DXDAaVmeHAwbxa0B?=
 =?us-ascii?Q?PdIUhxX2yv6Pjvdd0F1W3vvEb1im78uY7jNdHmlNAHWpIYFSgqgHyKtDBQZE?=
 =?us-ascii?Q?qhRkjH7kpATuCESlkeThgQuIQdyClhuEj3jKf8EgVtPp1xaiZDvpZq73hdiV?=
 =?us-ascii?Q?gaNc3IzWzl4ts83wKXYF1Wgs5OjQBL8X7HrM+WGADvaah5hQp/wnGGinga0T?=
 =?us-ascii?Q?nFp5XJ7tj6q8KBv/+pOszY0Gq4w7TTYLstnyPhx/VNDjQ3+erXBvvuiWSzad?=
 =?us-ascii?Q?1hUfCijaWjoKO5/oL7uptSFOhJbEsAXIG3702zLQaPsdlQKj2Rs5Mrk7GX5Y?=
 =?us-ascii?Q?tnbnvHzUX2nk4Q6EneeC6EjnUhZySSDQyrOpSGDvYIOWduSoVfrrvb2ERlqv?=
 =?us-ascii?Q?IXfGvjnlDxIvXBmJgFK7U+G8FTh6kVB21rSkrc1kh1+ILPe8D4WScHB4XwRx?=
 =?us-ascii?Q?gG9d5/rxVmKUfl3LfTx/0cTIojcRHLuLE9t3bg7Xd4GZvzWp82k/JpT3bQ+o?=
 =?us-ascii?Q?EZt4eChH7I0orKnHVv+irDfAhj6/8rlJylPiJvOZ+UfpCRf4oGqdE4fYgB76?=
 =?us-ascii?Q?ty4jozIO/3rrnhO+pbz39ixw47MSDzQseHncLfHTiOQS18PeMbE/QuznzGxC?=
 =?us-ascii?Q?ugBL7RpRNClylG9hmdt5l1amFtdIBBeP4HWeIAnHXKHYeGSdYUpn?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788776c4-55eb-4757-9b34-08decc4b73b5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:57.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8QhFAZosm9WtRpJSwkTZ9yxttg8a4tQHtat6OX55KX+ZGSShPqVDIlNzEMC8XhEPLOWW0QM1/EEOXetYeO9RqRaOpPUpzn39aXfmi1OB92yC3Ls8A7fdI8NLvqeJznx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23203

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit b73ac782828f27c2217a17bd26aa8710769f032d upstream.

Non-device-managed APIs were initially used here to avoid the buggy
interaction between PM domains and device-managed actions.

Commit f99508074e78 ("PM: domains: Detach on device_unbind_cleanup()")
fixed the interaction between PM domains and device-managed actions.

Simplify the code by using device-managed actions to unregister the SPI
controller and to assert and release the resets.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-5-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 58 ++++++++++++------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 02424d4e722a..6163ada3ccbb 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -93,7 +93,6 @@ struct rzv2h_rspi_info {
 };
=20
 struct rzv2h_rspi_priv {
-	struct reset_control_bulk_data resets[RSPI_RESET_NUM];
 	struct spi_controller *controller;
 	const struct rzv2h_rspi_info *info;
 	void __iomem *base;
@@ -533,6 +532,7 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	struct spi_controller *controller;
 	struct device *dev =3D &pdev->dev;
 	struct rzv2h_rspi_priv *rspi;
+	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int irq_rx, ret, i;
 	long tclk_rate;
@@ -568,28 +568,29 @@ static int rzv2h_rspi_probe(struct platform_device *p=
dev)
 	if (!rspi->tclk)
 		return dev_err_probe(dev, -EINVAL, "Failed to get tclk\n");
=20
-	rspi->resets[0].id =3D "presetn";
-	rspi->resets[1].id =3D "tresetn";
-	ret =3D devm_reset_control_bulk_get_optional_exclusive(dev, RSPI_RESET_NU=
M,
-							     rspi->resets);
-	if (ret)
-		return dev_err_probe(dev, ret, "cannot get resets\n");
+	reset =3D devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev=
,
+								     "presetn");
+	if (IS_ERR(reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
+				     "cannot get presetn reset\n");
+
+	reset =3D devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev=
,
+								     "tresetn");
+	if (IS_ERR(reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
+				     "cannot get tresetn reset\n");
=20
 	irq_rx =3D platform_get_irq_byname(pdev, "rx");
 	if (irq_rx < 0)
 		return dev_err_probe(dev, irq_rx, "cannot get IRQ 'rx'\n");
=20
-	ret =3D reset_control_bulk_deassert(RSPI_RESET_NUM, rspi->resets);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to deassert resets\n");
-
 	init_waitqueue_head(&rspi->wait);
=20
 	ret =3D devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
 			       dev_name(dev), rspi);
 	if (ret) {
 		dev_err(dev, "cannot request `rx` IRQ\n");
-		goto quit_resets;
+		return ret;
 	}
=20
 	controller->mode_bits =3D SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
@@ -601,20 +602,16 @@ static int rzv2h_rspi_probe(struct platform_device *p=
dev)
 	controller->transfer_one =3D rzv2h_rspi_transfer_one;
=20
 	tclk_rate =3D clk_round_rate(rspi->tclk, 0);
-	if (tclk_rate < 0) {
-		ret =3D tclk_rate;
-		goto quit_resets;
-	}
+	if (tclk_rate < 0)
+		return tclk_rate;
=20
 	controller->min_speed_hz =3D rzv2h_rspi_calc_bitrate(tclk_rate,
 							   RSPI_SPBR_SPR_MAX,
 							   RSPI_SPCMD_BRDV_MAX);
=20
 	tclk_rate =3D clk_round_rate(rspi->tclk, ULONG_MAX);
-	if (tclk_rate < 0) {
-		ret =3D tclk_rate;
-		goto quit_resets;
-	}
+	if (tclk_rate < 0)
+		return tclk_rate;
=20
 	controller->max_speed_hz =3D rzv2h_rspi_calc_bitrate(tclk_rate,
 							   RSPI_SPBR_SPR_MIN,
@@ -622,29 +619,13 @@ static int rzv2h_rspi_probe(struct platform_device *p=
dev)
=20
 	device_set_node(&controller->dev, dev_fwnode(dev));
=20
-	ret =3D spi_register_controller(controller);
-	if (ret) {
+	ret =3D devm_spi_register_controller(dev, controller);
+	if (ret)
 		dev_err(dev, "register controller failed\n");
-		goto quit_resets;
-	}
-
-	return 0;
-
-quit_resets:
-	reset_control_bulk_assert(RSPI_RESET_NUM, rspi->resets);
=20
 	return ret;
 }
=20
-static void rzv2h_rspi_remove(struct platform_device *pdev)
-{
-	struct rzv2h_rspi_priv *rspi =3D platform_get_drvdata(pdev);
-
-	spi_unregister_controller(rspi->controller);
-
-	reset_control_bulk_assert(RSPI_RESET_NUM, rspi->resets);
-}
-
 static const struct rzv2h_rspi_info rzv2h_info =3D {
 	.find_tclk_rate =3D rzv2h_rspi_find_rate_fixed,
 	.tclk_name =3D "tclk",
@@ -669,7 +650,6 @@ MODULE_DEVICE_TABLE(of, rzv2h_rspi_match);
=20
 static struct platform_driver rzv2h_rspi_drv =3D {
 	.probe =3D rzv2h_rspi_probe,
-	.remove =3D rzv2h_rspi_remove,
 	.driver =3D {
 		.name =3D "rzv2h_rspi",
 		.of_match_table =3D rzv2h_rspi_match,
--=20
2.54.0


