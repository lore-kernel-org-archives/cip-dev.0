Return-Path: <SRS0=HPSe=E5=lists.cip-project.org=bounce+64572+5823+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FE3C56202
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 12:04:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522F72076E
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 12:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="O+AYRyGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522F72076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5823+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4mkaYY4521723x8BUvkNJATu; Mon, 23 Nov 2020 04:04:07 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.34009.1606133039933459828
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 04:04:06 -0800
X-IronPort-AV: E=Sophos;i="5.78,363,1599490800"; 
   d="scan'208";a="63589412"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Nov 2020 21:04:05 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 067CD4007F28;
	Mon, 23 Nov 2020 21:04:04 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 7/7] spi: add Renesas RPC-IF driver
Date: Mon, 23 Nov 2020 12:03:54 +0000
Message-Id: <20201123120354.26413-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rQQemGg5jIDs2SZNiN2FfP1sx4520388AA=
Content-Type: multipart/mixed; boundary="gwW2dItwkonBpQsHt4Ar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606133047;
 bh=v0B3W3DYQ2M8O9cqsXRoPjEKxw5Ycr7Z25JlqjomxbM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=O+AYRyGwbPqUadIn9fGYMp/k2OVX10Xq6pXYoSav8BTTMsnC5z0YI375Jx9aPTYVimn
 llb2S0HHnLEv7mBddqly/VwCBYarke41sw0okUS4kYK+NoEXdlt30vTZJU6RxtXKFN25g
 NBmqwS7mMY9WTOT5EoAm86cUsJNVv4ah3u4=

--gwW2dItwkonBpQsHt4Ar

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit eb8d6d464a27850498dced21a8450e85d4a02009 upstream.

Add the SPI driver for the Renesas RPC-IF.  It's the "front end" driver
using the "back end" APIs in the main driver to talk to the real hardware.
We only implement the 'spi-mem' interface -- there's no need to implement
the usual SPI driver methods...

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Link: https://lore.kernel.org/r/1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/Kconfig      |   6 ++
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-rpc-if.c | 216 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)
 create mode 100644 drivers/spi/spi-rpc-if.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 0a7fd56c1ed9..461315967f96 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -514,6 +514,12 @@ config SPI_RB4XX
 	help
 	  SPI controller driver for the Mikrotik RB4xx series boards.
 
+config SPI_RPCIF
+	tristate "Renesas RPC-IF SPI driver"
+	depends on RENESAS_RPCIF
+	help
+	  SPI driver for Renesas R-Car Gen3 RPC-IF.
+
 config SPI_RSPI
 	tristate "Renesas RSPI/QSPI controller"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index a90d55970036..e0b5478fde62 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
 obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
+obj-$(CONFIG_SPI_RPCIF)			+= spi-rpc-if.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
new file mode 100644
index 000000000000..ed3e548227f4
--- /dev/null
+++ b/drivers/spi/spi-rpc-if.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// RPC-IF SPI/QSPI/Octa driver
+//
+// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+// Copyright (C) 2019 Macronix International Co., Ltd.
+// Copyright (C) 2019 - 2020 Cogent Embedded, Inc.
+//
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#include <memory/renesas-rpc-if.h>
+
+#include <asm/unaligned.h>
+
+static void rpcif_spi_mem_prepare(struct spi_device *spi_dev,
+				  const struct spi_mem_op *spi_op,
+				  u64 *offs, size_t *len)
+{
+	struct rpcif *rpc = spi_controller_get_devdata(spi_dev->controller);
+	struct rpcif_op rpc_op = { };
+
+	rpc_op.cmd.opcode = spi_op->cmd.opcode;
+	rpc_op.cmd.buswidth = spi_op->cmd.buswidth;
+
+	if (spi_op->addr.nbytes) {
+		rpc_op.addr.buswidth = spi_op->addr.buswidth;
+		rpc_op.addr.nbytes = spi_op->addr.nbytes;
+		rpc_op.addr.val = spi_op->addr.val;
+	}
+
+	if (spi_op->dummy.nbytes) {
+		rpc_op.dummy.buswidth = spi_op->dummy.buswidth;
+		rpc_op.dummy.ncycles  = spi_op->dummy.nbytes * 8 /
+					spi_op->dummy.buswidth;
+	}
+
+	if (spi_op->data.nbytes || (offs && len)) {
+		rpc_op.data.buswidth = spi_op->data.buswidth;
+		rpc_op.data.nbytes = spi_op->data.nbytes;
+		switch (spi_op->data.dir) {
+		case SPI_MEM_DATA_IN:
+			rpc_op.data.dir = RPCIF_DATA_IN;
+			rpc_op.data.buf.in = spi_op->data.buf.in;
+			break;
+		case SPI_MEM_DATA_OUT:
+			rpc_op.data.dir = RPCIF_DATA_OUT;
+			rpc_op.data.buf.out = spi_op->data.buf.out;
+			break;
+		case SPI_MEM_NO_DATA:
+			rpc_op.data.dir = RPCIF_NO_DATA;
+			break;
+		}
+	} else	{
+		rpc_op.data.dir = RPCIF_NO_DATA;
+	}
+
+	rpcif_prepare(rpc, &rpc_op, offs, len);
+}
+
+static bool rpcif_spi_mem_supports_op(struct spi_mem *mem,
+				      const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
+	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4 ||
+	    op->addr.nbytes > 4)
+		return false;
+
+	return true;
+}
+
+static ssize_t rpcif_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
+					 u64 offs, size_t len, void *buf)
+{
+	struct rpcif *rpc =
+		spi_controller_get_devdata(desc->mem->spi->controller);
+
+	if (offs + desc->info.offset + len > U32_MAX)
+		return -EINVAL;
+
+	rpcif_spi_mem_prepare(desc->mem->spi, &desc->info.op_tmpl, &offs, &len);
+
+	return rpcif_dirmap_read(rpc, offs, len, buf);
+}
+
+static int rpcif_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct rpcif *rpc =
+		spi_controller_get_devdata(desc->mem->spi->controller);
+
+	if (desc->info.offset + desc->info.length > U32_MAX)
+		return -ENOTSUPP;
+
+	if (!rpcif_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+		return -ENOTSUPP;
+
+	if (!rpc->dirmap && desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
+		return -ENOTSUPP;
+
+	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+static int rpcif_spi_mem_exec_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct rpcif *rpc =
+		spi_controller_get_devdata(mem->spi->controller);
+
+	rpcif_spi_mem_prepare(mem->spi, op, NULL, NULL);
+
+	return rpcif_manual_xfer(rpc);
+}
+
+static const struct spi_controller_mem_ops rpcif_spi_mem_ops = {
+	.supports_op	= rpcif_spi_mem_supports_op,
+	.exec_op	= rpcif_spi_mem_exec_op,
+	.dirmap_create	= rpcif_spi_mem_dirmap_create,
+	.dirmap_read	= rpcif_spi_mem_dirmap_read,
+};
+
+static int rpcif_spi_probe(struct platform_device *pdev)
+{
+	struct device *parent = pdev->dev.parent;
+	struct spi_controller *ctlr;
+	struct rpcif *rpc;
+	int error;
+
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
+	if (!ctlr)
+		return -ENOMEM;
+
+	rpc = spi_controller_get_devdata(ctlr);
+	rpcif_sw_init(rpc, parent);
+
+	platform_set_drvdata(pdev, ctlr);
+
+	ctlr->dev.of_node = parent->of_node;
+
+	rpcif_enable_rpm(rpc);
+
+	ctlr->num_chipselect = 1;
+	ctlr->mem_ops = &rpcif_spi_mem_ops;
+
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
+	ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
+
+	rpcif_hw_init(rpc, false);
+
+	error = spi_register_controller(ctlr);
+	if (error) {
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
+		goto err_put_ctlr;
+	}
+	return 0;
+
+err_put_ctlr:
+	rpcif_disable_rpm(rpc);
+	spi_controller_put(ctlr);
+
+	return error;
+}
+
+static int rpcif_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct rpcif *rpc = spi_controller_get_devdata(ctlr);
+
+	spi_unregister_controller(ctlr);
+	rpcif_disable_rpm(rpc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int rpcif_spi_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+
+	return spi_controller_suspend(ctlr);
+}
+
+static int rpcif_spi_resume(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+
+	return spi_controller_resume(ctlr);
+}
+
+static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
+#define DEV_PM_OPS	(&rpcif_spi_pm_ops)
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
+static struct platform_driver rpcif_spi_driver = {
+	.probe	= rpcif_spi_probe,
+	.remove	= rpcif_spi_remove,
+	.driver = {
+		.name	= "rpc-if-spi",
+		.pm	= DEV_PM_OPS,
+	},
+};
+module_platform_driver(rpcif_spi_driver);
+
+MODULE_DESCRIPTION("Renesas RPC-IF SPI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


--gwW2dItwkonBpQsHt4Ar
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5823): https://lists.cip-project.org/g/cip-dev/message=
/5823
Mute This Topic: https://lists.cip-project.org/mt/78451549/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gwW2dItwkonBpQsHt4Ar--
