Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1836BFCC04A
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:18:43 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74547.1772817506005814198
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:18:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: fra1UzFNT0SZq7GdD9hHPg==
X-CSE-MsgGUID: KooHRV/0SqK7sfIyIo6orQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Mar 2026 02:18:39 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D52AC4031C01;
	Sat,  7 Mar 2026 02:18:37 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v2 08/17] spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
Date: Fri,  6 Mar 2026 19:17:26 +0200
Message-ID: <20260306171735.226034-9-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:18:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22133

commit 1b7ce968ab2579702ea9dbc2fb599e540bbd8c88 upstream.

In preparation for caching the last requested transfer frequency, move
register writes outside of rzv2h_rspi_setup_clock().

The transfer list is iterated to determine the speed of the transfer
and the bits per word.

The speed of the transfer is used to compute SPR and BRDV inside
rzv2h_rspi_setup_clock().

BRDV and SPB are stored in the SPCMD register.

Move the transfer iteration earlier, move the SPR and BRDV writing out
of rzv2h_rspi_setup_clock(), consolidate writing BRDV and SPB into the
initial write to the SPCMD register.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-5-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * remove internal Reviewed-by tags

 drivers/spi/spi-rzv2h-rspi.c | 45 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index a1f17ec8727b..f02f25b98ec6 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -83,6 +83,8 @@ struct rzv2h_rspi_priv {
 	unsigned int bytes_per_word;
 	u32 freq;
 	u16 status;
+	u8 spr;
+	u8 brdv;
 };
 
 #define RZV2H_RSPI_TX(func, type)					\
@@ -263,8 +265,8 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	return 0;
 
 clock_found:
-	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_BRDV, brdv);
-	writeb(spr, rspi->base + RSPI_SPBR);
+	rspi->spr = spr;
+	rspi->brdv = brdv;
 
 	return rzv2h_rspi_calc_bitrate(tclk_rate, spr, brdv);
 }
@@ -283,6 +285,25 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 	/* Make sure SPCR.SPE is 0 before amending the configuration */
 	rzv2h_rspi_spe_disable(rspi);
 
+	list_for_each_entry(xfer, &message->transfers, transfer_list) {
+		if (!xfer->speed_hz)
+			continue;
+
+		speed_hz = min(xfer->speed_hz, speed_hz);
+		bits_per_word = xfer->bits_per_word;
+	}
+
+	if (speed_hz == U32_MAX)
+		return -EINVAL;
+
+	rspi->bytes_per_word = roundup_pow_of_two(BITS_TO_BYTES(bits_per_word));
+
+	rspi->freq = rzv2h_rspi_setup_clock(rspi, speed_hz);
+	if (!rspi->freq)
+		return -EINVAL;
+
+	writeb(rspi->spr, rspi->base + RSPI_SPBR);
+
 	/* Configure the device to work in "host" mode */
 	conf32 = RSPI_SPCR_MSTR;
 
@@ -301,6 +322,8 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 	conf32 = FIELD_PREP(RSPI_SPCMD_CPOL, !!(spi->mode & SPI_CPOL));
 	conf32 |= FIELD_PREP(RSPI_SPCMD_CPHA, !!(spi->mode & SPI_CPHA));
 	conf32 |= FIELD_PREP(RSPI_SPCMD_LSBF, !!(spi->mode & SPI_LSB_FIRST));
+	conf32 |= FIELD_PREP(RSPI_SPCMD_SPB, bits_per_word - 1);
+	conf32 |= FIELD_PREP(RSPI_SPCMD_BRDV, rspi->brdv);
 	conf32 |= FIELD_PREP(RSPI_SPCMD_SSLKP, 1);
 	conf32 |= FIELD_PREP(RSPI_SPCMD_SSLA, spi_get_chipselect(spi, 0));
 	writel(conf32, rspi->base + RSPI_SPCMD);
@@ -316,24 +339,6 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 
 	rzv2h_rspi_clear_fifos(rspi);
 
-	list_for_each_entry(xfer, &message->transfers, transfer_list) {
-		if (!xfer->speed_hz)
-			continue;
-
-		speed_hz = min(xfer->speed_hz, speed_hz);
-		bits_per_word = xfer->bits_per_word;
-	}
-
-	if (speed_hz == U32_MAX)
-		return -EINVAL;
-
-	rspi->bytes_per_word = roundup_pow_of_two(BITS_TO_BYTES(bits_per_word));
-	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_SPB, bits_per_word - 1);
-
-	rspi->freq = rzv2h_rspi_setup_clock(rspi, speed_hz);
-	if (!rspi->freq)
-		return -EINVAL;
-
 	rzv2h_rspi_spe_enable(rspi);
 
 	return 0;
-- 
2.53.0

