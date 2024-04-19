Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6821AC04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:48 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.15282.1713514720313720819
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kkMtumQF;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5561b88bb3so187516966b.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514719; x=1714119519; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iV7kggneN0m0q162OOT+99CLLUIKLoK2ZdGhsP7+6Lg=;
        b=kkMtumQF/6TD01Wt7xU84bIrOYjPVfyDwEbEpiDnNuwqvdF4Webl8u18jFWavfoxWA
         SzVjoPtncv+2OsfX3rGRTHG0TATGqw2vwBxt4sertmIgx3B/w6Jqjja+xzC0iQxtnX3J
         MD1xXvgJ/dp+KrmyiF9g8Vcxm/Xxn8jCsbAxaon1KoKq7wC8zJ4GDup5TTbC08igAWgq
         u0IFSoQKt9m4Zn5sQJyhPYN3a+saFYX54+wEUVWploKtnaTPD3mAYu7B0bGhfJ4nEw6W
         PNvl0j+Ixx5ak5x5KehMJHTFgsRWyV1WvjL4HUwiCfrAs5QVW93atk5edTiHuK05rogz
         530w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514719; x=1714119519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iV7kggneN0m0q162OOT+99CLLUIKLoK2ZdGhsP7+6Lg=;
        b=nMPKsavsLaG/YvoMczbW2n3VolUU4q20tRV8im+l54GLDldl0Juli2iocraKBtDZEY
         DgHLZJTWAsdVLBZeyHjB+8kJjmGAQ7DKtDM8vl1I36codX7E6sRCNfNo9MPOtErfbXLw
         JsYrQ7e73jcvlB097+ajVjCSI51N/0b8BpAg/GsSTZmNw3AACmI/m9N4XzW6pAFH4kdT
         zfp0wYgAPLvW3Hc3poYnCJNWeSeTqxC/X8mv3zZ9Yjx2oSibwfNq2yPITKne70J4vDFD
         lDhPP+vBb3VqVgKYVeM7vpy7lPCBbm77/Fz4sIFhCbPJv6Ern+Fllez8R077Oy4SnHE6
         qxzQ==
X-Gm-Message-State: AOJu0YxW/OU2AcpZs4X7LDkY/tWuReIAHgCnKZMNw42VTs9Hc0qvCGGF
	zShKcOwDPqd8UaKOf32bYeiiFj+lBwSMkUxiOq7NCfiG48Nc2lKkWwYm1EhcP94=
X-Google-Smtp-Source: AGHT+IF4RoXiQLRXRqnQq/9i3gfUo06cb+EiAXY9PXmvYhthNyxK7Loaats2RF9x6BOn0gzS3Sx0RQ==
X-Received: by 2002:a17:906:1b4b:b0:a52:5383:c22 with SMTP id p11-20020a1709061b4b00b00a5253830c22mr1186046ejg.69.1713514718785;
        Fri, 19 Apr 2024 01:18:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:38 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 36/53] pinctrl: renesas: rzg2l: Move DS and OI to SoC-specific configuration
Date: Fri, 19 Apr 2024 11:17:25 +0300
Message-Id: <20240419081742.3496709-37-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15623

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cca38201b492305dd1fbd3d28df398b5595f4836 upstream.

Move drive strength and output impedance values to the SoC-specific
configuration data structure (struct rzg2l_hwcfg).  This allows
extending the drive strength support for RZ/G3S.  Along with this the DS
values were converted to uA for simple integration with RZ/G3S support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-18-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 42 ++++++++++++++++++-------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index e924bd19ecfb..9791df26e149 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -129,13 +129,30 @@ struct rzg2l_register_offsets {
 	u16 sd_ch;
 };
 
+/**
+ * enum rzg2l_iolh_index - starting indices in IOLH specific arrays
+ * @RZG2L_IOLH_IDX_3V3: starting index for 3V3 power source
+ * @RZG2L_IOLH_IDX_MAX: maximum index
+ */
+enum rzg2l_iolh_index {
+	RZG2L_IOLH_IDX_3V3 = 0,
+	RZG2L_IOLH_IDX_MAX = 4,
+};
+
+/* Maximum number of driver strength entries per power source. */
+#define RZG2L_IOLH_MAX_DS_ENTRIES	(4)
+
 /**
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
+ * @iolh_groupa_ua: IOLH group A uA specific values
+ * @iolh_groupb_oi: IOLH group B output impedance specific values
  * @func_base: base number for port function (see register PFC)
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
+	u16 iolh_groupa_ua[RZG2L_IOLH_IDX_MAX];
+	u16 iolh_groupb_oi[4];
 	u8 func_base;
 };
 
@@ -173,9 +190,6 @@ struct rzg2l_pinctrl {
 	struct mutex			mutex; /* serialize adding groups and functions */
 };
 
-static const unsigned int iolh_groupa_mA[] = { 2, 4, 8, 12 };
-static const unsigned int iolh_groupb_oi[] = { 100, 66, 50, 33 };
-
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -600,7 +614,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
-		arg = iolh_groupa_mA[index];
+		arg = hwcfg->iolh_groupa_ua[index + RZG2L_IOLH_IDX_3V3] / 1000;
 		break;
 	}
 
@@ -611,7 +625,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
-		arg = iolh_groupb_oi[index];
+		arg = hwcfg->iolh_groupb_oi[index];
 		break;
 	}
 
@@ -699,11 +713,12 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (!(cfg & PIN_CFG_IOLH_A))
 				return -EINVAL;
 
-			for (index = 0; index < ARRAY_SIZE(iolh_groupa_mA); index++) {
-				if (arg == iolh_groupa_mA[index])
+			for (index = RZG2L_IOLH_IDX_3V3;
+			     index < RZG2L_IOLH_IDX_3V3 + RZG2L_IOLH_MAX_DS_ENTRIES; index++) {
+				if (arg == (hwcfg->iolh_groupa_ua[index] / 1000))
 					break;
 			}
-			if (index >= ARRAY_SIZE(iolh_groupa_mA))
+			if (index == (RZG2L_IOLH_IDX_3V3 + RZG2L_IOLH_MAX_DS_ENTRIES))
 				return -EINVAL;
 
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
@@ -717,11 +732,11 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (!(cfg & PIN_CFG_IOLH_B))
 				return -EINVAL;
 
-			for (index = 0; index < ARRAY_SIZE(iolh_groupb_oi); index++) {
-				if (arg == iolh_groupb_oi[index])
+			for (index = 0; index < ARRAY_SIZE(hwcfg->iolh_groupb_oi); index++) {
+				if (arg == hwcfg->iolh_groupb_oi[index])
 					break;
 			}
-			if (index >= ARRAY_SIZE(iolh_groupb_oi))
+			if (index == ARRAY_SIZE(hwcfg->iolh_groupb_oi))
 				return -EINVAL;
 
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
@@ -1561,6 +1576,11 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 		.pwpr = 0x3014,
 		.sd_ch = 0x3000,
 	},
+	.iolh_groupa_ua = {
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 2000, 4000, 8000, 12000,
+	},
+	.iolh_groupb_oi = { 100, 66, 50, 33, },
 };
 
 static struct rzg2l_pinctrl_data r9a07g043_data = {
-- 
2.39.2


