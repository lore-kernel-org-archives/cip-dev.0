Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8C3C25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:47 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.8665.1716970480840231275
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZPGIG7vk;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35b447d78f1so362617f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970479; x=1717575279; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4AwCdeGJRX9I806p+hJj0fv/nozdrmsN8orotkD9HY=;
        b=ZPGIG7vkyMaeSNZSQXkWsUENjfP0vjPngzPTGx2WZ3sHDiqN7syV7p/j2/RoOGrB0l
         jF2unnf9xCjbq6K50Q3uYF7KxbSOJ+HpHKntVB4JPDyvIvgTCTK6TUAX9NwX6BMN2Bq6
         MKrapLeF4saxUkq/MSMRGH6KfwEGReOGIuo2lx0vhs44M3SD/ub9DvzZ+vOVsBBUJROw
         4sFFx+oNm+7nui4OXJLXi1vVDZxQNT5rytz7soAMj7FZrEheODu9j+9vhnRqiEJ8eCI5
         hlrNPmhmLn83mACg4lCWuVM20r7155zx1MgzWA5XjvSv4/quLdtMv8JGw34ewYAdhT7g
         5GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970479; x=1717575279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4AwCdeGJRX9I806p+hJj0fv/nozdrmsN8orotkD9HY=;
        b=cRjLj8lXfPLMMhXWdgAZ22icpCpJuFV6hvV1atUHKeY0TRw2hc8LLCbATqigOo/T8Z
         boIVaOuSQSjM+bcbpvYDHD8pYtCnMBxQOBIzBaUaCTddLDXUSn1V1KFLaYpGEslenffe
         IPS+jC4R1dhzZ7g2QSlpkDbKGUnl+R4ASnmAUXDIt2wAktzoo/dZUAKC89zHlfQauIO1
         nY+onWEY4bXTtoglTMwZfgmL0GxJEoD5aOosGbkC1+GnlUoh1H/5w1WoMIkN7RsHnYEX
         2Q0V0RB/lhTeYlQlrWSgPF2SW665RLkwq//z+i2eorCdfErdsfyChqBYXgT4DetD4N3N
         xFKw==
X-Gm-Message-State: AOJu0YwEfrFexmXTmrhuN6fJIpZmRcGTejmAxOaKLtu34q3xp/HPGsrM
	ESI+5qV3oOA8UspaQ30vVqDtQkOm9vbw/BLZPQFe1rIXNovLAQp5HaKvARmfwmc=
X-Google-Smtp-Source: AGHT+IEsGBHb4JfaZnt5UpHSyNDYfBlMcORZLQDdiJ1GyS6sFoexqyd8v88j8KTBI+/7e/P96aPwnw==
X-Received: by 2002:a5d:658a:0:b0:357:4b59:18c0 with SMTP id ffacd0b85a97d-35c7b719b08mr1008536f8f.22.1716970479236;
        Wed, 29 May 2024 01:14:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:38 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 02/33] pinctrl: renesas: rzg2l: Move arg and index in the main function block
Date: Wed, 29 May 2024 11:14:03 +0300
Message-Id: <20240529081434.639519-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16030

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 906b545b16594e45f2d3433028dcf649d2c05ebb upstream.

Move arg and index in the main block of the function as they are used by
more than one case block of switch-case (3 out of 4 for arg, 2 out of 4
for index). In this way some lines of code are removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 777d6c291b33..abc4dd44b950 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -841,7 +841,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	enum pin_config_param param;
-	unsigned int i;
+	unsigned int i, arg, index;
 	u32 cfg, off;
 	int ret;
 	u8 bit;
@@ -863,24 +863,21 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	for (i = 0; i < num_configs; i++) {
 		param = pinconf_to_config_param(_configs[i]);
 		switch (param) {
-		case PIN_CONFIG_INPUT_ENABLE: {
-			unsigned int arg =
-					pinconf_to_config_argument(_configs[i]);
+		case PIN_CONFIG_INPUT_ENABLE:
+			arg = pinconf_to_config_argument(_configs[i]);
 
 			if (!(cfg & PIN_CFG_IEN))
 				return -EINVAL;
 
 			rzg2l_rmw_pin_config(pctrl, IEN(off), bit, IEN_MASK, !!arg);
 			break;
-		}
 
 		case PIN_CONFIG_POWER_SOURCE:
 			settings.power_source = pinconf_to_config_argument(_configs[i]);
 			break;
 
-		case PIN_CONFIG_DRIVE_STRENGTH: {
-			unsigned int arg = pinconf_to_config_argument(_configs[i]);
-			unsigned int index;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			arg = pinconf_to_config_argument(_configs[i]);
 
 			if (!(cfg & PIN_CFG_IOLH_A) || hwcfg->drive_strength_ua)
 				return -EINVAL;
@@ -895,7 +892,6 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
-		}
 
 		case PIN_CONFIG_DRIVE_STRENGTH_UA:
 			if (!(cfg & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C)) ||
@@ -905,9 +901,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			settings.drive_strength_ua = pinconf_to_config_argument(_configs[i]);
 			break;
 
-		case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS: {
-			unsigned int arg = pinconf_to_config_argument(_configs[i]);
-			unsigned int index;
+		case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
+			arg = pinconf_to_config_argument(_configs[i]);
 
 			if (!(cfg & PIN_CFG_IOLH_B) || !hwcfg->iolh_groupb_oi[0])
 				return -EINVAL;
@@ -921,7 +916,6 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
-		}
 
 		default:
 			return -EOPNOTSUPP;
-- 
2.39.2


