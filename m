Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EA2C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:48 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.15280.1713514718860523571
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dGmwj/gO;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51ddc783e3so204133466b.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514717; x=1714119517; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLSS7bYMLk3TvNZfROWvLQgbySEh+IS0U+d4isuI+dc=;
        b=dGmwj/gOc/9zcPwkenXHiowEjbgHxHfj9e30OGEBFR/yVM1YPdoZkvCeSx45E/owPv
         twQG7BFbIWIxxpPnjwXMd0Fc1qzsoXvSj4uJvHmrdtnOaHIqATWA1NvWu5sAKrAWzC8j
         1neLZZQtYrpTyyVdqgCxZHCyW8Hm+p+gmM0KEVopO2uwedHnlt0MUf0h/R4JH56jYKxf
         K+bN0X/U78ZSXFLG84i9p5/ydCuGYSjsz5ODHmOFAiPSJK8ygyC2Rzy2gAdg0uGjvB0A
         CS5rgOgHmyk79E2i3SdMUjnZNckAwUSFdAWLARPsKQhAN+EutZv6i3Q/cOV52RJnkUVz
         L6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514717; x=1714119517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLSS7bYMLk3TvNZfROWvLQgbySEh+IS0U+d4isuI+dc=;
        b=HrDrkjleYeB6bcNM0w9Oh98BhILFe1VF1TDXGGz/Ww7r7qMfMSmshrAWIdu5iVBMcP
         seQ/dOFLsvSIlqSZtqX2XLuurOTa65gte8YZBB49XdbM9t1nOAkCTIhsMegvR7yBo0A0
         OrX5I4tOCpODduEKMs1AxRKHTcQVMEvCvGcRnhKqrp1pHib7/9c2di7xcVgaW8LyLZB2
         6zfi6fGsrmT+jdf51QLNtEQWI01yzeNdHKbJUE8CdaXSpHFKUZZhh5iy4WMrV6LrGolc
         86t5UKzbXzJ/vEKh4FW8GGCnyATn1edjaa2NuqR/nzCxcNTXSZP9I9o1SUXSdibx/Not
         U4pQ==
X-Gm-Message-State: AOJu0YyICCtU4aDZbKX8VNmVp47GqCGL8haa45hcI73/gTo8fsTLYr3r
	A/Ez2qOEF+AGar1FgetJ4yVuXrx8ryODYIrv5G/M7QifasXCBFSYANPTg8IHhfo=
X-Google-Smtp-Source: AGHT+IFrBzP2vjOhw6OeB78Mi22fC5OOcr6SlnyENXhXagYtrjX4nzREtsWtEmDdXN2+vhx+YVkYmQ==
X-Received: by 2002:a17:906:3d6:b0:a55:a04:6fbc with SMTP id c22-20020a17090603d600b00a550a046fbcmr987961eja.23.1713514717364;
        Fri, 19 Apr 2024 01:18:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:36 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 35/53] pinctrl: renesas: rzg2l: Adapt function number for RZ/G3S
Date: Fri, 19 Apr 2024 11:17:24 +0300
Message-Id: <20240419081742.3496709-36-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15622

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 35a3610e5a2407913dd6505de06975ba5056af9e upstream.

On RZ/G3S PFC register allow setting 8 functions for individual ports
(function1 to function8). For function1 the register need to be
configured with 0, for function8 the register need to be configured with
7.  We cannot use zero based addressing when requesting functions from
different code places as the documentation
(RZG3S_pinfunction_List_r1.0.xlsx) states explicitly that function0 is
GPIO.

Add a new member to struct rzg2l_hwcfg that will keep the offset that
needs to be substracted before applying a value to a PFC register.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-17-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index f6a7041028b6..e924bd19ecfb 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -132,9 +132,11 @@ struct rzg2l_register_offsets {
 /**
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
+ * @func_base: base number for port function (see register PFC)
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
+	u8 func_base;
 };
 
 struct rzg2l_dedicated_configs {
@@ -217,6 +219,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int group_selector)
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct function_desc *func;
 	unsigned int i, *psel_val;
 	struct group_desc *group;
@@ -238,9 +241,9 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 		u32 pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
 
 		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",
-			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i]);
+			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i] - hwcfg->func_base);
 
-		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i]);
+		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i] - hwcfg->func_base);
 	}
 
 	return 0;
-- 
2.39.2


