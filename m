Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF70C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:17 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.15261.1713514687605176663
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bxSTpXg5;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a555b203587so191880366b.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514686; x=1714119486; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anhU6WmbSlVAmRNaOZQ3hY89T8ADhEDCuFtkLjSkO8Y=;
        b=bxSTpXg5r8DN6DcMU7X3EaV6CNEHkxBe6SuD6y8ddL63XjTX4dsbYBg+annj5MCFc1
         JuFBnugJf3ubYQfNtRXgO/kE7q3jpWRNESfqeM+bnw33gBJKXxv+zce/RKNqlrvpP46M
         IhgTtYvm9trpSdhJAqk4OkHWkrwOB07dIQ60VvPekwxDuPfjy6p5Gn7cYvwcdIc+5Dpo
         BmFDC2lFfx6Hv1RAepg8QCk8QdhXQfN2fddKMoJUd1hBDdm8Wg6KFOlhxlOnDB5yJ6/Q
         hmH4L0rHJP1e6Vh04uo7u4EKft64a5/tFF0Sq5bsRODLYRncQ+w22AFFgycOeIr6cr5R
         tfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514686; x=1714119486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anhU6WmbSlVAmRNaOZQ3hY89T8ADhEDCuFtkLjSkO8Y=;
        b=IAn6I4QOTD1+gLehQXoyu07z0kP4mBqrSLnDTAJVplYTEFMyWJ98m3Cm6nB1q3FbLe
         yYQHroOGcBe+vbJ52OHKRUwWHOQ4LQ/ZVsAsqnDkOK7EVIJO0XpmEQtnYH4vCD3wP9en
         1OXWaWuyYXN9LGDVj9hvm4/he8k9T0eLo0VgyiH2kvuleP2VpQTQp3gAR2E0czLFjkkd
         uFTF55m45ijik2eihy2iI85tl1iGGf6juyBg9WqzeC86++MORjSBfvVPwW896D/AXy0M
         3KG22XNFYDpcgUo0PmIzNezwNYHIbnzBHcpLPMYDgjCVFaO+2PRyt86JVs+HmV3Alssa
         DdLA==
X-Gm-Message-State: AOJu0YxoSLk8Jv22sXTczRd6KMhbb5VC84l6xr+V2xTGn0vy4kVtHprQ
	1R9gMZL8nwkSh0zrgl+BvC+XEoTkFNW5PCyCBS/8BeTBBlXp0uo2mTrBZ8F+iyw=
X-Google-Smtp-Source: AGHT+IGRFdByEjPb+vTFgs++LHfsZqU3a0ShL5JHDK38BVF/vueD48EAox5itEy4aN3G8NwBQtK+IQ==
X-Received: by 2002:a17:906:1c5b:b0:a51:d204:d69e with SMTP id l27-20020a1709061c5b00b00a51d204d69emr1232304ejg.7.1713514686123;
        Fri, 19 Apr 2024 01:18:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 14/53] clk: renesas: rzg2l: Use core->name for clock name
Date: Fri, 19 Apr 2024 11:17:03 +0300
Message-Id: <20240419081742.3496709-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15601

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


