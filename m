Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9CCE6748D
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:10 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78272.1766402229630983774
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PsZFUpah;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79ea617f55so672393066b.3
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402228; x=1767007028; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnIokrrTJrHZJUpZ9DQS9XuPcFE+dzteuo61OBOtYHc=;
        b=PsZFUpahJVeDXTh4nGA2EA5XzV48vpOjqplGUegH/KVLCYtv38oA5nE07RN0E3xM0O
         +1nRKNJ9rWGwhr6kuNjLKsOp0V3RgGeVsiI6ZvfdagXbPthLB+/GRgiSGVzU51k2KIby
         T7crGU11+UEZEKwQowjShCOo7H+gUzRyRn+Q6kEi0b7pMVGU68mauJaHnIrloICiWV4E
         bmw4+y/p7O/ssxB/wS6fQkrvgNoZ4376hBYa1b9sOByeKkXIWgc4ys7AIc3t4mbAnGaJ
         Hosr1BGx83yOyM3ADrMSqwXrbMnyPY9jB6iSiJ/9aRfp2rwrahEbi1c7N+6HDVejcpqi
         VEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402228; x=1767007028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SnIokrrTJrHZJUpZ9DQS9XuPcFE+dzteuo61OBOtYHc=;
        b=WY+Oiw+7Itggw4LCeTBP+xQmg6eebTNkJ3yf7CNgTiGZM0POLUihZaKb17kl4jw0kF
         db6T3hIGsNdLzQqVtIMJ8AXygV2r3wQ8CJfLc6pW5NlFTHJx+9/pCjGJigGj9dPbAMqv
         mwt22P9g8zQ3zH0Te4RbRlAFJZVrG283WyN5MBhLXkjOZF6GvEySvNNiT2dfJVZYCqmh
         cywi2pdg92MjjkIW/Gxy2+HCPkGS6TmQQp90P5aughZLz94imI6H9Hqc9VOWBmL6bGyS
         oOOpCzQkmdepZckKL0f8ybrLJQJVJPIJGH7QXbj26EMABbZ05Thn564AaxgiuvNFvpez
         greg==
X-Gm-Message-State: AOJu0YwGS3q65XRYcFHSI5UNpE/1s1TOxyblTHYcaF6bvh/KDsFY4xCQ
	oQevt5jskVxEsGhpmbkUlqZHhDgK7c00MKPkJeMlJAvrgk5Xiw6F9ErRCtB5FQ==
X-Gm-Gg: AY/fxX7n4IcltJuqNDgAUwPRQvUyI/uFmK1hAEMaekqnHqALDPCSW4jDrppVGOfMZ/e
	/bFXDpOA5A1JV+qqO5OvADnXedjRjI+jbqGDMmQrBNRQb1WL/Y1rQhuBPzfxxhXPp51f7XYrta6
	ngXbgGlBlZH5MRfbxiaaS0O10jFftnk7BE1wbHdYa0Xj0V3JyPRuui3NOsU1OhK4qTebFpa8dtZ
	wdfKoHueWil+uLvOGpixCTN+7qmI1520xdKOZLOqXJG+WMh0GC+iKDZDMzP91/2izfdDaahCxoN
	KfdAUNzTnqOsj/yVjNeBO8Z9kmSue/naFynryHjlfmCmxqC2XpETJv9s5OswtyTgMd/gNkwjBWw
	+cLiA3UL3I3caV6E2tSsIOe5jQbfxF9BtNOayUDB/okA3/iTn5N918i0xGJPNhmaz1ggwGPA4wv
	sILx60L1VECh+83ZE7YRCir2oE0ezPoPUkG0I=
X-Google-Smtp-Source: AGHT+IGDb2oRnPvo3nb0Fo4C1DMqKGo3bZaUWAx/hkj7CdGp9aB8c58cOKU+xPaHFVbvxaaRR4/gHg==
X-Received: by 2002:a17:906:9fc7:b0:b6d:9bab:a7ba with SMTP id a640c23a62f3a-b8037178753mr1139621666b.42.1766402227573;
        Mon, 22 Dec 2025 03:17:07 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:07 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/24] can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
Date: Mon, 22 Dec 2025 11:16:35 +0000
Message-ID: <20251222111705.27028-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21189

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 4e5974f5515bf631f4f39c3f53f5bdb8ba7746a3 ]

rcar_canfd_rx_pkt() has many users of "priv->ndev".  Introduce a
shorthand to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/22afe32a65f7c3e64ce3917aec943ac24d6e185a.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 11a1d1b992c6..0427219b4564 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1685,7 +1685,8 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 
 static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 {
-	struct net_device_stats *stats = &priv->ndev->stats;
+	struct net_device *ndev = priv->ndev;
+	struct net_device_stats *stats = &ndev->stats;
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
@@ -1701,14 +1702,13 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 
 		if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) &&
 		    sts & RCANFD_RFFDSTS_RFFDF)
-			skb = alloc_canfd_skb(priv->ndev, &cf);
+			skb = alloc_canfd_skb(ndev, &cf);
 		else
-			skb = alloc_can_skb(priv->ndev,
-					    (struct can_frame **)&cf);
+			skb = alloc_can_skb(ndev, (struct can_frame **)&cf);
 	} else {
 		id = rcar_canfd_read(priv->base, RCANFD_C_RFID(ridx));
 		dlc = rcar_canfd_read(priv->base, RCANFD_C_RFPTR(ridx));
-		skb = alloc_can_skb(priv->ndev, (struct can_frame **)&cf);
+		skb = alloc_can_skb(ndev, (struct can_frame **)&cf);
 	}
 
 	if (!skb) {
@@ -1729,7 +1729,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 
 		if (sts & RCANFD_RFFDSTS_RFESI) {
 			cf->flags |= CANFD_ESI;
-			netdev_dbg(priv->ndev, "ESI Error\n");
+			netdev_dbg(ndev, "ESI Error\n");
 		}
 
 		if (!(sts & RCANFD_RFFDSTS_RFFDF) && (id & RCANFD_RFID_RFRTR)) {
-- 
2.43.0


