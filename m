Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DABC25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:57 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.8671.1716970489173552514
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=B1zN+7QW;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4210c9d1df6so15290765e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970487; x=1717575287; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ASL8DQKy8xO2SNT9rPOja6Licbc4zExqIQNC+YKsAQ=;
        b=B1zN+7QWDmMqV/e64pXGP+6R4vzk2OZyf6HwvlbCELiEiR3Kp7UJS1eR7EvyG+I8zd
         evp9M/0WMpOHk/lXm8pCeVn3HV8TvPXZgtaN5ovAJn9hnzFZGyZo6hLvWe6lsW/IIRFT
         WHDnc/W8wHbR9MI7g31Q8us5c7q6xXsN9yJ2f3R1vk1jDoiHK7U/l0jKRxK4ql2pce8b
         Kon4qVIcFveb4cyx5coOzG7xkxFm5DqBI5vLQqHd8xz1VPh8lZnHZunN/oddebEarKPp
         VR634Gk9kvN+VU1RyQouvqEGlmOPu5jZ1FTnKcIi+wyP1WnPRufgOxEuwEf3Ne7qEBMe
         mDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970487; x=1717575287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ASL8DQKy8xO2SNT9rPOja6Licbc4zExqIQNC+YKsAQ=;
        b=iz6hd/7XLnNSoI3D6hbn5CQnNf9LIR2PQkLwkmKh5gGEPfReJFULQ2csqVk8oePdu0
         geX5KaJFx+AN4WCjAO+PwbIPMblAv+qhTEZyqNK3086eF3Mk1R9LCZLn+/bzXnP80ccQ
         7FIySuVLo68EYNmMADeclhJDLHW0CAAfuYSQcSxnDuVzvAvVut4XtLEItm2kXK+iUXj9
         P4aJjvS3OL34tshMsWO1SeWh4holq7w+KzDasC+Kmd9JvMLaC3BJHVVKuomBYmSXTk2X
         7v4NfUVRf9UOJTYVTb9aqzIlUWZBhtylhS1lXqz0FOXji8iWUtOfGMtF6VPAbJ6n6a/G
         UFyA==
X-Gm-Message-State: AOJu0Ywfsaj2vINLbq5UVzNM7C9Y5QwQ1LG6rvaFGNXuBTVHfEs1eq3m
	DDZau9H8ZyvMnCQ0Dcp5M8gFpLKmblVHwzJROLPP6VwuUSc6x++9VNk4FPFE/lc=
X-Google-Smtp-Source: AGHT+IGAvrMhohOvOqeoPSZpIBFT+D/zFjc7BThWX3AqbsPjFOG7ohjfJwpkl4A48OxCQKw/wTCRZw==
X-Received: by 2002:a05:600c:4f14:b0:421:e89:dd07 with SMTP id 5b1f17b1804b1-4210e89ddcfmr80690495e9.2.1716970487655;
        Wed, 29 May 2024 01:14:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 06/33] pinctrl: renesas: rzg2l: Add input enable to the Ethernet pins
Date: Wed, 29 May 2024 11:14:07 +0300
Message-Id: <20240529081434.639519-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16034

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
index 188284e70636..0277ebf3bcb6 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1443,7 +1443,7 @@ static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
 	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)) |
-				      PIN_CFG_OEN,					/* P1 */
+				      PIN_CFG_OEN | PIN_CFG_IEN,			/* P1 */
 	RZG2L_GPIO_PORT_PACK(4, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)),	/* P2 */
 	RZG2L_GPIO_PORT_PACK(4, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
@@ -1454,7 +1454,7 @@ static const u32 r9a08g045_gpio_configs[] = {
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


