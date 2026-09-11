Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C60C88E59
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40064.1789135325703560900
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:02:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 247766025A;
	Fri, 11 Sep 2026 14:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9A01F000FF;
	Fri, 11 Sep 2026 14:02:03 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 08/14] mmc: renesas_sdhi: style fix for proper function bodies
Date: Fri, 11 Sep 2026 17:01:45 +0300
Message-ID: <20260911140151.2119555-9-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24140

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit ed9ab884987bf80e015f0531e10ad1c1af978e09 upstream.

Put the braces to the proper position to make reading the code easier.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20220320124538.62028-1-wsa+renesas@sang-e=
ngineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
index 2f37b6f1f1c1..cd627b9acd02 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -274,7 +274,8 @@ renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc=
_host *host, bool enable)
 }
=20
 static void
-renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host) {
+renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host)
+{
 	u64 val =3D RST_DTRANRST1 | RST_DTRANRST0;
=20
 	renesas_sdhi_internal_dmac_enable_dma(host, false);
@@ -288,7 +289,8 @@ renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_=
host *host) {
 }
=20
 static void
-renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host) {
+renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host)
+{
 	struct renesas_sdhi *priv =3D host_to_priv(host);
=20
 	tasklet_schedule(&priv->dma_priv.dma_complete);
--=20
2.43.0


