Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33669C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:13 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.10313.1746783130630372690
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fq1rrzQ1;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fbc736f0c7so2853765a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783129; x=1747387929; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps1F/P+VjQs4cDZ6ilPWgVZPoPZA9cvOzXT2dF7/Ea0=;
        b=fq1rrzQ14WBSmdHJBEyvJOtSslpoy7vMRTha06Vd8LJLUJiJx8+O+PuzzK5TR+uaRQ
         gdEToGUaCdPx7BQylKVNBpB4ZwqA/OEnAWCwxVtPa7pLY8lgxTs4spHZuUkE10Ft+pfB
         tFAk4VAMDdzpTt/N1K9S38+ABQxKREM/351uWrRk7J48zpHaOeizDrrf2JeLtCEzpJq/
         RsHYo7iJSp/WoI6bu9YWyez6Ko0xds+4k4UkVv9HpOR2ivVsgr/CmoFSERtxza+/3P+t
         qx5na9SUdiUVWX8cKKvyltfL5q5GzlpOyZC0V0svvo3xopo8BopWKBP9Jx+aZw/ND4Bj
         Nr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783129; x=1747387929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ps1F/P+VjQs4cDZ6ilPWgVZPoPZA9cvOzXT2dF7/Ea0=;
        b=EMauew3rMrJBwCOtmXGSF2CwDo9i6HJHJGewtOPKW7C8V4gkuWMjllT/Mg5eCqw6Jh
         dsheZqTgQWK4PbAJHub2sFrZjiJyjzVPp2N6ggsUki7uM4NyEfOTk7iPz687WxndJwIn
         fKyAIZNwCv1SMvUAywuh9TLzg0MaFAfy3V8k6ekJgyV4SBlKhwpb/Mxe7NywXBqPLayW
         kKHixX3ocl3h9Ez7A6VYtIkL6tNcCCyclGHjLKPDeAHY6R5iir47SjBC7KhJF3AXaR9n
         8ITT7URwaFzvBx2a6dgXuhEdQRiY9FCxSFKxFgwj3FRkuUDCoKWNUtj75RcmqguZcaPY
         lxEw==
X-Forwarded-Encrypted: i=1; AJvYcCVHkTWcNPi9zX7YK8TjMKb5JuglHQa5L9Yz3kwO68m6KKTwR2JGf5+RR8Z5wdRgNowu8oJ9gOSx@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyv6ymqkmCtQu93/Glm+wEHIAY2mo8ikmjBjHy1oGXiEcZ/GHqk
	qf+9xtZayxfDtGvC5yBK7/5qhZOLrPUyKniwPDRxUVj0ne7tb7r1BrscFX6ctss=
X-Gm-Gg: ASbGncuiVQDgTl03kvRdSDwGSfz20Xjm5A0FvNPnELTgBhZBonquMBQuTXEyj63FVDi
	Tk1ZoOGpvduhX7E678xnaiXNVWxjt3n2kBlIqIKYSI+p+E6seiZhxGU3Fgyvh6PocX9X7WpAqnI
	CaT9FIqZvCcYEyCa/iN2NrOuowEkkxPhSwAx+ZdqEEodtn/axlUWytmIhJMCFBjR0PmRZCC7Dom
	kDwNhQIGe5cohE0LLKrPHFnjt+ZKZ0wyGiRJqh0769aRIwsjrfFwuvnQ5dkieoCWO63tcVgQJgb
	20KtKJgyx84cf8Nx1UECaW5Jocz6ycirMYaVhFNgFIHP0XlKlhhSH/P6xaYOPTQne20gNQ==
X-Google-Smtp-Source: AGHT+IHt/rrzUAx4KUvlY71aAtilj3zAZAMCvB3s4e5wzmtLC3G7P/lbFjsnfMMZOmeSj+5qe7bTRA==
X-Received: by 2002:a05:6402:2789:b0:5fa:aa28:b10 with SMTP id 4fb4d7f45d1cf-5fca0766b7cmr1828748a12.13.1746783128975;
        Fri, 09 May 2025 02:32:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 03/29] ASoC: da7213: Avoid setting PLL when closing audio stream
Date: Fri,  9 May 2025 12:31:37 +0300
Message-ID: <20250509093203.4014750-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18790

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
index d2bb12538a20..5ec51537ece5 100644
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


