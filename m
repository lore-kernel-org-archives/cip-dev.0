Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBF6C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:11 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web10.7458.1737709266520475636
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:01:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=IlRvjxEV;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab633d9582aso332243266b.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709265; x=1738314065; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/YNikkkxhG5IDAJLIfsvzBE/9wz3dlXvplx+eyQvZg=;
        b=IlRvjxEVZotnU7rYe3BUXO55w4CRFoFbKHY70mYIY7IClb3XgcY7/YEFagaMiYxpbW
         xUDF02ubnAvVlUA+9WvNTXpBq22vQcPBh1oEVSYkNVOXOcsm8HnqrRJo7339Y4wkIH1S
         YEZ8EVlmlLiCG6jcEAHfQ1FNYm2ATvqqz7dKZTcWVN9eVVJDWc+tG0z7yO601VcdsdQ0
         AYQQ0pEDlXw2CMUe0476AItY2WqUf1sFzAJLDdL41003BaRgEHibofxwDi7FVYJgifHg
         u0mqKnnHhyuTW0a7NqDcYTmanwaLhCQMJ5z4sDf3vA9SNhDJcgUkXWGBtAoGO6tw9Fp6
         iNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709265; x=1738314065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/YNikkkxhG5IDAJLIfsvzBE/9wz3dlXvplx+eyQvZg=;
        b=u3ISTphFhegsPKUgq4j9L+0krWNuQ/iyppd4PGQUIiNzNJ48C7vC7DwY2HPUVvoF07
         3zM5wOWkx37U49V890SPWlgKw9E+M5cgyApljOtXDOnHTG9RGU+o3waEJVPkUD/xQ7kZ
         hGChEkOiH1yD1GNm2Q8kFcp1dJrYDZ357BQk5o1dgvNCIsDXy1duqXfgk1bhtLoWAAV/
         o+qkgrVp+3cu55STK752bT290VlsXjr75f3Uq48y49mamEZpt+KCf1qMdb04vEfrK1C3
         V/Usk/3GfR2BFzddAlWfztwiDlom4VaAknsxuRiO/0B6Is56+HSQqhsaEcIwq3vj4DN6
         Odlw==
X-Forwarded-Encrypted: i=1; AJvYcCUMND3DkipPUvZtRw2icS+LKrU0HfVkMh9Zwl1YRq4KopWmiUmd7b/CdLQbaOaFJ+LrPRbKFvq9@lists.cip-project.org
X-Gm-Message-State: AOJu0YxZHd+ZcewhhHZ0K5sBI5SrNuSaBEpi8p1PM469TSBXVNI6tH0e
	I3cU4J6tJssVQ+KFCmuiE75CbJkdhjK22L7s/h35kBHPCgcBqc9JdRm3LhNzgOw=
X-Gm-Gg: ASbGncsCLemQ7dgQ1gsfxs4F3862UFIFk6OYthqaeaidVuUe3PHZ6+mJ8x/3YW++GA4
	MsgSOp1Dnlyij4ZToE+7mQQdCX/0xmgBPXwklZeDV0N9gzhuZE3r6vJNVUMRHXQdEayqqRvgclK
	vOEwMnwo+N6C1ncVTNW+a8JCNTw0SORd5C5FfFMBsAazZ+/ptZ9viLxjYGsaTAMBRhayVzc0Qmj
	QzQIrLaZlHaWf/uVIiUga7dFe5mfVD4fAkuKEbnlX/TbmTwaxu+jmQyBizrpksYfyrExcYsCj7p
	UlaScmPh29uafLbouKlow3iZmOyMXqPb9w==
X-Google-Smtp-Source: AGHT+IHn25fbCHRiCesnjDjzGD8EYp7MEaNjSu6RkbnzXbFaVJ8gD8N5WdWrz4jsDn1RwLj095mYIQ==
X-Received: by 2002:a17:906:1e4a:b0:ab6:4faa:bc82 with SMTP id a640c23a62f3a-ab64faabd04mr803071566b.25.1737709264560;
        Fri, 24 Jan 2025 01:01:04 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:01:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 15/16] arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
Date: Fri, 24 Jan 2025 11:00:40 +0200
Message-ID: <20250124090041.1401132-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:01:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17652

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0cd647cd53db0315361e41056e10739a5ee1e668 upstream.

Enable RTC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-9-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 67178d8c4108..b07d9251d182 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -342,6 +342,10 @@ mux {
 	};
 };
 
+&rtc {
+	status = "okay";
+};
+
 &vbattb {
 	assigned-clocks = <&vbattb VBATTB_MUX>;
 	assigned-clock-parents = <&vbattb VBATTB_XC>;
-- 
2.43.0


