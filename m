Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435EFC04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:38 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web11.15276.1713514709766139406
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fsuOio98;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.176, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db13ca0363so28673281fa.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514708; x=1714119508; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idlrwZ6ruYrVty70IyfSi4kAzBYExi9wCGI7/bjBgHQ=;
        b=fsuOio98eE33i7JLsRNw3VlteVgktzYIHfqZEVAboJF6ocVN6tM1I1tJSSdZgK6NQU
         0n3BUedLIAG7Qdoe4Y7v4jxjxhxk+LyXH0/OrObXl0mTydcvdPlJtNi+EKd1MB7HbXo+
         HXc2LA56OL8dBDKDDeShltkgoghFd2XpwnsVTLE3gMsrWru6wUlEZrAChjSXHEcrPaNE
         YjSxRL++adR6VKwoYY6jOCKew2OfXgU1qpaGhWpi8bha03QOfwPoHIoThzHfgDWo9UCT
         bLUFNbWsqFUnE2YUCBv1vZ2scrjvfqD234nnR8lrenHdcHM312fa0KEHHgSN6u2ioFb4
         s5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514708; x=1714119508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idlrwZ6ruYrVty70IyfSi4kAzBYExi9wCGI7/bjBgHQ=;
        b=V+6zT3TpPC8P/fd0T31BcA1nOJy9KihRnfbk8wE2qGy/jtw1KDrzKn/R04XeEGLr4Q
         U5yHqs8AcwM9f5QxeMaaZfHYn0dX/TURHZ7mk65ykefcWYDRIYJIaqoVHSVSOzc3TCSh
         VRdU061dJuwX754XbBMQhiYYmYeUnqwRj2Tsa73rDZbYf/N6vAlEdkXjsxhsGyxr3+4T
         Hoy1uOQSJ0cOxOuHuFUO+Gf8NKBCbtQmBZvI9Ixh8QhyF2vjcRVjGBziwypTzwkSAcJl
         dkc/XmWqxARqf2xFt0lQz0iwNcuN1fMunUqnWcavVQ2WiH4p/ZHbsKNtvXBqMHzFzjb5
         iTGA==
X-Gm-Message-State: AOJu0Yy8c3ITvt28IUpVg5FF9eTD+KoyMDDQtFoSht4SpTxP2crFXVpz
	0R1LjL7UHFGfMXGYwDpqnrN/LHkdaabxF9irwGpuePRoobc3zke2Jj4wKzP3jiMPvaGxIDcs4Lv
	1
X-Google-Smtp-Source: AGHT+IG3jTNFBEs1sh9oDsLrCz7mYNLjjHYXjJuKrWmr56hJvqB+0WLA/ASBeDjJVhn3iR2qz5bI/g==
X-Received: by 2002:a05:651c:1046:b0:2d8:6ca7:2165 with SMTP id x6-20020a05651c104600b002d86ca72165mr1060878ljm.46.1713514707983;
        Fri, 19 Apr 2024 01:18:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 29/53] pinctrl: renesas: rzg2l: Make struct rzg2l_pinctrl_data::dedicated_pins constant
Date: Fri, 19 Apr 2024 11:17:18 +0300
Message-Id: <20240419081742.3496709-30-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15616

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
index 2965c67d8ad0..e1d1142637ae 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -129,7 +129,7 @@ struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u32 *port_pin_configs;
 	unsigned int n_ports;
-	struct rzg2l_dedicated_configs *dedicated_pins;
+	const struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
 };
@@ -1055,7 +1055,7 @@ static const u32 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static struct {
+static const struct {
 	struct rzg2l_dedicated_configs common[35];
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
 } rzg2l_dedicated_pins = {
-- 
2.39.2


