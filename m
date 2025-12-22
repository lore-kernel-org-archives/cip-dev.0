Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7038E67496
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:20 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78194.1766402230788244402
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CU886x4W;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79f98adea4so565130966b.0
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402229; x=1767007029; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzJvBiXrHXOSF0o//6cp3kTgRMCrfeF3p2KWQOC39z8=;
        b=CU886x4Wofkw9r1ogiaEEhmq7IbeO/Alh2VKV39G+X4iNX9Gf4hamQ5yuI+/kMk5wI
         Xxe9x14l/zzQUPeokz+V/mewrF5McVAni20NwF4hM6gtQXeQEQf8gqXHQ1rBf+oUZQnL
         rmPUKLFkeY0c1/KqEV5F5fY9hv3o2nsRXENk0NKqdFTf2se9DyO++HjFJTn8JyoZ4opP
         5NNQS1j1sw06o3BeaP4L+tMXir46DFiulqcWsR/pbiqZo3vtxjqOeJXPpyDl+TkdCgT3
         vikUVtSynUs6EoJmHACfVJmOlvzgJkoA+H+TdtsDiefduhSepdfhd98K7c6SvXa3x27a
         huTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402229; x=1767007029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzJvBiXrHXOSF0o//6cp3kTgRMCrfeF3p2KWQOC39z8=;
        b=P95NxrXxSK52a9XJgEt3jDvQzQuvRE0zFRqyYat7MqdVvWb+QNaKV5gcgEQI1byXsl
         hs4FHpAzp/deIFVoGJ2/0bNUKBMieuvwJq179aW98sbMSxACpUWudMqBdhUhILGdMKZG
         nHmxSWd3JhW5IrxKZcxvtDiLNIE2NELNhrQB7jPNyNotk/A6NqZ049BfMn/4xv+ceXrT
         EUc3k3mmxE+bBrS9nYes3a75Bc+apqHzAPXCg+feO5+yPmRb6454ShKkLSXhhAkCiRLQ
         df/fJnT2QPLhyK9XkRumg80E/onUAUvN7gxfBuTrNJ0RYZEQ+zMz2fp4V5J/4JS/fiqC
         Sqkw==
X-Gm-Message-State: AOJu0YzaV1OYgzRdkCAzkAPejHON3czSa4NWtDmIqLP3v0A64YLrcRxS
	37lmD88xn8dje0/P78scwzNGzuDUWryu5QnmdPsaIgqKp5RYJfeQKTbdLSYpcA==
X-Gm-Gg: AY/fxX5D2nJTc7Y9dKuN1aERHWYohZDs/RBkdkeiuQhXiDvz9JqzNFriH72bbtMgHRR
	t2DNsiGbhN4JkDh67D450LYCIWAjYpTlEi59lLsxTbPpz9b47uWgDxqK4oVKY1bdhSEl9lW7gCO
	K8orFCglnk2NIRb7Nt8cJoB71xERyNabQGFyDBl2XDmRN1VN7ChZk069XYs+L9Qu3Fm6X5dAC51
	pCdy2KZKf/MUJeCpCnjtpfG/b3ab9UJV6R4Q4sUcvJVXSZ2phQhmSVODwWgKGIYymOZIcOhN+rc
	nEJPpFF+09al6lf8xvKoxPAjDoAq8Ik/mQIFAfqxyuUd6HCDd6j1x042gz1Dy6XK9ZCQh7y1DZK
	Yle1gWBvpubBQPdkqoMknnVTQBixYhuv1XvRdG4Y5Cz3rWyUGdTuayDcsNdvD3lcYouXhX2oPll
	Wq7m0s0EcFrPqeN6YnNxmu+8Yqus4+Ce8T+vz4XuI533KO3g==
X-Google-Smtp-Source: AGHT+IF0hDO2Y2+YXviLNcLQqkLK5d2aEo+OXjEIcyyJelYoA02WvyX47PhxsTY9ZT7BxjopuUxoZQ==
X-Received: by 2002:a17:906:6a2a:b0:b76:e6bd:7bcd with SMTP id a640c23a62f3a-b8036f107cdmr1156137466b.20.1766402228780;
        Mon, 22 Dec 2025 03:17:08 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:08 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 05/24] can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
Date: Mon, 22 Dec 2025 11:16:37 +0000
Message-ID: <20251222111705.27028-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21191

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
index 60ee6e82af52..1e37f685d9b5 100644
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


