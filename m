Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E07C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:43 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.10266.1746783162593383515
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P1kt1tC3;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac3b12e8518so384641866b.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783161; x=1747387961; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnBkCG4/6TrQEEyX+ydsYNCguNQ/xOMynXls2Ij4dVA=;
        b=P1kt1tC326KdQy6sNtXMJxFWGFGvGyqVld2efmkjXhXPwS4d5SF0050KFUAbkvjivl
         OQ7zsu7PPwmXSENlLeprxkpg4Xeoiuo613VII76xEbfRudi7ZnoHMYDERjGrtWK9K8dc
         faAEU9bBlVegk4kHfh/ON6qzZbKeuakJd4xxdoaQx5UKJAWISGDBFPQ8OOf7RaalpqoW
         1fT30xiBUfbuQPkFHYywJPqQ07KUny6DuULZ891hEbjF0DkT+009TKFDj9mduBpg+jXl
         q1DB610j67KdSp+rye+yYLhsKLqq7c6MWj/Fk6rMn4Z6H1MWDu+/CkcQjEatPKNsXbHv
         mYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783161; x=1747387961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnBkCG4/6TrQEEyX+ydsYNCguNQ/xOMynXls2Ij4dVA=;
        b=E5Ed09vmSi44Y8W9A8jESe7eLEWhvMibhBEhuLCRU4nBa2Kk2hQXV5u5s6InCWF4Tp
         jIhLZ2XfqFizf6o4DSpUV+d6APmMi4s1oY/CigIqYhJ5TAltBZXODRhjZTVhlmb5Oj6N
         PSXRhSobRQrrRLwINNArXh2i9w5tFrcRH+jJKg3+CgW6zSnIq3jWR/Fx3wGyfp/++FAN
         AyC0dJXXUl5wkXuh+4ERGtCndE7wkdrk2xENCzpmCRT1bI3qt33qpMZ24jJMkLWAXKZ/
         YGjOwuFMK+NRQGY+9TqDTsWohsGcvbgqyKMRnIVKSEYCSL1EKILzf03N1kBSIzw6K/WV
         CjRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBIDqD5UyzY5HMqGg10fVZAO6kDu6dAkenri85hBOXsd5g32HNvDh9hhDzGaMO3nYd0UAcngUf@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy6Lw9r98W2MiTKiLFfrSAn1P6A8IAMDv5CYeDh5cWnxsnQxpir
	y2V8RGjWZFgZ7CfyhHDcycnh5cF2l/A68Qj/7epk/EWV3eGpY9EvwESJOBDXaJ1bRFK2ATtvJI+
	+
X-Gm-Gg: ASbGncvDJ9cBUmHMPgj2OUyM3klLllvGPOpIunauSEQBArNmoCE7v32HQ3YM2pGnwmR
	90vq8lFgK6LFQtYKPLxpdX+aw3rzdDW6JnTLdmyw3l50TPam6QzKBVW1zQS5FOfJqitfp1GpLOQ
	IzX0++dJ+LjWtV/rhYPgNPUeyWL9iYqzppAI/0z/a7J7CZOkxamtQEvcNkLVc7gmFu95nctBusw
	TspbjOc6dzCN/yO3wfHvTkMiSG182KZwvmEWoTbqY6CAcjXz90pzo7NgD+rdLDEwSfr/S2yZtPC
	tm1dv0sSu04XJCDq+pOrzn37ZkoOJVOxhGBj3sbSikolZ2oeaMm2zbxir97ne9SyWAbOi8A7ceZ
	bdO/F
X-Google-Smtp-Source: AGHT+IHlXxC/8tKm7/0+Md61uJc2jEw50aiB8p/hQOheVutKM98x7u5N9EdXA7heiq6iLCbrCoprsA==
X-Received: by 2002:a17:907:72ce:b0:ad2:2949:bdfc with SMTP id a640c23a62f3a-ad22949bf5emr31604266b.3.1746783160970;
        Fri, 09 May 2025 02:32:40 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 24/29] pinctrl: renesas: rzg2l: Add audio clock pins on RZ/G3S
Date: Fri,  9 May 2025 12:31:58 +0300
Message-ID: <20250509093203.4014750-25-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18811

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 03fc60cd8e7b7e6f330d0a48c54545740addd9d8 upstream.

Add audio clock pins on the RZ/G3S SoC.  These are used by audio IPs as
input pins to feed them with audio clocks.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241113133540.2005850-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 99bc4b558378..0b139128d825 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2192,6 +2192,8 @@ static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
 	{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_IOLH_A | PIN_CFG_IEN |
 						      PIN_CFG_SOFT_PS)) },
 	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x1, 1, (PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS)) },
+	{ "AUDIO_CLK1", RZG2L_SINGLE_PIN_PACK(0x2, 0, PIN_CFG_IEN) },
+	{ "AUDIO_CLK2", RZG2L_SINGLE_PIN_PACK(0x2, 1, PIN_CFG_IEN) },
 	{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0x6, 0, PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS) },
 	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD0)) },
 	{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
-- 
2.43.0


