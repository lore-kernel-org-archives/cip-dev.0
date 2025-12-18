Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C472D6E2C6
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:07 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1392.1766076966473656931
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Hz0LSFzY;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so460779f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076965; x=1766681765; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRlPIvv8UpO8yQoGkuxgyIbxxVuuEeMnW2YcdVaSYzw=;
        b=Hz0LSFzYcY5+pHYGsf9mTJFw5JrWMpDYltxC7OLzqxouYLksLjMSwx/hPL8eZrzFy4
         Cgy9IA8f2lelGu42yp9sOlaGz9XO6t3KL4iYe5SZ2mjdjkIPEObzEU2gikTaQFptRlsL
         HLNZOPtnBnRP5fPDRxS7XqHa5adM4QIfEP1JTUq3qbHXj+1DBaLUjbjHSAq4K0ePgBdL
         I8tV6xcNmpMEgHCdFa8FEmntCWAeWMs08dF5IYGWuINbSoavMT2bzIZejCsX42tH8o0o
         ucjZo577YeblNMtjziCDvRasK+ivEkHf5Mx1q7v/bUuW3xb9guVp8jvfOeuKFnenkZBT
         OPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076965; x=1766681765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRlPIvv8UpO8yQoGkuxgyIbxxVuuEeMnW2YcdVaSYzw=;
        b=kzgjkXWW8TMmrnoqBQb1OdzaqL6M4CZqP/TBhkK6m5NI75wOz/AruIgxrsshqfYclV
         roHkJ6EzQhDx0r0/dt1k4txBmbfKR+u2fUns/7SZ5JFofbW7BklKm5duoja554MpwL1v
         tP5OVsQ7D6PAjReMI18pUGFVf85vb4JLk2J78GCw4njaKl5TfmX4x9pnZqhYGl7Dhswa
         Jl8u15ZmUykmtby8s1tEALL4+AAysh08dDg/YtCaiMNcAR1mfd7qjLZNsGy7J+JIPiKo
         MwPDexAwIYtIhspZDyRORjJY9DDG9Lf6LuFTkTJ4tOAS5DNg+ifWr5s5AmHHZ1FqsInY
         q8eQ==
X-Gm-Message-State: AOJu0YxybNKsiJBGuJNnpWbm61jK8OyaUcXM/9Bry5yasv52Uw35uw+4
	LRNlVDsl7hRsYf6qNSqI5Pw4moPLJfgBvnpuP3H3NMwmayY6AbXUSSJhHck42g==
X-Gm-Gg: AY/fxX6QlcxrdF24GH525bnBrHXRBJJpg8jCyzaRHdvDlV2ijV/BGgzX2RsaphDpnWo
	TvTQyjRNiK+Gc3hFDStCpfLSZ4S7MOABZrMPh5c+y9rA7BdqyjVteZIiCdhBKbMOTlT3zHrzZ/b
	ofvOauDEv4qQoV5m0yEssNYOosZf7z8V+pk7qTe73pOkrDBKoOWhH7M2ldjEgXlnhqkDMN3sTKU
	R48SHaxefpjPk6Tb/vCf+qMT/yHeSUkKiCQ2EOCS5wljiVzKLx7aZrs2R8x15X7KZ2bC5FWPspp
	wEhE/69og7Ad1OSOshggJNepNdUYPBa9Rl9Aj8HE2oxtk3o9sO4f5dSJ1ZoWl9aWtSG6TPdIumD
	YXvopSIU59MAoIvdxYgl41E03QyV6Rh6IyexkwkmwvsQnC+cpHkNRi24oZxpDqy0tUzndqRepjv
	c37McTLbx1yFrFoGivww==
X-Google-Smtp-Source: AGHT+IH7U2ysbfVrmaS20sc8TJ0b+k5Fz1gsyrJguobo4FomM2SijAQohJ5MeHvB/GkFN484/nbOow==
X-Received: by 2002:a05:6000:220c:b0:430:f58d:40cf with SMTP id ffacd0b85a97d-4324e4c9692mr185901f8f.16.1766076964512;
        Thu, 18 Dec 2025 08:56:04 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:04 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 08/24] can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
Date: Thu, 18 Dec 2025 16:55:07 +0000
Message-ID: <20251218165600.258194-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21146

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 0a0c94c682fd2606b65a512ba24478a3b5e73d7d ]

The configuration register format for nominal bit timings in CAN-FD mode
and the format for bit timings in CAN mode on CAN-FD controllers with
shared Classical CAN registers are the same.

Restructure the code to make this clear, also reducing kernel size by 80
bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/b7643a3c49777989d02145a85b85cf773ec2123f.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 6a3e1b06f4e8..1543952014d4 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1476,13 +1476,17 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		/* CAN FD only mode */
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
 		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
+	} else {
+		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
+		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+	}
 
-		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
+	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		/* Data bit timing settings */
 		brp = dbt->brp - 1;
 		sjw = dbt->sjw - 1;
@@ -1493,21 +1497,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
-	} else {
-		/* Classical CAN only mode */
-		if (gpriv->info->shared_can_regs) {
-			cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) |
-			       RCANFD_NCFG_NBRP(brp) |
-			       RCANFD_NCFG_NSJW(gpriv, sjw) |
-			       RCANFD_NCFG_NTSEG2(gpriv, tseg2));
-		} else {
-			cfg = (RCANFD_CFG_TSEG1(tseg1) |
-			       RCANFD_CFG_BRP(brp) |
-			       RCANFD_CFG_SJW(sjw) |
-			       RCANFD_CFG_TSEG2(tseg2));
-		}
-
-		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 	}
 }
 
-- 
2.43.0


