Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB57C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:54 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.10404.1746783287627989025
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Vwi0rvWu;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad221e3e5a2so61923766b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783286; x=1747388086; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUKzd4UlOr+zyHV/SjE45xakNDRodWBYuTZCaMni60c=;
        b=Vwi0rvWuZ8bJ6wv5G18+MXGzXTv8dohz2QhZD1ZNIOzBfIhe6LmhmCJInlQCPNCPf6
         1y2CtRLP8xDkV5vBYVbRjaVRg//Jyn+JHSFo9PQlcsTB8EMx4wdaqr2EuDEv+gehmfZ0
         hE7UVu7QsnU5BvFxvtohGV58NpqXB/lHkxBbmKlBo2R0fPl8pif7SMjMwoIMbWSdRc0v
         AfAQo8itr7Krt4eeg9q504ZhrGus5vL0d6IpWMnk1smJUv0FtesNMfk2tXbLxIeYhS7P
         0Y7qlp43ZBGvbR5HGoVfYRQNqmsETP6UX5Q0s0kXFTXfbQzR/F0e9yUglaq8KAlHUGQS
         baEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783286; x=1747388086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUKzd4UlOr+zyHV/SjE45xakNDRodWBYuTZCaMni60c=;
        b=bBrwgmgawiqY7ENuo3gu8BYHykyq7dARbwpaFy7Dj/dbojKedGCtv+2QU9oql5fCAz
         Y6p5yzIWaziag8uIOePYNb/6fG993YlgQfStvuzbJF7Bam3WY8RbPjppDIjUq45Na1nG
         TOslnm8yW8/UbtB5fa3Imd76YDXuIkPRz1iD8D3tCKqEQ4tUy6kKaVpymg89gxIRsJDB
         lP8yJzRtYE1zkIm5oowrr/VrqDHsFG0bYYFt8TpZ4HVtBa72K5REkD1f4H7VsR3YWmbE
         oCtwG7PFOZmrWNLdokmiFXWo6rs+gxHHxvkOm9RVhy+KwTGIdDcO0lsOkD3hYzGFfrRy
         6wMA==
X-Forwarded-Encrypted: i=1; AJvYcCVebbhy53Sd3sHPE76/HB3Glm6T0EN5NsrFn2mL2jCjtKwSF2o0BtKf72GMlw7rw8wFd83CKvZd@lists.cip-project.org
X-Gm-Message-State: AOJu0YwMQvSYLojUGjcLrW1lPwWFveJkzoDLGdOf8Ewc4/svsiA0Fk+t
	CmfQqTVesT47MvBPtMfJiUBZFgpqIk4eJr0NxV1XHvjTiV6TgWBvT/4spHp3eE720DJczVCLfAO
	q
X-Gm-Gg: ASbGncs8PWq2d0/JGL7UvZynFXhV9GPB5M89GUGu9QgQh7tDrigxH+uwatolI8MYutw
	RA74EoSg3xwI4tVBYKG9TBG0ipoRyXp4I9VFwlGIPnaHhZZ7/E8pwKnmm0PBkE3+4mAgD7h4g8b
	vOJ1Nx4B1FduBfJ60Nco2/aRd4QjDZR/lCdfy3CkWFB8eN54PC9U2rlaUjoqUmjKEgP2hUbsLZs
	WL1U9vMPI/H04iXYx/pIzFNNMk/vtwRA7eXu+Jv95yyCg4MVa2b3beYzjmmXQSPQ+feJSFJyuex
	EXaYYU8gIDGhoJlzxcuTa7PAsue/Ll38UtUnswyv9jqyRoYexQIIR7mKLyHlBzPJM9rQqA==
X-Google-Smtp-Source: AGHT+IHegy2gps9XTBt0KaWWuBzMW0v2eE2rLk0guXm4Xf06sAMkfQpOTIPTzJL47Q7CUvQkhs7lHw==
X-Received: by 2002:a17:906:4796:b0:ad1:e672:271f with SMTP id a640c23a62f3a-ad218f4ca71mr288794166b.18.1746783285941;
        Fri, 09 May 2025 02:34:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 01/37] ASoC: da7213: Add support for mono, set frame width to 32 when possible
Date: Fri,  9 May 2025 12:34:06 +0300
Message-ID: <20250509093442.4015145-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18853

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
index 72402467adcc..89842d77e4f6 100644
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


