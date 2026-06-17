Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B9CCD98F3
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:27 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11003.1781685377625307109
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=p15jPB57;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O60g9Jjk8YOrgj2hlOQ62XY2HumzOMq/Q1lLvqZ2FOefrbzMypgsGK7pgpMWzHb4Fvo5TjdKngv+RaNu/U0coOQCgnoWdcuGcNikT3qncCWtUBTLIaiBMm7WXDFgxP6aukTbRKXHzUYtXDtTGtPDSpDiDgh5CylNNHYIEIyG7MsXXE1d7PgHokk+TZD1G5Vwb8ShQn9MMSRoEoruymTfOEOOwL13DsP51IGuehtXAtKIJfSzJZRqm+XybHwN+V+8m2drazIn6L8FUu/jKXQvGZRIURhxtiIulf8OBbmdWqpj69hcVerXXtlayVV1JcMQqSCIZhcgTX3jjeNb5uyzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wY42lqLvPeA+lrdM/Ma2BA3eYS0KLJMkErOTV8OMk8=;
 b=H55iCAiZKe6KX0ImSg4hwgrLzYIGy8xSt1TxX3jAL8W9hNwNYdR1so3OxpGQqQpSG7HhSuVKRh3RDhUiTgsMiujrBH7BnbVKHcl3Mo4kN08hFRDYbhv5+vjEM8iy7q29wO/dNFDHBBJxbMe7PlzJx7K3pJ3/pwRsfP1bbd3c2O3DJ07mT6xZcMQ1DWzcJeJ1nPbxAFZAYn4P8BWoL/JbmVPyEUd00ZO5LOcRR37GKZMVffE3KZzrA4fPblizRwO69a4wE9/YUwDSMftWSdyo28ANnM3JWnOUUWw9rzsa3D/lCU9oKjXnFaSOX4MXk+cqxSj9rkywZqTZ/79h9IZHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wY42lqLvPeA+lrdM/Ma2BA3eYS0KLJMkErOTV8OMk8=;
 b=p15jPB57GmcAbmAq/y6UN1NjYtZrf2Vifj/Kk9z8bVmQuoFMOdCl0xVncu8Ldki3KsiUwB93u42d8F+pQNEgJCoRrWp4OQLdcaXA1buXYgajUOyAWE8SPj+bfWTDI58mCBgm23Wmds6ptRBZpBlP5BbeLpv/lHzE5AflCyzuQIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:15 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 17/24] spi: rzv2h-rspi: add support for DMA mode
Date: Wed, 17 Jun 2026 10:34:55 +0200
Message-ID: <20260617083502.1074160-18-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2d27bec-2da9-4e2a-a0c3-08decc4b7e83
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Umaj9DAY1vagaPG6EPMyHGZtcsPJdpNKCvG513EiOurjqcwUcc+tVQ5Y4RRPk4+pciy2wmx+fYMeiUacqtlIybRmu9L6us6yKLT9StS7LQd2XhtJFDRzOXU0Gw+067Td66T6qX7M9cmBBr9nDUJijFRwGbSlNkzwKwQnM7FdEFZVMoMrRdIe6SOZPCxC2PAFfcqDEOtibCrtwukVMR6Y/OKZouEWX+H+4hzA5YeVvPXRlF/4T0BMw/dx16dWduUXvdkNynLgT0xCKsKuikQ/IY/EueWVa9sLupFqZG4crGMRnz6r3UJ/EkvnS96cQjGTezLAcisy2r27eyB+izfKMSBc637tJ3I4X90Eqj37zrN4e6hWqDZjnGNXN8GJLb0SgZt5EatYCFtfM88gZt2vEREySeVAY19sh49VGAQw5z7jUzo/k9wnzrapQXrbTGVnUAN1BlUQpfzTNzGJRy1LyYZTHFVwlPxPDSzEd3C47p08mNDRLYuZkfGWBvOuFUP4K4QkINi8wWR3B2E37ZO49cBIJqYVMe6VTTGp3w/DI33i7x555CCGtpOof/YJpyOXAxZa2Dq+7cYeHEpz3wq1DcMQefNq97K/OhY8mmtbOwZJOHFHSN3/hkLecUWbyAykxeiOIwwzdI62K5UafqsxaiyCHD8Ok228ecYmPI/sg+RD0OXzBJGpHIa5BNbUY6KLknDLge5szHU2/yddxXbnAQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TVuhYld9jfnJpR47S97mpAWwyC6tGKtbrezBvLI5gGEqafdE9NPI2G/lsbEY?=
 =?us-ascii?Q?oQUMTFy8mZE+PhslZmF3QnutxlGlIQKt3KyltdyFiwPkWMqm+R+BKoQP2Tjm?=
 =?us-ascii?Q?0+oK6uFxGyv2qyhIqoJAWL0TeGoAGw9FjXQluftDLSde1WhMlhbKwocOX1g8?=
 =?us-ascii?Q?A81O76qmW23cbQd75qXgaJgRB8hQ4U9pUFs9ZEnzUYoyo4LaIzYPAuZ2WHpP?=
 =?us-ascii?Q?mXNDqsRG7295VVBd8LbstQjkLPM8sU6tHyRUXvJCqz7gaQ+ZWwI3hCqv/vdg?=
 =?us-ascii?Q?V3GHg/cgTgyT9meIOpmHQlPx/z+aSiWs7RVlCNr7ahWwPctBhiAYvIzS+sgM?=
 =?us-ascii?Q?Y0ge0ApAvy/paRLzc7SkeyjNVoyOArunICh/OtdBWmxNMKO8AYI/fMO/Nf4Z?=
 =?us-ascii?Q?vpwJFBttdYWNgewWfFB+iwcxZjTEDuklXq3jUHMioUDd/EDbIzpfOXNhmC/u?=
 =?us-ascii?Q?XrtEGpecdC7vMeCg8xVe55j0G3UQNaifeWO61LNIcLGE5ToCoHnwp56Fv1p9?=
 =?us-ascii?Q?SFBKhfuXL4bM3E0QBn6rCwg0TpWuBAyACxZ3XIYjJ/GR/KoWmj/nKlaHixD6?=
 =?us-ascii?Q?cF/PJBUvKZmR7+cUquHotr2ROpFTGaHaWYTPvfrUs2plBDZe0YIXhYZumvqJ?=
 =?us-ascii?Q?CRO0W6B/a+NIOVSK5JQhQyTc9vJ9h8r7qkFefxVgiT5P+iv3zk60l8S2iYtE?=
 =?us-ascii?Q?HZn5XGj3qcz6EA38dOHYMwofs5A3cORPR/eHjWlZn6rQy1G1RFfBtGe9RTHK?=
 =?us-ascii?Q?hriCK2Twb7GMYfXXw9dDJK8fWr6LrfIVWJYn91DcTN/9Z+Y5H2lE3CDMw9JM?=
 =?us-ascii?Q?23EmKtdx8Nop5CzwVSqYCvJQJSC4tke/w6YP3mxPUtLGzS2FCb6dJeWLbOEC?=
 =?us-ascii?Q?+Kxc7ZBdhlbbTxU5gR6R75P/8d7xsDgOZP8xXMaf/NCiLOgHpS/SiVohyQWz?=
 =?us-ascii?Q?/FvOtfvwWK64enB1QUqNc1oXPZD/1eWJUcaeofminxxn92IB90SkqJc18sv7?=
 =?us-ascii?Q?VdzCDI5sxb47n4vRnPgb3kc2PAixFKHdCzQ+wAxtLZK4Dd213RcktWd4201h?=
 =?us-ascii?Q?IJQ//30nTODWZlzvFLGCWjr/C6DD8VawC+9h4PnMudbpT8Fyk8Iz8Hc5k/L7?=
 =?us-ascii?Q?x4jYDeUuukDHPCjOATvf2LDfX1BiZ1wQPsSE+ryCggSiPb1K32RpcCHb6Z9n?=
 =?us-ascii?Q?by5RehF9vqJe1BI4+kLReJ51ug1/GDEZBcqgdLcIwgOSW8PxVnpPyOVTzWLY?=
 =?us-ascii?Q?k1IPS/XCoynnTvBoAkOeLs12WXvYjEzPRBj+VKvig+d5uWMjWtJTFlxh7VPA?=
 =?us-ascii?Q?nJU2w5pB9fM71nYFHuKqeL6KeQfGCSqkAJy3h8FHdIAcv6WtU8yMCmXpcRo4?=
 =?us-ascii?Q?ivGzq5EZsocpkp8gCHrlqP2r6LzMP7c9STp/kgzj+TubOCZL0SGsbZsppLcl?=
 =?us-ascii?Q?8dExECke4nNgOYUCV9lCPnaz/yPb8R26ElU+a17a5d0RxAqbSHOUrwHvf6wq?=
 =?us-ascii?Q?FbbOYXFcqDC7emXvaWNlv4ibrjvSS7MFoY4eTfuaqmzMqku+IULpqiN+4tGs?=
 =?us-ascii?Q?DrfK+7xmUIfbmfVBurREpPbygQPop+qDGvAD78soG2s1qsadGgs7iG690HKn?=
 =?us-ascii?Q?RURHzLLc6xVhhdSh9c0Ygu2tgTXy7K+Jaf9SggA9/c6t0GEOB4zoSkJdF9Ld?=
 =?us-ascii?Q?B+2SoG60Wnj76+ZZzk/VToYgfawvcSkRiblaX4lrC9JUFs2v9HzRGtHT/Xe7?=
 =?us-ascii?Q?Zjatr80VOmXTR5FYZ6VP/hEUukW5CIgOtFADNA/ZXvOhoznQ7CWP?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d27bec-2da9-4e2a-a0c3-08decc4b7e83
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:15.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idJSgPeTrPlKY2a3CTVBVFxkr9p3i8tzB/6pyj0hGIdGvYRUM5IgbCg0VUNBuYu5J2E7FW28ACGnyn4N/1voF8QCPGLnnhp4AueoNDN65PmWD4FeYN0pImuLtsJZ65AO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23209

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit fa08b566860bca8ebf9300090b85174c34de7ca5 upstream.

The DMA controller can be used to transfer data to and from the SPI
controller without involving the CPU for each word of a SPI transfer.

Add support for DMA mode.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-12-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 169 ++++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 9f5bc047b485..aae916882915 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -9,6 +9,7 @@
 #include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/limits.h>
@@ -21,6 +22,8 @@
 #include <linux/spi/spi.h>
 #include <linux/wait.h>
=20
+#include "internals.h"
+
 /* Registers */
 #define RSPI_SPDR		0x00
 #define RSPI_SPCR		0x08
@@ -96,6 +99,7 @@ struct rzv2h_rspi_info {
 struct rzv2h_rspi_priv {
 	struct spi_controller *controller;
 	const struct rzv2h_rspi_info *info;
+	struct platform_device *pdev;
 	void __iomem *base;
 	struct clk *tclk;
 	struct clk *pclk;
@@ -108,6 +112,7 @@ struct rzv2h_rspi_priv {
 	u8 spr;
 	u8 brdv;
 	bool use_pclk;
+	bool dma_callbacked;
 };
=20
 #define RZV2H_RSPI_TX(func, type)					\
@@ -219,6 +224,20 @@ static int rzv2h_rspi_receive(struct rzv2h_rspi_priv *=
rspi, void *rxbuf,
 	return 0;
 }
=20
+static bool rzv2h_rspi_can_dma(struct spi_controller *ctlr, struct spi_dev=
ice *spi,
+			       struct spi_transfer *xfer)
+{
+	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(ctlr);
+
+	if (ctlr->fallback)
+		return false;
+
+	if (!ctlr->dma_tx || !ctlr->dma_rx)
+		return false;
+
+	return xfer->len > rspi->info->fifo_size;
+}
+
 static int rzv2h_rspi_transfer_pio(struct rzv2h_rspi_priv *rspi,
 				   struct spi_device *spi,
 				   struct spi_transfer *transfer,
@@ -240,21 +259,149 @@ static int rzv2h_rspi_transfer_pio(struct rzv2h_rspi=
_priv *rspi,
 	return ret;
 }
=20
+static void rzv2h_rspi_dma_complete(void *arg)
+{
+	struct rzv2h_rspi_priv *rspi =3D arg;
+
+	rspi->dma_callbacked =3D 1;
+	wake_up_interruptible(&rspi->wait);
+}
+
+static struct dma_async_tx_descriptor *
+rzv2h_rspi_setup_dma_channel(struct rzv2h_rspi_priv *rspi,
+			     struct dma_chan *chan, struct sg_table *sg,
+			     enum dma_slave_buswidth width,
+			     enum dma_transfer_direction direction)
+{
+	struct dma_slave_config config =3D {
+		.dst_addr =3D rspi->pdev->resource->start + RSPI_SPDR,
+		.src_addr =3D rspi->pdev->resource->start + RSPI_SPDR,
+		.dst_addr_width =3D width,
+		.src_addr_width =3D width,
+		.direction =3D direction,
+	};
+	struct dma_async_tx_descriptor *desc;
+	int ret;
+
+	ret =3D dmaengine_slave_config(chan, &config);
+	if (ret)
+		return ERR_PTR(ret);
+
+	desc =3D dmaengine_prep_slave_sg(chan, sg->sgl, sg->nents, direction,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		return ERR_PTR(-EAGAIN);
+
+	if (direction =3D=3D DMA_DEV_TO_MEM) {
+		desc->callback =3D rzv2h_rspi_dma_complete;
+		desc->callback_param =3D rspi;
+	}
+
+	return desc;
+}
+
+static enum dma_slave_buswidth
+rzv2h_rspi_dma_width(struct rzv2h_rspi_priv *rspi)
+{
+	switch (rspi->bytes_per_word) {
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	case 2:
+		return DMA_SLAVE_BUSWIDTH_2_BYTES;
+	case 1:
+		return DMA_SLAVE_BUSWIDTH_1_BYTE;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
+}
+
+static int rzv2h_rspi_transfer_dma(struct rzv2h_rspi_priv *rspi,
+				   struct spi_device *spi,
+				   struct spi_transfer *transfer,
+				   unsigned int words_to_transfer)
+{
+	struct dma_async_tx_descriptor *tx_desc =3D NULL, *rx_desc =3D NULL;
+	enum dma_slave_buswidth width;
+	dma_cookie_t cookie;
+	int ret;
+
+	width =3D rzv2h_rspi_dma_width(rspi);
+	if (width =3D=3D DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		return -EINVAL;
+
+	rx_desc =3D rzv2h_rspi_setup_dma_channel(rspi, rspi->controller->dma_rx,
+					       &transfer->rx_sg, width,
+					       DMA_DEV_TO_MEM);
+	if (IS_ERR(rx_desc))
+		return PTR_ERR(rx_desc);
+
+	tx_desc =3D rzv2h_rspi_setup_dma_channel(rspi, rspi->controller->dma_tx,
+					       &transfer->tx_sg, width,
+					       DMA_MEM_TO_DEV);
+	if (IS_ERR(tx_desc))
+		return PTR_ERR(tx_desc);
+
+	cookie =3D dmaengine_submit(rx_desc);
+	if (dma_submit_error(cookie))
+		return cookie;
+
+	cookie =3D dmaengine_submit(tx_desc);
+	if (dma_submit_error(cookie)) {
+		dmaengine_terminate_sync(rspi->controller->dma_rx);
+		return cookie;
+	}
+
+	/*
+	 * DMA transfer does not need IRQs to be enabled.
+	 * For PIO, we only use RX IRQ, so disable that.
+	 */
+	disable_irq(rspi->irq_rx);
+
+	rspi->dma_callbacked =3D 0;
+
+	dma_async_issue_pending(rspi->controller->dma_rx);
+	dma_async_issue_pending(rspi->controller->dma_tx);
+	rzv2h_rspi_clear_all_irqs(rspi);
+
+	ret =3D wait_event_interruptible_timeout(rspi->wait, rspi->dma_callbacked=
, HZ);
+	if (ret) {
+		dmaengine_synchronize(rspi->controller->dma_tx);
+		dmaengine_synchronize(rspi->controller->dma_rx);
+		ret =3D 0;
+	} else {
+		dmaengine_terminate_sync(rspi->controller->dma_tx);
+		dmaengine_terminate_sync(rspi->controller->dma_rx);
+		ret =3D -ETIMEDOUT;
+	}
+
+	enable_irq(rspi->irq_rx);
+
+	return ret;
+}
+
 static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
 				   struct spi_device *spi,
 				   struct spi_transfer *transfer)
 {
 	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(controller);
+	bool is_dma =3D spi_xfer_is_dma_mapped(controller, spi, transfer);
 	unsigned int words_to_transfer;
 	int ret;
=20
 	transfer->effective_speed_hz =3D rspi->freq;
 	words_to_transfer =3D transfer->len / rspi->bytes_per_word;
=20
-	ret =3D rzv2h_rspi_transfer_pio(rspi, spi, transfer, words_to_transfer);
+	if (is_dma)
+		ret =3D rzv2h_rspi_transfer_dma(rspi, spi, transfer, words_to_transfer);
+	else
+		ret =3D rzv2h_rspi_transfer_pio(rspi, spi, transfer, words_to_transfer);
=20
 	rzv2h_rspi_clear_all_irqs(rspi);
=20
+	if (is_dma && ret =3D=3D -EAGAIN)
+		/* Retry with PIO */
+		transfer->error =3D SPI_TRANS_FAIL_NO_START;
+
 	return ret;
 }
=20
@@ -557,6 +704,7 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	platform_set_drvdata(pdev, rspi);
=20
 	rspi->controller =3D controller;
+	rspi->pdev =3D pdev;
=20
 	rspi->info =3D device_get_match_data(dev);
=20
@@ -613,6 +761,7 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	controller->unprepare_message =3D rzv2h_rspi_unprepare_message;
 	controller->num_chipselect =3D 4;
 	controller->transfer_one =3D rzv2h_rspi_transfer_one;
+	controller->can_dma =3D rzv2h_rspi_can_dma;
=20
 	tclk_rate =3D clk_round_rate(rspi->tclk, 0);
 	if (tclk_rate < 0)
@@ -630,6 +779,24 @@ static int rzv2h_rspi_probe(struct platform_device *pd=
ev)
 							   RSPI_SPBR_SPR_MIN,
 							   RSPI_SPCMD_BRDV_MIN);
=20
+	controller->dma_tx =3D devm_dma_request_chan(dev, "tx");
+	if (IS_ERR(controller->dma_tx)) {
+		ret =3D dev_warn_probe(dev, PTR_ERR(controller->dma_tx),
+				     "failed to request TX DMA channel\n");
+		if (ret =3D=3D -EPROBE_DEFER)
+			return ret;
+		controller->dma_tx =3D NULL;
+	}
+
+	controller->dma_rx =3D devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(controller->dma_rx)) {
+		ret =3D dev_warn_probe(dev, PTR_ERR(controller->dma_rx),
+				     "failed to request RX DMA channel\n");
+		if (ret =3D=3D -EPROBE_DEFER)
+			return ret;
+		controller->dma_rx =3D NULL;
+	}
+
 	device_set_node(&controller->dev, dev_fwnode(dev));
=20
 	ret =3D devm_spi_register_controller(dev, controller);
--=20
2.54.0


