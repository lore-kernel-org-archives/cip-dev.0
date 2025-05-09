Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32283C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:15 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.10413.1746783306397922713
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=AlXROt3c;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so5670509a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783305; x=1747388105; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IK5IAU8pI0ZsvPQhMGEPlNFMgPFOGCjMq42ZwDseHo=;
        b=AlXROt3cDN9ZxoHV5MJghU3vFg80CoxlE5WvD+662t9hNVe6Wxr7ylXIOoNhOA0RzA
         Hh8iX1ITZeBhWLWW/KAOpUX2vIZJHv0+CgaiUoI/jJVfcvCc8q8ELzV89jydyxJnRpHV
         SjuKS9shjaZ00uiU1wrz8w8/Vb2oq8osUC2Z3AayfWvLCUtqwCsf/AO8H1AY29n3hFfy
         C0KSEvzdtXsalzY6q/VJSMKU7cEoco/FJLcxWeCaHKbs5JPXDadSOK/VRqedMSWshw7l
         QFmG7CfyaKPLXUd2n/G8wChxjVriASwZjy7ntDQeCYphnzGkV+531JhqcZ/ddReIOPBp
         BCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783305; x=1747388105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IK5IAU8pI0ZsvPQhMGEPlNFMgPFOGCjMq42ZwDseHo=;
        b=MXk4sKWtNI9P3fysurm6+S60YjX4kl+witpBkO+zO/zZJyXCcfL0iODy8x+10AADCY
         zL9dkFLH8JrCqy9uiToSCcPDXEDxOncYfsK2UgiCD/pR8Edn7GJPgBbdKP095L5r44wd
         DeJMUjrQlsYtyBFwH4WuU0EriFa01I85DBNa6isaMDO0KFUQCzY/1V9QZY2cCz9Mi0Qb
         tJGaKCy1nyqiR+RvbBHGtwURDbUUy+AEVnfyFwkrNnYEaJasv19NwYxe23q4JtuL4EZR
         dHDhAlPyMzia4GYENlJofoXGzvAu4aNMIOp/vBuCJkbonpNNOFZdFzYSbfwwRKoY0NwM
         Uhvw==
X-Forwarded-Encrypted: i=1; AJvYcCVQc6pyJaE0ne1C2ydqKXwwTb68/720Znr8pgceVH7vrv3dBz9YAj1BvOW2jkMKNO5tNwbbdRvp@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw4BMlZB9fxC9CHgFQmOc3bI8dUFUuI4pwhbu8Q3nTGx2mdXVrg
	OaA5GVLRrmM+ZwSNavuiECXa8N/6+3EhNQp1h4zLmJ2aiABJ972Z9Zw1rinFpZo=
X-Gm-Gg: ASbGncubW9GBJ2tvxw8g/zfIYLQNEWJ+jgXpwEQmlb+opjVJB8N/T65NFqGG65XAV6v
	1VR6AhAoDdfwTg6ADi0sOYSAmr9bDT4XtUUtPxe+CJCAZI94KKSNHgAVFGFugE0Ph3++CWr5hsk
	HQgWlP08oB1rX0y3Oq0ohZeimPDbMW+QxRUiudXopY1iSxsDV+tQJry1/lvqiiSqbL7HmUCq15Q
	Z+GN3LSg40YYMIjlZR3L63clMCndEEMhZYQ3AJzbEr0n++3pKXFPCbt1EHYuZKTtobehcdwO5dF
	1RXY4olYw2XD97WQY4N7/g+cDrh0wNra7AkXHYdiuYNm2/qhJSk32TadiQ4IH/XwreWvXA==
X-Google-Smtp-Source: AGHT+IHgEol0M4WDRa1mXG3dEA+bGx+8tUrjHjZ4zn8UrZXZFuFCpstP4YV5QBsyz2/jMdCrKHvuPA==
X-Received: by 2002:a17:907:c717:b0:ac7:81b0:62c9 with SMTP id a640c23a62f3a-ad21b42627amr222222766b.20.1746783304796;
        Fri, 09 May 2025 02:35:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:04 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 15/37] clk: versaclock3: Add support for the 5L35023 variant
Date: Fri,  9 May 2025 12:34:20 +0300
Message-ID: <20250509093442.4015145-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18867

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d3dcc98f65dbd364ff839edecf39d1a1e949ee90 upstream.

Add support for the 5L35023 variant of the Versa 3 clock generator.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20241210170953.2936724-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index 70f23e64939c..b6db9453f9b6 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -1137,8 +1137,14 @@ static const struct vc3_hw_cfg vc3_5p = {
 	.se2_clk_sel_msk = BIT(6),
 };
 
+static const struct vc3_hw_cfg vc3_5l = {
+	.pll2_vco = { .min = 30000000UL, .max = 130000000UL },
+	.se2_clk_sel_msk = BIT(0),
+};
+
 static const struct of_device_id dev_ids[] = {
 	{ .compatible = "renesas,5p35023", .data = &vc3_5p },
+	{ .compatible = "renesas,5l35023", .data = &vc3_5l },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dev_ids);
-- 
2.43.0


