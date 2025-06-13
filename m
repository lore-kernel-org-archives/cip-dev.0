Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D4DC71155
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:50 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.7069.1749809741685935685
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YcrCmznF;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so3209634a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809740; x=1750414540; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjfCpIVovp7G/dAcAxi2sdE49DmY03tav6ed1o125r4=;
        b=YcrCmznFwc2lvzNwxZ0//okV4Qtf+LnheTxkud+k3Iu4SsjGekqhsiz4BJTGXixdvb
         /22eZgTVWhCDD34EoLXTEe1qRFRs0oaUeAOgCrsjr4ZbzsnpZowKnFp3pC1vltZFsO8S
         XDDcvFZhx45Pt/CmEqOO/XajggoUflVrRLhFwAET32VspWs0kmMa3cSQbfsiQV9K7/Or
         Epr+73qZ/nZOjoP+5OFOSKstaG0YanSCc0NqeT7Tg/Q5K7wqWplI/bv6mng8QmZSmqc/
         E2+2zDFCkAOEv+ieNA2iIpi0fCHS6KQ9WQLWNVFvc6j8aMzifrS+0SLOavMmuzAKUAv5
         BW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809740; x=1750414540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjfCpIVovp7G/dAcAxi2sdE49DmY03tav6ed1o125r4=;
        b=WIiM766ExmRsvJ8vrvFB4HrNaVWSBj0b7MgqCAx6jUzto+eBUgWG8EkXDp3sdiRz9p
         ZHCgxaKqz3+seK/qcnjPoH9603MSEJUFzuWtC2T0O8ZyZWt/9ENOG7c0w2ZvT1nNZzJg
         95akxTroes2ECaR8V1d9NbqAFLFig0Y/cGBf42Sh9dvI3GTyjWgMmPnd2PY3ROvySjpN
         0bkgu5A7qeuZhZtg/9+CRKtbg8RYrF50MwjJQtT8JTdTiWz2wJnpfoihbgr9EKsyaKyN
         ktfr9FCgcdvwPfhzb4qzJNKi1046zkhN0Xsq7npm0Pk3V3KM1VjbsUZcBnqKzK5ulCuP
         9iTg==
X-Forwarded-Encrypted: i=1; AJvYcCXlADkqEhG3ByWVe0CLeH6zqqYS/GyC2q0SGAaULtSh/udZM/483sAHFWqiCQSfbJR4e3fUAlo/@lists.cip-project.org
X-Gm-Message-State: AOJu0YwPnutWsLSvowzNvnKAEZb7BvBmSbp+z+iU1AlG74aou153vakS
	wfs2XrfT2eu1+kPEJjC13tHSgiAl5Oo6lNMk64r1J6ZbsAaIkTuutgnjo5q13qbBRFE=
X-Gm-Gg: ASbGncuDSi6nAf+eJgO+bjfEnihQDjsYAWzoQVED6bDUWuKeM8zJMertgZZgjUPNGTw
	k4PHBVn+PlqTuTcWh+cydEo/vn29ZNb5bdWi659G+eP1/C640r1/d58to9WPNjrwgD5bPIvN/mm
	W9Vyy1dpAQARtsLLrugtGvZtdKNkUYNVt3yiD0Ct8TS1InxeIhGP9jKpUuW3Q+prQOXF57ZBTi2
	h2X4K3Yas52q9OThwaFnCNWrQvGKg24hznHo/nh+mcmvbwHC+b0V7bUYr2xo9ysQ4wepuY+V0UB
	siWL0nNJh7wCaaUsHCTCkgb0eqPU2LkzY3H5kfVnzTSLqwPhsZQg0+c5vyZ0MFWE8Xe7W7lrKJ+
	rSK7VpILnVMtTEqr/
X-Google-Smtp-Source: AGHT+IHR+9CNIL65RFhCt9oavDTMXXftMOKUfnCrVKEhaSVDWwYqU5yDWktMj4JEHXg4gG1mL4NxUw==
X-Received: by 2002:a05:6402:2355:b0:602:36ce:d0e7 with SMTP id 4fb4d7f45d1cf-608b4930898mr1921095a12.14.1749809739852;
        Fri, 13 Jun 2025 03:15:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 01/14] clk: renesas: r9a08g045: Add clocks, resets and power domain support for the ADC IP
Date: Fri, 13 Jun 2025 13:15:23 +0300
Message-ID: <20250613101537.279131-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19055

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f962745289958e89bf520407728e384e52ea8e27 upstream.

Add clocks, resets and power domains for ADC IP available on the Renesas
RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/20241206111337.726244-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: drop the power domain description array as the core code
 is not available in v6.1]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 7f96b615f087..89d6f361a5d3 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -186,6 +186,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 	DEF_FIXED("OSC", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
 	DEF_FIXED("OSC2", R9A08G045_OSCCLK2, CLK_EXTAL, 1, 3),
 	DEF_FIXED("HP", R9A08G045_CLK_HP, CLK_PLL6, 1, 2),
+	DEF_FIXED("TSU", R9A08G045_CLK_TSU, CLK_PLL2_DIV2, 1, 8),
 };
 
 static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
@@ -233,6 +234,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("scif4_clk_pck",	R9A08G045_SCIF4_CLK_PCK, R9A08G045_CLK_P0, 0x584, 4),
 	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0),
+	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
@@ -265,6 +268,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
+	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
-- 
2.43.0


