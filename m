Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16112.1795706773714035162
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:26:13 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 21E5B6369A;
	Thu, 26 Nov 2026 15:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0718C1F000C0;
	Thu, 26 Nov 2026 15:26:11 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 10/11] dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last descriptor
Date: Thu, 26 Nov 2026 17:25:52 +0200
Message-ID: <20261126152553.1298561-11-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
References: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:26:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25148
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cd2d36e8ae61832aaac3bddf5aafdab72821e6b9 upstream.

On an RZ/G2L-based system, it has been observed that when the DMA channel=
s
for all enabled IPs are active (TX and RX for one serial IP, TX and RX fo=
r
one audio IP, and TX and RX for one SPI IP), shortly after all of them ar=
e
started, the system can become irrecoverably blocked. In one debug sessio=
n
the system did not block, and the DMA HW registers were inspected. It was
found that the DER (Descriptor Error) bit in the CHSTAT register for one =
of
the SPI DMA channels was set.

According to the RZ/G2L HW Manual, Rev. 1.30, chapter 14.4.7 Channel
Status Register n/nS (CHSTAT_n/nS), description of the DER bit, the DER
bit is set when the LV (Link Valid) value loaded with a descriptor in lin=
k
mode is 0. This means that the DMA engine has loaded an invalid
descriptor (as defined in Table 14.14, Header Area, of the same manual).

The same chapter states that when a descriptor error occurs, the transfer
is stopped, but no DMA error interrupt is generated.

Set the LE bit on the last descriptor of a transfer. This informs the DMA
engine that this is the final descriptor for the transfer.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-19-claudiu.beznea@k=
ernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 5d5109510110..547e14d2b6e6 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -185,6 +185,7 @@ struct rz_dmac {
=20
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_LE			BIT(1)
 #define HEADER_WBD			BIT(2)
=20
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
@@ -354,7 +355,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz=
_dmac_chan *channel)
 	lmdesc->chcfg =3D chcfg;
 	lmdesc->chitvl =3D 0;
 	lmdesc->chext =3D 0;
-	lmdesc->header =3D HEADER_LV;
+	lmdesc->header =3D HEADER_LV | HEADER_LE;
=20
 	rz_dmac_set_dmars_register(dmac, channel->index, 0);
=20
@@ -397,7 +398,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct=
 rz_dmac_chan *channel)
 		lmdesc->chext =3D 0;
 		if (i =3D=3D (sg_len - 1)) {
 			lmdesc->chcfg =3D (channel->chcfg & ~CHCFG_DEM);
-			lmdesc->header =3D HEADER_LV;
+			lmdesc->header =3D HEADER_LV | HEADER_LE;
 		} else {
 			lmdesc->chcfg =3D channel->chcfg;
 			lmdesc->header =3D HEADER_LV;
--=20
2.43.0

