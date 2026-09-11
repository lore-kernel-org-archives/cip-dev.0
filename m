Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D01C88E5C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40070.1789135329931416591
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:02:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4BD3B60A5E;
	Fri, 11 Sep 2026 14:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED741F000FF;
	Fri, 11 Sep 2026 14:02:07 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 11/14] mmc: renesas_sdhi: improve naming of DMA struct
Date: Fri, 11 Sep 2026 17:01:48 +0300
Message-ID: <20260911140151.2119555-12-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24143

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 7f3ea248cd1b2ea9b49f6f3523250bc8e622dd5e upstream.

Commit 058db2868cd8 ("mmc: tmio, renesas_sdhi: move struct tmio_mmc_dma
to renesas_sdhi.h") is correct. The DMA struct should be prefixed with
'renesas_sdhi' to avoid confusion about is namespace. Fix some
indentation while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20221006190452.5316-3-wsa+renesas@sang-en=
gineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h      | 8 ++++----
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_s=
dhi.h
index 604bc52b9c56..444dbd0bb774 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -50,19 +50,19 @@ struct renesas_sdhi_of_data_with_quirks {
 	const struct renesas_sdhi_quirks *quirks;
 };
=20
-struct tmio_mmc_dma {
+struct renesas_sdhi_dma {
 	enum dma_slave_buswidth dma_buswidth;
 	bool (*filter)(struct dma_chan *chan, void *arg);
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
-	struct completion	dma_dataend;
-	struct tasklet_struct	dma_complete;
+	struct completion dma_dataend;
+	struct tasklet_struct dma_complete;
 };
=20
 struct renesas_sdhi {
 	struct clk *clk;
 	struct clk *clk_cd;
 	struct tmio_mmc_data mmc_data;
-	struct tmio_mmc_dma dma_priv;
+	struct renesas_sdhi_dma dma_priv;
 	const struct renesas_sdhi_quirks *quirks;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default, *pins_uhs;
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/rene=
sas_sdhi_core.c
index 0be49d90ed28..4f3b62256754 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -908,7 +908,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 {
 	struct tmio_mmc_data *mmd =3D pdev->dev.platform_data;
 	struct tmio_mmc_data *mmc_data;
-	struct tmio_mmc_dma *dma_priv;
+	struct renesas_sdhi_dma *dma_priv;
 	struct tmio_mmc_host *host;
 	struct renesas_sdhi *priv;
 	int num_irqs, irq, ret, i;
--=20
2.43.0


