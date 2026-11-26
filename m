Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15965.1795706529975779299
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C435244709;
	Thu, 26 Nov 2026 15:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1001F000C6;
	Thu, 26 Nov 2026 15:22:08 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 02/27] dmaengine: sh: rz-dmac: handle configs where one address is zero
Date: Thu, 26 Nov 2026 17:21:38 +0200
Message-ID: <20261126152204.1297798-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25112
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 6e9c5c8ef2820d18492d07172ac52f23ea8a54d9 upstream.

Configs like the ones coming from the MMC subsystem will have either
'src' or 'dst' zeroed, resulting in an unknown bus width. This will bail
out on the RZ DMA driver because of the sanity check for a valid bus
width. Reorder the code, so that the check will only be applied when the
corresponding address is non-zero.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20241007110200.43166-6-wsa+renesas@sang-e=
ngineering.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 18b12cba3a34..6cf60c11a355 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -606,22 +606,25 @@ static int rz_dmac_config(struct dma_chan *chan,
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
 	u32 val;
=20
-	channel->src_per_address =3D config->src_addr;
 	channel->dst_per_address =3D config->dst_addr;
-
-	val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
-	if (val =3D=3D CHCFG_DS_INVALID)
-		return -EINVAL;
-
 	channel->chcfg &=3D ~CHCFG_FILL_DDS_MASK;
-	channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
+	if (channel->dst_per_address) {
+		val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
+		if (val =3D=3D CHCFG_DS_INVALID)
+			return -EINVAL;
=20
-	val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
-	if (val =3D=3D CHCFG_DS_INVALID)
-		return -EINVAL;
+		channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
+	}
=20
+	channel->src_per_address =3D config->src_addr;
 	channel->chcfg &=3D ~CHCFG_FILL_SDS_MASK;
-	channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
+	if (channel->src_per_address) {
+		val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
+		if (val =3D=3D CHCFG_DS_INVALID)
+			return -EINVAL;
+
+		channel->chcfg |=3D FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
+	}
=20
 	return 0;
 }
--=20
2.43.0

