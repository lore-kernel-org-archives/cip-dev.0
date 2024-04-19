Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3712CC071FD
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:00 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web10.18434.1713526736997182709
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:38:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pvZXFV4t;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.178, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db101c11beso22096111fa.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526735; x=1714131535; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anhU6WmbSlVAmRNaOZQ3hY89T8ADhEDCuFtkLjSkO8Y=;
        b=pvZXFV4tWEoC4yg1kMLEGXggMfn59x+gjgE/SEqyH9eBL3taoaI5yihbw9+TOG598I
         nQtkoEFCMh1IcGioP2ULSiYVtsvicX8IsLbYW8r2Lhe3HzXKF3fctrxb/bVx2Q7PgUvM
         s5uMwvpsHPDCIP0HVGJM2EIOfzxjfd95FRTuBg9oIVAMfG2n5LfOOqiAi9bh4+CI/nsX
         T/p4okrwUob8YtzK+1ADjqunQpVrtQbXySmOA3Yc/kHG6EFTwZQ3OG2Tw24FMhmKYpJS
         BIITcxiw4mOuBXwwdyOvjshtam0l3Obo6X4ICXVgSbeFSfyATAqTQFdbBVjeRA+lCBa1
         zEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526735; x=1714131535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anhU6WmbSlVAmRNaOZQ3hY89T8ADhEDCuFtkLjSkO8Y=;
        b=k2vwaJOp9jBL/M0Ur5Qa47Iwp8XhyWbnsAOODEEKuyjm0BL91T8/hPoTGmEc1ouEho
         I8B7dRJfur9k1ipr/YG4GUgjD6djDJyI/MU82V96MGmj3pOEYS4rPMsB529geZEQY4M/
         j652YixIlak1ptdJXacxzeaAfLsWZ7ipie7/aD6V1GQMoziLGgaGuQJqSGZ2uBtAT37R
         Bl5bmAs+pbz79sWk87Ybzmi8MgUbSYP9ciWiMe9U/0LEqtAE3grC+QoggfE5AYIAg3ui
         L0PDMfKJ8+ohA4F+zX925hmdkkeGMovYQCUGKNS2haZMZVIxIDhqA+4PHCtyNxQONBXd
         Hwcg==
X-Gm-Message-State: AOJu0YxGu7Qg8l92LcuzLU+t8PDDNcCrt6lM4h+9io5by5xo1osQ9MRM
	aI127ZoGlG9LEhuXVi4jrRfgKmR1Ufit9z+1oPj0w21z/TOyllmG+zsQKf48rNw=
X-Google-Smtp-Source: AGHT+IEjlFqsz/YXZ78SYTELzGs5KM1It1jZYLELP3ZH3baWpukqhtUOntvdmdeUmSoiwHKlssdW9w==
X-Received: by 2002:a2e:be84:0:b0:2d8:60e6:f482 with SMTP id a4-20020a2ebe84000000b002d860e6f482mr1349044ljr.30.1713526735093;
        Fri, 19 Apr 2024 04:38:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 07/44] clk: renesas: rzg2l: Use core->name for clock name
Date: Fri, 19 Apr 2024 14:38:05 +0300
Message-Id: <20240419113842.3675543-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15658

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 17939df3c9acd26e4dac1c5943dd8e58e1bcb4e7 upstream.

core->name already contains the clock name thus, there is no
need to check the GET_SHIFT(core->conf) to decide on it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-11-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 43dcea9f7ed1..cb31efab2cce 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -266,7 +266,7 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
 	clk_hw_data->priv = priv;
 	clk_hw_data->conf = core->conf;
 
-	init.name = GET_SHIFT(core->conf) ? "sd1" : "sd0";
+	init.name = core->name;
 	init.ops = &rzg2l_cpg_sd_clk_mux_ops;
 	init.flags = 0;
 	init.num_parents = core->num_parents;
-- 
2.39.2


