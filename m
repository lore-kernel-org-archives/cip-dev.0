Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BEAC25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:10:55 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.8561.1716970246077436464
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pxMxtGpU;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42108739ed8so21247105e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970244; x=1717575044; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dyg+0RNietexKhCdgpfqu1Bqtvm67+BZ77jMA1GXI8o=;
        b=pxMxtGpUwtmVIOm+EWA5mXyE01d6Nem2o1N0FhPrio+ZKrGS/YOSiTx29NATtifqdg
         p4/Nh0IVpnhJPTJfA1uchQccSeJwhB9auIr/gH1tMgiu8iHmP7+SZEjGBZcqAm1RPc55
         ZdtaYxe248KbKJmrK3gwt+w/ytcoBZ5Zv9f/XJ10IEnxH/CtQekrZ06mgxRQ94NBmzyu
         UnGa98hLvUSFhDu3sDiWHyPfbciC3PI2P6scyrqDiY89spWtZhTZS3hdXY1HUt8OkVJP
         ZuEVrlD1Y7xeRPIHjNHOfrpKMx4mx1MCoPuLzFNEOycjWPUWq/jVROkq4MrB6QDLjnMa
         irig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970244; x=1717575044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dyg+0RNietexKhCdgpfqu1Bqtvm67+BZ77jMA1GXI8o=;
        b=uJS6Efy6vs8YQOVvtfgBNj/CaaygWJIiuclCLF7dKA/05bRptSZgwcYFZ8UrLXfhXo
         p32Yi/PXQjLfPUSbka9Sxnq8Y5U2CLvCnh0VZBnvUsHAP+lLgorZtll74HLeGwzJgWbD
         hl/uscIWgBzX3WiLCPuO4mpWrvlHKlm1p9gh0g/J0//adJFceIiS8r5lGSaSYOLWdDjA
         R0hCw1ke9LBTQ0uY9CAoaC9+1JrrzkaYvFkfpU3vAQFYTavUQ07WZH8581xy9y/J9Gv9
         vkq0d6hwQ91FvxC9WlJmhu1P4Z56G3uo9+LYj4Y/kV4TghjmOxT9PweesZB5Gchx84oR
         g7jg==
X-Gm-Message-State: AOJu0Yy/JBAaFteY87iLhVooxN4gLI6GTgdTN87odeSJniCyAMk4KX53
	UkvMPizFuGRqmbYF+BxCM2yZyGY1G/P8lAwj0XhB5dxFPtuUAWpcSBRBSYXyqfI=
X-Google-Smtp-Source: AGHT+IH0yxI0FvxpCA8l0dogI3luAEf/MSgaD8B5HSJaiZR4nHWpgyg7lDWnQyzLDAjZ16usRypKzg==
X-Received: by 2002:a05:600c:5746:b0:420:29dd:84f8 with SMTP id 5b1f17b1804b1-42108a99ba4mr149541875e9.32.1716970244469;
        Wed, 29 May 2024 01:10:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 02/47] pinctrl: renesas: rzg2l: Move arg and index in the main function block
Date: Wed, 29 May 2024 11:09:54 +0300
Message-Id: <20240529081039.639010-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15982

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
index a3f31065c4bc..480d4bba2704 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -838,7 +838,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	enum pin_config_param param;
-	unsigned int i;
+	unsigned int i, arg, index;
 	u32 cfg, off;
 	int ret;
 	u8 bit;
@@ -860,24 +860,21 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
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
@@ -892,7 +889,6 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
-		}
 
 		case PIN_CONFIG_DRIVE_STRENGTH_UA:
 			if (!(cfg & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C)) ||
@@ -902,9 +898,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			settings.drive_strength_ua = pinconf_to_config_argument(_configs[i]);
 			break;
 
-		case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS: {
-			unsigned int arg = pinconf_to_config_argument(_configs[i]);
-			unsigned int index;
+		case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
+			arg = pinconf_to_config_argument(_configs[i]);
 
 			if (!(cfg & PIN_CFG_IOLH_B) || !hwcfg->iolh_groupb_oi[0])
 				return -EINVAL;
@@ -918,7 +913,6 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
-		}
 
 		default:
 			return -EOPNOTSUPP;
-- 
2.39.2


