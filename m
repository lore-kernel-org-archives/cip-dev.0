Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15964.1795706529638906229
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3817B6363A;
	Thu, 26 Nov 2026 15:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB2C1F000C0;
	Thu, 26 Nov 2026 15:22:06 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 01/27] dmaengine: sh: rz-dmac: Avoid format-overflow warning
Date: Thu, 26 Nov 2026 17:21:37 +0200
Message-ID: <20261126152204.1297798-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25111

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c4d6dcb3b6250ea546a952ad33382daf7cd32425 upstream.

The max channel count for RZ DMAC is 16, hence use u8 instead of unsigned
int and make the pdev_irqname string long enough to avoid the warning.

This fixes the below issue:
drivers/dma/sh/rz-dmac.c: In function =E2=80=98rz_dmac_probe=E2=80=99:
drivers/dma/sh/rz-dmac.c:770:34: warning: =E2=80=98%u=E2=80=99 directive =
writing between 1 and 10 bytes into a region of size 3 [-Wformat-overflow=
=3D]
  770 |         sprintf(pdev_irqname, "ch%u", index);
      |                                  ^~
In function =E2=80=98rz_dmac_chan_probe=E2=80=99,
    inlined from =E2=80=98rz_dmac_probe=E2=80=99 at drivers/dma/sh/rz-dma=
c.c:910:9:
drivers/dma/sh/rz-dmac.c:770:31: note: directive argument in the range [0=
, 4294967294]
  770 |         sprintf(pdev_irqname, "ch%u", index);
      |                               ^~~~~~
drivers/dma/sh/rz-dmac.c:770:9: note: =E2=80=98sprintf=E2=80=99 output be=
tween 4 and 13 bytes into a destination of size 5
  770 |         sprintf(pdev_irqname, "ch%u", index);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While at it use scnprintf() instead of sprintf() to make the code
more robust.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240110222717.193719-1-prabhakar.mahadev=
-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 71c37d5e3227..18b12cba3a34 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -760,11 +760,11 @@ static struct dma_chan *rz_dmac_of_xlate(struct of_=
phandle_args *dma_spec,
=20
 static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 			      struct rz_dmac_chan *channel,
-			      unsigned int index)
+			      u8 index)
 {
 	struct platform_device *pdev =3D to_platform_device(dmac->dev);
 	struct rz_lmdesc *lmdesc;
-	char pdev_irqname[5];
+	char pdev_irqname[6];
 	char *irqname;
 	int ret;
=20
@@ -772,7 +772,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	channel->mid_rid =3D -EINVAL;
=20
 	/* Request the channel interrupt. */
-	sprintf(pdev_irqname, "ch%u", index);
+	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
 	channel->irq =3D platform_get_irq_byname(pdev, pdev_irqname);
 	if (channel->irq < 0)
 		return channel->irq;
@@ -850,9 +850,9 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
 	struct dma_device *engine;
 	struct rz_dmac *dmac;
 	int channel_num;
-	unsigned int i;
 	int ret;
 	int irq;
+	u8 i;
=20
 	dmac =3D devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
 	if (!dmac)
--=20
2.43.0

