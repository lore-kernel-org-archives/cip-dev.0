Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE9CC3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:54 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.10334.1746783289971743500
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BgpyWP3w;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad220f139adso79683366b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783288; x=1747388088; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyolEi/VWdfWNMRCbR+rEZmNay92O+5lh35OGVw+V5o=;
        b=BgpyWP3wWQWdPgKejOMO3FcklBvvBjMllnsc8BobODtlYKoYQaKt0jFqLltlVVrrL2
         5+dJnjjr85zkM/mliLJU2deELTzS+czhHbqjoX1lpxTX8b5856H+6hsXfDSPs6TG13vI
         KCoJtvvqVxb+qZQONxspQSlcFjPPvbrX2xwTSldLbd+frgvHURyA8chLqDl19syCyXr3
         +U7rhcxDzWuhZROBus1risN3BYZM/dPNarUNY7NlUcuducbpPxGnRQ103sqwfu9tQ1/8
         luaR57vAKNZfSKvVFbUphpgFeRuZPSSuxBbyjSZcircBw7/58rxErBHTkgFlAaLbOGkC
         4pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783288; x=1747388088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyolEi/VWdfWNMRCbR+rEZmNay92O+5lh35OGVw+V5o=;
        b=tio4HjeE4NlgbT2//fgoT6GFYLKmBaNEUYWexhch+bBgPwKipRWWVmTqQZ/dA0vGca
         vjGos7rrPXAb2pkLFcqnrIMAxYGdYFPcIn2Va51/T7CD5NDiOPjr/bOCZ8pOwEsR02J8
         tvL0q7oU3s6giTQJZDDY/tUZrkh8o2eywKSP22WPuctFVOn//RBJqffvy2zP6oIwRIt2
         4PbFpVUZhmnX564Vx19U5UWAt88HawbzDuQwfljAKYsyTqSsrNhjuFiYWoUUuRcbGpj8
         KLjM15xl9Boc3A7E6AFLisqLFQh9ktQ6xXJkKOSJQjhAc1a2Jkq7f1xD3bIrP9MD9yiM
         DW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTwsvHJzZtAZihhQeRsWG7T+HePyDLMkPk5+QOcdwBijhEZH3tqj9GGk7LYM/UPN7Rgzkmd/6P@lists.cip-project.org
X-Gm-Message-State: AOJu0YxtQRAEfCvr5GerUQ028lQ11ncI+oZrhL+XKG69PSKmJL1R8JOd
	wyDqq42g5EI0QQkcEJKK+6KqJ6Z3ZsvJ+j7TztbsknesBA8CgC6kJFe+ZUDbkR2FPHLlQnAtj9k
	n
X-Gm-Gg: ASbGnct7BAAzzC3Ea9UY7mmqavEyFDzATYjdKlGH7T2c+b2PxaTpN25KFZG3O+N6YfE
	UesHqcbXKDV+AgHO5Wd1awteJaI+mU0BRlGgcYC1RTA8qEeLQsFTcYGM7t7jPskD5gOtBor0Lqc
	kpxGbpyiqgH1t/uhDr+fgwed9Gcv07ivbAZigcM5Raiod7ER/JpDD13CQt0TxQSpcaok6/+cnJM
	yh1aaa/EsOtp4rUeGY0uWNIIIHZM2+stPvY1TV02NCYbwHUbskYWB8mVXmWfZAYNB3LWNF1aWCR
	OiYvWiXdsfTJNvs4qSejWYM6BC89g2pyMC6tRYS5lLJDNWasPSxrjps2Y5yrmb/sg7FTXQ==
X-Google-Smtp-Source: AGHT+IHSUCuZrGDVhfuItDf6F0bIUca1sjre/ozcbfGBMhkUIjlYAEE/BaV5UJF7rpNcFPv4IymJ5w==
X-Received: by 2002:a17:907:3cd2:b0:ace:68b0:62f5 with SMTP id a640c23a62f3a-ad2192e32d8mr223427666b.60.1746783288285;
        Fri, 09 May 2025 02:34:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 03/37] ASoC: da7213: Add new kcontrol for tonegen
Date: Fri,  9 May 2025 12:34:08 +0300
Message-ID: <20250509093442.4015145-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18855

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
index 0a4b22a711b7..8a30221a20a1 100644
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
 
@@ -2082,4 +2250,5 @@ module_i2c_driver(da7213_i2c_driver);
 
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


