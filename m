Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612FEC47BF5
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88168.1767699902720531712
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UGq39MSt;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so5533145e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699901; x=1768304701; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZaipRN7jVU+yWzB97HP/+GlbsmQoZLbxqUjQFLJAwg=;
        b=UGq39MStM7G0sh7FGlnFjX9m8VWpSsv3/0RDHnBIx8JIloWYn0W8SwyvpuZTh/FJDM
         RMyBKzsa4lBWz5YGmLczasyuT9MscqG2Z30vHBZvATAVwwHi3qXOTXBg9PtL1lWyqX38
         Ni52M7uFdxlWZ+8c4Vgi6x9y18cHmDQZ4heXGsmVpfWuS8uj4HrQXtUfLKLSvyk+NC7R
         y992OpCODc5XtEhJUy9bV8anPZVVng4c4gUG/IyoPWSVerdnJzkuCEjIG1BUj48GEach
         +QSlZ46hECnQITRUwsqKjEM28SQPf1MfjOGi8AezcraEpmTvFPDWAWhrv3Syl76ZiMOK
         iJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699901; x=1768304701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZaipRN7jVU+yWzB97HP/+GlbsmQoZLbxqUjQFLJAwg=;
        b=q8mDCRF2NouxVoWNCSDVu6KfQBbvjUdGoiz4OA/WTcExY9PpOuhiRNXTZwGe5lrL5h
         hpT7KRrVpnU8Gco7vcSrTnw/TQeXUPh77iRNj2qvqHc6rGXV3iiaPPYccHeLMsxxk9Dj
         0HxcHGyWILrRn25+3CvJgl+lcMorOi/PzhRsHwbzRbAzhWp6x2lE+/ACZ7Sfcx0vYETk
         Abwn6vmiJWt3yctgW949QXJejc4qp6WMOkvGw7CcltqLIp42X2pbKxY0dX54AQuMpTTQ
         qcVaPEoCQmqPZ3z3NV0QyraBs69ijcIGCRZaT5JKuasNiA6gKhP6ll1C3Czcn00I5v0K
         J7lw==
X-Gm-Message-State: AOJu0YzsXPosom22TMGj4mOPxX0J4tJThtx4pGEXRy5Y+1DxsmmXTSsY
	yjofqGcG256C0r2O9nqSCn0/Ny8NQ0ej9H8ryLB0N8xHwlprn/dY9EcSViUkyg==
X-Gm-Gg: AY/fxX7Tvwxp1bngZbFa7XYkfMkYHu3+2xf56mE30gUSsG8HRwPwyXxuHoq0WXarD7Q
	E6AOpPi7ONbcpIcegnUObD88DIFNR5k2VfgCerKSi1csAb7NF4m3XfVAJu+Y22GUDTZhDBfHN7E
	S1R5Notbin9B+uyATp7rALc/710lNNYPeZafMqZY4/e941pBRAp3MwY8ItAdbfoFdFPC22VzPMJ
	vXIcv/dXXR93babTdfvyyskCFDqXsPN0AcGuC/RTsj4J57H+0SDw2fAhAVXfxtFv67fxiWDhw+S
	QXVo1vSbJisMtEXcNZEuZsklx0rEKPbSWPtmS1suimoOxD0xT1YCGV7aiUqCA5R4+0zTsbp7z8D
	LA5uttYkSjZwmY492juAR6Fffr6JuuWDKWlmsWfR5UZYTlBnjZb80swStja//seJZ5VWN0qIpVj
	85M2K7rPr3BZV5tQkdU7kDM7CfObUC
X-Google-Smtp-Source: AGHT+IEApLMRWTFpKurnXTpdA9oNMgTJAxZ72/u3xnc7E2d2O+l1e7bo44b/eD59Ne6zMl0ffCerCQ==
X-Received: by 2002:a05:600c:154c:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d7f098beamr30276985e9.22.1767699900829;
        Tue, 06 Jan 2026 03:45:00 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:00 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 03/24] can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
Date: Tue,  6 Jan 2026 11:44:26 +0000
Message-ID: <20260106114458.122333-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21335

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
index fe72f7680fbd..9b40b787d913 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1692,7 +1692,8 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 
 static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 {
-	struct net_device_stats *stats = &priv->ndev->stats;
+	struct net_device *ndev = priv->ndev;
+	struct net_device_stats *stats = &ndev->stats;
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
@@ -1708,14 +1709,13 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 
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
@@ -1736,7 +1736,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 
 		if (sts & RCANFD_RFFDSTS_RFESI) {
 			cf->flags |= CANFD_ESI;
-			netdev_dbg(priv->ndev, "ESI Error\n");
+			netdev_dbg(ndev, "ESI Error\n");
 		}
 
 		if (!(sts & RCANFD_RFFDSTS_RFFDF) && (id & RCANFD_RFID_RFRTR)) {
-- 
2.43.0


