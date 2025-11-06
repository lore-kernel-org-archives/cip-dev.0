Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062FFCCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:15 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10091.1762416724647143668
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=L+UuAkaD;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47118259fd8so4375975e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416723; x=1763021523; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK/hfxW+raa7tbjhJkkIkm1mmmU2BTvdkM6FrHMsRt8=;
        b=L+UuAkaD4tcLWahNsNhcSqqC2CojsvuyhnR58qwNS9C2OvrQKZkejb1Fi+jy3ivFoj
         yiyOREFy29nhZBy0XDQnSlJFS/H4EiBs0nAEwhKs6TxRpwN+t3hRaJjykTn+65VRo7yN
         pkh+miF/1PyqpPbageZv0oO4DhAwz3JGCA34nlqtqcSsDzicTRtAFNSv18CJF5GbiYO8
         ofN0B1wWZ/4n+dWcw5SPzsqGsvvchNjFUwePCDeUpP8SNn7bUaEssjjPZIa1V0yaGyb1
         DBb4Ug6hMtCwWAH2+miJVRrTtmwsbi/R5qoloZidJp+jM8T2582tfbFGyh8hrKgoFpQ/
         1V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416723; x=1763021523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EK/hfxW+raa7tbjhJkkIkm1mmmU2BTvdkM6FrHMsRt8=;
        b=ZKYb8ku0vr9jsgYflRAVf62uKWZ5+ZzqSgbdLyl4s8oOsbSrEX8CYi0Sz+oACwG9Ab
         oG1iqYAAloJqFmzd6KoXMWI2336k44y/Gb8xY5IxEclDVKpM6UttMZh8Z3hxTkzG8qeG
         +dgUYR2n3K8Qu05UMMMFTIRy5sxQk22F0dRS2RhzJClYPr8kU7o/vk70OgxTkZP4YtLW
         5FMAbTZayQZu5DdDefIDWSHRq446gCeyBuCPxTcp5iPkJ7ZDuOwJiULt5pfYd8DsB5Nb
         6yGvQickpWT3pnr7fq41xWedtkD8NBuPhY+53uvyM5oF0pzuwj/dZwZfBwu1i41+cErX
         Eqdw==
X-Forwarded-Encrypted: i=1; AJvYcCUirNOwb9h67AF9Ey/Sy4iPuCSx2Xg4Zj3xyqaLQlDvSazybD6NToqlD778+14sqzXzalV4vxTE@lists.cip-project.org
X-Gm-Message-State: AOJu0YxGFYc2Do3VShsAGSzdqIwY2iSXjFbG4XjA5lKoUUabBRPi0Y34
	GA0AJrwdxUFNhVPBbY7n/hFaHnBqimz9ouh+508XRwq6Uj5pbV+OcRWHTgQz+NUxOwRwC+qpxWm
	TTJP8eB8=
X-Gm-Gg: ASbGncvdKzb0SxZBdS2wOieQEYEEghLGATBWotbw+dWcbet7RlR1UEmkGuCfRmFEX1x
	oPqVcth5zKhK5ahnVYQthyPv0GK4AYMiG8wkShWCRwpVoRDanbinYS3tCPII4Hu55Tgyq+1ky4m
	72qZ1nc+vPYsN9WSqoizfdkWBPHO8hc0i29Wpy6N0je260t64Z/fQ/QybcBBh2IcT9GTqUELSIv
	B96qqVsLmGC8bDDvckKYGpE9yktlnhJuFyCxV0ZbNmu0mIDCxvjDYPROCWl0UDRfF5FKbjle1ap
	5b1mlYTAlQxgTzZ+/lqmjQHHsPy9C/kh1PcmZJ+8vzfHEXTm3eyRdWn0aZ0y738Ehm1JsemAfL/
	0wVqYAb24b3B3m/U2NPpr5hRbELjF4fMSswBybs+hiY5XooojyXkqHPxsjxhyxdoXORzuz440Ph
	ykTs/TG4y2Y8R8Ip9qrxhGOZGGUy1FjemC8iaUyORE
X-Google-Smtp-Source: AGHT+IHTfgk1/eVfsRGugndGjPbg5lJ1Bhi7QPtr1zCTSzAmO7GiXT/ooYvin8aY+SzkA4MOFditzg==
X-Received: by 2002:a05:600c:1386:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-4775cdbd53bmr50558355e9.2.1762416723059;
        Thu, 06 Nov 2025 00:12:03 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 20/23] clk: renesas: r9a08g045: Add MSTOP for GPIO
Date: Thu,  6 Nov 2025 10:11:29 +0200
Message-ID: <20251106081132.2574638-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20413

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f0cb3463d0244765ab66792a88dc5e2152c130e1 upstream.

The GPIO module also supports MSTOP. Add it in the description of the gpio
clock.

Fixes: c49695952746 ("clk: renesas: r9a08g045: Drop power domain instantiation")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806092129.621194-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 6d7295c36d5a..69b027f52506 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -274,7 +274,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU2, BIT(5))),
 	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5,
 					MSTOP(BUS_MCPU3, BIT(4))),
-	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0, 0),
+	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0,
+					MSTOP(BUS_PERI_CPU, BIT(6))),
 	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0,
 					MSTOP(BUS_MCPU2, BIT(14))),
 	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1,
-- 
2.43.0


