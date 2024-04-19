Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A65C04FFE
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:20 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web11.18433.1713526757884715933
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hSuf2RI6;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so2118537a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526756; x=1714131556; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXOb/bOZqd+J9Jz9egtzTRAMm44bEBe+eJ/DYthMqZ4=;
        b=hSuf2RI6ufKN07cgjZGRhLNvm3zZXFlFxOS8sX2HrXc5mSkv0oe0Iu1T4DLm7hq0+M
         /+g5xzeL7NVJ85+eVuA4XwmeT4IyaaniNV4iTY7EN1pA9Ahx5ZbQV2/NxQ/gBfFaATFQ
         AOSryNzZZ1bzVy/Cfaslz9tsKe0vnTt6S4DVlfCPUXplI2gP65WcoLwFWwn39Tup0d5T
         G/dyeUfZOHnjPDreW087UMCnp5+Q4vz7mK4vpYauwVvNz113y3GN6J5YGy10x2ZQqJtY
         qto0FzkjTw/nnNusJzMfxLM5UIYVMdSWY1CU+mtVTVl6pTZLI7JCQrHLpIhDjEnmwoPU
         NvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526756; x=1714131556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXOb/bOZqd+J9Jz9egtzTRAMm44bEBe+eJ/DYthMqZ4=;
        b=XsqEmyV5DSmiNYE+E2tiJ/72PjY3vRtNJlf5kb0wcIBVkKx8bVT3qNkHKlFwUcQf3f
         k+R2oT9TEa4DnK+f8SwZQmzkWV8Ic+TEvOIL6sphm+lZn3E9ueMR6yCFOSNYSwT1/103
         4gW3Q8YJFyHuNq+KIXZgYldSglDswNyGELA6n7qcoYIocPdsRWcTKsg7/mfXLQ7Ad+NM
         NskoSh4+5Dz95hFKRZuwvN4ofHYz1l4YtmE+y3UJeOPwFo8HdHQTno2+/ZAle2+23WSl
         k2I3g+jLULmqOBDV34xGyeYTPx+4dXOvO+v2Mji1sFE69XG/TPuyFTRzzu8C1TVMnMXv
         Bykg==
X-Gm-Message-State: AOJu0YzaeZ/ei51q5C5v2IVQnZW79+QpB/aSi+65M2JRvhYtEaCay9yV
	YJzrgA+IhxZteWSGEdK1Cevwv+IXv5Cd6qW0ExnKKduHF9AsvOQ1ckQ4rDLAe7E=
X-Google-Smtp-Source: AGHT+IFg/WbrbIZEP3Hkc6DQkUzFlwBjIC+YgDZT+gVdnivo3b6RGLBGva5dWJ5Ltu//cydggUmwPg==
X-Received: by 2002:a50:bb62:0:b0:570:1ddc:5e4f with SMTP id y89-20020a50bb62000000b005701ddc5e4fmr1179890ede.8.1713526756325;
        Fri, 19 Apr 2024 04:39:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 22/44] pinctrl: renesas: rzg2l: Rename rzg2l_gpio_configs[]
Date: Fri, 19 Apr 2024 14:38:20 +0300
Message-Id: <20240419113842.3675543-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15673

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
index 21ce68560043..cf11b8e08842 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -984,7 +984,7 @@ static const char * const rzg2l_gpio_names[] = {
 	"P48_0", "P48_1", "P48_2", "P48_3", "P48_4", "P48_5", "P48_6", "P48_7",
 };
 
-static const u32 rzg2l_gpio_configs[] = {
+static const u32 r9a07g044_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
@@ -1485,7 +1485,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	BUILD_BUG_ON(ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT >
+	BUILD_BUG_ON(ARRAY_SIZE(r9a07g044_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg2l_gpio_names));
 
 	BUILD_BUG_ON(ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT >
@@ -1535,10 +1535,10 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 
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


