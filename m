Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB3AE67496
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:10 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78270.1766402228865191143
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fNhwUGNY;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7636c96b9aso665627866b.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402227; x=1767007027; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvL9EgCjI1XRmph+UveXFhoqrHF+rv84pHAYClmNF1Y=;
        b=fNhwUGNY3u+fGCkw/beGi3NfIkukcL889U2idr4J3WD883j53B814SDErOrIr2Y0pN
         XJZjrF6yrqYQ+XK5wXpgD8aqz/zrvyI3j0SSE3QcEM324wEgPVfOvtbzCGhb4VDB2y+f
         F4U07Mw82ywJ+53vsGYjrWRsA3BEIv50344IL8OqZN7dsjODkl6VkCwcqVGyo/baRsJK
         puSrLANWMcUTVhwTFezC164SvOhsIa29U/MtyJMG+/nkPFXNoJDk0g+DzbXZG/8IIt5+
         D1JJYnr4tsZeB8uRDSa+bE7u5gjta4tmKPB6yocSB+2zkA7cJTLK6v4HO9803AX+Z8rg
         +V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402227; x=1767007027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gvL9EgCjI1XRmph+UveXFhoqrHF+rv84pHAYClmNF1Y=;
        b=QzxXiE0Fwo0noGcRNhxIacJwBAihkwXaEK7BXRuiBGmX4T2f95Upn6d7ogGj4jvKyt
         8bAfzmfR8nmATfOFU9DzS6QRLToHv0IPylNjudYcBsKpqUlIyUo+yBtY9WYZqLfv2Wre
         OV0uSQzAGFjRtPkyXrWhe35ftkIOVrlZJGrJo8CJ5uPTBjksdnHdMpO3xLBLMQZ6PD3g
         xFmr+MviHTqEJkX/yY2P/N5JxwFPAJIqUI9AUzvLglQx2zK2iTDckTEl/BtWKuEZYRsT
         08T2YS6+RFABhfnyacoJXk43KXCGNPTKp7555HMC8iw/7JGNsf52l066mKvRI9fNLVpJ
         EeYg==
X-Gm-Message-State: AOJu0YyEkoaUNgd54jSu2xhwgsIfj1puBAqwnJUBMSVY6VKoT1gfdvS+
	waqZP5NyZ4cIWTZX+tDX9R8Xf7ac5kKvKCcY4nNVqf2soqUB1WYojvD5FiDRXw==
X-Gm-Gg: AY/fxX7n5NdUNGEhBfnfs8ojv9cpz+M8MSNv953pHEBMqfYmK0adiQA5X970FAShxCX
	3tr+Lgop9kXniaZmgyubLTGgSCR1o0C8w9D3pUuTZivLy4iTKHmd2VVnH/NDGfRazLzScqIaTQc
	SKv/8HOVsuF5JT3BOBpcvrou5pgUWIj92ywopU7vGyzzYEV9m48j6zhjp63X/g0MQCiG4BC9by6
	Re42yHIo3mKmfl72Ko03kzs6NRn5j502asZ6d8Nbvf9dS4gUfv0httd1AOMrb6V4YwR8Ihtb+YC
	avhMZOEfzDHazVw8OEg4AgK24rpb/i34E/r7QoTs6e/0D57yyT3wdVqERF2vmvL5s9+a2/KVb3n
	bGA6xzc/dOiY4q77yXFvAvb9N44tVebxQ/ZFPHUXhc1XtuNwgdjOrnX5S0OXydqbDt02rORWnFr
	lxTjyXUnYJl6s/gANJyhhXRxZmnMA2+CYQUGI=
X-Google-Smtp-Source: AGHT+IH568A1xMmV53OUbvIWL/C97DaGLnDJs4m8PGc1w8c5mgcM/XMXln03AKyBRPxsVKPYCDHA/w==
X-Received: by 2002:a17:907:d8c:b0:b72:6143:60c2 with SMTP id a640c23a62f3a-b803722fd2dmr1114915566b.51.1766402226673;
        Mon, 22 Dec 2025 03:17:06 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:06 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/24] can: rcar_canfd: Consistently use ndev for net_device pointers
Date: Mon, 22 Dec 2025 11:16:33 +0000
Message-ID: <20251222111705.27028-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21186

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit df6b192e25df2c2460d27f04d4a43fce87c8bf14 ]

Most net_device pointers are named "ndev", but some are called "dev".
Increase uniformity by always using "ndev".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/7593bdd484a35999030865f90e4c9063b22d2a54.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index bd404c41ab6f..5136454a1300 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1437,9 +1437,9 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void rcar_canfd_set_bittiming(struct net_device *dev)
+static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
-	struct rcar_canfd_channel *priv = netdev_priv(dev);
+	struct rcar_canfd_channel *priv = netdev_priv(ndev);
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
@@ -1819,10 +1819,10 @@ static int rcar_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
 	}
 }
 
-static int rcar_canfd_get_berr_counter(const struct net_device *dev,
+static int rcar_canfd_get_berr_counter(const struct net_device *ndev,
 				       struct can_berr_counter *bec)
 {
-	struct rcar_canfd_channel *priv = netdev_priv(dev);
+	struct rcar_canfd_channel *priv = netdev_priv(ndev);
 	u32 val, ch = priv->channel;
 
 	/* Peripheral clock is already enabled in probe */
-- 
2.43.0


