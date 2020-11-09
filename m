Return-Path: <SRS0=BNet=EP=lists.cip-project.org=bounce+64572+5775+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2992CC2D0A3
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A1E206C0
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Q+B26tuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A1E206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5775+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BbI1YY4521723xjpbhZo91cm; Mon, 09 Nov 2020 07:50:23 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.13504.1604937019730124247
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:22 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="61913714"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:21 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 942A340065C9;
	Tue, 10 Nov 2020 00:50:20 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 06/14] spi: sh-msiof: Avoid writing to registers from spi_master.setup()
Date: Mon,  9 Nov 2020 15:50:03 +0000
Message-Id: <20201109155011.10291-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TApaAfrFc0R45SShBYtChqvcx4520388AA=
Content-Type: multipart/mixed; boundary="SCcCnwvhOhPmju8tzTp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937023;
 bh=F/pyUQd3pCFiI5byz8xI51YgYSoU7ASJe2xAnOIMswg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Q+B26tuCbK0uxp3+1YO21imD9FmqPLemGnOYbs5EzQimh2hYc0S/OI5LDZ6T28ErKFG
 J2CPCGU7in/WxZyi4lD1XMO93F22K1JwDueBJsp5jQedRtOVNsbVFMmlbaljB1HAoT9pe
 uTFXs17zZpIYhjh5kmbmTWqUwBKym2kJQtU=

--SCcCnwvhOhPmju8tzTp4

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 7ff0b53c4051145d1cf992d2f60987e6447eed4f upstream.

The spi_master.setup() callback must not change configuration registers,
as that could corrupt I/O that is in progress for other SPI slaves.

The only exception is the configuration of the native chip select
polarity in SPI master mode, as a wrong chip select polarity will cause
havoc during all future transfers to any other SPI slave.

Hence stop writing to registers in sh_msiof_spi_setup(), unless it is
the first call for a controller using a native chip select, or unless
native chip select polarity has changed (note that you'll loose anyway
if I/O is in progress).  Even then, only do what is strictly necessary,
instead of calling sh_msiof_spi_set_pin_regs().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
[PL: Manually applied the changes, dropped check for slave]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-sh-msiof.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8c25dbcaae4d..13aa354aa2e9 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -54,6 +54,8 @@ struct sh_msiof_spi_priv {
 	void *rx_dma_page;
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
+	bool native_cs_inited;
+	bool native_cs_high;
 };
 
 #define TMDR1	0x00	/* Transmit Mode Register 1 */
@@ -522,8 +524,7 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 {
 	struct device_node	*np = spi->master->dev.of_node;
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
-
-	pm_runtime_get_sync(&p->pdev->dev);
+	u32 clr, set, tmp;
 
 	if (!np) {
 		/*
@@ -533,19 +534,28 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		spi->cs_gpio = (uintptr_t)spi->controller_data;
 	}
 
-	/* Configure pins before deasserting CS */
-	sh_msiof_spi_set_pin_regs(p, !!(spi->mode & SPI_CPOL),
-				  !!(spi->mode & SPI_CPHA),
-				  !!(spi->mode & SPI_3WIRE),
-				  !!(spi->mode & SPI_LSB_FIRST),
-				  !!(spi->mode & SPI_CS_HIGH));
-
-	if (spi->cs_gpio >= 0)
+	if (spi->cs_gpio >= 0) {
 		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+		return 0;
+	}
 
+	if (p->native_cs_inited &&
+	    (p->native_cs_high == !!(spi->mode & SPI_CS_HIGH)))
+		return 0;
 
+	/* Configure native chip select mode/polarity early */
+	clr = MDR1_SYNCMD_MASK;
+	set = MDR1_TRMD | TMDR1_PCON | MDR1_SYNCMD_SPI;
+	if (spi->mode & SPI_CS_HIGH)
+		clr |= BIT(MDR1_SYNCAC_SHIFT);
+	else
+		set |= BIT(MDR1_SYNCAC_SHIFT);
+	pm_runtime_get_sync(&p->pdev->dev);
+	tmp = sh_msiof_read(p, TMDR1) & ~clr;
+	sh_msiof_write(p, TMDR1, tmp | set);
 	pm_runtime_put(&p->pdev->dev);
-
+	p->native_cs_high = spi->mode & SPI_CS_HIGH;
+	p->native_cs_inited = true;
 	return 0;
 }
 
-- 
2.17.1


--SCcCnwvhOhPmju8tzTp4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5775): https://lists.cip-project.org/g/cip-dev/message=
/5775
Mute This Topic: https://lists.cip-project.org/mt/78138433/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SCcCnwvhOhPmju8tzTp4--
