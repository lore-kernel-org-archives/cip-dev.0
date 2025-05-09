Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA97C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:05 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.10346.1746783300881848882
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=p6hyMuIY;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad221e3e5a2so61954166b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783299; x=1747388099; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb12DoZwHc9YoOL7RjZ/tQ+aPeTqA2wzf4IXjgzwS40=;
        b=p6hyMuIYI/K9BXvaeRvaneO2Vs+LbbsNzbuX/MFUq9P2lLLNSNyGpVRLqd30vDjXvc
         Nkoo3PrqwcjOEEb2G01aLMg1svBFJdQq+tugSg2FvI/40wbJ2k6LTGrs6fW64r2AjHcy
         zArKSNknSxaoMVYzQuY8fhBbYgVEJZJDg02g+QCg8uD10/GHB4oSYV/Fo4qs/tlKI240
         T0mBby6BMY3SEFpfvH9dxtgl0wN7KLpt3sD0Z3Yf+uFNLvrkRkhK8OH9ppe8RayOp08d
         q62zYDUG2vnszSBAO+KLsdFy08louVpONStPk361PLjXIs3fHwaA4HjQNxGXfFVL6iOm
         HhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783299; x=1747388099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb12DoZwHc9YoOL7RjZ/tQ+aPeTqA2wzf4IXjgzwS40=;
        b=UGpxold2GhmSGwgUE3TRy1GE7dy3ywTAt7zFT/WRYFVUyXyx2QoXl08UhtriywCe9B
         v0je0dP5upFzGkk1TXb2TxlmA3HnWFQDeJQ/hPOdPREqboSYfjff0drfBQ3FAPXFysGi
         BNzjam+GzRWB7ydwLZj/OU8QzyYEFsw/5g2Cz8bG6SCwQjooM5j8kb9QvKV0bEDKqp4P
         Zuu2Dd8uWapMG/QS+qkSHpCfa52CvB1vHOTs++zAL/87AvUXzajuO7P+304ILwEQIC3p
         DKusRCB/Fg7czUQspEB2AHBGmIkUAJKNpxaSTJwdURZNncxDL4PSiUuvHGgALtHRh7ec
         8c1w==
X-Forwarded-Encrypted: i=1; AJvYcCXhpjfyOaifLqf2E79NdF7qDvVLhZWkA6Z2dHIF416kSgQZmzy1FzytKuVjaS6VGO179BhdvmxO@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw++KemEULkYON9iQ/cOJXkIo5ixifPSRi98fFm2k3mqGX3rb4n
	aYEleo5hTuIK0DwMi70ecBi+lleqRA26pHydaC+SEPLFF0PMHtBGPi1AJg9w4Jo=
X-Gm-Gg: ASbGncs04Nzy5gUOT0E+dn/DY0p3BKOUI2x9IU1xnRlXYEFwnGKDE/d5dfOlr6Vrq93
	y3BQAz3mL/QMyESwXDmtGC0SHePnRR/3AtTO44TvhWi7AuOHe02ZwGaCWv8gOTs/PLDa+eZR5Oy
	5MO3cIR3S+uEaNSFa31qf4GOhtis9crBPqtYgfiVhAV8HPsWpml+hJGCL0mKYS79myFUL2f9cWr
	FoMFO7SCMwI79vjhHMLvUta7r/Q1+tEd41d+TA+ZjwL37OgFNOSJ2lBIvinMutZg2ryiNiztjvd
	x3ncWaIYgqOYSSZh3Z85/0Wd7aXQLoW2GclJFMJjS6wCdhn8CZW46SUjX73dnX6UDvO9qg==
X-Google-Smtp-Source: AGHT+IF0TgMKYPoAlHz8ps9BylYOKOsPsLP8+JYZFDzPiR0aq8Y+cWIPTHvIP9Uk+aJcsVFFtYKiHw==
X-Received: by 2002:a17:906:8e13:b0:ad1:825f:e33e with SMTP id a640c23a62f3a-ad218f4cb47mr242014566b.15.1746783299249;
        Fri, 09 May 2025 02:34:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 11/37] arm64: defconfig: Enable DA7213 Codec
Date: Fri,  9 May 2025 12:34:16 +0300
Message-ID: <20250509093442.4015145-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18863

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 29dfd412ec9e08b05b65848174646353b58fb54d upstream.

Enable the DA7213 Codec for ARD-AUDIO-DA7212 support on R-Car V4H White
Hawk.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/87mt4pl9sz.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 14a6a6978714..0bda64450d24 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -731,6 +731,7 @@ CONFIG_SND_SOC_TEGRA210_I2S=m
 CONFIG_SND_SOC_TEGRA186_DSPK=m
 CONFIG_SND_SOC_TEGRA210_ADMAIF=m
 CONFIG_SND_SOC_AK4613=m
+CONFIG_SND_SOC_DA7213=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
-- 
2.43.0


