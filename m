Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858AFD65536
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:05 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11753.1765967522066377110
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pIm0yskw;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6492e7891d2so7552204a12.2
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967520; x=1766572320; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxToODkoTgAbQPPen8lBUuz1MmJ0RaFvLKPD7xBvBCI=;
        b=pIm0yskwpdVwXegRqxj2ryIpgaW1Am4UETvH5x4fWkeMR+q4975gKf0dnzb9LPQ3yE
         HERsmm8JZjlriS1QpEdlvU36otfmdB6eDKGDZu0wse0t2YH/3gfSbpG+FpX/xd9Im5+i
         2KZ5Sx9n+cH2c7OlLn6mznx2LXJlmKxmzC8Adccu1zL/DLPw0d2YOwkuei5sKX+P7wzb
         sIKl+UaYjn5sbZZFxO7+XUBnr4jAdOiCfKdtwklJC7s1PrLslsxYD6THLS3LAhViK6cr
         Ljy3n2r3Yx/hbVEMwJwjfQZL/0hfbd7SIWB7uxQ6cSnpWh+W2YmoeIYRUIqUjg8DuZaU
         C/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967520; x=1766572320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rxToODkoTgAbQPPen8lBUuz1MmJ0RaFvLKPD7xBvBCI=;
        b=TCvHHarwcZxaSSLm9VWwxBQuC673StojTktVg5nZ7PZQVAKFE+d7Q+7VOUMIDU+nlj
         wdVLEyOPi1lcH+AiF4V1Xe1uRBDk1nRYQnI/cnUXqA8UG+vySf/020nZwMV+QCuLTOdT
         ZqieWxu2tIv0WMTUsoYSYWRLBRh3gT47o1WpxEq6QKkLU01KLFJpgxh7hPGs5nn4Mncd
         8C7uKWc/QtcEYlLoGIo4ITO+PtjMrN2tvUHoA5y4q0QWKN7DQJDVaxOUwS9II/0/fHUS
         5WoZG4Psmig31kFUCW/sn/giL1kr014VIJFYoI6+SyYCDLLoRC2ZiAzf6zEDKcekd64m
         IOlg==
X-Forwarded-Encrypted: i=1; AJvYcCXpfIPq4e+3E3vH5BDIuotFQSI8g6izXQcOtwnkq96x3fqfjo1sVGyqOOp7Y7KLmloSEy45s3cO@lists.cip-project.org
X-Gm-Message-State: AOJu0YyHShWwM7tdzO1L/sCiBu/imy1mMddRER23z84F+UfKTDnDYYYU
	r0xBWPUlPuJq2FpYYTyewWZQu6tnlcQ/FFwW0QZgDuCK+2tFczyTX+REBT0krh3EzhQ=
X-Gm-Gg: AY/fxX5X0MEFoen/lS7iqESSewvEPCWDzmsaTbo6M/BKJBLX1+/8osdbYMi2rkuhUSK
	q+MlqbddI2UbCP2K71HktSCc6EfS+7roSNKIyPzaus1NDon1xWHH23GtYNVSgiDS/rQ8UDzHdaA
	J0iZyPwVxbDKWLG2J/cvL1RtuQydzYqnxyrzUJ7SPRl2l5Nruf0gzgbiwrs4yPKULm3BUBILUMS
	7DgceFtKqhFt8pz36k6pIBuzQymOpB2GN4ICfXUUWdm6v2kUhnI3HiDtB5CoMcE/HPfqi2Ihpb8
	GqTlNcDVeNGCjPdxsrHBtBP41livAimaszVU4cAFVg0/fLfgC1giJ67ugt1LNMhEyM0K8YLXwnq
	AF/DzeUJTnjrtYmYgAk6eMGFqfaYpcdO71Tiz6MyprT0n/g7o7MKWYmF4xYpxFy92dAohbX1DEV
	viW/jkkNne9N5LjLBIb3xoKYecZH/f4ztG8DvE7dBi
X-Google-Smtp-Source: AGHT+IFo2KQxDLPhaJV/KwXdhqeoy1URVwKa/sbTJ9qZP5fknoikOc8H03QLncpoU7cstL3ajcRDAQ==
X-Received: by 2002:a05:6402:4402:b0:64b:4624:777d with SMTP id 4fb4d7f45d1cf-64b462479d7mr778382a12.18.1765967520441;
        Wed, 17 Dec 2025 02:32:00 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f584800sm2050292a12.30.2025.12.17.02.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:31:59 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 2/7] clk: renesas: r9a08g045: Add clocks, resets and power domain support for the TSU IP
Date: Wed, 17 Dec 2025 12:31:43 +0200
Message-ID: <20251217103149.4182935-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21099

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5599c7c4b4df440aa4a470a5b72669081413981f upstream.

Add clocks, resets and power domains for the TSU IP available on the
Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250103163805.1775705-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: drop the power domain description array as the core code
 is not available in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index eddf6cad8d35..acfa9fa01031 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -237,6 +237,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
 	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0),
 	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1),
+	DEF_MOD("tsu_pclk",		R9A08G045_TSU_PCLK, R9A08G045_CLK_TSU, 0x5ac, 0),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
@@ -271,6 +272,7 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
 	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
+	DEF_RST(R9A08G045_TSU_PRESETN, 0x8ac, 0),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
-- 
2.43.0


