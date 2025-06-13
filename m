Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD0C71156
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:00 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.7084.1749809756708834642
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MhOH5K1R;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adeaa4f3d07so347245566b.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809755; x=1750414555; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S1afLlbpj1B3s7nm9tpjr3mXb470X/7Nt5bLSv6zTU=;
        b=MhOH5K1RVKV/DDCF/BdwiUjUaJMmlGxHp1RlwLwBR+ygKtJmEc2kiQQEvLYav73p5H
         LeNynz2WZEA3zUc3VQZ9OwrHU/2lmZ/AFz8zNoQ0CnPWqb1SEF228rxkMmmC+k15Qazy
         O7vyVHe7TtWt0m4IvDA/925T0rGHoMxoHGsMjIe4mdBS7E2k2xD8SkKHzHuZRhBkGYoT
         WXRwQvDTyIli7T2ASEEY3bFw9Is5UR9/dIFRTwXs7pZv8D0btm1R3ZdcYnjISfld0Wlu
         Ac7KNybZvvFw4AK6WgWKg85fsTwpc8ZUjtfN7iXoGhoO4OEWmBbUptO+sgwkoZpQUz5U
         xccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809755; x=1750414555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S1afLlbpj1B3s7nm9tpjr3mXb470X/7Nt5bLSv6zTU=;
        b=XmfWOs5rFwSv5wZKJsN6N8ETPkneEscTMUZsvEBYAWByqIXNFY5boHlBphw4NOt/PF
         gm997p/LHQ0k1cSBoE/sVea++CKSTQVI6dkne0SlAUAA8lGS03SzTBys/t2QfZSQzhJX
         Kmwe5aCI+StbCLk6FElnUO98BPq3cj3mmJ/2pEh8YLQnFVOsu+ocfy8kKbg0/g4Bg6pX
         QvkCYIxQTWCReoVCVDO4L4xjw3l9zng1aY7d7qP3PeKHN8JREJ3AZM9bY5OdjoaJDJag
         Vo6Vsyrk+auZ7Pgm2Dqzi3D2wsGP8IivD0kWhq+gaWrLe5oFhS8L+GzhtpD257xQ4wUI
         NxAg==
X-Forwarded-Encrypted: i=1; AJvYcCUR9ObWsiTpAFoYaFHtTyxTgKUYe5SIdOua3wQBDY/qi27xP+yEs5o0w27+bvLPD/36xnU5RUj2@lists.cip-project.org
X-Gm-Message-State: AOJu0YyNiGyDPIoOMWTf0C4ezewwQUQDO8u4xNaCufXRH3/rPIpITv8T
	C9c8Trz2Vo8El81sY28wzPyyKGIW6RupdFTxejzBdmt0fCGmKyZaeRngdt1CMqk9tso=
X-Gm-Gg: ASbGncv6Ef4VeYLvTzc8qgzy6k2RIpmjJibe0xxbU7SxN0TAAq61iTEdoGtqVbU+gdL
	MUWvaHqVRePj5jsjdugfJ3NVrnaVE9gYBjSzQdN1cT8MtxDfXxdCQpfmtgYO+6DIBV7Oieirlej
	4/CBLMdjRQvBQ68ducl4tfnoUtWznDGq8P+GWuQKufuJT+iShdNtPDbk4WYlTtEPZdCHoMNQ09s
	gSxV2l3KdUEpeZJ5iCSZU51DBfRCnxKNNlfBtBoz0DIyE+pa00Fo6sre+Y3Dsj3OfV/9JO0IlGd
	e/ujOplvscLV4kP78hNUBnWEXy42fZbhnI4jad3DnPvme5apgb77DMX4vkQmi3NQRyOfvoj55yt
	V7ukYE7lOgDYZq2Kt
X-Google-Smtp-Source: AGHT+IEuvPyysxfwqgP8K0lRO+87nhqQOSJPuotnCTTuHS64rhVduFxKlZ8YpNHkHym/ieNCb1Nz5Q==
X-Received: by 2002:a17:907:1c25:b0:ad2:2146:3b89 with SMTP id a640c23a62f3a-adec5d2232amr230986166b.47.1749809755092;
        Fri, 13 Jun 2025 03:15:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 14/14] arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
Date: Fri, 13 Jun 2025 13:15:36 +0300
Message-ID: <20250613101537.279131-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19068

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 8cbf69bc74e1f365b0ef8caf5dd2ac994ce965e0 upstream.

Enable ADC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241206111337.726244-16-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 942f9a5fc543..3f050a28f2a7 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -84,6 +84,10 @@ x3_clk: x3-clock {
 	};
 };
 
+&adc {
+	status = "okay";
+};
+
 #if SW_CONFIG3 == SW_ON
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
-- 
2.43.0


