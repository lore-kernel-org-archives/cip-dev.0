Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFD7C88E5B
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40065.1789135326589002372
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:02:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 64A2A42E97;
	Fri, 11 Sep 2026 14:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F77A1F000FF;
	Fri, 11 Sep 2026 14:02:05 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 09/14] mmc: renesas_sdhi: Add missing checks for the presence of quirks
Date: Fri, 11 Sep 2026 17:01:46 +0300
Message-ID: <20260911140151.2119555-10-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24141

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 139bbdba494b0ba8ba5304db747d7f136ca9ad66 upstream.

When running on an system without any quirks (e.g. R-Car V3U), the
kernel crashes with a NULL pointer dereference:

    Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000002
    ...
    Hardware name: Renesas Falcon CPU and Breakout boards based on r8a779=
a0 (DT)
    Workqueue: events_freezable mmc_rescan
    ...
    Call trace:
     renesas_sdhi_internal_dmac_start_dma+0x54/0x12c
     tmio_process_mrq+0x124/0x274

Fix this by adding the missing checks for the validatity of the
priv->quirks pointer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/cc3178c2ff60f640f4d5a071d51f6b0b1db37656.=
1648822020.git.geert+renesas@glider.be
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
index cd627b9acd02..f080a75fa752 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -348,7 +348,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_=
host *host,
 	struct scatterlist *sg =3D host->sg_ptr;
 	u32 dtran_mode =3D DTRAN_MODE_BUS_WIDTH;
=20
-	if (!priv->quirks->fixed_addr_mode)
+	if (!(priv->quirks && priv->quirks->fixed_addr_mode))
 		dtran_mode |=3D DTRAN_MODE_ADDR_MODE;
=20
 	if (!renesas_sdhi_internal_dmac_map(host, data, COOKIE_MAPPED))
@@ -356,7 +356,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_=
host *host,
=20
 	if (data->flags & MMC_DATA_READ) {
 		dtran_mode |=3D DTRAN_MODE_CH_NUM_CH1;
-		if (priv->quirks->dma_one_rx_only &&
+		if (priv->quirks && priv->quirks->dma_one_rx_only &&
 		    test_and_set_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags))
 			goto force_pio_with_unmap;
 	} else {
--=20
2.43.0


