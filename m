Return-Path: <SRS0=LSNZ=EP=lists.cip-project.org=bounce+64572+5776+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D776BC388F7
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634382074F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Wp3dx4oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634382074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5776+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RCy4YY4521723xiLMDi9ZZQJ; Mon, 09 Nov 2020 07:50:24 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.13504.1604937015956466828
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:23 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="62129280"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:22 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DD9F740065C9;
	Tue, 10 Nov 2020 00:50:21 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 07/14] spi: sh-msiof: Implement cs-gpios configuration
Date: Mon,  9 Nov 2020 15:50:04 +0000
Message-Id: <20201109155011.10291-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FOKwYRu3lneVpwelPkakzOkex4520388AA=
Content-Type: multipart/mixed; boundary="pRbQ40NeDngKNhbiuHsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937024;
 bh=ZRtl7UXA5wHl2bXBmPxfkkB53dApK3Ziz0pT/+OIsV0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Wp3dx4ozXoduOiiuICMeg7Pf8dc0jxwrrf+w0c6uBl+WTIbPTe2JULcAY/LPNl0pS+v
 srCepPDT9NFbVSlAJ6avuFXK8ehq/Onix02AoO4jFfb2a0WKUZBe3rPFbQJkMD/kKahGs
 22uE+O4Jp6CeTjbzTQA2SQWrGpnZarKxq8k=

--pRbQ40NeDngKNhbiuHsQ

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit b8761434bdec32fa46a644c26a12d16a9b0f58d8 upstream.

The current support for GPIO chip selects assumes the GPIOs have been
configured by platform code or the boot loader.  This includes pinmux
setup and GPIO direction.  Hence it does not work as expected when just
described in DT using the "cs-gpios" property.

Fix this by:
  1. using devm_gpiod_get_index() to request the GPIO, and thus
     configure pinmux, if needed,
  2. configuring the GPIO direction is the spi_master.setup() callback.

Use gpio_is_valid() instead of a check on positive numbers.

Note that when using GPIO chip selects, at least one native chip select
must be left unused, as that native chip select will be driven anyway,
and (global) native chip select polarity must be taken into account.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
[PL: Manually applied the changes, dropped multiple slave support]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-sh-msiof.c | 62 +++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 13aa354aa2e9..2c8690cd0058 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -18,6 +18,7 @@
 #include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -58,6 +59,8 @@ struct sh_msiof_spi_priv {
 	bool native_cs_high;
 };
 
+#define MAX_SS	3	/* Maximum number of native chip selects */
+
 #define TMDR1	0x00	/* Transmit Mode Register 1 */
 #define TMDR2	0x04	/* Transmit Mode Register 2 */
 #define TMDR3	0x08	/* Transmit Mode Register 3 */
@@ -534,8 +537,8 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		spi->cs_gpio = (uintptr_t)spi->controller_data;
 	}
 
-	if (spi->cs_gpio >= 0) {
-		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+	if (gpio_is_valid(spi->cs_gpio)) {
+		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 		return 0;
 	}
 
@@ -564,13 +567,18 @@ static int sh_msiof_prepare_message(struct spi_master *master,
 {
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(master);
 	const struct spi_device *spi = msg->spi;
+	u32 cs_high;
+
+	if (gpio_is_valid(spi->cs_gpio))
+		cs_high = p->native_cs_high;
+	else
+		cs_high = !!(spi->mode & SPI_CS_HIGH);
 
 	/* Configure pins before asserting CS */
 	sh_msiof_spi_set_pin_regs(p, !!(spi->mode & SPI_CPOL),
 				  !!(spi->mode & SPI_CPHA),
 				  !!(spi->mode & SPI_3WIRE),
-				  !!(spi->mode & SPI_LSB_FIRST),
-				  !!(spi->mode & SPI_CS_HIGH));
+				  !!(spi->mode & SPI_LSB_FIRST), cs_high);
 	return 0;
 }
 
@@ -1030,6 +1038,45 @@ static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
 }
 #endif
 
+static int sh_msiof_get_cs_gpios(struct sh_msiof_spi_priv *p)
+{
+	struct device *dev = &p->pdev->dev;
+	unsigned int used_ss_mask = 0;
+	unsigned int cs_gpios = 0;
+	unsigned int num_cs, i;
+	int ret;
+
+	ret = gpiod_count(dev, "cs");
+	if (ret <= 0)
+		return 0;
+
+	num_cs = max_t(unsigned int, ret, p->master->num_chipselect);
+	for (i = 0; i < num_cs; i++) {
+		struct gpio_desc *gpiod;
+
+		gpiod = devm_gpiod_get_index(dev, "cs", i, GPIOD_ASIS);
+		if (!IS_ERR(gpiod)) {
+			cs_gpios++;
+			continue;
+		}
+
+		if (PTR_ERR(gpiod) != -ENOENT)
+			return PTR_ERR(gpiod);
+
+		if (i >= MAX_SS) {
+			dev_err(dev, "Invalid native chip select %d\n", i);
+			return -EINVAL;
+		}
+		used_ss_mask |= BIT(i);
+	}
+	used_ss_mask = ffz(used_ss_mask);
+	if (cs_gpios && used_ss_mask >= MAX_SS) {
+		dev_err(dev, "No unused native chip select available\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static struct dma_chan *sh_msiof_request_dma_chan(struct device *dev,
 	enum dma_transfer_direction dir, unsigned int id, dma_addr_t port_addr)
 {
@@ -1241,13 +1288,18 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	if (p->info->rx_fifo_override)
 		p->rx_fifo_size = p->info->rx_fifo_override;
 
+	/* Setup GPIO chip selects */
+	master->num_chipselect = p->info->num_chipselect;
+	ret = sh_msiof_get_cs_gpios(p);
+	if (ret)
+		goto err1;
+
 	/* init master code */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->mode_bits |= SPI_LSB_FIRST | SPI_3WIRE;
 	master->flags = p->chipdata->master_flags;
 	master->bus_num = pdev->id;
 	master->dev.of_node = pdev->dev.of_node;
-	master->num_chipselect = p->info->num_chipselect;
 	master->setup = sh_msiof_spi_setup;
 	master->prepare_message = sh_msiof_prepare_message;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
-- 
2.17.1


--pRbQ40NeDngKNhbiuHsQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5776): https://lists.cip-project.org/g/cip-dev/message=
/5776
Mute This Topic: https://lists.cip-project.org/mt/78138434/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pRbQ40NeDngKNhbiuHsQ--
