Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42A0C3ABCC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:33 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.10357.1746783204524023239
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hoe6sFlY;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso3476132a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783203; x=1747388003; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loEt+NiMEmfKGruB0NVDeD0MBvF/eyV7aK0Mz4u1Iwo=;
        b=hoe6sFlY8IHnVOGjUTg/7JV2Hp0SfYguqViY4KrjXb5QWy6nOprgxXXufpPbgIyd/n
         VB6i2XwkNaK5o6yC9jQgWK2BbzwW+rb5XP2sK6bgY/eNVSwPy0B/bciQ+PgdJVD85uVz
         0M9Z+7kxC7b4/LSZHkFPvjtTm2PTDuAdijxGJqCOKOtMJYhDOdbSJmLosikwICUaMFif
         D+H8YnpSqAaQ3hmCJPeLoOWUNBSLobg/gOigswkdTY7kBYC8t1JRuGWNFHeWg1Px+JBF
         mhESQ8L9B3yEbjgjlc5OkDNXIxIElk+RuI9xbOhFoy7exnHIZLc/7v7t2qLdKQ41szya
         POeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783203; x=1747388003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loEt+NiMEmfKGruB0NVDeD0MBvF/eyV7aK0Mz4u1Iwo=;
        b=E5FM+QKLcu6r7oQ5o5O3a5JpdIkTE7+vBxbNawFcA/+EGTcF6PB0DHPj3Icc2RxV6N
         fvJdpVju6/L9i0qKZv+uflOzOIzr4R96otleeceb8rEuVkGnajzY+vVXBZ8GjOFApx5Q
         ogG21BaXlzh1oO10MhoDVbhtWBTHc8/HvjYHkS0ZwvwUAaQWjKl9gB8A5MCfucRPJZ2k
         iFgtoElSQ4/3MFKh9xukyLDStVIYfy3y0tHG7mb7nZDH2jL9kv56K1airyd1ZR0F/A9R
         n9an8zLzz/9zjXiYSZ2Q5rwNfqDgMG88x1wvXAWFPjiAMTiRkR5xefoZUWbSBKYBlRn+
         0NFg==
X-Forwarded-Encrypted: i=1; AJvYcCXcqBzxTH97JRb2ReMG/++sSQtjgAsYx2DHkDK/AP5nDnDhHcaqAfhFRgzQaVDQgJSnahikDmxO@lists.cip-project.org
X-Gm-Message-State: AOJu0YwuxzuDI7zo6VooEZ7b/HUHubJfJBKdCUT7wfiEcRXQX9c6Uc1c
	zQiesyxCNqgfm9FijcbblL8QAqWAN9QSIhtbAdtzyyltNLgfDtv3lbOEG+IG9SI=
X-Gm-Gg: ASbGnctlNwuOrx6WnGFFIt+ppU+4L0BAmuCDQ4XIdrkbCz1lIb4dYGXT7YBeccB2n5z
	Jt/0fDlHqvXbkMReO5pW4Dp6pd5zflm+Ktftp5kvriju2PlXYCW/8wLeS6cbpWEKIE5RYr7UWDD
	31djpq9FC8p6GkiZL+mHnVAJhU2PE1CjJ5Yz5MVr5u2xHauvUK5jLy/XkhfgsTFzIcjcIBOR0tB
	UDluzZMKvB8HwkiSb2dCNCl8nznNJuT9pQsmiLIrC+sAX0cv8aNDoAf0RcVUXqk4zFawfF6ssEg
	lSY6OQc8Sb5r+N3p/Uqrx/QJg9GdZRsxmbfOy+v4rCiAVj9iJ5uC+/1GFfIaZ2+elRu0Qg==
X-Google-Smtp-Source: AGHT+IFhFtcrH99/MN2wohKH/+Jzsax0xsmLKemLsfcTxwjgiKzQJhFHt5dr8s7tL4gHinRQjGDI1g==
X-Received: by 2002:a05:6402:3513:b0:5fc:8b5b:53de with SMTP id 4fb4d7f45d1cf-5fca080e61amr1954683a12.31.1746783202708;
        Fri, 09 May 2025 02:33:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 02/34] ASoC: da7213: Add new kcontrol for tonegen
Date: Fri,  9 May 2025 12:32:46 +0300
Message-ID: <20250509093318.4014916-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18819

From: David Rau <David.Rau.opensource@dm.renesas.com>

commit 64c3259b5f86963c5214e63cfadedaa2278ba0ed upstream.

Add new kcontrol for tone generator

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
Link: https://lore.kernel.org/r/20231018064444.23186-1-David.Rau.opensource@dm.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 171 +++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/da7213.h |  64 +++++++++++++-
 2 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 1c1f211a8e2e..3aa98b52a912 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -55,6 +55,7 @@ static const DECLARE_TLV_DB_SCALE(hp_vol_tlv, -5700, 100, 0);
 static const DECLARE_TLV_DB_SCALE(lineout_vol_tlv, -4800, 100, 0);
 static const DECLARE_TLV_DB_SCALE(alc_threshold_tlv, -9450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(alc_gain_tlv, 0, 600, 0);
+static const DECLARE_TLV_DB_SCALE(da7213_tonegen_gain_tlv, -4500, 300, 0);
 
 /* ADC and DAC voice mode (8kHz) high pass cutoff value */
 static const char * const da7213_voice_hpf_corner_txt[] = {
@@ -86,6 +87,23 @@ static SOC_ENUM_SINGLE_DECL(da7213_adc_audio_hpf_corner,
 			    DA7213_AUDIO_HPF_CORNER_SHIFT,
 			    da7213_audio_hpf_corner_txt);
 
+static const char * const da7213_tonegen_dtmf_key_txt[] = {
+	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D",
+	"*", "#"
+};
+
+static const struct soc_enum da7213_tonegen_dtmf_key =
+	SOC_ENUM_SINGLE(DA7213_TONE_GEN_CFG1, DA7213_DTMF_REG_SHIFT,
+			DA7213_DTMF_REG_MAX, da7213_tonegen_dtmf_key_txt);
+
+static const char * const da7213_tonegen_swg_sel_txt[] = {
+	"Sum", "SWG1", "SWG2", "Sum"
+};
+
+static const struct soc_enum da7213_tonegen_swg_sel =
+	SOC_ENUM_SINGLE(DA7213_TONE_GEN_CFG2, DA7213_SWG_SEL_SHIFT,
+			DA7213_SWG_SEL_MAX, da7213_tonegen_swg_sel_txt);
+
 /* Gain ramping rate value */
 static const char * const da7213_gain_ramp_rate_txt[] = {
 	"nominal rate * 8", "nominal rate * 16", "nominal rate / 16",
@@ -191,6 +209,64 @@ static SOC_ENUM_SINGLE_DECL(da7213_alc_integ_release_rate,
  * Control Functions
  */
 
+/* Locked Kcontrol calls */
+static int da7213_volsw_locked_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = snd_soc_get_volsw(kcontrol, ucontrol);
+	mutex_unlock(&da7213->ctrl_lock);
+
+	return ret;
+}
+
+static int da7213_volsw_locked_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	mutex_unlock(&da7213->ctrl_lock);
+
+	return ret;
+}
+
+static int da7213_enum_locked_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = snd_soc_get_enum_double(kcontrol, ucontrol);
+	mutex_unlock(&da7213->ctrl_lock);
+
+	return ret;
+}
+
+static int da7213_enum_locked_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = snd_soc_put_enum_double(kcontrol, ucontrol);
+	mutex_unlock(&da7213->ctrl_lock);
+
+	return ret;
+}
+
+/* ALC */
 static int da7213_get_alc_data(struct snd_soc_component *component, u8 reg_val)
 {
 	int mid_data, top_data;
@@ -376,6 +452,64 @@ static int da7213_put_alc_sw(struct snd_kcontrol *kcontrol,
 	return snd_soc_put_volsw(kcontrol, ucontrol);
 }
 
+/* ToneGen */
+static int da7213_tonegen_freq_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mixer_ctrl =
+		(struct soc_mixer_control *) kcontrol->private_value;
+	unsigned int reg = mixer_ctrl->reg;
+	__le16 val;
+	int ret;
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = regmap_raw_read(da7213->regmap, reg, &val, sizeof(val));
+	mutex_unlock(&da7213->ctrl_lock);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * Frequency value spans two 8-bit registers, lower then upper byte.
+	 * Therefore we need to convert to host endianness here.
+	 */
+	ucontrol->value.integer.value[0] = le16_to_cpu(val);
+
+	return 0;
+}
+
+static int da7213_tonegen_freq_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mixer_ctrl =
+		(struct soc_mixer_control *) kcontrol->private_value;
+	unsigned int reg = mixer_ctrl->reg;
+	__le16 val_new, val_old;
+	int ret;
+
+	/*
+	 * Frequency value spans two 8-bit registers, lower then upper byte.
+	 * Therefore we need to convert to little endian here to align with
+	 * HW registers.
+	 */
+	val_new = cpu_to_le16(ucontrol->value.integer.value[0]);
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = regmap_raw_read(da7213->regmap, reg, &val_old, sizeof(val_old));
+	if (ret == 0 && (val_old != val_new))
+		ret = regmap_raw_write(da7213->regmap, reg,
+				&val_new, sizeof(val_new));
+	mutex_unlock(&da7213->ctrl_lock);
+
+	if (ret < 0)
+		return ret;
+
+	return val_old != val_new;
+}
 
 /*
  * KControls
@@ -477,6 +611,37 @@ static const struct snd_kcontrol_new da7213_snd_controls[] = {
 	SOC_DOUBLE_R("Headphone ZC Switch", DA7213_HP_L_CTRL, DA7213_HP_R_CTRL,
 		     DA7213_ZC_EN_SHIFT, DA7213_ZC_EN_MAX, DA7213_NO_INVERT),
 
+	/* Tone Generator */
+	SOC_SINGLE_EXT_TLV("ToneGen Volume", DA7213_TONE_GEN_CFG2,
+			   DA7213_TONE_GEN_GAIN_SHIFT, DA7213_TONE_GEN_GAIN_MAX,
+			   DA7213_NO_INVERT, da7213_volsw_locked_get,
+			   da7213_volsw_locked_put, da7213_tonegen_gain_tlv),
+	SOC_ENUM_EXT("ToneGen DTMF Key", da7213_tonegen_dtmf_key,
+		     da7213_enum_locked_get, da7213_enum_locked_put),
+	SOC_SINGLE_EXT("ToneGen DTMF Switch", DA7213_TONE_GEN_CFG1,
+		       DA7213_DTMF_EN_SHIFT, DA7213_SWITCH_EN_MAX,
+		       DA7213_NO_INVERT, da7213_volsw_locked_get,
+		       da7213_volsw_locked_put),
+	SOC_SINGLE_EXT("ToneGen Start", DA7213_TONE_GEN_CFG1,
+		       DA7213_START_STOPN_SHIFT, DA7213_SWITCH_EN_MAX,
+		       DA7213_NO_INVERT, da7213_volsw_locked_get,
+		       da7213_volsw_locked_put),
+	SOC_ENUM_EXT("ToneGen Sinewave Gen Type", da7213_tonegen_swg_sel,
+		     da7213_enum_locked_get, da7213_enum_locked_put),
+	SOC_SINGLE_EXT("ToneGen Sinewave1 Freq", DA7213_TONE_GEN_FREQ1_L,
+		       DA7213_FREQ1_L_SHIFT, DA7213_FREQ_MAX, DA7213_NO_INVERT,
+		       da7213_tonegen_freq_get, da7213_tonegen_freq_put),
+	SOC_SINGLE_EXT("ToneGen Sinewave2 Freq", DA7213_TONE_GEN_FREQ2_L,
+		       DA7213_FREQ2_L_SHIFT, DA7213_FREQ_MAX, DA7213_NO_INVERT,
+		       da7213_tonegen_freq_get, da7213_tonegen_freq_put),
+	SOC_SINGLE_EXT("ToneGen On Time", DA7213_TONE_GEN_ON_PER,
+		       DA7213_BEEP_ON_PER_SHIFT, DA7213_BEEP_ON_OFF_MAX,
+		       DA7213_NO_INVERT, da7213_volsw_locked_get,
+		       da7213_volsw_locked_put),
+	SOC_SINGLE("ToneGen Off Time", DA7213_TONE_GEN_OFF_PER,
+		   DA7213_BEEP_OFF_PER_SHIFT, DA7213_BEEP_ON_OFF_MAX,
+		   DA7213_NO_INVERT),
+
 	/* Gain Ramping controls */
 	SOC_DOUBLE_R("Aux Gain Ramping Switch", DA7213_AUX_L_CTRL,
 		     DA7213_AUX_R_CTRL, DA7213_GAIN_RAMP_EN_SHIFT,
@@ -765,7 +930,7 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 		/* Check SRM has locked */
 		do {
 			pll_status = snd_soc_component_read(component, DA7213_PLL_STATUS);
-			if (pll_status & DA7219_PLL_SRM_LOCK) {
+			if (pll_status & DA7213_PLL_SRM_LOCK) {
 				srm_lock = true;
 			} else {
 				++i;
@@ -1931,6 +2096,9 @@ static int da7213_probe(struct snd_soc_component *component)
 		da7213->fixed_clk_auto_pll = true;
 	}
 
+	/* Default infinite tone gen, start/stop by Kcontrol */
+	snd_soc_component_write(component, DA7213_TONE_GEN_CYCLES, DA7213_BEEP_CYCLES_MASK);
+
 	return 0;
 }
 
@@ -2078,4 +2246,5 @@ module_i2c_driver(da7213_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC DA7213 Codec driver");
 MODULE_AUTHOR("Adam Thomson <Adam.Thomson.Opensource@diasemi.com>");
+MODULE_AUTHOR("David Rau <David.Rau.opensource@dm.renesas.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 4ca9cfdea06d..505b731c0adb 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -5,6 +5,7 @@
  * Copyright (c) 2013 Dialog Semiconductor
  *
  * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+ * Author: David Rau <David.Rau.opensource@dm.renesas.com>
  */
 
 #ifndef _DA7213_H
@@ -135,13 +136,24 @@
 #define DA7213_DAC_NG_ON_THRESHOLD	0xB1
 #define DA7213_DAC_NG_CTRL		0xB2
 
+#define DA7213_TONE_GEN_CFG1		0xB4
+#define DA7213_TONE_GEN_CFG2		0xB5
+#define DA7213_TONE_GEN_CYCLES		0xB6
+#define DA7213_TONE_GEN_FREQ1_L		0xB7
+#define DA7213_TONE_GEN_FREQ1_U		0xB8
+#define DA7213_TONE_GEN_FREQ2_L		0xB9
+#define DA7213_TONE_GEN_FREQ2_U		0xBA
+#define DA7213_TONE_GEN_ON_PER		0xBB
+#define DA7213_TONE_GEN_OFF_PER		0xBC
 
 /*
  * Bit fields
  */
 
+#define DA7213_SWITCH_EN_MAX		0x1
+
 /* DA7213_PLL_STATUS = 0x03 */
-#define DA7219_PLL_SRM_LOCK					(0x1 << 1)
+#define DA7213_PLL_SRM_LOCK					(0x1 << 1)
 
 /* DA7213_SR = 0x22 */
 #define DA7213_SR_8000						(0x1 << 0)
@@ -484,6 +496,55 @@
 #define DA7213_DAC_NG_EN_SHIFT					7
 #define DA7213_DAC_NG_EN_MAX					0x1
 
+/* DA7213_TONE_GEN_CFG1 = 0xB4 */
+#define DA7213_DTMF_REG_SHIFT		0
+#define DA7213_DTMF_REG_MASK		(0xF << 0)
+#define DA7213_DTMF_REG_MAX		16
+#define DA7213_DTMF_EN_SHIFT		4
+#define DA7213_DTMF_EN_MASK		(0x1 << 4)
+#define DA7213_START_STOPN_SHIFT	7
+#define DA7213_START_STOPN_MASK		(0x1 << 7)
+
+/* DA7213_TONE_GEN_CFG2 = 0xB5 */
+#define DA7213_SWG_SEL_SHIFT		0
+#define DA7213_SWG_SEL_MASK		(0x3 << 0)
+#define DA7213_SWG_SEL_MAX		4
+#define DA7213_SWG_SEL_SRAMP		(0x3 << 0)
+#define DA7213_TONE_GEN_GAIN_SHIFT	4
+#define DA7213_TONE_GEN_GAIN_MASK	(0xF << 4)
+#define DA7213_TONE_GEN_GAIN_MAX	0xF
+#define DA7213_TONE_GEN_GAIN_MINUS_9DB	(0x3 << 4)
+#define DA7213_TONE_GEN_GAIN_MINUS_15DB	(0x5 << 4)
+
+/* DA7213_TONE_GEN_CYCLES = 0xB6 */
+#define DA7213_BEEP_CYCLES_SHIFT	0
+#define DA7213_BEEP_CYCLES_MASK		(0x7 << 0)
+
+/* DA7213_TONE_GEN_FREQ1_L = 0xB7 */
+#define DA7213_FREQ1_L_SHIFT	0
+#define DA7213_FREQ1_L_MASK	(0xFF << 0)
+#define DA7213_FREQ_MAX		0xFFFF
+
+/* DA7213_TONE_GEN_FREQ1_U = 0xB8 */
+#define DA7213_FREQ1_U_SHIFT	0
+#define DA7213_FREQ1_U_MASK	(0xFF << 0)
+
+/* DA7213_TONE_GEN_FREQ2_L = 0xB9 */
+#define DA7213_FREQ2_L_SHIFT	0
+#define DA7213_FREQ2_L_MASK	(0xFF << 0)
+
+/* DA7213_TONE_GEN_FREQ2_U = 0xBA */
+#define DA7213_FREQ2_U_SHIFT	0
+#define DA7213_FREQ2_U_MASK	(0xFF << 0)
+
+/* DA7213_TONE_GEN_ON_PER = 0xBB */
+#define DA7213_BEEP_ON_PER_SHIFT	0
+#define DA7213_BEEP_ON_PER_MASK		(0x3F << 0)
+#define DA7213_BEEP_ON_OFF_MAX		0x3F
+
+/* DA7213_TONE_GEN_OFF_PER = 0xBC */
+#define DA7213_BEEP_OFF_PER_SHIFT	0
+#define DA7213_BEEP_OFF_PER_MASK	(0x3F << 0)
 
 /*
  * General defines
@@ -534,6 +595,7 @@ enum da7213_supplies {
 /* Codec private data */
 struct da7213_priv {
 	struct regmap *regmap;
+	struct mutex ctrl_lock;
 	struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
 	struct clk *mclk;
 	unsigned int mclk_rate;
-- 
2.43.0


