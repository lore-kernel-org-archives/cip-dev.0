Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97849C88E45
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40059.1789135322244269747
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:02:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DDCED60234;
	Fri, 11 Sep 2026 14:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1EC1F000FF;
	Fri, 11 Sep 2026 14:01:59 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 05/14] mmc: renesas_sdhi: remove a stale comment
Date: Fri, 11 Sep 2026 17:01:42 +0300
Message-ID: <20260911140151.2119555-6-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24138

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 254b7d1299eb4876821d62cb957bf6f6434c1074 upstream.

The whitelist has been refactored away with a0fb3fc8af01 ("mmc:
renesas_sdhi: remove whitelist for internal DMAC") so the comment
doesn't make any sense anymore.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220320123016.57991-5-wsa+renesas@sang-e=
ngineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
index 1e176e0b98ed..cd328af38b15 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -487,10 +487,6 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_in=
ternal_dmac_dma_ops =3D {
 	.end =3D renesas_sdhi_internal_dmac_end_dma,
 };
=20
-/*
- * Whitelist of specific R-Car Gen3 SoC ES versions to use this DMAC
- * implementation as others may use a different implementation.
- */
 static const struct soc_device_attribute soc_dma_quirks[] =3D {
 	{ .soc_id =3D "r7s9210",
 	  .data =3D (void *)BIT(SDHI_INTERNAL_DMAC_ADDR_MODE_FIXED_ONLY) },
--=20
2.43.0


