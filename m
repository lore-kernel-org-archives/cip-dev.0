Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EDFD6553A
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:35 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11769.1765967547264238151
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=b3ZdK3ur;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b735e278fa1so1020827466b.0
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967545; x=1766572345; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ1QUy7p9pe972g2x2+icyG+6tl6ql8lmi7JgS33RGo=;
        b=b3ZdK3urtjcJ01CukS8hUQ4PaqXQkp1hZAU4+sOxFRoJKaEdpe+nzU3gXcqrNT9mC0
         7w/KX/uZiSZKWWhXfurRI7HZZUYXXhDLt3VRvmt37gdV0OCY7sWwMKaZ2Ki6xHjX7e4p
         mQHUyrQdqNmS2AjFIDPQRdEURkPYjpoWXQin/BPo50o9jm+/H8b6PepxGzshWUIusYjQ
         Kdr7GmpNnXzxawJfuhij4yWqrN3E5WVsrhmXZwDZ1kBOe6fQ2TRLgNGp8KiY0MxREk1X
         wm3DYRraFbIVDipCikHUGpjqCEfNnZZPRff2Fa7QkoKqe5+pXG38fDBLXMKzx9wG3rFM
         No1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967545; x=1766572345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VZ1QUy7p9pe972g2x2+icyG+6tl6ql8lmi7JgS33RGo=;
        b=ivk/9KRPKLMBjv6zO5lZBS0r2psc9ZgKcT61cYWkCvvO1COQSdPOItW7+Kw2z/R1Qs
         H3PhhCDoFML1xU4oxpbM5009+Y9ewL3rbqs8HhkjmhzrnPspbvVQ4Lk+jKs+C/w4zXw5
         Z21jNvsa7TyJgyECP0PsVlzfvGY+zdhnOEF2cwUOXQCLHJGwK7JB8CbMwaZEGKYtS3vg
         fXcmCzQ6caU6/alFPi9x4HeO4gLUNQMHDQTGSD7kEcGnkgynPoxrbVYDXfhaqzNv23WZ
         8bf/7k7ziaFNYeURaVZMzsQE5N/u5a8oDGTuDThevb1nEtXOfWwwvZNL1YFDNF0rWC5+
         9VDg==
X-Forwarded-Encrypted: i=1; AJvYcCVV9Ra5S5mjJ9sLGqyRJwa3ax0j3shox9+ASgXQlhIcd73JDaZrKzbUpQ0rxaHq39hBQ1c44Gtu@lists.cip-project.org
X-Gm-Message-State: AOJu0YzZCaz1H0Wn1yGwEzXvLnGQmoUlBj0tRmHz2qJPJyB9BaXParaW
	nFLW7pTmMJyGIX5CyS+S43aNfbZ72wwnA8oOcL00VdCd0079Sm5SuDy8KGgT/oc28Hs=
X-Gm-Gg: AY/fxX69s5Yb6YDxPljbS33vRZ2LqNd0FHLt0bJz8x+6JcPwSm/Db+uzHL0C/7uN/wZ
	JE5Tx8cjIvtUT3+7r7dbz1x9DgJ2QKnbOxN13ny94LKQMfi2JulL9uAAI57Pj1Dpq5PNDq1d6/g
	+3BLRafKyN20/w01INg2wIcp751Ug3H1CBDWqUQDJeUDd12UjqBBfr9Uo2mj+TFhV0wy31ebznL
	/+Gv3QxWOqXL6MpZcQk0RJ1F/U8+0U0wtP0AisLvn1iFAuEbLK/gMCs3MbhgO8f4xxmwlx7ZYsh
	XtCZeeMQmCafxhl1umRGdFs9XEqz/RhfhK02NLmV7kIR5HJwJEb4qkHm5uhnduhwxeZWIImsMEX
	1cKaW4meghn/NHPaX4mTpeAVdtRPYgWB4WLmWsRtnG65dV0p9xTBfqA+4Yx7yVqKb+ZkWsVajFA
	/b8prjZknjnyWHWKLarejqAsgkbydtEX4hTrMEf+OI0rNKeSxPDsU=
X-Google-Smtp-Source: AGHT+IFq5LoZrlBK5FL+fox0SI1vrAnExSc17eYdbpmkI/fwBnkZJroG0UpTEnr3H4LYjbBLqcQu3Q==
X-Received: by 2002:a17:907:94c3:b0:b73:8b79:a31a with SMTP id a640c23a62f3a-b7d23627315mr1780852566b.16.1765967545516;
        Wed, 17 Dec 2025 02:32:25 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e6edesm1955414166b.18.2025.12.17.02.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 1/6] clk: renesas: r9a08g045: Add clocks, resets and power domain support for the TSU IP
Date: Wed, 17 Dec 2025 12:32:17 +0200
Message-ID: <20251217103222.4183089-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21114

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5599c7c4b4df440aa4a470a5b72669081413981f upstream.

Add clocks, resets and power domains for the TSU IP available on the
Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250103163805.1775705-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by using RZG2L_PD_F_NONE instead of 0
 for adc and tsu power domains]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 5156032f9fd9..7cdce3cd7dc0 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -241,6 +241,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
 	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0),
 	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1),
+	DEF_MOD("tsu_pclk",		R9A08G045_TSU_PCLK, R9A08G045_CLK_TSU, 0x5ac, 0),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
@@ -279,6 +280,7 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
 	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
+	DEF_RST(R9A08G045_TSU_PRESETN, 0x8ac, 0),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
@@ -376,6 +378,9 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 	DEF_PD("adc",		R9A08G045_PD_ADC,
 				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(14)),
 				RZG2L_PD_F_NONE),
+	DEF_PD("tsu",		R9A08G045_PD_TSU,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(15)),
+				RZG2L_PD_F_NONE),
 	DEF_PD("vbat",		R9A08G045_PD_VBAT,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8)),
 				RZG2L_PD_F_ALWAYS_ON),
-- 
2.43.0


