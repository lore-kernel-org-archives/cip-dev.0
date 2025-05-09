Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF593C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:33 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.10356.1746783203051313455
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KgtxREn+;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5fcaff7274bso425247a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783201; x=1747388001; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xNKWDJcGfNXk+fIdU/ZBRGiSE56zYC2bks4RgRv9us=;
        b=KgtxREn+wB1tLBdQQKXMOAddfZnKX9FxjrLB6Ie4DwqJ/WNrbPpc3uhMLEHkvGNzXr
         g3a7G8z0LznNKziJYoohtnbxQW+szbrLRIoWU7p8a9jX0G42OFKdm97QPrKcoKhaz2IV
         JN7zqtmeMzRDgPuRk51FiP+icrTGkAqJDCX1AC1oe2kgUsZjNwaP/THk5NPnmfOIR4z/
         blUN/rXm29VdnDLpYg+2qI4Nv63e72z5Sa6StideF98zLsiglAg9erbAj+P1m3o+7PfB
         8KDdDvEHRo/AM+YWnZr0ZgxmcV4SVd0O0ycQhuEOnsCVkzNgF9+50BIzXU2WQ6Gx3f94
         4zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783201; x=1747388001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xNKWDJcGfNXk+fIdU/ZBRGiSE56zYC2bks4RgRv9us=;
        b=KqJ27gOJBaO2oXQQnY5CrQp27QwNFKRze6QXyelOFeh/tZItROVzUKT9+wfwFp9EOR
         FTn8Z31AMbEUZZhsnZHWFePU7kY/3v4CiFe2ZR0FELxfrJB5K905+e4hhQW4EC6yunM+
         oJmCEgxN0TGbTNNOfMBs7m8ES7ep4LVKUK4MtmtC8LAKoxvQZhWTNHONn6CmHnT5hnwp
         A9FA4BELH3wUZQOB76qsDF/prBBB/Vi07rTl3bW5OYGUTEfkeVxReizX2Vf1mFDkeVCx
         DvgwLQ004gaHgpbTEw2gITumpf0R+N/9usYR6DF9CkzKPTjQyNNA06xK+vaK6ETqG44U
         cbPw==
X-Forwarded-Encrypted: i=1; AJvYcCWhZXyEOsG5Wx5pdM2BLX3+RLPFPUtRXijZ1XK86ES61+vsVp3TFatKXuwM05Gg/GB0TERYxRhs@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz4nkAzjlFEKFOuh4K1Zf5AP3TmmlIsKGSDjBHRr+lYiiCifxst
	EJ+RHT3psWw0kt6S1Bi8g7dcqQnyAbChpdxZwjfbcDLH50MYM+RlCX87TAkhEQs=
X-Gm-Gg: ASbGncsaUxi4tpOtDhE2bW2/wVKdHLH0DVsw8uwjDeYIDMgVMnA+Qo6zvGLFVorCUKm
	gn+gJKbZBvCuVLzHXN/ZQbQPbDXunUv21AgfSTpOOvNh7SGceoD2WPvN5N8bOYYDxy05EBdrAtQ
	2b3K5m4586zwCoVO0owD7LQxpQLZuMOkoo3cSh1rL9t7uP93HatHKNqTbL8cwgxNmrNOU5BVqxF
	kWppaDlRQfL31R6AZt4D4GbH9mEPQRbPh629e/n2bUFffZZ17dyTYaXQ6eEePGGuypOn0/B7LBN
	RaqFWblE+6925QxGmNzvAw6yVgyyJiJliVMSd6Qa4Lnwqx5Sis7KmWmXakshV4XNEv8ndQ==
X-Google-Smtp-Source: AGHT+IFWUc4QvHYTnuGn2i09j91sJfNPcJZ+57uJJLYFQXS/jQq6Y1bSSKdbeS2Xauvgi7E1WnbRZg==
X-Received: by 2002:a05:6402:2389:b0:5fc:aa26:a12 with SMTP id 4fb4d7f45d1cf-5fcaa260db7mr789128a12.23.1746783201296;
        Fri, 09 May 2025 02:33:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:20 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 01/34] ASoC: da7213: Add support for mono, set frame width to 32 when possible
Date: Fri,  9 May 2025 12:32:45 +0300
Message-ID: <20250509093318.4014916-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18818

From: David Rau <David.Rau.opensource@dm.renesas.com>

commit c89e652e84f636354213aae42490c7f77a0eadde upstream.

This adds the DAI mono mode support and set the frame width to 32

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Tested-by: David Rau <David.Rau.opensource@dm.renesas.com>
Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
Link: https://lore.kernel.org/r/20221214044058.6289-1-David.Rau.opensource@dm.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 30 ++++++++++++++++++++++++++++--
 sound/soc/codecs/da7213.h |  3 +++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 5678683c71be..1c1f211a8e2e 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1157,13 +1157,31 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	u8 dai_clk_mode = DA7213_DAI_BCLKS_PER_WCLK_64;
 	u8 dai_ctrl = 0;
 	u8 fs;
 
+	/* Set channels */
+	switch (params_channels(params)) {
+	case 1:
+		if (da7213->fmt != DA7213_DAI_FORMAT_DSP) {
+			dev_err(component->dev, "Mono supported only in DSP mode\n");
+			return -EINVAL;
+		}
+		dai_ctrl |= DA7213_DAI_MONO_MODE_EN;
+		break;
+	case 2:
+		dai_ctrl &= ~(DA7213_DAI_MONO_MODE_EN);
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/* Set DAI format */
 	switch (params_width(params)) {
 	case 16:
 		dai_ctrl |= DA7213_DAI_WORD_LENGTH_S16_LE;
+		dai_clk_mode = DA7213_DAI_BCLKS_PER_WCLK_32; /* 32bit for 1ch and 2ch */
 		break;
 	case 20:
 		dai_ctrl |= DA7213_DAI_WORD_LENGTH_S20_LE;
@@ -1224,8 +1242,11 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_component_update_bits(component, DA7213_DAI_CTRL, DA7213_DAI_WORD_LENGTH_MASK,
-			    dai_ctrl);
+	snd_soc_component_update_bits(component, DA7213_DAI_CLK_MODE,
+		DA7213_DAI_BCLKS_PER_WCLK_MASK, dai_clk_mode);
+
+	snd_soc_component_update_bits(component, DA7213_DAI_CTRL,
+		DA7213_DAI_WORD_LENGTH_MASK | DA7213_DAI_MONO_MODE_MASK, dai_ctrl);
 	snd_soc_component_write(component, DA7213_SR, fs);
 
 	return 0;
@@ -1300,19 +1321,24 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		dai_ctrl |= DA7213_DAI_FORMAT_I2S_MODE;
+		da7213->fmt = DA7213_DAI_FORMAT_I2S_MODE;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		dai_ctrl |= DA7213_DAI_FORMAT_LEFT_J;
+		da7213->fmt = DA7213_DAI_FORMAT_LEFT_J;
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		dai_ctrl |= DA7213_DAI_FORMAT_RIGHT_J;
+		da7213->fmt = DA7213_DAI_FORMAT_RIGHT_J;
 		break;
 	case SND_SOC_DAI_FORMAT_DSP_A: /* L data MSB after FRM LRC */
 		dai_ctrl |= DA7213_DAI_FORMAT_DSP;
 		dai_offset = 1;
+		da7213->fmt = DA7213_DAI_FORMAT_DSP;
 		break;
 	case SND_SOC_DAI_FORMAT_DSP_B: /* L data MSB during FRM LRC */
 		dai_ctrl |= DA7213_DAI_FORMAT_DSP;
+		da7213->fmt = DA7213_DAI_FORMAT_DSP;
 		break;
 	default:
 		return -EINVAL;
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 97ccf0ddd2be..4ca9cfdea06d 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -195,6 +195,8 @@
 #define DA7213_DAI_WORD_LENGTH_S24_LE				(0x2 << 2)
 #define DA7213_DAI_WORD_LENGTH_S32_LE				(0x3 << 2)
 #define DA7213_DAI_WORD_LENGTH_MASK				(0x3 << 2)
+#define DA7213_DAI_MONO_MODE_EN					(0x1 << 4)
+#define DA7213_DAI_MONO_MODE_MASK				(0x1 << 4)
 #define DA7213_DAI_EN_SHIFT					7
 
 /* DA7213_DIG_ROUTING_DAI = 0x21 */
@@ -542,6 +544,7 @@ struct da7213_priv {
 	bool alc_en;
 	bool fixed_clk_auto_pll;
 	struct da7213_platform_data *pdata;
+	int fmt;
 };
 
 #endif /* _DA7213_H */
-- 
2.43.0


