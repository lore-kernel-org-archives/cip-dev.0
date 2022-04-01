X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.3732.1648842189396644004
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200"; 
   d="scan'208";a="116465363"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:08 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 710AF40061B8;
	Sat,  2 Apr 2022 04:43:07 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 19/40] mmc: tmio: abort DMA before reset
Date: Fri,  1 Apr 2022 20:42:13 +0100
Message-Id: <20220401194234.14057-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: <cip-dev.lists.cip-project.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit ab0cdefec052825303c05687d9416bafc867fe3d upstream.

We will soon allow resetting the whole IP core via a reset controller.
For this case, DMA must be terminated before the actual reset. For the
other cases, it is probably better, too.

Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20210317091622.31890-2-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_c=
ore.c
index 48083acdb077..0c752b4348de 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -172,11 +172,11 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
 	usleep_range(10000, 11000);
=20
+	tmio_mmc_abort_dma(host);
+
 	if (host->reset)
 		host->reset(host);
=20
-	tmio_mmc_abort_dma(host);
-
 	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
--=20
2.17.1


