Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15997.1795706547681210337
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 15DAA6131B;
	Thu, 26 Nov 2026 15:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABCF1F000C4;
	Thu, 26 Nov 2026 15:22:25 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 13/27] dmaengine: sh: rz-dmac: Fix incorrect NULL check for list_first_entry()
Date: Thu, 26 Nov 2026 17:21:49 +0200
Message-ID: <20261126152204.1297798-14-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25123
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5fbf3a2a3b96ef5810e6e0fbc601f82067629bc5 upstream.

list_first_entry() does not return NULL when the list is empty,
making the existing NULL check invalid. Use list_first_entry_or_null()
instead.

Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() call=
back")
Cc: stable@vger.kernel.org
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-3-claudiu.beznea@ke=
rnel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 61300845968f..83499f481821 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -705,8 +705,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_ch=
an *channel,
 	u32 crla, crtb, i;
=20
 	/* Get current processing virtual descriptor */
-	current_desc =3D list_first_entry(&channel->ld_active,
-					struct rz_dmac_desc, node);
+	current_desc =3D list_first_entry_or_null(&channel->ld_active,
+						struct rz_dmac_desc, node);
 	if (!current_desc)
 		return 0;
=20
--=20
2.43.0

