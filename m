Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF55CC3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:33 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.10364.1746783210433714643
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TpY5v6Ja;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5fbf52aad74so4676106a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783209; x=1747388009; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00bQ52KDXo5XFsImJ46ctIOPCHexHN3gUW9s7sjuXjY=;
        b=TpY5v6JauYcAdnDa4BhJ2b79b4zSRt4jyVvzoYB55o8p0my5kQpBbAz6zpW1XbsOSq
         QDS+g+a2ygJ12hcof83+6/qnaS8lp+tnMIkQiQr+rqjRO6F4cXzgV7nKLRgxv8iCmM9r
         L5zm6C6j1pPSoruNjKnIGdBV6SDeY9GYEI7P3aKcQsUxKSKPewPdYBK/VervvA3Oweug
         uqF4gjgDcc5FL+LwYy4tDaKf5hMpMgRjDK7RqA0kZRrcJSXNx5QqtlBxzw8hzfCIXp8I
         k6Hcr6YQ5cZE6ZY4tfVdeAd5/9To0HE9iOkCxtHoFQT1WPZ4PnnrTMGYRRORBSxUSv/S
         6yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783209; x=1747388009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00bQ52KDXo5XFsImJ46ctIOPCHexHN3gUW9s7sjuXjY=;
        b=ZN6vnhJcOEJfMhAO06GBOAD6ekPvXSHTTj0k7siXLbRLbQiKIxvPb2T7nkZqDMowgL
         KUo4mt4DPYdrBUAVyACC/KwPWATGinrihdCWOFg23dcJ7GMHpG8XFej52EkgEF6iAyVG
         QCvjSf1GwmyMhSdZW+lwBK986Xm4G5ynxuBsCF75ucv5FgJfT0hx1w4qhl6NQ19S3vZE
         Cb4o+nIXjfMKrzDLuka8dI8COvbJSsn50hj5C1tFowe7bNaDSeatJVc0feSwDiuWwB07
         HsGB4h5a6Nk1p6r6ZPjfyGadOyHSdmlMj57LM8HUdgcrRZh6hIVZ0qc+vsTho/ggNtdI
         0LUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfHRQc12V4W6jIdzGdrAJjJXgdcQOw5a6TjCchrQo29sUln/OVdYB5Lc4nfHdTCyF/Q/Uyyh14@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyrn6lleeS2Xr1RWhy/G83bEZsQc6CjltwbIc/1GSJMQkw3/3JC
	uWsIZO8UvzpgPM+dv61SwK5nMJbR5Axv8xrPXKpvXxgeCJ9ffOA8ARV/dYv4k6RYsO0qznEcY16
	H
X-Gm-Gg: ASbGncsqQiyrJd2xv0xDgPVpYCaLIRrrrVcF+aKuFBl+OGoMTCbzD0gxNyscnvBMwRD
	QlyMAJ/tQXmyLwqaCYB4mkKQJAmBr3WlulE3W6AEOahZ+KRlmlrNIHeP7ro4InaJv9MWHCMq+vJ
	bY1UA05XnTp2Q8Q5vVg+DLJQ5IyYsWSmtIqUiqouCsmXZFlBcXwURUVgmVyfn1UZ0R3gnT7IWeG
	LZ21BoignxSt9F0zpJxhdkE0OArS+dbxZdwj4QZmYppXXZUNxrrjJEFWdMGFtKJ1cOSgzwQyX5r
	BKUDf9lU79BDdIoqI75ppsxa2LlrugOGdbBg5iuALzHTORdJeWpzt0GPMC9fyJj3tvSVvA==
X-Google-Smtp-Source: AGHT+IHxIETd9nLft16P4JbiXnxxS+Tw9vG6SZS4f+3knKVP32ANX2RZMszgvuLPIeIIUiHuYgMyAw==
X-Received: by 2002:a17:906:7951:b0:acb:1165:9a93 with SMTP id a640c23a62f3a-ad1fc8d8aabmr599592466b.3.1746783208821;
        Fri, 09 May 2025 02:33:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 07/34] ASoC: da7213: Avoid setting PLL when closing audio stream
Date: Fri,  9 May 2025 12:32:51 +0300
Message-ID: <20250509093318.4014916-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18824

From: Hao Bui <hao.bui.yg@renesas.com>

commit 1e1a2ef95b571825ca9c0113f6bef51e9cec98b0 upstream.

When audio stream is closing, audio frequency is set to 0 by ALSA but
codec driver DA7213 does not handle properly in this case. This patch
adds checking of 0Hz frequency to da7213_set_component_sysclk() and avoid
unnecessary PLL settings.

Signed-off-by: Hao Bui <hao.bui.yg@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241106081826.1211088-26-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 40be8c5093c2..3e1ae89305db 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1555,6 +1555,10 @@ static int da7213_set_component_sysclk(struct snd_soc_component *component,
 	if ((da7213->clk_src == clk_id) && (da7213->mclk_rate == freq))
 		return 0;
 
+	/* Maybe audio stream is closing. */
+	if (freq == 0)
+		return 0;
+
 	if (((freq < 5000000) && (freq != 32768)) || (freq > 54000000)) {
 		dev_err(component->dev, "Unsupported MCLK value %d\n",
 			freq);
-- 
2.43.0


