Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC967C27C44
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:10:55 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web10.8633.1716970252490930059
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZiKBclZH;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52961b77655so2021252e87.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970251; x=1717575051; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHoCSJtWFYDBm9gN29zxfd9NDDGOVbQ+fZ6tqxis/Y4=;
        b=ZiKBclZHakyLLAMrOBPyLn/jcZsUgN37RMpKaHZ865lF1rB/ym/wlZ40sS/Usr9Wb8
         4gvdhEGTnd/rTmMleZHkwacaU3r7/DAdstZHML/+EepAYdvWhbPPhpnoPopgUeS+lRpW
         L90stkU4j/jQhEgIkBfRjeXYMM+NN+eAJWO3SPxIxQF08aTsEuzmj13109OSCca8Rs5n
         JBMV88ty3RyT4DNXLcPUxvFKwYdYPdUd/iCemLTSZ9gleZWHnn/+RVydxmZjPt9x0f00
         gYjGtG2gUxUI64agPR8hPx5+SUbE/KrNF8egGX+tjyMJGUOCeWmYoCQPhKDvsooktUbb
         D7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970251; x=1717575051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHoCSJtWFYDBm9gN29zxfd9NDDGOVbQ+fZ6tqxis/Y4=;
        b=KsVcZSnzrVAtFKiX97lw9gt6c05bz+SawL7rj8feLr4zzhoyZnyvr9X9wanTRTlGkh
         JdLmZLpDkI4rJNchHDEV1JIgEQNQtI2StfSajzl0Aj1QCgNc7tl3l1Y+jqwqcUNL7DRA
         6U3d2t3YuVWLXdHs2MUMzAuKO7kV4Oyjqq1WZH0APJQAm7l51spqW2+9pzOz6krZSw6Q
         Bma1y6sW0xKIgVsU2zp71KpGgfrV+Jvd2GqJun5EsWZiOtUPOY22YSRoTUFu6A6uBmT2
         c66nhNK4A+D0TUwduepN00wJcQUzP9is3S2WhKl3Ge5BzbBFFNkgt3lmJX1lBou+wl+1
         haJw==
X-Gm-Message-State: AOJu0YyMRtlkY15TiX1jmItBCXaqV8PdZRIXBlDWaBnmTsPsQUmxqXQH
	MASO3pjMaAs/f9AajcHQLwHMbOI77E2EVkGHtLtyIyt8bm1aFAW+1eR++Nnot9c=
X-Google-Smtp-Source: AGHT+IHC9L+DC704xwWabRFuXGyG1gEBpXBypPnbZmeKyUGNIk5VVWK+QrEsbU7GCIVIkmAqQP42bg==
X-Received: by 2002:a05:6512:1597:b0:51d:3fe4:c3cc with SMTP id 2adb3069b0e04-529613bf320mr12145775e87.0.1716970250711;
        Wed, 29 May 2024 01:10:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 06/47] pinctrl: renesas: rzg2l: Add input enable to the Ethernet pins
Date: Wed, 29 May 2024 11:09:58 +0300
Message-Id: <20240529081039.639010-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15986

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9e5889c68d992b65efd10aa0a4523c96fd07077f upstream.

Some of the RZ/G3S Ethernet pins (P1_0, P7_0) can be configured with
input enable.  Enable this functionality for these pins.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-8-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 6d0b10f77692..bd54ab706654 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1440,7 +1440,7 @@ static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
 	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)) |
-				      PIN_CFG_OEN,					/* P1 */
+				      PIN_CFG_OEN | PIN_CFG_IEN,			/* P1 */
 	RZG2L_GPIO_PORT_PACK(4, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)),	/* P2 */
 	RZG2L_GPIO_PORT_PACK(4, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
@@ -1451,7 +1451,7 @@ static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(5, 0x22, RZG3S_MPXED_PIN_FUNCS(A)),			/* P6  */
 	RZG2L_GPIO_PORT_PACK(5, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH1)) |
-				      PIN_CFG_OEN,					/* P7 */
+				      PIN_CFG_OEN | PIN_CFG_IEN,			/* P7 */
 	RZG2L_GPIO_PORT_PACK(5, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH1)),	/* P8 */
 	RZG2L_GPIO_PORT_PACK(4, 0x36, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
-- 
2.39.2


