Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA65D41141
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:42 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31326.1768466197940270973
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GY2tgCvG;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8010b8f078so112050066b.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466196; x=1769070996; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT4S5GRyk3D2qSN1GMkEn4z4lFvYkjeNHd+p2JQ1w1Y=;
        b=GY2tgCvGFsqF7SL6/CGT25UxzIv+GobZZYfrzNO36UtvIHcJY+RqFNATcpH829fado
         zqRSeUkdYfUN8icHGPUHjAYW0z0/HWP5yL9uQ3hYdrYRXSuvEI98X8hNZXWw64YobhKa
         gilJIB2e9NEo8NFo2lleIImeBvDW5jxAjaNuyowEeeMsjR6AC0B+FLYjB6VXijS85KP0
         4s7fwfKjmkDBAtFSAABankArneV9MG/At28wifBws653g8PJsXGiO8/2wZraxSpcJeNg
         tgjkI4GJZpdXidOUt9twsiF4j7Ep7mtAp7uswkPpZCl0Iy8vVkfsA3AJ4cChHOjehwWM
         qakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466196; x=1769070996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dT4S5GRyk3D2qSN1GMkEn4z4lFvYkjeNHd+p2JQ1w1Y=;
        b=NCCFySaWTLQI1ThsDUHRKyBXJ6DPX0wjDSNXoHvgGqluq33VfsZZvDIjeTwsGneDbx
         qsjIVNj+nhkfl9HEhV07nMJNJjdji9NdihLKSBJ4oAtUKsPsUD49PjEcAgq85TpjG6zx
         ytGbPEjgA1FRsFGsOWMMH8KLyTJKH7yUTAuGQlD7KpLWB0Jyoj9qyEjYEgSUqMkRdm6U
         ZR762nuT21kpNg6/FHl7D1PJDWjXertU3NBUUCwCURF/TC8VISt1q/fbhCpDYcCXgZDF
         nqfJasPfewSm85I0R2CsCtnulRmMAb68BjFJonTXNDT9AxongJux3kgmvQgKU2/PS7So
         s6CA==
X-Gm-Message-State: AOJu0YzDFIML+F5YTtIWW56KfLZEgNwzf6WVaP7P7XsjHYIb3f3aQwnZ
	U8DtyAS8iNWY9Eko2F3qW6RVKW+pt1niFKkLLLIQaaDx0w5I0i6cnGbNfmWVSZVdvc0=
X-Gm-Gg: AY/fxX69HSRBk2Dxz9EPQMCfiruTmN/OnJKwC/xqmgbnRGQOQNVMwWQ+xNRoxXsv7P0
	bVgoELUl297VpzBNInGs3dSsrUp7xl2BoF63Iv0S3VxOrru6XsS/hkMl1qGQlWehMTmD7toGr/w
	BXNKP1RMoXd7LWGjkgTZTzw47N6zWw4ygA9UkBGPsfCWXfNSrSSJxWUXxp197oZoM4HH2Jm6Bd2
	uN3e8vkDtMdQO4lxaSLHMZUIn6CZ0RmxVcCavz9NnNcMFMZjiO/r/1O4tzZqsWcle7le0/Y5uTx
	kpWnmCnELBSyEr0cmEl6kSnCrtL+1hH+fVGjQ38AtyW8wA0Eb7l2XBEkOjyBcaWjIoKp1G6oWTU
	mr3XJ5yDqBpgrtmsfoFv+ceaK63zFIQKQzyzSwXFayKYKm6yEfn3D+qeAhm4RTlS8o4AuJ37nqD
	ktAIj87P+5svR/wfVUXsQmTiKbFFZoBLLipiW39N+pdsz2/fKv6GCguVArrcGDYme+5A==
X-Received: by 2002:a17:907:94c4:b0:b84:200d:15b5 with SMTP id a640c23a62f3a-b876113a315mr477477266b.31.1768466196298;
        Thu, 15 Jan 2026 00:36:36 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 17/19] clk: renesas: r9a08g045: Add MSTOP for GPIO
Date: Thu, 15 Jan 2026 10:36:01 +0200
Message-ID: <20260115083604.1064260-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21617

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f0cb3463d0244765ab66792a88dc5e2152c130e1 upstream.

The GPIO module also supports MSTOP. Add it in the description of the gpio
clock.

Fixes: c49695952746 ("clk: renesas: r9a08g045: Drop power domain instantiation")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806092129.621194-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 812adb223fdd..9e6bda7f6c57 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -283,7 +283,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU2, BIT(5))),
 	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5,
 					MSTOP(BUS_MCPU3, BIT(4))),
-	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0, 0),
+	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0,
+					MSTOP(BUS_PERI_CPU, BIT(6))),
 	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0,
 					MSTOP(BUS_MCPU2, BIT(14))),
 	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1,
-- 
2.43.0


