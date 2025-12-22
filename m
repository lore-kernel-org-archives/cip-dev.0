Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC9E674A6
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78274.1766402232649734860
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aNkNk0in;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7697e8b01aso721152966b.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402231; x=1767007031; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBRnSDFRzaqYkh0DnhUV20ZE9jOTMtWvjIWNNsoQ1x4=;
        b=aNkNk0inmO7+ba5wepqK+DIBhPHhUx6fSqZoYt/05esSiREJVKZdpbGr/9prha59ax
         x9HgINMSmTFs9UmS6068ht8k2fFIsy5EyRRIEhKznVPu8HRPQe7hvo+6DoCA1bmS7lEN
         W9xU9k7ebSumpnVPDuQXlIEmmM8qJdGryirdnazX8pCWkgP9AKAJQgGzgmoZqkRTi+lk
         iwT9qki+lqiwpI+bsrxbbsNnFulaST8xXA7MDKh5A2ViRF5tetrgNCkv5xWCdMPMoRTK
         Z1SMRmHYLvyK9JPBHA4q9j8q8KYWOgpijuyfxqqgXpxcJueIRXFa010I8SebHm/EwU1y
         DZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402231; x=1767007031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fBRnSDFRzaqYkh0DnhUV20ZE9jOTMtWvjIWNNsoQ1x4=;
        b=wvhQP9Ab9ky80Xsv29rSntMZq+/vom1BJk0/8xo5MFAPD9jnQJc8P/x1FgxbUkXnlo
         8fknivYZLBwTTJ9DXSfFk/zRnyuCDluzsNiRounX2C+5m8A99iYmd6x6vqfavefzeUKw
         V4cT9u5iG3IlNScSXSkjSi8HOTXEtHYrARQA6/M08qdGMYrs2bNEy/YaoG5Q/ShNFFLB
         5KkDyIQaGXpxYMn2B7TYG217THimKpIkVnxqmDms7gPfi1cXsARRHwv68Zan82St9+fe
         v1WMeO4WUwMXHcj9NWFU6lkaDtT5WuzRzBYVy8yXC6bWDaJsW9heE/eS+UBDyFkqBUg7
         xZfQ==
X-Gm-Message-State: AOJu0YwzMy0dZotIhAGhMpTJb8L4QpAG8/kaDPzmLKMAXinsZGWA/kEf
	SC4AS81vRbCMEfI86IWgmyFxbRCcr6pfDXIBrTDwEuqaEX2OI/4SMwjDcZO3gA==
X-Gm-Gg: AY/fxX72GJwNCBeQvPlDc2QoBRfOyxfbw1IaHst2tJyshCC+sqv+RN5bXDQTjt2GTOJ
	cYFKOLNl9h0d9xOkYJfqCGPJMVWpK5gKq/Fntfp8rqUfxHBCmpufg+j+cpYCTcxAj+fb0U6Kfdo
	tmv1YD9GJJrM7+wpKFzWLF+WLAFUwyAnGlFn1dTBs29olpco4/kUydycoTzfw4cZ+4IJ5KEkoCI
	p5Mf1gijJiFyqUuDkAtME6MC25EYYKD37o8QVYUA6Ij/Qe/hHRxmgNeQkAlmxXI4GADj0VfgKdB
	NS0Opqf/6NeRjfHmZEWbpb9MwY+fA3XevXxo4uyVQJryBi1kV1Z10vSsJbyr4VK+asuCZRnKOVM
	UT2KI1ObCzjmDYes7dGn/52DqmWaQ+NcXAB1yx6g+RGxBe1Q+n8/gIbbjrTSjBnW8g6FS2Bgdbc
	5yocgN70XskwOsTFsrF6D1JHX0pXNKk6xV4S4=
X-Google-Smtp-Source: AGHT+IFyUQ5kb69mPGuTMAC+R1F8oOUK7B6uN4qiWuuqwQ1Xxf1GuspfmnVH4dH1tb5kA0RueDXjHQ==
X-Received: by 2002:a17:907:6eac:b0:b80:333e:faf6 with SMTP id a640c23a62f3a-b8036f0d7b7mr1173377566b.14.1766402230736;
        Mon, 22 Dec 2025 03:17:10 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:10 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/24] can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not FD
Date: Mon, 22 Dec 2025 11:16:41 +0000
Message-ID: <20251222111705.27028-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21195

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 0acd46190ea2157a175b4b2b8e764843e2c93b66 ]

Return early after completing all setup for non-FD mode in
rcar_canfd_set_bittiming(), to prepare for the advent of more FD-only
setup.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/35fcdcad026cfdd0fd361637f065842d99a6c19d.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b270fe5658fd..e76e5d76f836 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1485,18 +1485,19 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		/* Data bit timing settings */
-		brp = dbt->brp - 1;
-		sjw = dbt->sjw - 1;
-		tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
-		tseg2 = dbt->phase_seg2 - 1;
+	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
+		return;
 
-		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
-		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
+	/* Data bit timing settings */
+	brp = dbt->brp - 1;
+	sjw = dbt->sjw - 1;
+	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
+	tseg2 = dbt->phase_seg2 - 1;
 
-		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
-	}
+	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
+	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
+
+	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
-- 
2.43.0


