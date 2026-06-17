Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74FDCD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:04 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10739.1781685055262869849
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UvohuEwF;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrOrYUGvdWRfDe5p3obXPJXiDXcMuh5+kCfTZvl3yBFApoNqKsh/BlXq8u0ajcZSeu2519NLej4U5JLvrKzh1ok4ZitHWX5RqEMki3GjTKViN4Ew1+EDdJEbrOYj5rZQUa4OTUMOzAwSGdoZDrjTWNZeU44mTnOp/ofTIMoeF/7gEe0AH5HYxbWZ8+f807KDdQMbE5Pcg5BjkbrJ8jCmIHFskCskDQF3Cri9MPl76isdmz+8weBKQvcbkkmbOFBgnTfNhtHa0CbnAl2TVX+lO1Kg3v4GlKJkDeoh7mRVxXdKtqZgV+z4gE9xjKudjW5AKoam3vbqStPR5fMq/aWbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZEgn9p3IIF6d4x3blw3u7Pk3aG1YkohEfO7wGurCoI=;
 b=RQdyvsYfLrLqXnwHOBZIwo8zXwiAFeL9UHvtXMcMJVd5uZEQJN68uaVvXwoPWloAoa53Lw5shQK1kJtnpO0tje8zRUm+vEwp/ofF/pgySojLCvwTsZdbVJDNBOkJ4YbTJdDnML3Uma8wn+U5zXiPNPWx1wMkkeut7x1g7F4hE9IYWyXu4nE/3FM6WAjygpf+hOcgb4gfEJrK9Wt1lFWN2ZnO18hsXKmDWT677QSpXYhc+33LViFnO1hyNqTtILu6muZP5RFB+XKcZPO0+pdU6rXnaecf++S7sR+KsSY/TE7W9vQgHvX+U78reOlr1ZguCbz9+lJyaaRuSNxvL5Vwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZEgn9p3IIF6d4x3blw3u7Pk3aG1YkohEfO7wGurCoI=;
 b=UvohuEwFayVd26BHS+Q6V1J1ZGyw+PU6eU8h2N7/9GCdMXW6UvzeK6BbVjk/2VM+AOQVes1mIXHlwtgbQnLnPbA6RP7COrPdmtHxDQIgHCn+lu6B3HjWMfkhP2aRI/V0sismsRIXdg+zZh0eSaQtlp4bQifAPt1G9JSH52NwXe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:53 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/32] spi: rzv2h-rspi: make FIFO size chip-specific
Date: Wed, 17 Jun 2026 10:29:40 +0200
Message-ID: <20260617083003.1071543-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: de33e539-39cb-4f4a-d8fc-08decc4abec6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Mg6q/jdx1dkhL4WVSNxYiq9WwmhftwMWoBHXd4itqhSUZSBVqLFnJxZXLqlMOgy0YxGI30yWUlQ/URz/bYAx1QEU/ujB3Nd8z0k+0o7IaodQ31iaz74uxKooGV1fg05gs9aW5pqR0jzxxc9ms71HRRDzWkuv9HYr6wAaJNQPs0wYSgH2E8zjYCvptIes3wYBmSrrDcpKpfk6lU1x7yqdvuZvKZIjaLjwxMO8THeOwVqfpGAKHWXMUhjRte1WSYdQfhwf0r2Ei3vUpgE5fxKgxez85Ih8SDVKHdE1ElfKQFTfLDeLUri46aqbQhdd4+CipTbnS0yRdpHk2qQfWVXZrgIMniYVsPKrunAd9NH7bswkQt2PHNt3qSJH6GHSpGl8P8aRNW5pS5Jy3+XQjsL9WMm+dZYETHKuH8HqrEPHNJJxvLQLqs5RkcMDMYweCem0VHlJZM734uw5sGOhCmo0RZKdg7yNZZt0BOc1nzbhcrLtASGfJkT/RYPyMe+5TEse3PaQGtJ+m+Lh6vfoMkpzWu9Fn60NSXqLBk1iqTDvZuQTyxqHwiYOqJSANLbZYbcae6dFlsEkyYNwCCQOfGEFVadlQC8zbPzfHbO3RwNQCwNt/XnKiTHueMRIQBedRNRW0hDnEZyFBtZUZeDOyr6q7m5SZGiF0wL2DnnDKLwZySeg0AoZ8/RGf7sop3IozXOMxo+QBghq1zMHf6Z0J/P7kg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bpRUTdJb7+C161gozRlKrNKRBa4YZ2fQPjrYhV3qVdqUhQtVMvo+FbWtLUFl?=
 =?us-ascii?Q?Yg53ti4EYD/CXWNU0wzFsy5MJ8z0noq4mLGx8PLqOCkRVH7pjcem9ay5pR0G?=
 =?us-ascii?Q?58KML9tMTzzicRux4qzNmuLcMZTTggENhTG53H6dz7e2Y9jDou/4Gp9QTPKs?=
 =?us-ascii?Q?afq1yc5+98rm1BAaZ9lymgZWITlsmYM/8hTX4YF3UGiBG/GjZgiB8XoGuq1s?=
 =?us-ascii?Q?4gsu4aRv7McXz1EGHH6SiB0MJBXoDd5Pm1H9ousMeijm8fIM07fXbHl9L3oz?=
 =?us-ascii?Q?In7wgAFI9chtb4HpHipI6ZLtPlL95v3T8Ly9PRPPa2YKPpF54Ifc04tO+CWk?=
 =?us-ascii?Q?CqAiExcL06NbBD2kicqGlXgpk0wxWNXyI7XVhMULyV7TBalW9+GN+Yf0HeT/?=
 =?us-ascii?Q?1peze5stO90OvbamPptuGHr12UQa4wYKvnrdsTO2WV/jzw2tU97vlHbOs+zQ?=
 =?us-ascii?Q?bK5jb4zh2eQUO4YConm456dFLGwneP1wPMNoJn7pZtAfCL1sJB/kGqEmshtn?=
 =?us-ascii?Q?3uyrSL10VM46NHibr5bdi8+RsgajVclceiR9CJOxhLQamrZH+QiEfxJPg+cS?=
 =?us-ascii?Q?Y/RoUaB8SYXWmScHMZsJFIly0NjYPjeYEi8e4HAMkU3WTjrzKSzRUvvNEhWW?=
 =?us-ascii?Q?h/LutmDTimPGxzu5BD4NvPsbpIbyzihPlez7B1qjrnXDDAe3TThbDA6RV5kw?=
 =?us-ascii?Q?Yk4Y7wQtDIOCN3S4qqkkh7YQ9J1BDc451r93Xiys9WSUkgaN+7vIyexlDeou?=
 =?us-ascii?Q?PAGvOqHY4V1FD0PgEdbgqOaiBluaxMQUjZhU9tsmll+q8MAHqgTki+Bc9oAp?=
 =?us-ascii?Q?hk9bNPz/dpHhq4e+fAT3upLiAeidrXp69HVuBllGNHXw1C05ogsJdnLiPDg9?=
 =?us-ascii?Q?8DSLitcW/q0UzVU4n7yHN0OAZEcIZJ+14Q1O0iyYnptb7hYXeeWh4jkwnCd4?=
 =?us-ascii?Q?YFQxLGrhG4Eh8FU8GzGTboKI+YcucOme0ek9SJwN0GXj3bQK0KeHtBR9Zpre?=
 =?us-ascii?Q?CqbnBt6EE5ij09ICaV/VFr7fdcb6yTpiEXXZkTk7ikNWNFb2wLaMbWEVe+jU?=
 =?us-ascii?Q?hxrGTIHbvWeMCJ0ylhLdM0yx9P7GZVkaHTvogrWOHhbr8yBqxgOSdposV9Gi?=
 =?us-ascii?Q?PVLolBTJZ8cu7qSNgU0BIjWA06tgliRTLAzNPyyyp6DsvAXSstFKsSw8UENf?=
 =?us-ascii?Q?MIltldwXU6C8mvJ5q3uzDOQlenr6jD1AN5SzF7XSCdSxxzayTFsoBQbbtCyN?=
 =?us-ascii?Q?XErF8J9Oz18p8Co16hlpzKUx01pcB6uE4s92j8fYEoMAkANU3B8PewLORri4?=
 =?us-ascii?Q?5XOGzbxU5d5GAQyhDMz9MPJMqqQEYzNRX/oIs48xV1vZneGBIO5qqY+oOOVa?=
 =?us-ascii?Q?5GLPD9Ftf/bka2BevdJqowESYeHCltItf7O6JKRq/ycvSdB+VGYQiOD6we9r?=
 =?us-ascii?Q?o0JFrgiXsb577jQcmsErDwdbblUWkKYXE+U0pL4Sf1K6Mk0DC8IMDgYhGC4G?=
 =?us-ascii?Q?5HiwcXUpimCxm9lceihekiySyz4Emf5EJofZdOOgUyl9iAA9e774CeXedy1q?=
 =?us-ascii?Q?7GQrN8P4zTFcPTteeZVetJ5PUb+ssR1wsNTuN/1sMyOZyLb8fKWG+yVkBE+U?=
 =?us-ascii?Q?iGXTIBqT3t1u6G5UyHvwOb/12K72VvcETu/ZdWL2PBl3x7TN5jovUN0ojKL0?=
 =?us-ascii?Q?6m7d36EXXPyEYxyoNuTug7PYSNRoRN3pSwkkbUb0kg9yl855U9ItcwZDyG5f?=
 =?us-ascii?Q?dIEHP7DvKj9WX+Yz5hyP9sVnLgn1XOsPd25KmoZwX60fdQZumxUs?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de33e539-39cb-4f4a-d8fc-08decc4abec6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:53.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fm9kB3T8iRsRFEWi11d0ALAgeFMc0JotbB0PaYt5mny/03Pqq1axVeTfZBDqrLmEYfpBFKA0nAkVIRXS5tHNwSers9PJtTK633drHFiEUuqQceUoxyjtiJCB2azeknjv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23168

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 8e89ee6cd2b928a8431bef61e8b851ce5df1ecb0 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a
different FIFO size compared to RZ/V2H. Add a chip-specific structure,
and set the FIFO size inside it, to prepare for adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-3-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 66006d3e7c73..2914d356292b 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -58,7 +58,6 @@
 /* Register SPDCR2 */
 #define RSPI_SPDCR2_TTRG	GENMASK(11, 8)
 #define RSPI_SPDCR2_RTRG	GENMASK(3, 0)
-#define RSPI_FIFO_SIZE		16
=20
 /* Register SPSR */
 #define RSPI_SPSR_SPRF		BIT(15)
@@ -69,9 +68,14 @@
 #define RSPI_RESET_NUM		2
 #define RSPI_CLK_NUM		3
=20
+struct rzv2h_rspi_info {
+	unsigned int fifo_size;
+};
+
 struct rzv2h_rspi_priv {
 	struct reset_control_bulk_data resets[RSPI_RESET_NUM];
 	struct spi_controller *controller;
+	const struct rzv2h_rspi_info *info;
 	void __iomem *base;
 	struct clk *tclk;
 	wait_queue_head_t wait;
@@ -302,7 +306,7 @@ static int rzv2h_rspi_prepare_message(struct spi_contro=
ller *ctlr,
 		writeb(0, rspi->base + RSPI_SSLP);
=20
 	/* Setup FIFO thresholds */
-	conf16 =3D FIELD_PREP(RSPI_SPDCR2_TTRG, RSPI_FIFO_SIZE - 1);
+	conf16 =3D FIELD_PREP(RSPI_SPDCR2_TTRG, rspi->info->fifo_size - 1);
 	conf16 |=3D FIELD_PREP(RSPI_SPDCR2_RTRG, 0);
 	writew(conf16, rspi->base + RSPI_SPDCR2);
=20
@@ -359,6 +363,8 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
=20
 	rspi->controller =3D controller;
=20
+	rspi->info =3D device_get_match_data(dev);
+
 	rspi->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rspi->base))
 		return PTR_ERR(rspi->base);
@@ -444,8 +450,12 @@ static int rzv2h_rspi_remove(struct platform_device *p=
dev)
 	return 0;
 }
=20
+static const struct rzv2h_rspi_info rzv2h_info =3D {
+	.fifo_size =3D 16,
+};
+
 static const struct of_device_id rzv2h_rspi_match[] =3D {
-	{ .compatible =3D "renesas,r9a09g057-rspi" },
+	{ .compatible =3D "renesas,r9a09g057-rspi", &rzv2h_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzv2h_rspi_match);
--=20
2.54.0


