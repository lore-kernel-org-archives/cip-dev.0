Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9775C04FFE
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:30 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web11.18437.1713526766051484789
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=H/p4RE3w;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.175, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad2so28116831fa.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526764; x=1714131564; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9v0wzmSFAm5hEAvJbTGUJUPLmMtF4HD7VhWEiWxdy0=;
        b=H/p4RE3wFr9uVKoKtcnvMQHNjCqcFFtsjg0/WbD/5zmt0m8LDfHQrwT7Sv3X22nTFg
         odVT8bixujCOsBL++mv5Z/VbBysr5CQ97ctzmxuIxw7k5KC4Xi8gnARqte7i0aX/oArY
         BY8ISeXGKHKm+X+eEqLuHHgO/rMqUDubEPb5lBq1Ka29EiLz8/6jacuf0RB3cwF41Xte
         LgBvmAF7Xi/Es/nt1S1lFM0nQcXLTprMRAIjuFeIUozLsjtkSKbPUcbflHwSv1ZCIsmq
         6L5rmKtelWiUx75nV8pivJBvzdfJx531QABWb1c4bQlaUjavGwfpint15ixNvo/nQaV+
         B76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526764; x=1714131564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9v0wzmSFAm5hEAvJbTGUJUPLmMtF4HD7VhWEiWxdy0=;
        b=JVrfxdOy2ep3LR7digQfqNLIkm+ZdYGU1eQfLcGwctMAA5wbrSGrFRy9bQNOWdBHre
         v2Ar1r0FfIXYSjNRb1cuw7h1kbqqDq1DdCd8glsIu13Re1Uptg4dLhwyl71t32IrTcSB
         zWnYoPY+f1pJ+axk97I0xjLcs29nrOxWfSIRKbUoRZ+sIgn/6+S6FhmtPiAl19BlOQB0
         DRyoKDHoRX4adaZdmdIkuUKK4uTbdNWYuMV1Kp8vFxVel82GQAWxQkWLDKqsVRLFvP96
         mC/lQ4gR9+xCo9NIWV55AQAbvD1RXtHKSc20N41mvvD1psm1tLWgKIDPWTAU6gZySm/z
         h5yg==
X-Gm-Message-State: AOJu0YyJyjOHDedC9ViAdeaeQ/54jPuaJEZLvq4PgBJtq6Fgc4fi+Qqu
	Qk4iZJqlpO2et8is62lTx9IApEsKQUwuBgWU4fBmqjRacaK8VHOQDI6N9JCrCBI=
X-Google-Smtp-Source: AGHT+IFzEySGBSGKDQJbQAAoTrAy1AuSpCSfs4sympy7JgMepFpXgzCOvdByDrWquz1fZ1LidkLTAw==
X-Received: by 2002:a2e:9357:0:b0:2db:196a:a8d2 with SMTP id m23-20020a2e9357000000b002db196aa8d2mr1056755ljh.17.1713526764278;
        Fri, 19 Apr 2024 04:39:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 27/44] pinctrl: renesas: rzg2l: Move DS and OI to SoC-specific configuration
Date: Fri, 19 Apr 2024 14:38:25 +0300
Message-Id: <20240419113842.3675543-28-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15678

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
index 14cfbe687ba8..612e34bceda0 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -132,13 +132,30 @@ struct rzg2l_register_offsets {
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
 
@@ -176,9 +193,6 @@ struct rzg2l_pinctrl {
 	struct mutex			mutex; /* serialize adding groups and functions */
 };
 
-static const unsigned int iolh_groupa_mA[] = { 2, 4, 8, 12 };
-static const unsigned int iolh_groupb_oi[] = { 100, 66, 50, 33 };
-
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -603,7 +617,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
-		arg = iolh_groupa_mA[index];
+		arg = hwcfg->iolh_groupa_ua[index + RZG2L_IOLH_IDX_3V3] / 1000;
 		break;
 	}
 
@@ -614,7 +628,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
-		arg = iolh_groupb_oi[index];
+		arg = hwcfg->iolh_groupb_oi[index];
 		break;
 	}
 
@@ -702,11 +716,12 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
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
@@ -720,11 +735,11 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
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
@@ -1563,6 +1578,11 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
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


