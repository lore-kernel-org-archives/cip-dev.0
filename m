Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC15CD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:35 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10762.1781685090821933454
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UldfjWKK;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD55AoZVBvh8rZ7N7Ka6yM/ZJPNeQCxUCsf7kWq6ufKM2yPwoJj1NeUVhXN/iLYNhpboQziQqBGCUc05hIdtaZ22TUo7oy6RjToqF9HicmL2v2eCijoJ8OuRYkRluQ38SsEGFBJh++HFRtETKNmTx4C4fcj3COEdrLMGvJWtaxpu2sRhj3iw4lA/QqRQh5q3exOJISCj5zPoPqTFweXD3ipbE9vHCtHsuBWRI7TTcqjIAool9BMwlw+7ugR8Qvvz+tdjOdTPhXyro2FRiGCxWC7iB7hbYqK3aQw02VRAkF+YcGZ1OMi8LDJnkFmyX4xD6CX4pAbYNxepXG/6yIGbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxB1DnYDmn6tdbHNRG1i0JYcvwGlYgZQzbwimbDAB2c=;
 b=ygB4D1s0hcdcgrLSV3n7AlskooodqjptcgXSUhj2YJWIKLRzKeMiym2pKKHESKc28DB/dsT8hlyq/UQONas0MaKHPplbd4iyhEqxswxE/gQ6RhwWPxyymMj7f37t+Gx7OVMe6s6129edXK/1+V3PtJJQ+b2GqrwtL3LALFMM60PNIUhmNR0iamid0ad85/dFh6bBPRav8pq9sq0rKI3UkvE6VcFneZ/DJM1DOOqIH5qmWDwqo4cZm+/wR0ZAVPs3YSGXR/L/mgA0DCv6Td8W7QDyMg0cS5AHKWq7UFEksC2IW/Sg1e0vXpzahDcam9I6wy2yRw5NEBbPscn1UMllig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxB1DnYDmn6tdbHNRG1i0JYcvwGlYgZQzbwimbDAB2c=;
 b=UldfjWKK+35acMFjB7dGVtbVFIuLJCanA5RcTCCrqCBiZpbyNH8Z/yAVjuOF2i7IqTuuRHn5BWRjP3c1UJPemE8rHA37XvccOyoE5pX4UzsVnwqnEurvvbZQhCkEYjwBohruOQjd4cohZdJLK4dwXSuMHzpSd6mc2jT8NIAU6z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:26 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 20/32] spi: rzv2h-rspi: use device-managed APIs
Date: Wed, 17 Jun 2026 10:29:51 +0200
Message-ID: <20260617083003.1071543-21-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 33e9007b-f93a-454b-883c-08decc4ad281
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	+uq9nEUIcjphcxF6izQiMAPQAKcq/3HWihKosJMoGv0eajLZaY2QoaARtnR5A4zsAaMok1iZPRdQpNxAwtIVEE/XWVzc6TZ7Knewfixh5PDBOdcr5XM+GYDRJbVA+C7rQIUy3pTn+viFojndnXl0rsYh4eKZ5lEmNK8Bcn1bmvnT3cMMIn2usjA8E6gumU6/S29pZGKvsrt9JxMtHgxlsl5BKJrS3vJ32NUgbOMPZttxJNBgJvc4vWmSwpSpsUUn66dHQD+7esosbr55GIl9dWR/WyE/gDc6XEvE/ySNVmumemI/f8IMS/154jyqu95LW37BaRnVtVpDed9Kqnb2Cj9OSMwU1xuh4ImkzH2PWtvzCo2Uw30YCe/h4sKkvN3mBK52Gyp/MIb6VXbbjUMra1Jmi7mR7Fbm4ome4I7MGgXlmokAVbkCqY3DLMlu//sdhy7ZSU1nrtLp6Xqd9NZ05zNajeKQduWB3p8qeB59keu4WEIYMKkv2go265KLBuP/nmS7DnA6V0BmIeA8D8/LTtjuzP5TZ8otzUlW7Kj/V+WEPpypf5cBcvtl3u9u3o9jxUolodWEGeuQHUQsRzeDF92qm4B2ewx4h+oQYa3z8SFKALyYUFBo1kv6Y72aYQXY1SvYNIuD/UlLgK3tzhdw8S5ALXxFxuITLDgkwnO0S5UYDZCxg9rt3xTdrKDDaV9EXrjtrinkn2+vx2zvw+iuSg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0PT24T8KZlpllqX6sLdOebEJUCvwrJlqU5Fkeuu2mLsaLEYFgFCUXP3eY5Pj?=
 =?us-ascii?Q?F4fTAad3L/Sfn0RZ0CSxhU5hy6aqcBw18MBPHhVhbw6AtJ4j10kegRSoSt5R?=
 =?us-ascii?Q?qFC/6LkKoHIiRCyf64YLw230TWzY6pMMQfW8sHWM+xawhGBBPfgZyKDMf/Z2?=
 =?us-ascii?Q?ho1eVFP49l0Bpi/wbIH1piehXa+7MYK4ViMUB1EEEL90sgY7GsyGgT+9vtvC?=
 =?us-ascii?Q?I8Bfb3BXss5+tkyfUGZVh18I8jUrqi1Z9gJ6seEYJr9k5opS+dLqjQ915UTe?=
 =?us-ascii?Q?D5fQC/sZiXNM7ZVExFCf5MyQMTf2BrXY+zWVrbcAi72o3c1TUUN5Pa1lPkHg?=
 =?us-ascii?Q?hNqkcwTQxox6t4Tuu1hSbc4ILKT48Lf0UEPJIYv7UMWRqn0ksc8BH5qm4iVn?=
 =?us-ascii?Q?zp8C2BlCDmymXZrsuVDbZcKcfbU3C8go75Ivo4J0Va6dKxFPXE4k0wncBQFq?=
 =?us-ascii?Q?ELp5VX97/lT7WqBM8Tgi25m7Vph2uWSqizsaOMWBc0PR8WAwLQcaq3os20y/?=
 =?us-ascii?Q?gwdTPrLrpki4Hk9g/FkigAfjljGFaDX7YDSFnm9OuE7zt1gGkSFtdJd4LQxT?=
 =?us-ascii?Q?qfsa9p72cVV3TpBBoSG8VKpkU6oMgHZU7jONqIzaBUBx0xxALV0EynlkNp6f?=
 =?us-ascii?Q?qQbZxDE3Y9l1d1m5A1TIyzMYNsMR/gAXFElYBDugwf2FkPi4BvvxDwyWjeJw?=
 =?us-ascii?Q?8kU32/y/+RMJaaeYYD21dxbEVk9JnmrZjvbQBaUYbsmL+j0NY6mspaBAqy4z?=
 =?us-ascii?Q?22Xch38nuagz8M5lMHioRUEggJFnSnIgWoSXKbPAyWvaZWL4DSa9XxuTeG2Y?=
 =?us-ascii?Q?Oh7JZOmXEmCFidZ9KC8IYCoQqLmVw9rRCC0FR+a8bizxEb/9RDyNvUAxU+oV?=
 =?us-ascii?Q?sNu08CyI8qjGKfqvtye1IK0RCM7T3Beidy3aSTncKEg5DZt/GnrQRvXJq18b?=
 =?us-ascii?Q?xTPjoVMbnY9QIAay95fk6HxRtlpB79jSMkwfYhiB2SSVlfeVoazrcXfmFBt8?=
 =?us-ascii?Q?VHxfnN/A6XyaFgt3TftNF9shH3uo9qYFcyGiMWVK5SAO0diprYetq2p8XmhS?=
 =?us-ascii?Q?jENQgKVzLesirJ9sf80T7rm1HKOJm4Wry4Ut50VwQq+pJH3mtPUYA1ajSx1X?=
 =?us-ascii?Q?pyEGjBjJH7g7wuRWmkJXu0gN1SvNf1zreWtmqIfy55lCRapk3O5L7fFEglq/?=
 =?us-ascii?Q?jHA2uAaYiCYDt/GDgWJ6Zqis2oxHEPoFdv2kB79Za0W9CdwuMZZvdpgINJBd?=
 =?us-ascii?Q?Lzp21hxb/noW0F2lmNlTDrFF6tHHOOH4UUzJjRV4BR19Pb3M/rwyEccxFkyL?=
 =?us-ascii?Q?A7Nx3/QVSlVcjeSri0f51FTL1kDNti3clzkSb/eP1jOeYXYg+RiobreAAhBl?=
 =?us-ascii?Q?j4BcnD6pPS9fBusKA0XXx2VFVUFQTc7M63B1Rs9Dpkcq/jX6k25Gu66VSdWr?=
 =?us-ascii?Q?/4Yn8dEs+K5QzaZ0BMrgkO/hm6UO+Xoxa1iZMdlGGcn1go83wKIEJIzXyeut?=
 =?us-ascii?Q?ws7EADOAXbF0DGr2r605niGvLlI1SsTOTls8F3hYHyNh6LqrnR8C1EoAmiFO?=
 =?us-ascii?Q?s1ucakDIQOFx4FTZBj/t+wSqdH/jryRde80IFzRG6lcvnUoNQzfnpmpGZ97x?=
 =?us-ascii?Q?qNoS9lyW9OkKbbbNOfwUcJx0r9shnfyAzcwmBPNAjQDvhEzL4UREAzxIhPV7?=
 =?us-ascii?Q?6QIy4+InY1rl5V2ZtHVDScQzjkcG8xQf6PwqOcyg2gLaNVAHb1JBt4wF8XLa?=
 =?us-ascii?Q?+HLy6pN+TSCpd50IHwyWwGD72ie3gLmfNTRrmemOrANlsQdg40sg?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e9007b-f93a-454b-883c-08decc4ad281
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:26.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5g8iWtxJJCjbVnKX4ZOAsB/XwMoTdzySOpMmaU9V6vkI1cDAB5On8EpTHmfhUuVk8ShE2hUcWb5FGV0jz9g0vnL79dWN+YwZOi5uDg9hoAlgzr2GrHQwqeK0NOR1y6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23179

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
[tm: Use devm_reset_control_get_optional_exclusive() +
 reset_control_deassert() + devm_reset_control_get_optional_exclusive()
 instead of devm_reset_control_get_optional_exclusive_deasserted()]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 77 +++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 62ca0d7eed98..1153f2aba44a 100644
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
@@ -528,11 +527,17 @@ static int rzv2h_rspi_unprepare_message(struct spi_co=
ntroller *ctlr,
 	return 0;
 }
=20
+static void rzv2h_rspi_reset_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int rzv2h_rspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *controller;
 	struct device *dev =3D &pdev->dev;
 	struct rzv2h_rspi_priv *rspi;
+	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int irq_rx, ret, i;
 	long tclk_rate;
@@ -568,28 +573,43 @@ static int rzv2h_rspi_probe(struct platform_device *p=
dev)
 	if (!rspi->tclk)
 		return dev_err_probe(dev, -EINVAL, "Failed to get tclk\n");
=20
-	rspi->resets[0].id =3D "presetn";
-	rspi->resets[1].id =3D "tresetn";
-	ret =3D devm_reset_control_bulk_get_optional_exclusive(dev, RSPI_RESET_NU=
M,
-							     rspi->resets);
+	reset =3D devm_reset_control_get_optional_exclusive(&pdev->dev, "presetn"=
);
+	if (IS_ERR(reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
+				     "cannot get presetn reset\n");
+
+	ret =3D reset_control_deassert(reset);
 	if (ret)
-		return dev_err_probe(dev, ret, "cannot get resets\n");
+		return ret;
+
+	ret =3D devm_add_action_or_reset(&pdev->dev, rzv2h_rspi_reset_assert, res=
et);
+	if (ret)
+		return ret;
+
+	reset =3D devm_reset_control_get_optional_exclusive(&pdev->dev, "tresetn"=
);
+	if (IS_ERR(reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
+				     "cannot get tresetn reset\n");
+
+	ret =3D reset_control_deassert(reset);
+	if (ret)
+		return ret;
+
+	ret =3D devm_add_action_or_reset(&pdev->dev, rzv2h_rspi_reset_assert, res=
et);
+	if (ret)
+		return ret;
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
@@ -601,20 +621,16 @@ static int rzv2h_rspi_probe(struct platform_device *p=
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
@@ -622,31 +638,13 @@ static int rzv2h_rspi_probe(struct platform_device *p=
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
-static int rzv2h_rspi_remove(struct platform_device *pdev)
-{
-	struct rzv2h_rspi_priv *rspi =3D platform_get_drvdata(pdev);
-
-	spi_unregister_controller(rspi->controller);
-
-	reset_control_bulk_assert(RSPI_RESET_NUM, rspi->resets);
-
-	return 0;
-}
-
 static const struct rzv2h_rspi_info rzv2h_info =3D {
 	.find_tclk_rate =3D rzv2h_rspi_find_rate_fixed,
 	.tclk_name =3D "tclk",
@@ -671,7 +669,6 @@ MODULE_DEVICE_TABLE(of, rzv2h_rspi_match);
=20
 static struct platform_driver rzv2h_rspi_drv =3D {
 	.probe =3D rzv2h_rspi_probe,
-	.remove =3D rzv2h_rspi_remove,
 	.driver =3D {
 		.name =3D "rzv2h_rspi",
 		.of_match_table =3D rzv2h_rspi_match,
--=20
2.54.0


