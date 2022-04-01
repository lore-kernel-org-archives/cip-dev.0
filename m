X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.3615.1648842199155839517
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200"; 
   d="scan'208";a="116465374"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B863A401143F;
	Sat,  2 Apr 2022 04:43:15 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 24/40] mmc: tmio: always restore irq register
Date: Fri,  1 Apr 2022 20:42:18 +0100
Message-Id: <20220401194234.14057-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: <cip-dev.lists.cip-project.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 0751d56ef1f25c4206626dff99445db34dedf437 upstream.

Currently, only SDHI on R-Car Gen2+ reinitializes the irq register
during reset but it should be done on all instances. We can move it from
the SDHI driver to the TMIO core, because we now have the
'sd_irq_mask_all' variable which carries the proper value to use. That
also means we can remove the initialization from tmio_mmc_probe()
because it calls tmio_mmc_reset(), too. We only move that
tmio_mmc_reset() call there a little to ensure 'sd_irq_mask_all' is
properly set.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20210413083137.11171-1-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c |  2 --
 drivers/mmc/host/tmio_mmc_core.c     | 11 ++++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 1783a0a6ee56..8a9d74474768 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -588,8 +588,6 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *ho=
st)
 		renesas_sdhi_scc_reset(host, priv);
 	}
=20
-	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, TMIO_MASK_ALL_RCAR2);
-
 	if (sd_ctrl_read16(host, CTL_VERSION) >=3D SDHI_VER_GEN3_SD) {
 		val =3D sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
 		val |=3D CARD_OPT_EXTOP;
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_c=
ore.c
index 59372de733b2..bb5eb478b6cf 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -192,6 +192,9 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 	if (host->reset)
 		host->reset(host);
=20
+	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_al=
l);
+	host->sdcard_irq_mask =3D host->sdcard_irq_mask_all;
+
 	tmio_mmc_set_bus_width(host, host->mmc->ios.bus_width);
=20
 	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
@@ -1183,13 +1186,11 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		_host->sdio_irq_mask =3D TMIO_SDIO_MASK_ALL;
=20
-	_host->set_clock(_host, 0);
-	tmio_mmc_reset(_host);
-
-	_host->sdcard_irq_mask =3D sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MAS=
K);
 	if (!_host->sdcard_irq_mask_all)
 		_host->sdcard_irq_mask_all =3D TMIO_MASK_ALL;
-	tmio_mmc_disable_mmc_irqs(_host, _host->sdcard_irq_mask_all);
+
+	_host->set_clock(_host, 0);
+	tmio_mmc_reset(_host);
=20
 	if (_host->native_hotplug)
 		tmio_mmc_enable_mmc_irqs(_host,
--=20
2.17.1


