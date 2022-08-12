X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.8954.1660299214547583633
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:13:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,231,1654527600"; 
   d="scan'208";a="129340341"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Aug 2022 19:13:39 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0CBB0424396E;
	Fri, 12 Aug 2022 19:13:37 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/11] spi: spi-rspi: Drop redeclaring ret variable in qspi_transfer_in()
Date: Fri, 12 Aug 2022 11:13:16 +0100
Message-Id: <20220812101317.12380-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

commit 1d734f592e1a1d41af80e90001d109cec1c98fb4 upstream.

"ret" variable is already declared in qspi_transfer_in() at the
beginning of function, drop redeclaring ret in the if block, fixing
below:

spi-rspi.c: In function ‘qspi_transfer_in’:
spi-rspi.c:838:7: warning: declaration of ‘ret’ shadows a previous local
  838 |   int ret = rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
      |       ^~~
spi-rspi.c:835:6: note: shadowed declaration is here
  835 |  int ret;

Fixes: db30083813b55 ("spi: rspi: avoid uninitialized variable access")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211118031041.2312-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index e5efa0aab5a7..7a014eeec2d0 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -835,7 +835,7 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 	int ret;
 
 	if (rspi->ctlr->can_dma && __rspi_can_dma(rspi, xfer)) {
-		int ret = rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
+		ret = rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
 		if (ret != -EAGAIN)
 			return ret;
 	}
-- 
2.17.1


