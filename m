Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E580CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:25 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10757.1781685077674698932
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nOy+uoE7;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkB1olMu1VzIJxYkPhVen3x6+gxJBUKaUM/Gj75Ucdc04mxf0htBoy8+zmITqtlnaavRKQhsmiwkBzeXQ/2X2Wfi+jDTg1WCP9givB0RVH3dsXsgQGQoR4EQwcj5oBLd/3h/Xvo6ACbCskfgMDlRZwkPLPi67VDMgF9YTOUkYdzBrAhvXKD2rfJRd7uAXkdxx3ixlHt5gbsJ/Q4pra3Rc5/61f3gsfuiZrZnvxVTSpV38sFgWtELG8Vrox0AC5ipk87DLS2S1COB0Bt3wOK9EAh5DT/BiNhHpNFxMOrmsYNUMpUqUeQuyP0lNN6+8b9ZSp9Fva+l2KzWT+tfd2v1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEjkXwsp0hfK+iwUFZ1CjEOmbTzR0vnOA09BgoPf3bQ=;
 b=wRkvgBL8Q1qWtqsLVN1iNVoKP8FKAVWY+tRhOuFocHdRPrJCem3+tdzT5IYUBYYGR/TCNtp6Snx2V6Svb72wTNjILlme/bpEiXQVnYwj1WQAc0m8xJ7gN/+H7FvtFfFz7Xjfpuq4jhQBNem4IJ4LYqCr5CA0hzfEHBb7DJ8buqufy1MrckJ7c7zfp1rPhybnx5w/PlcfIDwI9H6sORk+A3FwjyNjiJhhdJbmBAISb03+hsYNBKpTNcoeLfok3qI+MWRQsPZw2vw2YxS3qXTD/h9E2m0jh+LToGim0wjKoovLaUsjZOJa9WMXiy/KamBegdtMfJZs5IJvu2WfOFBfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEjkXwsp0hfK+iwUFZ1CjEOmbTzR0vnOA09BgoPf3bQ=;
 b=nOy+uoE7YKgxIKS6+KXtTKSwaSftj4mE7GPVEr9RamSiEUXioYx20eFby8azLzUgaJuIN1eZHDUw8gi7KrUZKv2j6V3UBYsiLkP9rbmGe8ZPJYLkyWyLj9LKNJSdvuOYD2GTtWQ9P36t+9PwEU0LoJL9z/rr8n3/plswCIsZB7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:31:14 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:14 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 16/32] spi: rzv2h-rspi: add support for loopback mode
Date: Wed, 17 Jun 2026 10:29:47 +0200
Message-ID: <20260617083003.1071543-17-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6dd62df8-f082-4504-845c-08decc4acb5c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|6133799003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	2iRgVL1vUaeMeNbOfubfrmLGc+PQVMNKQ1osFxSnZvIYSQl1guCOZ//dKNKXkJo9bJYnN8yz06m02Nd2Xsjd74Qpxj5fZFWpeYppTPMASelt4m0CyMl19uOXCvi/jid+W/yxOIt5jvGrp0XtNo72e1tSU8hDBySp2J0x2QWcB7UaDvksxNdwtpzh2KaAYc7U1n++oFUkdC8PyNFy4mwwMGVnk/czNSshPLbOOjd+tueMt+AC6XozuwKy5pjLHue1oBSP11NMJFPnq+KZrDJAzJqYLmxat7snJCHUJbXZVHPmaEtutVH7Liiho7OJsi81t6h4isV8DRUFDPehlnCto5xUCGdqeEeIFqZ3l5bmLOe+r90oJitAOlqdc4axGK4LOJYMadxVHzgQctFEy6Ie/EgHGj+/1c0bnBpD5DPn5P4103HcA7VIgM6NvrXTiGg80Gqwr6rf+LW477Gr0JvtrIPrrBDPldA4rjqLYw1YrI6eaK5FT+yDis7oDN8LEtNV/FOYK5ObaMPgd2iv5SO1PeOxJ1oJu5xAYHExOl8f9bMkeCK6DAV1LQ6EsN5lejDQhdqLI03bYoHU+SE9gCpBUYT/Cy1DSnpiW61RC2u4lG3e0Iq9kiyN3U7yJTL74tmxCsaJqCjm/tnqU7WAVjzSEstptD9thMPFLSlG4GpZnN1I6kvhCpBKXAj9XSP3eX5diyzBur9BaPGcq302ntwh9Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EEWh/tIOLu7cKBoMJfB4FkKRD6mifmuYDF5wKtug0R2VbNfdh5VRgjlAaSbb?=
 =?us-ascii?Q?S03MosExMHwkmf+b5DTxB5XoZSB2CsNoBP0+ZYGEUwxCpFnfWRiG0ucene9D?=
 =?us-ascii?Q?ut2bAKL0W783jYrxtPnLrhH94Fu/qG3bemu7+ooFuzocO6fKWZFKkA5585bH?=
 =?us-ascii?Q?tbpP0ToIF7QLJyNdny15Hsj83Bp68EJkbDZI3ct6e5f1U1y7AszQRwoUE798?=
 =?us-ascii?Q?Gc0RfJz6CM3IlZ55AMGAxYqvtIttwDQaRItK+An3YxQvNL4RpEtHNQzQdW4o?=
 =?us-ascii?Q?6WC5dayo96GdEWV1zHK0TywC6968dJppK0nb/20uEHwiBMMDXjJlBvctJRn5?=
 =?us-ascii?Q?vx50g6ATEi6IXmtW5m866njxtZmW50kCcA4kavIOfl9qlwpSbeDVqyDB9KwC?=
 =?us-ascii?Q?tTMBuup8ylOdCPIWfqsjormcpKNztSsraZnoT8+oRnuN6XjVytUtyB39wTl5?=
 =?us-ascii?Q?xID8V1J1a1gUVRGKxwsey9hXd036SN3LnRJoQEqh6VUR3tWp6f2JtT+vo9qP?=
 =?us-ascii?Q?HtAVpikzjnTu8dFyAyb/AubM6elXA2TmJ+g9w2ZOZceL+imKNgQDqZza8mhP?=
 =?us-ascii?Q?wwJGKm4fm0Mbp24rPMmS6owKxBIo/KNblDdfCDTptcmMUvvHs3n2mVUAObkA?=
 =?us-ascii?Q?z8UErL9A3dDueQPkYQT+LPZmlc8X2HVYUul13fkKCWDgPsHSJeCKIVSf9zYt?=
 =?us-ascii?Q?Ab2DzUGS8VvRl85F3PmBYiOGtwjC8EX38baVLrdSEgd6YmWUEP7GoHKf4q+1?=
 =?us-ascii?Q?/gDEXHu1WYQFdjrWacFdh0jpodLQvB5z5VXWA3mgg3Ri3TbjzRGWJLn1gWfn?=
 =?us-ascii?Q?QAIHEovetQnWIXUNq/llhTt5CsTzsEqOkwNxImywMHvCUx613oR04o/i41To?=
 =?us-ascii?Q?bTAyfNRxP6dfbuCmw5KUtc1ixlc42NLr1gikGijCcQYoIJ4Ukco+sg5io4lq?=
 =?us-ascii?Q?BebbKCzB9c4wYM2JqhDzoEPRbgw2YwiHW5TBRUsGYfx6GzlJ5E+8qZ62XW0N?=
 =?us-ascii?Q?EuAYNx43qMOFbvp0x428qXVUt3a+VTzrxrGGzJR1e2kfkRWi9m994S3uVaDf?=
 =?us-ascii?Q?7ESx4sLOQiSAnMHCEr+F1vmCO+nE5Z4G7vyQ8Z602eJkhWldHQZYq70Pe6RK?=
 =?us-ascii?Q?7yGAeNrPk/M4lX3lx3bOuVeKbl7XJis9H0ch6lr/cxORehGn3UaJMuNp1AyF?=
 =?us-ascii?Q?cVxT/gA6hOPQ5tAQoaWx9cC/9fB4jKKaVMAubcXWFhyKqoc8QXuJ+xCB4ibq?=
 =?us-ascii?Q?7gwT8eCad9Sk68tp3+cGoDwGvkGMtPlEUc94pXMfGdoavzMKdH9c5a9CfBIO?=
 =?us-ascii?Q?A+sLHG7FLOouIKF1hpsQsx7oGn9QIpQ0FXyzeq1WtyfDCLs5m/g2hhbti16W?=
 =?us-ascii?Q?PsXQsjPmnGM2oG7JHG7NmaR8rvAMCDr+pCMzL4Ky+TP6CDmzjUF43NyWxhWZ?=
 =?us-ascii?Q?MZZT0jmUBD7hUfHzUItUtF1xjHutM2Lg8I1DsJod9iMdfP5j3ROprEJ6POrG?=
 =?us-ascii?Q?H3VsRBmjGidtzbdwEkey4Dsg2MiJiXA9QbFjIwkJ/b3qc+REJirVvvuQN+5m?=
 =?us-ascii?Q?+VWc3D3BnuwIzCZvNIkDvFBqkHdRANrifDyGzW/GveuNAfcuoLBqWSVZteSf?=
 =?us-ascii?Q?A6QFIw3HdFTjUJEC2EqsOBpJh0kwnnuBJyoAnT87nNJbZTjuOFTEnfobHCT2?=
 =?us-ascii?Q?qiCnMXCBUabxwcY0Bfy51zXx8Dr9yTFkoDeIF6SkIRgyy4XSkUvmbrFU+xIf?=
 =?us-ascii?Q?ZHAFO3wG09qtzCWzOVZTN76c7aEJ0IezzP6baQTdoToneGhDCU8J?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd62df8-f082-4504-845c-08decc4acb5c
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:14.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POhLKsqkToCYhUTfxxbCmVAlWabDfkkP4F11EsY24Su6w1L/P73Q0PBwzdmqHgcaZ7hiRuLcAzN3C0Rx4a6bPR5g88XAR0MFJLCMN8kd/GH5FBPKiBVMBh+U7+Np3yEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23175

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit bc4f0b1e39035b9bb3d5d9692074702110f5e2b1 upstream.

Add support for loopback mode for debugging purposes, allowing us to
test the SPI controller at the maximum SPI transfer clock without being
limited by external wiring.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-10-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 11721a1c75e5..3c1cb76bc7b4 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -24,6 +24,7 @@
 /* Registers */
 #define RSPI_SPDR		0x00
 #define RSPI_SPCR		0x08
+#define RSPI_SPPCR		0x0e
 #define RSPI_SSLP		0x10
 #define RSPI_SPBR		0x11
 #define RSPI_SPSCR		0x13
@@ -40,6 +41,9 @@
 #define RSPI_SPCR_SCKASE	BIT(12)
 #define RSPI_SPCR_SPE		BIT(0)
=20
+/* Register SPPCR */
+#define RSPI_SPPCR_SPLP2	BIT(1)
+
 /* Register SPBR */
 #define RSPI_SPBR_SPR_MIN	0
 #define RSPI_SPBR_SPR_PCLK_MIN	1
@@ -342,6 +346,7 @@ static int rzv2h_rspi_prepare_message(struct spi_contro=
ller *ctlr,
 	u8 bits_per_word;
 	u32 conf32;
 	u16 conf16;
+	u8 conf8;
=20
 	/* Make sure SPCR.SPE is 0 before amending the configuration */
 	rzv2h_rspi_spe_disable(rspi);
@@ -386,6 +391,10 @@ static int rzv2h_rspi_prepare_message(struct spi_contr=
oller *ctlr,
 	/* Use SPCMD0 only */
 	writeb(0x0, rspi->base + RSPI_SPSCR);
=20
+	/* Setup loopback */
+	conf8 =3D FIELD_PREP(RSPI_SPPCR_SPLP2, !!(spi->mode & SPI_LOOP));
+	writeb(conf8, rspi->base + RSPI_SPPCR);
+
 	/* Setup mode */
 	conf32 =3D FIELD_PREP(RSPI_SPCMD_CPOL, !!(spi->mode & SPI_CPOL));
 	conf32 |=3D FIELD_PREP(RSPI_SPCMD_CPHA, !!(spi->mode & SPI_CPHA));
@@ -487,7 +496,7 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	}
=20
 	controller->mode_bits =3D SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
-				SPI_LSB_FIRST;
+				SPI_LSB_FIRST | SPI_LOOP;
 	controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
 	controller->prepare_message =3D rzv2h_rspi_prepare_message;
 	controller->unprepare_message =3D rzv2h_rspi_unprepare_message;
--=20
2.54.0


