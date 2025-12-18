Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D792D6E2BF
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:07 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1403.1766076964590284028
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=btdDoUK0;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so432142f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076963; x=1766681763; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pD8pFHTQ5Sv1J8g7yVUvHbMQ+E/VIza/T46RCyeoz4=;
        b=btdDoUK0DsKfhtgJes32WaOhCHsnrccyT075eo57Y4ORuHI+PxgZK3Tpsj9n2HAOmo
         UR5in6xbyJhcKubtY6sof+lf4bVjXxHbNGoFlOiB3QAWuE9pzbX/L4Kzif2x8aygNx+M
         DDlTV6MUj1ozVuC3LEwRTrRdWUZbINh4tqz2cMs4IWy4FlbmcCNRi/ECwWaR25yBejGZ
         k9ulBrsWxzsGJnR12fDox4rJ5wjJhlx0j/jgGa18M4J7cu5lF6J5gla6sxLmnSq5AIPK
         YPV2urnVHCLhCdR0VmpFasXMQy1M9pg4oaHBWF8WnWjPx/CZCwE/gfhTJNIUgyGT10SD
         RQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076963; x=1766681763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4pD8pFHTQ5Sv1J8g7yVUvHbMQ+E/VIza/T46RCyeoz4=;
        b=SUxeqWyQSaC0LFM1xiT14ySm5rTM4L1BRYLgA7ghmNCe/6c16ZaPIieEwA96Pn+uZ0
         82ak4Ok2dSQ1l+Cva0nCYzx404YuCT+CeHxBsIskGdlng2T1/giajONCaDHMP4dSUrkg
         Apnv2t0TFPLvrJ1eEjhJ5P0Abv63e1JIgWexQR+j2VX2RqXZkjPyaE0hDo0vzHPF9gcs
         WJz0UyYjrd3eC6mbwAxBed/zPzFnfDzdLkbxEpmfUGl8ZyVlC0T2wpfyQ5v/+CV0jeDE
         +ewYsy33RY9oZ25RzFXQcJUCPg2wSiRA+lK8mxkSDQIlpve+XAK5uf/4kNynghA8WYdn
         fNAg==
X-Gm-Message-State: AOJu0Yxp0BmP7QG7On79O9qmBXcUYuRXjHEm8etFd/Mo+KMp8rSdzVEM
	YhWX+Jt3wxcl2fYH246/L3GkvlOstL4db0MtV+96HE7aa+InIkX+70VGW6lxFw==
X-Gm-Gg: AY/fxX6u3OABNBj6/QdxiscKrcYPT/Asbw/tRZMbbzNLoqCxbbrd0G607QAOfoWW8rG
	StYj7ZG1K3o0aKXnRbcfil0r+qZFw193stY9lj9hXidaRdaeBeF6dlbyJXTiFBld9cHw8Z/opcv
	4J3uJOyg1avcW2SIGfSMjtsqosD2IWepdfG2WOJJr2Ftg8EyTvCn9WwkQUdR9OZtmjwketyWdnp
	DD+qhznYxqm1f6nSRmxP5NfgTiexvyjTalUoQuPbToLsbkHoW4qmP0R4cCf+zsN4EBgTrSmMNKk
	o5zLHan2EHbNA6K8ujfhLqOCgn9b6hXsQ4DOIcB3BPGxnRTr/3LixFaIcakjs+lEuNb7lpTy014
	otipJIo2rDN0kuuBuVqCOvl8JvnnbfplATwPFuUS7FPTLXWG6ZogMrlHd0yCW+bqUFZh64T2/ZN
	SQsggv3P6Xxy4IkUuHEA==
X-Google-Smtp-Source: AGHT+IGXSqS9aBFwXwe0Zb042p/K6f81eHeMfOGJhUpZKkcGCIzxyMMm4o86fbv5kPI7esFeqpa06g==
X-Received: by 2002:a5d:588f:0:b0:430:ff0c:35fe with SMTP id ffacd0b85a97d-4324e50b989mr173393f8f.45.1766076962542;
        Thu, 18 Dec 2025 08:56:02 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:02 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/24] can: rcar_canfd: Add helper variable dev to rcar_canfd_reset_controller()
Date: Thu, 18 Dec 2025 16:55:03 +0000
Message-ID: <20251218165600.258194-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21142

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
index 6c059d5d9cf6..0b47461bcb08 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -842,6 +842,7 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 {
+	struct device *dev = &gpriv->pdev->dev;
 	u32 sts, ch;
 	int err;
 
@@ -851,7 +852,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 !(sts & RCANFD_GSTS_GRAMINIT), 2, 500000);
 	if (err) {
-		dev_dbg(&gpriv->pdev->dev, "global raminit failed\n");
+		dev_dbg(dev, "global raminit failed\n");
 		return err;
 	}
 
@@ -864,7 +865,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 (sts & RCANFD_GSTS_GRSTSTS), 2, 500000);
 	if (err) {
-		dev_dbg(&gpriv->pdev->dev, "global reset failed\n");
+		dev_dbg(dev, "global reset failed\n");
 		return err;
 	}
 
@@ -885,8 +886,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
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


