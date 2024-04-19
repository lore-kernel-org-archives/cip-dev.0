Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5501C071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:20 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web11.18431.1713526757034393359
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kFHxWSoH;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.172, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d717603aa5so23498101fa.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526755; x=1714131555; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXVFonGLCQcYC4TuCjocbi2tFqr/DPBaWJRIzk1NbHI=;
        b=kFHxWSoHwszHEXZ8m1lh23RvFQqORkrr7SSCs8JL18Tt1iT/B45XjndOnvs/YxN7KD
         blWCnTc5IG1yaBbtUmG7NFJJfXM0j6pgxVOHiSrFN3FOXghLLBsP/CTYLOcW3NekUo67
         Z9tqGfHaqE0wquq9k5lxTOi91Pc1Ga953LyMAvS9gqpeqh7O/zhZ5TEt4jnkxFIRPiNp
         lVbVa/WX7UBnC8k/y0vMXsyanTXaXe410DVLSHfoG0YM9LDl00vhb1X4LpYFPcO5K7ss
         QOpuj1eYEl+0VTrGiYb5hPcgpP/ztkRXt2t0RmxURa0ZI35ADuc/i4uLeM1trtSB/MXs
         UTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526755; x=1714131555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXVFonGLCQcYC4TuCjocbi2tFqr/DPBaWJRIzk1NbHI=;
        b=TBOT3m2NFMCW6zDgM1Hpr7iIRJwjIvVO3pZ5qaHKesfL95EOfnnnwltOD45r3wE5W7
         kdzt8A1eIvubBGrBU1EmsH9V1QYJaAqLq1FbETgQ1xk4hfIs0LjM6AJ33DNJZHCi0oRA
         eMA5ed7JsnLI4jZgHHoNmNyIGkGX0rXO7e65Jd8MehNx/Zna87Mozm2NuPrLQCvxU1TK
         BLUwxs3tjVCjbPRGQGhopRK8LAObsjJIeLubFB3pWETzELZM0kM/CgpFAbHLXy7f10Su
         OfhPnK7itk19HcZ3pyTY+hysxXMGI33eoXsFXGNlX2/qceDE7n40Pb69bmqyo+JWLEgk
         xGSQ==
X-Gm-Message-State: AOJu0YxJ0ZOCSKt8UkqXzg7gQircGFNM3pF8YbPGD0XB4gr7X6ihzJh3
	64WZl3+bO93ZqbeDCo5Jnxn6TFzSYPn3OoPWLzsH9F0VSbqG1ObKAWiUgsUkHZ6QkOR+YTAAPgr
	4
X-Google-Smtp-Source: AGHT+IHCJ33uhkwj2lloeM1O12viplE5oCOTXbyBLcmav9vSwBUDnVrefG5sCadrSjuAppQoFna8Ww==
X-Received: by 2002:a05:6512:3719:b0:515:d164:2583 with SMTP id z25-20020a056512371900b00515d1642583mr1291649lfr.11.1713526755306;
        Fri, 19 Apr 2024 04:39:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 21/44] pinctrl: renesas: rzg2l: Make struct rzg2l_pinctrl_data::dedicated_pins constant
Date: Fri, 19 Apr 2024 14:38:19 +0300
Message-Id: <20240419113842.3675543-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15672

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 84c580e9695084d688904a18bfdc129aeca78144 upstream.

struct rzg2l_pinctrl_data::dedicated_pins is constant thus mark it so.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-29-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index b0ef821e7016..21ce68560043 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -132,7 +132,7 @@ struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u32 *port_pin_configs;
 	unsigned int n_ports;
-	struct rzg2l_dedicated_configs *dedicated_pins;
+	const struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
 };
@@ -1058,7 +1058,7 @@ static const u32 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static struct {
+static const struct {
 	struct rzg2l_dedicated_configs common[35];
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
 } rzg2l_dedicated_pins = {
-- 
2.39.2


