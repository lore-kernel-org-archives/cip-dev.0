Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B74C071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:30 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web11.18435.1713526764532513846
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=aybC2C5N;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.169, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d895138d0eso16194751fa.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526763; x=1714131563; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjx96l0ApWXxkP/YBle86+w8V4QiDlIG58SAaMJhD88=;
        b=aybC2C5NXlr+GhdRrSLCV3/f09HWFYPgc3dUjBYZwk6HZOfegfYSV8pepwyvH7i+X7
         4iaFyHcPwRG748+Q9msKdDnWLI4xB7+Cx4JGUkGiEQUzzsuY1HAjfaLF70JD8eWIU9+K
         rq7GIuq+Sb3ZKQt3PTm3kr8n2dY3pecZfSh30eeQYeWBsEkTtPmN/5nKU8u0+h/tLoq/
         sSty91nSl2qTl8nwEhH0G+b6P+vmB8XPc4RXY1vUtVxOgzo0Bz40NWSu1OKegKZZw2mF
         dovkbaLYjsAOsSISMvYt3PTGP5MzXwkjTzU/8NU1BAcnal6Q4Ki90kuedoZb1en/+8w9
         StVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526763; x=1714131563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjx96l0ApWXxkP/YBle86+w8V4QiDlIG58SAaMJhD88=;
        b=UxR/shDgw8dmjU+MRN5F5SXuOak7Z+6kcHvV75aHe+5SR0Gerzq1ZEMqDuBL3BoH6p
         wmtpCvQg0mcY59ZsPhUa1PMl7JEZozd+lufMAM/gEBolu6F8xJeafm86VRDnceL+oFLv
         snxyWGjDU9n2nIDWkn2Evl5sQY/PkreWx0zAMYAxIANHfXUaXi47TuKzpWd+zSH8fBtR
         NOlAB5floqpDP2pBHSmzfFAS3elqSG5deLzoeZA3fkMN4SCdJEVVtewbR0PoYpclCJDX
         UzXu+qYkqH2F1B7dyh1mqIq1zZXBwO7eb+dQe/UF31y4cDxpepElPmeT5vc32RaO04dp
         5lsw==
X-Gm-Message-State: AOJu0YxBxIbbRk5UFg7+0kj48wrFGRIwe88fyrNPyqGy2TCjOPPu9aLH
	C8GSbS0L8NozXaKstApTXrMQ3lOQ7FVjQxOE1OpMDKDeGPDarVea2Iamdb+OUZg=
X-Google-Smtp-Source: AGHT+IGgY6PZYRzeI0VgsB6dEkspv9qpKexF+DCTzZC2nZFrMgAECuTkpugAgaRZO9zj12SGur6buQ==
X-Received: by 2002:a2e:7e02:0:b0:2d6:eaa7:2cf8 with SMTP id z2-20020a2e7e02000000b002d6eaa72cf8mr1029323ljc.16.1713526762766;
        Fri, 19 Apr 2024 04:39:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 26/44] pinctrl: renesas: rzg2l: Adapt function number for RZ/G3S
Date: Fri, 19 Apr 2024 14:38:24 +0300
Message-Id: <20240419113842.3675543-27-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15677

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
index eb7ac2253642..14cfbe687ba8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -135,9 +135,11 @@ struct rzg2l_register_offsets {
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
@@ -220,6 +222,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int group_selector)
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct function_desc *func;
 	unsigned int i, *psel_val;
 	struct group_desc *group;
@@ -241,9 +244,9 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
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


