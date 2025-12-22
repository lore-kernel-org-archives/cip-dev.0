Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A81E6749A
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:10 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78193.1766402230210967892
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hSlYYgfq;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79f98adea4so565129466b.0
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402228; x=1767007028; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9+x4UKcJM/cEIpawfZFrS9iUdgnOicdjvDkB26MYZY=;
        b=hSlYYgfqfWXOmObShKE/CKx7JmNOnCmZWR7G75E28MazhwVCo4KcgnGJQbyd2Yi+rw
         tKMNJPV7H3T9ZuXundXCbLskXPxMw8CTnYnXUgjKOtrhrkOvyDZDml5vNkqIei+mafRj
         t0rSbTUeq0FklXFgQvHkmTYMf4iOTn2pSEbVTSRHbuOI6Mr8nAAkvk+jDxcfVq/GWqu5
         0l3hNBlNZFBoegf37x6UBXvXoIfZATZM5cmJb664gZk7oYP2CJPwwoulYZOsOX+cloxw
         BLPbqTYuZ/ZtZErleZCNlecTnXjzmnUROg0TxRahsVAnc4JpFFB4rJMcyjDXvD+rlDYx
         jiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402228; x=1767007028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j9+x4UKcJM/cEIpawfZFrS9iUdgnOicdjvDkB26MYZY=;
        b=HqOJEotr76HsedlQJznR0P+E0Ra+9W8lpI0LjdIy9Js/QluqdtPd9pOtzKJ1riEOlc
         tD71q1rGVS4n2LqxO7e55cd57DzTtdgvNEtC8ghoh+jpo3RPM9Ktc/mFvaCv/kP1zqUO
         1SsJxPbjYOZAYXTB8DX+USDLFwO/DZ1gWGKOZsrI8Koths1yr8Lo8aaPgflv+hqBKE60
         DRGMHK64/FS//UZlEqF38AE09MSwzxVj7Dld4VQd+6JavLWPjPQ5drZ0xsyUqx5B6sTO
         UpQ+ymUpPvlKj7RUjWl98rAMB7gSkgTGGwRwxN585op9MBICubXK3OCT266bmHdAGLr9
         uTbg==
X-Gm-Message-State: AOJu0Yy/NPZewnTeGEUxT0TkSTixdDLkc8QbAut7+qZCga6ljzG30iVi
	GaUmFj0324i0jro4lWduXVIAjfXJyNlypGp/P5F+7iu6qC1iUvNkh2LALXYf7g==
X-Gm-Gg: AY/fxX5MTP3R253w978NEBa4jGS4k5/Xm8vSs4QJ10j84Y/NyDhMgOaSA6AdUX1WXgx
	TW/OtbpA8kW3aee+HtAWmxfufS8FSl0U/3DjrT/EW+921ENvIancuF0KuMi6vPNy4O1HYnAkIhE
	rrrHtpoiwjwOBH7rZWWh5oTzXnrMUNsXjSZMhKxPuLxIaxuK//ePBIl7fBQNPrkKr5vTKCLJecP
	z2qsQ3kKtVPJr/Swq5P7tpCt43xlX9tZ9NXvUTMt7HndFA421OfUrVhWhvqwAMYWJG95nXlvSJ0
	T8bfjXhJld+XegyFPVeAHLAO7Zb5WuYJ+t6OBSJRl2rKdy51PcgrerwuBotITfgY+oSiMYQexsb
	/MS88Zb0xt0nWRG2ebPTjHpXc/kChpVx0KF6BnYnsDx/e1S7cH/J2BTgvrXMcAdqi8w2xL30Ack
	6njktLLYr3e5ozPX1zbOgjiaTozZaf0SSWq+c=
X-Google-Smtp-Source: AGHT+IHBRO58bZr0XactCl8p0us/cqduy6++1+8QyRnQ6IVwUrnKo3Yw24S+AG/z4n8d/mH0fItniw==
X-Received: by 2002:a17:907:3ea1:b0:b76:74b6:da75 with SMTP id a640c23a62f3a-b805ab8bb56mr562102766b.38.1766402228230;
        Mon, 22 Dec 2025 03:17:08 -0800 (PST)
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
Subject: [PATCH 6.12.y-cip 04/24] can: rcar_canfd: Add helper variable dev to rcar_canfd_reset_controller()
Date: Mon, 22 Dec 2025 11:16:36 +0000
Message-ID: <20251222111705.27028-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21190

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 1f9b5003d4baf72055371fcdb15dda5759a8e908 ]

rcar_canfd_reset_controller() has many users of "pdev->dev".  Introduce
a shorthand to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/21e64816808eb3eba722f4c547f4f5112d5d62a6.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 0427219b4564..60ee6e82af52 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -841,6 +841,7 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 {
+	struct device *dev = &gpriv->pdev->dev;
 	u32 sts, ch;
 	int err;
 
@@ -850,7 +851,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 !(sts & RCANFD_GSTS_GRAMINIT), 2, 500000);
 	if (err) {
-		dev_dbg(&gpriv->pdev->dev, "global raminit failed\n");
+		dev_dbg(dev, "global raminit failed\n");
 		return err;
 	}
 
@@ -863,7 +864,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 (sts & RCANFD_GSTS_GRSTSTS), 2, 500000);
 	if (err) {
-		dev_dbg(&gpriv->pdev->dev, "global reset failed\n");
+		dev_dbg(dev, "global reset failed\n");
 		return err;
 	}
 
@@ -884,8 +885,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 					 (sts & RCANFD_CSTS_CRSTSTS),
 					 2, 500000);
 		if (err) {
-			dev_dbg(&gpriv->pdev->dev,
-				"channel %u reset failed\n", ch);
+			dev_dbg(dev, "channel %u reset failed\n", ch);
 			return err;
 		}
 	}
-- 
2.43.0


