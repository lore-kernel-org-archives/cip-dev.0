Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E99C0218D
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:50 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.41878.1737546704427151869
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kUc1i9P6;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43622267b2eso67278965e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546703; x=1738151503; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdoaaBkruq8UaBR6aG2nxEBiJ4gLHmsErL0xCb1P+ys=;
        b=kUc1i9P6dc+zF2l/Y2JI+onnoQJeAS5xbXC4nD0IfqpN8pqFiTjs3sz0qfqi9IQWMi
         mA48x/Y4JvpRNsI27fNnySgD2YqOJd1EnsSeLZvfhDVEqBhZXk9oHZV8uL6WAbJkSXWY
         fHvitjySBDWOwLFQ+AS7cTLWsGRtVZohVSc0aD9m6wXktTgAeWdfRdsIvtihG9uDOjQQ
         CChKVIP8D6jXp4D5uQUCZKuTdNmV9k8kxtiHG9hiOb37We+dMpAN3Oh5dJxJW7cjiAwV
         lOr0q+UIe6pJWqI6J8bBE3gv/7qtSuN3hyYd6sgYp5Kn7OsemORVlGuNNVKqnFH7ERTF
         s9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546703; x=1738151503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdoaaBkruq8UaBR6aG2nxEBiJ4gLHmsErL0xCb1P+ys=;
        b=aMIHwNei1zeOweEpjFDyIoNLI9vQH2+CysSq8jKFTmgiMq+F8sAh9O4XzaG82RlqrW
         ztbWGwSomK1AqiNam246Zsnu+NDHJUuNUmr3vYvNmUWbDp18mvK5inuJosGQA0TJAUZv
         PjU9vyox654Pnv1/dghkFZ9tICCnBdfofrCLpwbbQ8385aq/DjaNq8M5GNvObpV6Otwm
         iLIi29meBAthOsISUx8la8UK1yT6fmVvfAPQ0TkXNEf8GGD+6Ls8mnVVm6lpUnwSu3ev
         KdXVipkpNFE8yXJf2Av9UT5b0dkDvffJoE1xajoAE5065/j2rgdo7JSt3CK6MrjE19ar
         S1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+svp4rIeT3qTbc0brqHakje7kAOtxIsAo4hmzYjX2V66Hzj1sheO8cRBYD8sg8lysxSDAw37Y@lists.cip-project.org
X-Gm-Message-State: AOJu0YziKy6aVJwNgH3VqYw1xHAjEAE1YWT2S26sZBBR81bAK2+bPF3x
	KpTNEa29GRGejqw2hKMuDIqAtRTmne3Vrq3IL5gIH3wwNRCwp00NxUBNNGc4cKo=
X-Gm-Gg: ASbGnctASOl7mB6DsSi0xiF3oZb6rBE00t7ouLTBpM1u9h/pqoyFm8LZ2AUdlslRf3+
	/1Q2NpCkPSJ3dYgL9tHMZ5fv7KZr/9yfvr57CSW1EHzQ4r3stILeTqZi4lJyduXqlhUZuJcAwhq
	iS/nUHN3m9cgcY0/Z738YsXHmJBYsY//dagpu10tCRAZGZ1bGlYu9+/qqug0pLezEoqkm3pitem
	4R2V7wjCthTMC4SCxx2S30nH4orlNiGjjTTAqOWQISP3zrD4v4lfYkCokWAO0uIz2+ZF+B8iDvM
	ud4RlcBfQLXKXDwi6LeXzVs=
X-Google-Smtp-Source: AGHT+IEv0caoBtDaoqnPoQQkId4Sp5hpCHR+ZOUIkJujv/utaVpxgHVwMZkz7uv1moPKXtI6pwkRsw==
X-Received: by 2002:a05:600c:6a94:b0:434:f753:600f with SMTP id 5b1f17b1804b1-438914376b1mr179381095e9.19.1737546702869;
        Wed, 22 Jan 2025 03:51:42 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:42 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 14/14] arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3
Date: Wed, 22 Jan 2025 13:51:19 +0200
Message-ID: <20250122115120.2885015-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17577

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c520bbb523304ba98de9ffeeb0ef289921434125 upstream.

Enable the Renesas VBATTB clock and RTCA-3 RTC drivers.  These are
available on the Renesas RZ/G3S SoC.  VBATTB is the clock provider for
the RTC counter.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by dropping CONFIG_RTC_DRV_TI_K3=m
 and CONFIG_TEGRA186_TIMER=y; although drivers for these are avaiable in
 the v6.1.y cip they were not enabled in the previous arm64 defconfig]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6f644364b743..a15bfa82fe59 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1016,6 +1016,7 @@ CONFIG_RTC_DRV_SNVS=m
 CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_MT6397=m
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_RTC_DRV_RENESAS_RTCA3=m
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_DMA_SUN6I=m
@@ -1104,6 +1105,7 @@ CONFIG_SM_VIDEOCC_8250=y
 CONFIG_QCOM_HFPLL=y
 CONFIG_CLK_GFM_LPASS_SM8250=m
 CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
+CONFIG_CLK_RENESAS_VBATTB=m
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_RENESAS_OSTM=y
-- 
2.43.0


