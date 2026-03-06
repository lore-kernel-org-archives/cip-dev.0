Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39508FCC049
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:18:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74548.1772817507868725562
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:18:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: wWgStraBRVywXe2bP3GhlA==
X-CSE-MsgGUID: Mg5Z0elLTDK8kb3jGzGJnw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 02:18:40 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9BA724031C01;
	Sat,  7 Mar 2026 02:18:39 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v2 09/17] spi: rzv2h-rspi: avoid recomputing transfer frequency
Date: Fri,  6 Mar 2026 19:17:27 +0200
Message-ID: <20260306171735.226034-10-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:18:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22134

commit 88782493204512fcf4e020e2385bca3e3c5bd4c0 upstream.

Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a more
complicated algorithm for calculating the optimal SPI transfer frequency
compared to RZ/V2H, as the clock from which the SPI frequency is
generated supports multiple dividers.

Cache the requested transfer frequency and skip calling
rzv2h_rspi_setup_clock() if it matches the last used one to prepare for
adding support for variable clock frequency handling.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-6-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * remove internal Reviewed-by tags

 drivers/spi/spi-rzv2h-rspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index f02f25b98ec6..d7719f3c7b13 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -81,6 +81,7 @@ struct rzv2h_rspi_priv {
 	struct clk *tclk;
 	wait_queue_head_t wait;
 	unsigned int bytes_per_word;
+	u32 last_speed_hz;
 	u32 freq;
 	u16 status;
 	u8 spr;
@@ -298,9 +299,13 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 
 	rspi->bytes_per_word = roundup_pow_of_two(BITS_TO_BYTES(bits_per_word));
 
-	rspi->freq = rzv2h_rspi_setup_clock(rspi, speed_hz);
-	if (!rspi->freq)
-		return -EINVAL;
+	if (speed_hz != rspi->last_speed_hz) {
+		rspi->freq = rzv2h_rspi_setup_clock(rspi, speed_hz);
+		if (!rspi->freq)
+			return -EINVAL;
+
+		rspi->last_speed_hz = speed_hz;
+	}
 
 	writeb(rspi->spr, rspi->base + RSPI_SPBR);
 
-- 
2.53.0

