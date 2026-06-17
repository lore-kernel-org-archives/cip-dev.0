Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4F9CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:55 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10770.1781685107479730198
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ub7bS+2C;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAhyb7ybeERhPe6a5HAPwZ85mG5qPROrX1PhEdbb8IQvCb6E7nb6Pq9fiyPTcRMmPUHkUeXNJJpGyABZA7dPshLpKRxs8TM2fYMmbnChNUsiYRIw/rKpdHa0NvJsTo8Ce5qIXsN0tqZNBxdfk4LzDWr2ql5yOV9QpHSGwsmRoYbIq+8MknokqBz7C4smgkKCbz160vMaHsKMlbzOdnHqhTJBQGhn/8F7ewzWHEdGd8L8PCCK5UirkOMv4ZqBfsjvbPDRpBhNhbYvK1TkMpleK/2zHxpT12phV7qOpn2ckmgORVv+V0LIDeqMio/8lkYz4/+F45yAERP//XUUHwMdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9vw0w4vuBi4FvtvxuoUPiqM0Zw0vt5UA9ChW3a5n30=;
 b=HBUgB4qSaUPVgj1YULyoOV1+qXqNTZuZOqween8vhlmSZcUzqQ9mf/p+ixXAW3Uxv3BYRsKjAUJdR6P8EE0Bo1iOM14n9wIIYHeJ1j5o4qDGU7romr6mwVR6L9AH07kj/HXvFz0eu+5fIIwY1YhyBJQQbgsttvTlPu12nz+QYBw52hMe3FYS/SBW8aFex6QGVChVyRX4RHvqAKrhAJ/CPPivKKUbs+3uIeL/UIRagSj3GuHmibMYDB4/BIEUdhFdDcVXC7USTsp61WAchnpZ+gglS+Yhr/Y0j8Wy+c8YFP+Eeffq0Xyd3ZqW6yDo1ZJwzvDMQmWinWGMBmClzpsW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9vw0w4vuBi4FvtvxuoUPiqM0Zw0vt5UA9ChW3a5n30=;
 b=ub7bS+2CtDdynR4qXs8LIagLeQeXaB9XZLtYK859YKVw+IEtgoK0NHu3A/f1eO4FkHHnMzfMqyif1YFz2MQ91uHskFUAZVIXZcCePVKjevXMUduF4rXEXFVI5XzfpudMLv3kGPO3v5sPUp/bb6ekUf2/6nEjWsTXS4T+5BEwJf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:44 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 26/32] spi: rzv2h-rspi: add support for DMA mode
Date: Wed, 17 Jun 2026 10:29:57 +0200
Message-ID: <20260617083003.1071543-27-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6093241d-8805-4810-01f0-08decc4add1b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ASb2pUvr0Xczf9t105I6fFwKUkhvyTmNpKAgVP/Modu1lOZnziw9QvtByMa6ZyN0MvUMRfp6jwrvreeq41Gm6veltE/yE/MYYRBpA5lY8pzHQ5EMf/jAiuESP2xMAqsYHokhYsc126JQzLY2z/LmEa/BFEvhKapH3wb4SeaAV8ZWNcCjygT2LcNA59cgrGyiqMoRWAGdAsDLeCO8iLMLy/HbjUoL2jxPo83CzJt/2sq8cSJB77q85ZAPV3GzbyKv6YueaWGGsRzvwaHKbMCiQfOaLLibay7tEyq4iNxVU4N/6g/dWC4zU9uiIyQDqew8gQBJwfqSq98/HGP7S+62ktAy1xWyc2lScVL70ZDk2rG7F8DcuBKB2+N28ADn3VR02kq2QxfqNVmiFg1ER0rY5tVMLDp3tOv2W82+fEqaMshwHp/VAZJk92v5xXaqRePwk8Af1WGoTMR5yP8lrG7VFu/ex0JNEETaKEaxfKuhbDj3BZhczJYLz+C4WdPcnlr6BMhvIbsvMq+8JIh0lb2NWniw53N2p5QpRgvVEW6KHZ3W07TbkOneFtiCqPgDvaxhieg4Xbxy4SJNmP5+8pNo6zAqDB0gEGMSct9KHdrdhflCwu9vCBDa7gA7Q7DDWHm0kETceNoMTQUNaoMUBeixuOeb5mAp3pYVv6HhnK9WZvZUR/4cj+KhXEHpWwqIUS1EIes+0owjU/9DDq9ovJv++Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WhwjjJuoL1ScHnwSMHguNQ5QJVzFlPspEsetzYewbCO8yrQ/l2zs2yqvgWm9?=
 =?us-ascii?Q?1EjvLB2rdOOSNQShI8BaQuGB8Y6g1KVIfL57Y6R0PFAF8iTNCyNa08/XHnqi?=
 =?us-ascii?Q?gHStr1wXakkLWnQTc3wZ0Jri1M9Pan3PibQ18GcVa8Fy7XnGtMMarYe7/2eL?=
 =?us-ascii?Q?d1JhYjnFicRH97AE48u/wOQy0GNAYRUMik4PT6RTO+Kq8VLM8wmBDYNJDifo?=
 =?us-ascii?Q?GWgD0hBxmhZaBLanXx0W3JwDah0SHECiU36riqrsij7u89GaF3UTPIbrfScb?=
 =?us-ascii?Q?Xan5ic5VipGQzWBnm8+8ioxpJ5N/a19FRBMI4K6MyC/dNRY5JrEoW5GUp7m1?=
 =?us-ascii?Q?Mq+AFxKOIs39Qxq8kKcFlpPdJjD+Cfjdxa6zA27Xd03Lz6LoGuZE56bAxBNy?=
 =?us-ascii?Q?IlCqm2lRrCkzwm8LFxK8IucKHfqA748t2V9BYZZh0xXm5tGy2ANj6p4tr1YO?=
 =?us-ascii?Q?5DDgnVBSBWFeZnwxJom8+xfjhcPo9oB037Wi5xNOUR+FvriUgvk9GhUTwUSg?=
 =?us-ascii?Q?H4aG3UrMoFgGC24oukkUdHnN/ibvQjX1YOk8LoLYgWgPvLYSx7FVyGCULBqF?=
 =?us-ascii?Q?h+04PLfxWcD5CSXMDi5VYQZNwmnLnUt1a1eA+PUCtKgmR0+0+nPOW7+Hr5/P?=
 =?us-ascii?Q?BE8XfB+k2WOoUhrfUNelJmDZWxuOyEdRVDMUuWnDGKeEi1XKdXmB4O77+yrT?=
 =?us-ascii?Q?v5Novw2ggxr5KrwITnl9wWr8DBnouBYeqxWJ+vlVk0E5GpHe/LYB1q0uhRDj?=
 =?us-ascii?Q?2OFKpRM/lw0g8h37BOGHv4KrZvoOKKKGIV7bmevxMQj4rUSVPDnaYYjVarlF?=
 =?us-ascii?Q?73h5KsOAVxq0jUklBrIDhJMn1nhtVOq2J/ruujIgfvkxuAsoOnvUplR2Vrmx?=
 =?us-ascii?Q?FiNRKSFRVQL0EwF3FYm9xfXkSeJrSikLfctfgAu0CU6Z2tmo6tzCmO2rcMfS?=
 =?us-ascii?Q?MYagI9jk0DtMJqun4y1vsPu0TT3YLkzxHW345Mu0IehCcAJKZaZZRU97Wwhy?=
 =?us-ascii?Q?ocV2SUntMD3rclRmCDFUSMkcBVJi+yGoKPENaUruW9vyTYJLlElvqN2GRzhl?=
 =?us-ascii?Q?OIdmooA7+DYJyy2jJCZDH4xadcjRBMSbyTbsPHFfjI2cMcTiO4XIqzE/3TVR?=
 =?us-ascii?Q?XHgVKEgrp2eANxBIWv7bXpy50aQEakHSa3qtTQ96DG1mRAdZkVKsFA8xGecn?=
 =?us-ascii?Q?BxerE9UWY2szp4A/0opTfHQYRlC6mYfx4pOySj3HgmCf4m1ZSZvgZ/DvMKIe?=
 =?us-ascii?Q?lJ2icAu91nkB/ifBoCde0WTHB35wtXp7rsjw/1EjEfu1Lnv8/SA99DznLpku?=
 =?us-ascii?Q?WkwF2v51+/y3dkXgtEuPsbBwdpPmjuPvnC9ttylmATW7Oa9tsx+jrs2z3tQx?=
 =?us-ascii?Q?BiKFdD1AmiptcLoaEAAGOWsXfGY4yCiQs4vlw2qyxUtUKEWCbP9mmmfLWIK7?=
 =?us-ascii?Q?U/qCHJwCQzbOznzm7VNBow1hoMXBioZR90eKPGVde1fR+7yiJrnNUmLOLxhf?=
 =?us-ascii?Q?pbPeYhnmHL2ul7dWh8QGS7boUg3prhIIRjyTsYOGmPT5wEMPOn2Z0Xwa7qaF?=
 =?us-ascii?Q?WgYOM+46SPlwlnaOOUkKWbczvxHz1wG2OncxBq1Op4flxbFgI0Hbb45xab94?=
 =?us-ascii?Q?pvHW9OpvS2RUWVQBE3/OqCV+pnetxJLhtPZ2VKr8yLoEuzktQoinQRwdsCIM?=
 =?us-ascii?Q?MfOSP12UzRD9KJPIg7OigYUNdSPoPRBC1m5/6X1jsaTXD1xaYpnJ+L06i5W4?=
 =?us-ascii?Q?C95/KGoEs3fqB1BD2S/pvJIhSLjRrXd7YjYI07TjhcIDQ9MPGLTL?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6093241d-8805-4810-01f0-08decc4add1b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:44.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL1utjbAXO5Lbl638/pcNofYs18iUbW3U+/6Z0UPIhnIp7aeMlrY/JRkz1XX2Ehj0x+wAXKojcsmVBNCQMkPeNm8M32HlPzLVmtmcsv89oB6/0FiL/qmUxmRwb3vejtC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23185

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit fa08b566860bca8ebf9300090b85174c34de7ca5 upstream.

The DMA controller can be used to transfer data to and from the SPI
controller without involving the CPU for each word of a SPI transfer.

Add support for DMA mode.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-12-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[tm: Use dev_warn() equivalent of dev_warn_probe()]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 171 ++++++++++++++++++++++++++++++++++-
 1 file changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 3191eaddc9d5..623e7683dcf3 100644
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
@@ -562,6 +709,7 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	platform_set_drvdata(pdev, rspi);
=20
 	rspi->controller =3D controller;
+	rspi->pdev =3D pdev;
=20
 	rspi->info =3D device_get_match_data(dev);
=20
@@ -632,6 +780,7 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	controller->unprepare_message =3D rzv2h_rspi_unprepare_message;
 	controller->num_chipselect =3D 4;
 	controller->transfer_one =3D rzv2h_rspi_transfer_one;
+	controller->can_dma =3D rzv2h_rspi_can_dma;
=20
 	tclk_rate =3D clk_round_rate(rspi->tclk, 0);
 	if (tclk_rate < 0)
@@ -649,6 +798,26 @@ static int rzv2h_rspi_probe(struct platform_device *pd=
ev)
 							   RSPI_SPBR_SPR_MIN,
 							   RSPI_SPCMD_BRDV_MIN);
=20
+	controller->dma_tx =3D devm_dma_request_chan(dev, "tx");
+	if (IS_ERR(controller->dma_tx)) {
+		ret =3D PTR_ERR(controller->dma_tx);
+		if (ret =3D=3D -EPROBE_DEFER)
+			return ret;
+		dev_warn(dev, "error %pe: failed to request TX DMA channel\n",
+			 ERR_PTR(ret));
+		controller->dma_tx =3D NULL;
+	}
+
+	controller->dma_rx =3D devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(controller->dma_rx)) {
+		ret =3D PTR_ERR(controller->dma_rx);
+		if (ret =3D=3D -EPROBE_DEFER)
+			return ret;
+		dev_warn(dev, "error %pe: failed to request RX DMA channel\n",
+			 ERR_PTR(ret));
+		controller->dma_rx =3D NULL;
+	}
+
 	device_set_node(&controller->dev, dev_fwnode(dev));
=20
 	ret =3D devm_spi_register_controller(dev, controller);
--=20
2.54.0


