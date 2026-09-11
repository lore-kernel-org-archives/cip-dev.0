Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB190C88E58
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40050.1789135315556278189
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:01:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 37DB34395A;
	Fri, 11 Sep 2026 14:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2760C1F000FF;
	Fri, 11 Sep 2026 14:01:53 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 01/14] mmc: renesas_sdhi: remove accessor function for internal_dmac
Date: Fri, 11 Sep 2026 17:01:38 +0300
Message-ID: <20260911140151.2119555-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24133

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit a8687078fc5e7606b3e91f32cb6ba2574d83736d upstream.

This accessor function does not help readability but makes it worse.
Because I soon need to read from the registers as well and don't want to
add another function like this, I chose to remove the existing one and
use the accessor directly. I also switch from writeq to writel because
no 64 bit register is actually involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20221006190452.5316-2-wsa+renesas@sang-en=
gineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 31 +++++--------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
index 149b244ccae8..359ce4703e4d 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -135,13 +135,6 @@ static const struct of_device_id renesas_sdhi_intern=
al_dmac_of_match[] =3D {
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_internal_dmac_of_match);
=20
-static void
-renesas_sdhi_internal_dmac_dm_write(struct tmio_mmc_host *host,
-				    int addr, u64 val)
-{
-	writeq(val, host->ctl + addr);
-}
-
 static void
 renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host, bool e=
nable)
 {
@@ -151,8 +144,7 @@ renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc=
_host *host, bool enable)
 		return;
=20
 	if (!enable)
-		renesas_sdhi_internal_dmac_dm_write(host, DM_CM_INFO1,
-						    INFO1_CLEAR);
+		writel(INFO1_CLEAR, host->ctl + DM_CM_INFO1);
=20
 	if (priv->dma_priv.enable)
 		priv->dma_priv.enable(host, enable);
@@ -164,10 +156,8 @@ renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc=
_host *host) {
=20
 	renesas_sdhi_internal_dmac_enable_dma(host, false);
=20
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_RST,
-					    RST_RESERVED_BITS & ~val);
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_RST,
-					    RST_RESERVED_BITS | val);
+	writel(RST_RESERVED_BITS & ~val, host->ctl + DM_CM_RST);
+	writel(RST_RESERVED_BITS | val, host->ctl + DM_CM_RST);
=20
 	clear_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags);
=20
@@ -250,10 +240,8 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc=
_host *host,
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
=20
 	/* set dma parameters */
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_DTRAN_MODE,
-					    dtran_mode);
-	renesas_sdhi_internal_dmac_dm_write(host, DM_DTRAN_ADDR,
-					    sg_dma_address(sg));
+	writel(dtran_mode, host->ctl + DM_CM_DTRAN_MODE);
+	writel(sg_dma_address(sg), host->ctl + DM_DTRAN_ADDR);
=20
 	host->dma_on =3D true;
=20
@@ -273,8 +261,7 @@ static void renesas_sdhi_internal_dmac_issue_tasklet_=
fn(unsigned long arg)
 	tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
=20
 	/* start the DMAC */
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_DTRAN_CTRL,
-					    DTRAN_CTRL_DM_START);
+	writel(DTRAN_CTRL_DM_START, host->ctl + DM_CM_DTRAN_CTRL);
 }
=20
 static bool renesas_sdhi_internal_dmac_complete(struct tmio_mmc_host *ho=
st)
@@ -355,10 +342,8 @@ renesas_sdhi_internal_dmac_request_dma(struct tmio_m=
mc_host *host,
 	struct renesas_sdhi *priv =3D host_to_priv(host);
=20
 	/* Disable DMAC interrupts, we don't use them */
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_INFO1_MASK,
-					    INFO1_MASK_CLEAR);
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_INFO2_MASK,
-					    INFO2_MASK_CLEAR);
+	writel(INFO1_MASK_CLEAR, host->ctl + DM_CM_INFO1_MASK);
+	writel(INFO2_MASK_CLEAR, host->ctl + DM_CM_INFO2_MASK);
=20
 	/* Each value is set to non-zero to assume "enabling" each DMA */
 	host->chan_rx =3D host->chan_tx =3D (void *)0xdeadbeaf;
--=20
2.43.0


