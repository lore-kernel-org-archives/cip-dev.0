Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E564BC44502
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:28 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89966.1783076368133671562
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FGpKQobg;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-474560436c3so471012f8f.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076366; x=1783681166; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJScGHrvr6ePXe6LsTzh9hQ2PGw4gZ7ky1qbXNuSMCI=;
        b=FGpKQobgbqlSzga6ZF28DSimG63OWJ9FovEKoc+BdPEYPiuB5e6evXrt0zd88xJSxR
         AEeoi1qJMN/TO7hn9KV/iLRio8oDRczwqwPKamsXIFUwVB2vXhUKBJdmP+FUDs396g33
         uXXNouACzTkDmv2Um56vlsdfYjHJ1nCizJwK7sCINDKvEYTUHvQQvFGvYTpcaG1tGAGV
         BLfv46jzAc5xWv4dmtJO/ZvlzBHly8qtGU1/KITTFKMu37aesbUxtG/dcTPpmj02xSNm
         i0jrdNSkN6NIkAGQykQb8ey+5s1WlXgaDoXa0ucsFaD3H4jSb/1qJkd6q7/yyuUjbhoz
         Fhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076366; x=1783681166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PJScGHrvr6ePXe6LsTzh9hQ2PGw4gZ7ky1qbXNuSMCI=;
        b=Mp2jvNGgv2iPFQUe7D50BfdsPD83RuDj7PHPN0uiCcB+x4Dy66mr8bMqQwVOzLafwD
         hVmnZRJwrof1WjmJuVER29/qQaQkU+G8uiJW0H178QplIrhUre9Hlg0+M6/0UYPwfGql
         ZWn5MVqcS394UblYRYW+yoFYdBbYZEmsWuCvjXEapFGTLzPlWcnlq23EtY7neIi8rLED
         JYuvgKFHqSXQ3K/DiwSLmyomLww5TmusW1UKx7W7vS+awohQlt0GHhBGIvo0F107ryVe
         8cbRwtIEMGft2VnWEinltdwgzcNoSimxS1fet/q+gH4tnSvA5b0PCAZd6zAtiCKG/7K8
         OdVw==
X-Gm-Message-State: AOJu0YyR5fW5iVPfiThSXWEImLWq+oZb0qXpTzUcjr9Hxin1S9c8ukll
	N4sRr9rKK/TaONqJSrAmhXVHwh55Cx3Uv+hAOvEAtOErQM4vhJHH3y0FrZBIApCe
X-Gm-Gg: AfdE7ckx2eM62anIfrcU3P4qoy7WzziEcY+KqAjIP3GvJqHbGyjrvB04A4WTjLi1ZK3
	IGNtki4xXTbSUVOIUDQl0DRCLELX0AqfiDyQJvH71KRir4ekC0IGlmv2a1Swuc0W+/0bT4YvQVN
	g80ndKUSNLI2FFZllsaC3Fk4lSkW7TKndUst8RPNrcfzzAJiKY5zAAPSelHYdYl+h+Eu5gpx0mq
	/hVhvOxvXuH2x2DfjsgE+cuHc8c5C2I83iW4KbfJjtX7GSa7t/eY+Enajps/Uy/JBKdAmP4tOR3
	aSlvqu0jTp2vCbq9l+9RfINd8VCIYO5MEHFBO2qy6/9p6UPobH8m2S2rc+PTuCw/BJbd74DAfof
	2G3jzFHeiMRzBCdID5s1IWit92plrouBZ3bdu5HCkKuf6i1Intb1srDONOjax7S3rwwidOkpUpD
	9VWyN2dK73ZCFG723uENW0
X-Received: by 2002:adf:f104:0:b0:477:6da:1b83 with SMTP id ffacd0b85a97d-477af9dc11bmr10361919f8f.24.1783076366270;
        Fri, 03 Jul 2026 03:59:26 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:26 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/23] pinctrl: renesas: rzg2l: Fix SMT register cache handling
Date: Fri,  3 Jul 2026 11:58:55 +0100
Message-ID: <20260703105923.251255-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23423

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit c88ab9407986836820848128ce1f90f2fa49da95 ]

Store SMT register cache per bank instead of using a single array.

On RZ/V2H(P), RZ/V2N, and RZ/G3E, the SMT register is split across two
32-bit registers: bits 0/8/16/24 control pins 0-3, while pins 4-7 are
controlled by the corresponding bits in the next register.  The previous
implementation cached only a single SMT register, leading to incomplete
save/restore of SMT state.

Convert cache->smt to a per-bank array and allocate storage for both
halves.  Update suspend/resume handling to save and restore both SMT
registers when present.

Fixes: 837afa592c623 ("pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt control registers")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260413182456.811543-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index ad51cf232aed..5d4ac07533cb 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -335,7 +335,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u32	*iolh[2];
 	u32	*ien[2];
 	u32	*pupd[2];
-	u32	*smt;
+	u32	*smt[2];
 	u8	sd_ch[2];
 	u8	eth_poc[2];
 	u8	oen;
@@ -2746,10 +2746,6 @@ static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
 	if (!cache->pfc)
 		return -ENOMEM;
 
-	cache->smt = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->smt), GFP_KERNEL);
-	if (!cache->smt)
-		return -ENOMEM;
-
 	for (u8 i = 0; i < 2; i++) {
 		u32 n_dedicated_pins = pctrl->data->n_dedicated_pins;
 
@@ -2768,6 +2764,11 @@ static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
 		if (!cache->pupd[i])
 			return -ENOMEM;
 
+		cache->smt[i] = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->smt[i]),
+					     GFP_KERNEL);
+		if (!cache->smt[i])
+			return -ENOMEM;
+
 		/* Allocate dedicated cache. */
 		dedicated_cache->iolh[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
 							sizeof(*dedicated_cache->iolh[i]),
@@ -3075,8 +3076,14 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 			}
 		}
 
-		if (has_smt)
-			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + SMT(off), cache->smt[port]);
+		if (has_smt) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + SMT(off),
+						 cache->smt[0][port]);
+			if (pincnt >= 4) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + SMT(off) + 4,
+							 cache->smt[1][port]);
+			}
+		}
 	}
 }
 
-- 
2.43.0


