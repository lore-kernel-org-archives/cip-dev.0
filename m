Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A974CCDC162
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88208.1767699901931270157
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iX5fO+WV;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so7348375e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699900; x=1768304700; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvE1Ozyy5T/aphHUqDylf6Tgz/ZoqVJimSkP4YEk24E=;
        b=iX5fO+WVNXIyppiCN061jgb/ahGWWWy7VT/5Xyhnx2y8M7s3dXcqVD6yjCBvC5UefY
         cL95AX9gTELZOqYD28X5TVFISiiUBzwU7xN5lf1UMSOAPiNoXwJZN+PGsAtRoN5g0NRS
         MM2o2q/AQRmz805URBqF42/QT7f/e8IzSdLBL0ckilFY69ZkdwOSI/3Q/vM+BONK3KxX
         YP6MOhp/jBj4NDPKM8DWdsJSxOGsP0eomtsjzl3KhtDfeEZpPQCkvLBlKc4UHVc3iPfV
         jM2Jg6dZDrGBAir65lcFuiCQIgvoowHQGxhkzJ3n7xnsaXneLob7zoG/4UGzNiDwPp+g
         +iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699900; x=1768304700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QvE1Ozyy5T/aphHUqDylf6Tgz/ZoqVJimSkP4YEk24E=;
        b=Ysk+ZhBb/SkJzg5yJBaYIPJ6GImt8zVaBmlABWsus8TkXuAhwwWvd2pY8HqCRLb3Mc
         8/IAr28b8OwwZCHEtJzTt35uTWixOBI/UeeO8sF2SrEmc8FPOC0a+eyfafL17bqrJ9fi
         30fyU2iQsUG1iyioyrex4CyWln8wp8aC9HikaX4GBxOxOIIPKsqzNXKIoKpspVR2+bpO
         d/E0ouSrDuckoJPEHbP6nevJHVI1ZfPW6G2zu5iB7brDQ2CUkqY//P6Qr1zDrkFamzkb
         47nEWjgB+6oEGNdINxcqfwQ9NN34ZYHhnthsodTpxzERQ0pObA226hWytdZk12zOgBzA
         A6kQ==
X-Gm-Message-State: AOJu0Yxen0qAVLd1BPR8dcvTsD+8P50XG3kgRvgkoJOZm8heUB3x6o2i
	4Td0e9myhguBl16y1JTEYTha9QhZ6ucWrF/fZRkT844cP9iKWpxuYpBgunt8RQ==
X-Gm-Gg: AY/fxX5RN1iDbapTgXPm0NOm6Uq9fZOKrfQMxhBEu/tviA22nRTlCd3yjAku5Scx7Mt
	m3SzjFW1f2B64eGE2bM7bybiH8kdYGbB+xWE60g4zI5yI9c7PdC3C4gU4awmR2d2jT+LvcPHbMs
	adRo2A6WcaKOwYNPwiuYDM2ANfMmZxyHebIApUWM5LLkAGgyYodxl4cOtYIFj1iCvbS3VeblXib
	YMcdDp+Gm4SZOAZBU+SwXxcMfKEFo+kyXZzSzY3Qor05/ZqkPfl8wdZEUuoOgnxqDsJAbJzu/AS
	0sSFIV/QhYZ15RL9btlDy32phi/DiR0bK4CN9SnzTA8l0K3fFPlntXluh9LBFu24mK6W5oGQeQW
	Qn3+aJg9DbcoQukt42gCyoPAXtuk56AGss4nDFpHC8QGJUKXYtJmqRpOQ2qmetQvBaZExUh0WSg
	TNQaLhnH7b50lNRpDqvQ==
X-Google-Smtp-Source: AGHT+IE7BcY9bnGrZvPYE11unQY1oyCOrW/UT6gB+5csZ8siSQnBVUEUJK3S84NcS15EIF+FSy7CoA==
X-Received: by 2002:a05:600c:1d19:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47d7f09ed9fmr27588265e9.28.1767699899904;
        Tue, 06 Jan 2026 03:44:59 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:44:59 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 01/24] can: rcar_canfd: Consistently use ndev for net_device pointers
Date: Tue,  6 Jan 2026 11:44:24 +0000
Message-ID: <20260106114458.122333-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21333

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
index 99d0cbe86321..423343671bb4 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1444,9 +1444,9 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
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
@@ -1826,10 +1826,10 @@ static int rcar_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
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


