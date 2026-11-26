Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15969.1795706538154242970
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E6C8143283;
	Thu, 26 Nov 2026 15:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5C11F000C0;
	Thu, 26 Nov 2026 15:22:16 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 07/27] dmaengine: sh: rz-dmac: Drop goto instruction and label
Date: Thu, 26 Nov 2026 17:21:43 +0200
Message-ID: <20261126152204.1297798-8-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25117
Content-Type: text/plain; charset="utf-8"

commit 7badd294fc82629378b153327c57b8ba453688c7 upstream.

There is no need to jump to the done label, so return immediately.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-5-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict in rz_dmac_irq_handle_channel()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index e0f8c4f462a8..5086e1e19200 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -689,7 +689,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac=
_chan *channel)
 		spin_lock_irqsave(&channel->vc.lock, flags);
 		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
 		spin_unlock_irqrestore(&channel->vc.lock, flags);
-		goto done;
+		return;
 	}
=20
 	/*
@@ -697,8 +697,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac=
_chan *channel)
 	 * zeros to CHCTRL is just ignored by HW.
 	 */
 	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
-done:
-	return;
 }
=20
 static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
--=20
2.43.0

