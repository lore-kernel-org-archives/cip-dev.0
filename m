Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23756D6E2B9
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:07 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1398.1766076963120836348
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nPFa+sgz;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc305882so494795f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076961; x=1766681761; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBcoLm5vT7RP+D4eaqlFI6FNZVLoi4R9WYTfobdmijA=;
        b=nPFa+sgzQFTA73mylxwtkHsys5u3u2sXht4pdzdA/MrWMBgDtJKSligczCCYaBxtOd
         flrgDIPdkRqjnwdLnrizdmKAHk4CMyCO+/mWEfDlRfzSCBXE/r4khCq/5xIE0zu5zLmm
         JDCmiwv4pt7XtitYWoRbANuJW4pG4zRAlyYCleGxQ6dqCla2tFWg2DKUkIBGBGbEcLsD
         KJxbYlHWog1ZpNTpoCpj7NxskvMU/QiS3Nfp0Zb9Vy4IjASqYXvhJiEbZPsO3bT5HVw3
         cTMom2LT+TMn0xPmUSLphJs3lnjKpNEIxv346lsGJpqQ8FcyBf1jK9MFA2BYD4xZLP2P
         wh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076961; x=1766681761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jBcoLm5vT7RP+D4eaqlFI6FNZVLoi4R9WYTfobdmijA=;
        b=A4fCNIN7Pv+qmiU8bd297eINqBY2fhxU5b6Gwu0W1uwM51RtmZtw8HYKUwL3BqjQpc
         slaQ6vvS1D57V98HnHcLcpK2Re/ddD2Olk0xpPb9TEpgOG0WXyVtUFHyvHLS0W0ZeVl2
         P1QrkzdGRGPoVFQ4DDSINcs4h5FAX7l1K+d4tR0tvCjYHRRILzRldMb7OzCEGIh2wmlF
         7/MNHwE1p/BjW1OYoICZZtL3KCqYdgUYnvPj6MrFuCbTPoxS7ZnecyFtyUOFBjD764D+
         ttgeAStQ8E/FCfh3X87i/kM/R1RQQP8XzFrWUqu7vF/Be7lnlJ22rRKO8gFhuaZyzQRq
         M8+g==
X-Gm-Message-State: AOJu0YyC+5eSrEyLvNvWrxwBZRSjufLsDkz/6XosKjuWZ+octKcwvQZc
	/+TObBneEqeiiWbQN5OmcCkHTZRjn/FxiZHqHothalyXKcEtlyt9yR1PAv09Vw==
X-Gm-Gg: AY/fxX4nkP8fHPyvU3bTfLaVcxfk1EnocaHWl1PKKYuRNUeybGuoBF6FTnu5St6qRQN
	4Qzrpx4K0W4C27gFop/fswLfWYrIs9P4zQYBOI0wbS2/p5e5FZATxmNNugFKj/eRewjoAJd2pJj
	si43ByWOxSEnsGqQPw2CFq99lq6FOw1k7ON+5Cngedig1qJkYxK9NzMMgOeY3zw6wyETwADzZqw
	olJvERP4kM0mL8Lyk1Bq9PepWY0zszfLQLPwxmROc+8r0zKKNnmaTjjo7T4mn4cXVGqnOMAtOu4
	gDaYH4r132Nj1dOGC2eN8fgc/mcg9jDxAMP+V+axrRMbyztW5EMCNGc8uZVVEhNLcaCFPtOneYB
	z83Q8UxqogXkaZxL/EeC8YfHnXFHiOy5FF6NO0AV41euUPLmWEZZFQRGAzqN4VxJyqerArSM77h
	OKndNaq8kAD4VNWjMvMg==
X-Google-Smtp-Source: AGHT+IE/YdTUrSnLv7Q9zmM18S6U5Ew7ESuzlvHS+U0lNCc6g9z0zkMfbdziVj6NWh2LIC2iTRtHUA==
X-Received: by 2002:a05:6000:2882:b0:431:488:b9b4 with SMTP id ffacd0b85a97d-4324e4c8fa8mr195235f8f.17.1766076961220;
        Thu, 18 Dec 2025 08:56:01 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:01 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/24] can: rcar_canfd: Consistently use ndev for net_device pointers
Date: Thu, 18 Dec 2025 16:55:00 +0000
Message-ID: <20251218165600.258194-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21139

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
index 2808c53a323d..e0d3031e4b4d 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1438,9 +1438,9 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
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
@@ -1820,10 +1820,10 @@ static int rcar_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
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


