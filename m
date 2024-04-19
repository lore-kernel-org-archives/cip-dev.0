Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53149C04FFF
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:38 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.15315.1713514712796690959
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pcDUWRuv;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso290874766b.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514711; x=1714119511; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbAYJfSHyWAa/RaHAACeJhexN6Yn1A33rLMrdz9biAY=;
        b=pcDUWRuv99awzZDd9V6Qwh9b/XRX1jkxgBxpuneY8ytG5XTG+giFwiQa81fO5+P563
         drOmIT9LxNVe5/DD1a+yNMERNs5yoV9nhlDU4s8CUV6QjhVMMDEHBQq4CF+kpvYBiGAC
         eGCC4z1ALJ6AwZKSb4hu/Q6YPtxsnH0Rsg9+xYeGJPPW8YeSbCNfungVayd6OPeDBk/p
         1EiLVW95RRLH3d4Jfhk5sWVHBracc44TpFwYwRVJ1jJftYQOREBSEUsyyf649wxoidxN
         i+5VZQCzXq1v3QOTPAVNBo8pah+PvCjppe6ETbAbz1LE0498DerRq+nPWr0HcIVKbZkk
         fLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514711; x=1714119511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbAYJfSHyWAa/RaHAACeJhexN6Yn1A33rLMrdz9biAY=;
        b=GEK6LMMyYgyvJCYlJWbzzoFk9gqD7SLU6aaWnFelR3e9rJpShKdozuwwaaW5PLO1nf
         JFqJchoxpMaVDzCaFbh5wMHIIA+lgf6ctoVoLFUvLuYyAEYbkmsCGzZbcGLmP3U2aVsj
         AetuYpraq3gHWy1RCHLeTxV+YDu+UKu1X6D7oYu9q2uzKrK/NpjcqWcV9CZhc1AFVaK8
         R/sx3dgYdazpoHutcZhZv0BpiPV/T8ipqM69br6UoONrCcI4lRN3xwthiR3b529Fucsp
         EMsSJNMmA235QyE2F0H587Z3mM4T/mP83i8Knv/qQNyUyzTM6jP49iArvp8YWbYgJbSs
         QjhQ==
X-Gm-Message-State: AOJu0YzfVXwR7h44hiDWSxqHdDZ3ETx4WRxIc2TuYwnLYczGQPdwXL+j
	EAsmFU80awuTBKiZb02yBHrI4AAHe7/kIJbFfpYqfKKVq2A7QM/mgNEix4UP92Y=
X-Google-Smtp-Source: AGHT+IFG8a2UixQX8uR72NZQZMa8BdO9vOr/FuEBdSe8VFdcekkywFBv+937K4BeanaqN/M9mjbgMw==
X-Received: by 2002:a17:906:28d1:b0:a55:6c07:1569 with SMTP id p17-20020a17090628d100b00a556c071569mr1408934ejd.0.1713514711269;
        Fri, 19 Apr 2024 01:18:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 31/53] pinctrl: renesas: rzg2l: Rename rzg2l_gpio_configs[]
Date: Fri, 19 Apr 2024 11:17:20 +0300
Message-Id: <20240419081742.3496709-32-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15618

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c385256611b1af79d180e35c07992b43e1be5067 upstream.

The rzg2l_gpio_configs array is really related to the RZ/G2L (R9A07G044)
Soc only.  Hence rename it to r9a07g044_gpio_configs[].

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/19958e63a2b793be5182640c4301ec5a77a507f6.1695369116.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 4802c6b1302a..beb6fd73c3fa 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -981,7 +981,7 @@ static const char * const rzg2l_gpio_names[] = {
 	"P48_0", "P48_1", "P48_2", "P48_3", "P48_4", "P48_5", "P48_6", "P48_7",
 };
 
-static const u32 rzg2l_gpio_configs[] = {
+static const u32 r9a07g044_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
@@ -1483,7 +1483,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	BUILD_BUG_ON(ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT >
+	BUILD_BUG_ON(ARRAY_SIZE(r9a07g044_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg2l_gpio_names));
 
 	BUILD_BUG_ON(ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT >
@@ -1533,10 +1533,10 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.port_pins = rzg2l_gpio_names,
-	.port_pin_configs = rzg2l_gpio_configs,
-	.n_ports = ARRAY_SIZE(rzg2l_gpio_configs),
+	.port_pin_configs = r9a07g044_gpio_configs,
+	.n_ports = ARRAY_SIZE(r9a07g044_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
-	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT,
+	.n_port_pins = ARRAY_SIZE(r9a07g044_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
 };
-- 
2.39.2


