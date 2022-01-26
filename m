Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD81C5DF62
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 20:22:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.18528.1643228538730755457
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 12:22:19 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,319,1635174000";
   d="scan'208";a="107767488"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Jan 2022 05:22:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id ED16E4010904;
	Thu, 27 Jan 2022 05:22:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe(): make
 sure we free CAN network device
Date: Wed, 26 Jan 2022 20:22:13 +0000
Message-Id: <20220126202213.31975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 20:22:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7489

commit 72b1e360572f9fa7d08ee554f1da29abce23f288 upstream.

Make sure we free CAN network device in the error path. There are
several jumps to fail label after allocating the CAN network device
successfully. This patch places the free_candev() under fail label so
that in failure path a jump to fail label frees the CAN network
device.

Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
Link: https://lore.kernel.org/all/20220106114801.20563-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 52629c6c1970..6c8e7a51b04d 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1640,8 +1640,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	ndev = alloc_candev(sizeof(*priv), RCANFD_FIFO_DEPTH);
 	if (!ndev) {
 		dev_err(&pdev->dev, "alloc_candev() failed\n");
-		err = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 	priv = netdev_priv(ndev);
 
@@ -1735,8 +1734,8 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
 fail_candev:
 	netif_napi_del(&priv->napi);
-	free_candev(ndev);
 fail:
+	free_candev(ndev);
 	return err;
 }
 
-- 
2.17.1


