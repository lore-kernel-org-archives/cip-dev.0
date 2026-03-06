Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7EEFCB62E
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:00:21 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73802.1772816412211779145
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:00:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: ot2VYQgdRSeFoJ4R5fU+5g==
X-CSE-MsgGUID: PAPeVxrURj2w01axm+02JA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 07 Mar 2026 02:00:16 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.180])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 47E004004BAF;
	Sat,  7 Mar 2026 02:00:15 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 05/17] spi: rzv2h-rspi: make resets optional
Date: Fri,  6 Mar 2026 18:59:06 +0200
Message-ID: <20260306165918.209377-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306165918.209377-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260306165918.209377-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22111

commit aead5ae91e4cbadac817d15737eca3b531237448 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs don't have
reset lines for the SPI peripheral, make them optional to prepare for
adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-2-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index dcc431ba60a9..09b9362e9b1f 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -384,8 +384,8 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 
 	rspi->resets[0].id = "presetn";
 	rspi->resets[1].id = "tresetn";
-	ret = devm_reset_control_bulk_get_exclusive(dev, RSPI_RESET_NUM,
-						    rspi->resets);
+	ret = devm_reset_control_bulk_get_optional_exclusive(dev, RSPI_RESET_NUM,
+							     rspi->resets);
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot get resets\n");
 
-- 
2.53.0


