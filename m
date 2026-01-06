Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF90CDC167
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:18 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88176.1767699909969364608
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Xnx/Bdgv;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so9258385e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699908; x=1768304708; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4BxYnerkYTC5Zty+vRzFSXcnOCiLweXOPIywb1F9PA=;
        b=Xnx/BdgvE6ct7V5tma3N9pXrbLjbmV171E37tHYlHpckzAw/eP03pQMJOeNDtZ9615
         pGaZHKn7JF+eimK3+flHhk/E5ee1inJqk8mgdafX1T8N4sGxij2S+Mf5pYwiVDiROOJk
         s5zUBqJs8Y3PccD9/p76BRTzO1N7O4yRomXbFB1fiChQW7Z0C0GSfXaAwAgRGNI5svFO
         t33hZkGQZMsNHgTukdgxsMG6Bz0aUv03YYkhnxpsWz7P857mx/Bd4eBD04pP1loSNysX
         0msQsFcwEF7zUD1fRgnAYGVOXOVbP9Ui+eQ1brum4N9CHDUggZyuoqVuWNdOnaLq7hp5
         5uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699908; x=1768304708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j4BxYnerkYTC5Zty+vRzFSXcnOCiLweXOPIywb1F9PA=;
        b=pRL8xR5YwMxgxL/XoFHEXF4+mLbDbylc+MLJhKlnotl32+CE89AcsKweCKsMVNUyPl
         z8jU+7sO/vuUugbky3kMbIufsedoGmS5izF/oOB7SX1+A1EemJH7xuQaflegvoJskA5H
         9CEBhld30PkpfLi5ZJetEdDIaBM79fYtzyPLrRVcVoCS2V2VHgTiGCNq5bdiaADYAlZ6
         g/ZZs235jDQ6PEaTBuzwYbd1LGm8x05b/Hv3V8K7zF51Yd0/p5Jsrc4kPBRgAOVLx0qt
         jIZ8WGGawDrC7Ct5k7vtKuy/KJKX8ia3lt9EP1la6Hh+vY0y7OWr9g4rlHdE5Bohu5Mq
         idrQ==
X-Gm-Message-State: AOJu0Yz8SlQc6djUqxX+hTxPPc3ggYGwN+uDVv+GTa8HayI4qUbcxn80
	iW8ZqviApcy0AXqXwCFRSKglG+ltLdEPSLVf6jC4w87TT1vobX18/bsecAxM9Q==
X-Gm-Gg: AY/fxX6Qh2lKil2KQwa6RYRh6IkgUO8FNMoLWRzn4u49d9rPp+uH4hHRzsE4FJs2n89
	woAWWna03UMKTzTpA8UTbL/ryrIX0kduGtAtu7k59RtHOLZmMlb8WiydrXmIWpBQWih30pREVcN
	fi0fiMI8NIOOmuA3cUdsmks9cWBLtIKcVgA62rQVLffS5BxVvXHEos4gIxJ6ToBMOSrnus5VAbG
	oma93PTjIywPLxs1ET/RlK8bgVXS1TDoNG2aSCfxehFQkxYE+BmGyJ8mtC+17GOTTSbyr0XZN5a
	imSIFmkQ7LlWNPVMEO1fnrHnZsjK/YeXDudQ578KVy8OfVT745EleUzm8n9bewiWDobrC0KQj4Y
	q7+p+ejiA8HIvQQ4iQMoBjypUmxLft3lWUh658t5gJuQ9oLMpw4NqiOyfp4jWU8lghIPoewXBnR
	E+N2fO9/vUbvEeYfbrvw==
X-Google-Smtp-Source: AGHT+IGzkoBqnyehkbfDzTwCdcn1HW4sajB7ET81b3OoXxM5Yqoi9MkliE9Ii9iQcjWdvhuJqQEQlA==
X-Received: by 2002:a05:600c:a08:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d7f066044mr31603505e9.5.1767699908086;
        Tue, 06 Jan 2026 03:45:08 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:07 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 18/24] can: rcar_canfd: Invert global vs. channel teardown
Date: Tue,  6 Jan 2026 11:44:41 +0000
Message-ID: <20260106114458.122333-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21350

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 790ec4c453890f1221ea595674a1206bbee41dc4 ]

Global state is initialized and torn down before per-channel state.
Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index cf1f478a87f3..246aae427582 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2212,14 +2212,14 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	struct rcar_canfd_global *gpriv = platform_get_drvdata(pdev);
 	u32 ch;
 
-	rcar_canfd_reset_controller(gpriv);
-	rcar_canfd_disable_global_interrupts(gpriv);
-
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
 
+	rcar_canfd_disable_global_interrupts(gpriv);
+	rcar_canfd_reset_controller(gpriv);
+
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-- 
2.43.0


