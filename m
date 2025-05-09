Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D0FC3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:33 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.10369.1746783213024405486
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kQDr1Phu;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so3012345a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783211; x=1747388011; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIVNBkoWsTjZOk/VrEWZhdjsZSBvbCCIasdyWsKgvWo=;
        b=kQDr1PhuPSLLH9Kc+TFLfgD0orSzbIFdBm+U7wgQvyaxGiMTF/NvIC3CKpVUdDyoPo
         o6aXVAHHBvIRhfFW6QDT7CrWgsqd+tVjRuw9f46KsQdWPTcU67QwsO2GeWJtMLy4m1eD
         ZcLGkkB2CRKt95J0pdL75xgXnF3N0mvySgy/jFA4DVUCtc84UcLCfRou2IFeW1s1ZPtj
         4PNcPVUHRcT3lcFlYwAhWNwnX3JoQE6wCXklUYYnefiAe3D28IGlsxrRdryJsqZx1wAg
         UZkzB5ATpNb8V83a17WGZW19ssq6+oTbjXAZTJZIqQbs4HBdSizydoWA5jsUghk28AKi
         aqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783211; x=1747388011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIVNBkoWsTjZOk/VrEWZhdjsZSBvbCCIasdyWsKgvWo=;
        b=GzcCB6gvL0Qnx0P8djz+ruRt9WQdsVWUXolaxyEvKM2lcvljDKc1sLvpFUFcXLtl8s
         p+o/SYLRTHoJfHkP2hDoDR5A697/tBbLeTNHACWzMToPb4BH/fpDswfjFpDQVvedt5Z6
         xzZKgvdf3Ji2tFgp/b8wzO3b9DbdoVXPst3uXG4QchE7c6hRvoZPbDAN5eH9r+MgqrIG
         JfAm2oBs/gK+LOp6szBjlRA7J0bu2WOwWQ/xb19gWK24EdTyKwfgnyhdtzoatYiKjyoU
         0hjGsYIrHUEqzuSbvrrrj2WtErGBTfRujOq9dlGJ0a1l8JnCRYzqfpg9ZniGAGPw78/4
         9ZFw==
X-Forwarded-Encrypted: i=1; AJvYcCUy+GoFZF689BUvTu+LBBPtOLPzEN3SsoM90Pp+TT2AzapDj3AhP8W1mWYiIyYa5HOhVtgZijnE@lists.cip-project.org
X-Gm-Message-State: AOJu0YwsVwbuc1rCOU/bNyDAoC505oifyRG9ekYYBNYDKGZquzj+QD1m
	GVVRG9p5qjsy1/1bZ75Sh6a3CbP/4vvqQOrq6dXsWlFImnzr3TUdmtaOqlFfEtI=
X-Gm-Gg: ASbGncsLDnNqeJjD9zk4VaF14g2GNGpoZKwVemf0ln7c1i+hLaeD9jYbii5gTfLt0lD
	bUsr9EoUpAT7B/bd3qeek0/JfQrl67We1/TeBRc6VHQnrO6qM7XlnDyzGF9sXdpdbmL6iDB6Sa2
	zbKZhO9D6B8wlDudjjb+YDmAerODkKX6uqYrqQJRhJkqDArVspaEZ3raqZCTV3/nIUibUZjRg2t
	100BI1opGkYTRq6rd5byHsRcR8uEYjDS6MAoSqHM4pgY1GbrqfxB0gG/LFVgTkLa2W5GH6kqxPb
	QJAOC3rc5gDA3KJo+yab9XkzBXJPG17aBotjN/eH/yc/azt9abSdMf/8tiBTXwQaor1Hkw==
X-Google-Smtp-Source: AGHT+IGBPhmtr/sMCFDljEFVNwG1k1i9ydyr7RRU4QljKs/ofspa1o6T5m+bV90g+yMAEsSAb1/cmw==
X-Received: by 2002:a05:6402:5201:b0:5f3:81a0:c3d7 with SMTP id 4fb4d7f45d1cf-5fca07eda79mr2179092a12.22.1746783211483;
        Fri, 09 May 2025 02:33:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 09/34] arm64: defconfig: Enable DA7213 Codec
Date: Fri,  9 May 2025 12:32:53 +0300
Message-ID: <20250509093318.4014916-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18826

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
index 116000b07c8d..e99fc8006025 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -846,6 +846,7 @@ CONFIG_SND_SOC_TEGRA210_ADX=m
 CONFIG_SND_SOC_TEGRA210_MIXER=m
 CONFIG_SND_SOC_TEGRA_AUDIO_GRAPH_CARD=m
 CONFIG_SND_SOC_AK4613=m
+CONFIG_SND_SOC_DA7213=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
 CONFIG_SND_SOC_GTM601=m
-- 
2.43.0


