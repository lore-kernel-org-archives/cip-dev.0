Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B5CD6E2BD
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:07 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1401.1766076964092323102
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jx1sMBzg;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47755de027eso5587905e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076962; x=1766681762; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlaHtiq4sKC1X21JNWWLd3PSFv6E1zc/Sg/8Cs8KU8s=;
        b=jx1sMBzgTPTVL1urYBgVN6q2wyZU/Xuy3kcAcO8cj4DQ7WNZZq3HwNKuO04hbDRxuM
         JA610YebPdkTObJKsXzQLNKM8nkQKN8ZPEt7/e+W+/6NB+uMGaLWvAXOPWclSxDWAB4f
         QzoG+zLVGLLLc0uf0wD1T1kRNZ0nMtAEKtbSFi6a+4aeuXITPj8ToKHkfg+ZsjJ2pMOL
         skNYQQSdqXjBzQj7chc2V90eI55HEFhfkr5fw5C3KkkvUphOvl/ODhQH0yWoY18axHL7
         6AUwDtnYC2Y+V8cCHGn5Ur7NrAIP/GpmYH7ladVELXRAN3bGf/gqYDA3UMo6U3KNs/vq
         egEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076962; x=1766681762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wlaHtiq4sKC1X21JNWWLd3PSFv6E1zc/Sg/8Cs8KU8s=;
        b=s6pNFIUYVvI99ufyUkqgwz/PyxjX556KcL4yddONdgA6suGTrDgkDSg25TWN1UqXJ0
         JWjh9MiSsMuIW0JL7q8MW978t4AWccKozSa5wxxSnaj2Vb5s9ttyhJvnihSFOfJEnApb
         DLG43K8jqAIWbuQKO8llFs5mxlVncwYfEjFnSWYpPi32jahUT31UyBZBdnJer8ecs0o7
         cxQp95Vggecn2etEFFVP6tMdeVz/6xchPoY9lQHpzVeh1cFy+NZ2esNmd6dEZB9LC6bY
         68Lz/1p6aywpQdl/foBxwP/DU0SMuspMaJiuCEFzpkYFdPP8HYHfAnsXT6EWu20h7DAG
         b+XA==
X-Gm-Message-State: AOJu0Yz/j6HYiJ0aWurfFteqfRdir2lKCUYsktKtaMxvD3vXkn4w5p2z
	hvn3nOs7M/VeI7/p/gGcf90Km/tOiQiDGfJkDuR+DM1EWJ65iQE/68vT+B6EjA==
X-Gm-Gg: AY/fxX50Cn5tCOp5z92TuP6rtiouMVaw0TBIoaK64xfNdICLXI8e4g9vbE8Gb1F7f9c
	+bLk+acheadFNPzu5xhrqZ6Q7xETIGvIOSdtBl4KoXjuQZPf5Dm/vZUkL99kG+br94JjiBnNjDM
	cD5xnQPX1Kgl4BUSwE4C8/txosGv3HuL0FizxvRJA4qcEl4dXulO0F4NIbL9V5YCzhTyI18xyz4
	9zQXS1SrKNzMmd4DPEbkboJ89WXVDZQ0EBIHWxgwmeteRwf+xmChp9QMjqbnephY314EOVfzVcm
	/3ePd3aqFhR0wYbSCXGX1xoAzP1HqiZpXqBfS0m8GLAUbkygRE1f7AJr5pXqo2oJLbzits5fYdy
	FqaJNSYYLutccTD46xntDVysgN9I4DIimjKE//46AQyy52oinsdrxRkCamJJZbOG5ipF+TKk57v
	CIFzvpCRRxQ6mL1DqHEg==
X-Google-Smtp-Source: AGHT+IFy89cA1bSE9OidAiiAy4GRg1jOmauY5lH6oqCTkLTpgRVNIVenPD9A4H5cMU/v0NC5LDcnYw==
X-Received: by 2002:a05:600c:4e49:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-47a8f90c3ebmr234483545e9.30.1766076962126;
        Thu, 18 Dec 2025 08:56:02 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:01 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/24] can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
Date: Thu, 18 Dec 2025 16:55:02 +0000
Message-ID: <20251218165600.258194-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21141

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
index 282187d5387c..6c059d5d9cf6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1686,7 +1686,8 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 
 static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 {
-	struct net_device_stats *stats = &priv->ndev->stats;
+	struct net_device *ndev = priv->ndev;
+	struct net_device_stats *stats = &ndev->stats;
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
@@ -1702,14 +1703,13 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 
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
@@ -1730,7 +1730,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 
 		if (sts & RCANFD_RFFDSTS_RFESI) {
 			cf->flags |= CANFD_ESI;
-			netdev_dbg(priv->ndev, "ESI Error\n");
+			netdev_dbg(ndev, "ESI Error\n");
 		}
 
 		if (!(sts & RCANFD_RFFDSTS_RFFDF) && (id & RCANFD_RFID_RFRTR)) {
-- 
2.43.0


