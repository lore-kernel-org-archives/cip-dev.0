Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7709BC71148
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:20 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.7116.1749809777744237329
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=FTWGUe1Z;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so4049901a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809776; x=1750414576; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhUzkSLFoChtvkN5UrPVkR5tTbKsoIq6eu3+CcoP3TE=;
        b=FTWGUe1Z1lcw52BCTM9Kw5Ht+k0hr1Tf8OhS/lZp+Xuo5sOQRdz6VMwN4djH7e40Dd
         jRpAIrTZW0tbt+hii7ooggFAkt3EmR1MmsHSPYwvlTtQIff4N0EyvCFfaQz7wqTLONTk
         FpKmHFGlu4Qbtb42Kmh1jWQRmE3OjXpDzjFLbnk+5cwe/6Y+/YMskuXBHx6o1F0Lfu5c
         YpsNppcklx3oKMPiYy2Tb+4xEmXaVtZMt24OECMFi857CgTmWc+J7oNYPlC9osgqzngo
         pzKegfOmRbm1ZtbVCtemIoE0cQZ4wJ+lEkMZmjRa9w4b3/pOiZHZLiXvTUbNHewC1FaV
         R5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809776; x=1750414576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhUzkSLFoChtvkN5UrPVkR5tTbKsoIq6eu3+CcoP3TE=;
        b=Qxm0ohKaiuFEFybC+YzFe/oyAW2yzVPRdivFsYG5JNFdcGFMmEX0TN2j1wnFpk9dj7
         d+e5lAI0Eut/a+sxoMHbTVxuajK+WGd+9RZZLi/KxfLCmhYLz1RoUQr+VZPUBfCAclPR
         UPK/hRgCPF59DO3UL9rqsH8Q+/VUCF7PN5p+QX/Hv8hM6cS/jdlc8W8dYMtjRa3E2y2n
         0/F/t+Z8d1dLEVn28eeMzOLZn7F2rTTK/9s3bIpUvgYwVz3TQeGxGT2lasvUXVYwYCht
         xbScZmBtuF5Fu5VdGveycj+mN9AvWfQ9icosia2he+fsUjacCmyS8gSulrAbf/AxjoL5
         HsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBs6dcTZqapeWL9rBgPQwOwYG03lnde2jXSAqr3yPYgWNgs9ubb/tflgbgHFORDbiR4xWmR883@lists.cip-project.org
X-Gm-Message-State: AOJu0YyI8pUS0B/98d5bbFW7liTKy0DT3PmoFdllTFTjx6qCfp8syMZo
	GLiOyOrROLYo/aCVKeSpWO8nA5Od1jMfw+TjRruN1at6KVF/mienSKWeknag6WNbblU=
X-Gm-Gg: ASbGncsM2cnkpixCRvSM0K9iG26YxhBtLq33O0T9R16CfFwM4Y5VKZXd1R/oQw9skzT
	jCUFVW11nzrZo+w/ht1Kkt1KTcTeOFVGjhZXFZeRM1oizKJjP70e7G2wgqdhjqvm1cvXyjThzCs
	nIIWKeJwkaDujZ2vVfI1ZpvDILT5iCMT1fBvx162JUCkkQ3lxLB5j+v44rlPOauniy0FHWG416w
	Fd1KumZzQkSZVHuOEFLRTEIKuh9ptEgwG5HVoC0UcePt38df32SnXuGVNIwZG/KIwJnTA+Kx9dk
	7plKAU3CWPtfD8MFdq2/HRALtpRXqn4/faKxoC3D6t7iyeY5ARnGNnB+ql+LluFLsH3T+UQh/VK
	XSGw5Pnb0zeWEp5i8
X-Google-Smtp-Source: AGHT+IEuRf7kKFHt7atwBUgMiZi+SW4q9gX0ZiK0s/XIjOJYZuKxjnmxhWzH+UPSEHGRa9bVQjo9SA==
X-Received: by 2002:a17:907:86a3:b0:ade:3b84:8f04 with SMTP id a640c23a62f3a-adec55fd88bmr244650366b.21.1749809776111;
        Fri, 13 Jun 2025 03:16:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 01/14] clk: renesas: r9a08g045: Add clocks, resets and power domain support for the ADC IP
Date: Fri, 13 Jun 2025 13:16:00 +0300
Message-ID: <20250613101613.296649-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19070

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f962745289958e89bf520407728e384e52ea8e27 upstream.

Add clocks, resets and power domains for ADC IP available on the Renesas
RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/20241206111337.726244-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by keeping RZG2L_PD_F_NONE instead of
 zero for both scif5 and adc power domains]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 70ad59f63d45..5156032f9fd9 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -187,6 +187,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 	DEF_FIXED("OSC", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
 	DEF_FIXED("OSC2", R9A08G045_OSCCLK2, CLK_EXTAL, 1, 3),
 	DEF_FIXED("HP", R9A08G045_CLK_HP, CLK_PLL6, 1, 2),
+	DEF_FIXED("TSU", R9A08G045_CLK_TSU, CLK_PLL2_DIV2, 1, 8),
 };
 
 static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
@@ -238,6 +239,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("scif4_clk_pck",	R9A08G045_SCIF4_CLK_PCK, R9A08G045_CLK_P0, 0x584, 4),
 	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0),
+	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
@@ -274,6 +277,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
+	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
@@ -368,6 +373,9 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 	DEF_PD("scif5",		R9A08G045_PD_SCIF5,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(4)),
 				RZG2L_PD_F_NONE),
+	DEF_PD("adc",		R9A08G045_PD_ADC,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(14)),
+				RZG2L_PD_F_NONE),
 	DEF_PD("vbat",		R9A08G045_PD_VBAT,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8)),
 				RZG2L_PD_F_ALWAYS_ON),
-- 
2.43.0


