Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D29CC9833F
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88170.1767699903592728288
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BzECBjiy;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso8146335e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699902; x=1768304702; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmitBaOUiBf11AQKeRLuytGdAXhxzKrsZlaUStJE0jE=;
        b=BzECBjiyAzp9vFFmmztHMICdp06ivIIA1FkAFMl0LuqFAdC+oZO7SyQ8H89utnjwDB
         o8PUkXEs6uSZQ/fU0ISAYom4T8ME9jpO4af+QRtguICFi8WLqGlLAmZtYhxpAU5dzvhL
         emLypkAJIfdopueKjJkESH0AismwZfF4blkkQIqgaj6EMjBiuSif57m4v1cslN1HAlp2
         S+WA0R4AgUZED3kAfuQoGzUVE3flAhv1HW74tWVXOL2Ik4IbXv2OfH4nUy/8hbWvD/wf
         0LLJmODI0OmP5E3104hG4QQn1KD4OSkUtgTfyuPavbchQnSUmOPtgm1mTzO8KRrNOkWr
         hR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699902; x=1768304702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmitBaOUiBf11AQKeRLuytGdAXhxzKrsZlaUStJE0jE=;
        b=V9HWHEkN2aVffb6+C0aiOdcswPpDelnP0s+23IWRfhZoVB6hN6LQginN3zmxQeGZBX
         BJ3fABNpsJkrLX8ok1dt4f8Nrb4fWgDv/pVOLWvz7VQuK45IF7AgsoUV+Ve37plkzO/r
         C4ll5BJG5WA7/zYh5HOowkzrUtZZBgibxysX7mzRcny/nQ1C8s6f/CAl5St9zJUMJB7O
         TeOoytRT2wa2ttq1hoEnQ1we9Ve+epK5aFljb2eEZ8TH9dBuaM2MlbFtPuO04ae7ZHZd
         PjLfV5SvBJC5Kt36297V+SSLhNAB3Tz+VZp0K8jgoiS2zp/znuKS/le3qlRny+j6K7i7
         wHZA==
X-Gm-Message-State: AOJu0YxEb06gKiKmSYVlzAuR20oyiet4jm6pIJrDfvqzPKSgc2aVMQa+
	fAYZnLNxGIwawb2Q/Y2HTkUDTkzt6yzhSqodWnUyMO4d9XwSUhZfam2B+iQYOQ==
X-Gm-Gg: AY/fxX735uRJ8Hc0VlEjY4jdNEcFvWxXKIgetDzu7LcIiPrbGgIqM6DiKhILZzS/wzf
	D7hZwyg4ucgHSAbHSPC5PvQmAEahBsC7+18liT0WSJuK9YyTuEk1L5tLhAJv8FpvFCBpAcJWFVu
	5P02MPQm6MfRtn21KQOSNZ9LcUEVv9mhwnoKqLIq84OdsuC5hauUaE+uF4qWKZtPt5T3sQRMCgi
	x54mAqm1ILRp582JDe5pb75DYdQV3PDnTE9y5u8aa/8L5w5U5Xr8XLB0W4Lr2SnpSguXPy6lxTj
	qHGHMZNp/IpEk/ivHlrl3U5R1LQKw++BOCBCmjTLISvSYI1nvPMhxC1WuU/dK49Y6pUsESo5Rvp
	71ux+gJMNNZ5yq+4CjFNHogvYkITMegfoveny6xSA0563sdAA/UxveAwRv8gW5kl+N73fgtK+wS
	CvkDoZ0SzJQjH/0hZVYxF9W0Fbx7mS
X-Google-Smtp-Source: AGHT+IHJM0LcBj3nv+RXXzSCiA42/GojopJse/vQI2voxuuirtIBJ8VkMA2MeEUbWWPTxSWdE776Wg==
X-Received: by 2002:a05:600c:34cc:b0:477:7b72:bf9a with SMTP id 5b1f17b1804b1-47d7f0a2ce8mr29064615e9.28.1767699901713;
        Tue, 06 Jan 2026 03:45:01 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:01 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 05/24] can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
Date: Tue,  6 Jan 2026 11:44:28 +0000
Message-ID: <20260106114458.122333-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21337

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit f5e3150b1a0f0f80b162c1ac6178344959a2506d ]

Replace the repeated casts, pointer additions, and pointer dereferences
by array accesses to improve readability.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/4f43f44dcfda13d48a2c502648833934a51d9d6c.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ac6a942c3c85..d7ab9a7ec4c8 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -781,23 +781,23 @@ static void rcar_canfd_update_bit(void __iomem *base, u32 reg,
 static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
+	u32 *data = (u32 *)cf->data;
 	u32 i, lwords;
 
 	lwords = DIV_ROUND_UP(cf->len, sizeof(u32));
 	for (i = 0; i < lwords; i++)
-		*((u32 *)cf->data + i) =
-			rcar_canfd_read(priv->base, off + i * sizeof(u32));
+		data[i] = rcar_canfd_read(priv->base, off + i * sizeof(u32));
 }
 
 static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
+	const u32 *data = (u32 *)cf->data;
 	u32 i, lwords;
 
 	lwords = DIV_ROUND_UP(cf->len, sizeof(u32));
 	for (i = 0; i < lwords; i++)
-		rcar_canfd_write(priv->base, off + i * sizeof(u32),
-				 *((u32 *)cf->data + i));
+		rcar_canfd_write(priv->base, off + i * sizeof(u32), data[i]);
 }
 
 static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
-- 
2.43.0


