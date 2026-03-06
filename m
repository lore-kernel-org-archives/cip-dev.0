Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D842FFCB638
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:00:31 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74088.1772816422272121011
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:00:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: ozpsVZj0Ske0PWKic91MOg==
X-CSE-MsgGUID: dKBXgGYIRMuVJ90OEA+gxQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 02:00:30 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.180])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 35CD8400BC09;
	Sat,  7 Mar 2026 02:00:28 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 13/17] spi: rzv2h-rspi: add support for loopback mode
Date: Fri,  6 Mar 2026 18:59:14 +0200
Message-ID: <20260306165918.209377-14-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306165918.209377-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260306165918.209377-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:00:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22119

commit bc4f0b1e39035b9bb3d5d9692074702110f5e2b1 uptream.

Add support for loopback mode for debugging purposes, allowing us to
test the SPI controller at the maximum SPI transfer clock without being
limited by external wiring.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-10-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index be45269e8853..da110efba971 100644
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
 
+/* Register SPPCR */
+#define RSPI_SPPCR_SPLP2	BIT(1)
+
 /* Register SPBR */
 #define RSPI_SPBR_SPR_MIN	0
 #define RSPI_SPBR_SPR_PCLK_MIN	1
@@ -345,6 +349,7 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 	u8 bits_per_word;
 	u32 conf32;
 	u16 conf16;
+	u8 conf8;
 
 	/* Make sure SPCR.SPE is 0 before amending the configuration */
 	rzv2h_rspi_spe_disable(rspi);
@@ -389,6 +394,10 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 	/* Use SPCMD0 only */
 	writeb(0x0, rspi->base + RSPI_SPSCR);
 
+	/* Setup loopback */
+	conf8 = FIELD_PREP(RSPI_SPPCR_SPLP2, !!(spi->mode & SPI_LOOP));
+	writeb(conf8, rspi->base + RSPI_SPPCR);
+
 	/* Setup mode */
 	conf32 = FIELD_PREP(RSPI_SPCMD_CPOL, !!(spi->mode & SPI_CPOL));
 	conf32 |= FIELD_PREP(RSPI_SPCMD_CPHA, !!(spi->mode & SPI_CPHA));
@@ -490,7 +499,7 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	}
 
 	controller->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
-				SPI_LSB_FIRST;
+				SPI_LSB_FIRST | SPI_LOOP;
 	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	controller->prepare_message = rzv2h_rspi_prepare_message;
 	controller->unprepare_message = rzv2h_rspi_unprepare_message;
-- 
2.53.0


