Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D61C02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:50 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.41877.1737546703274535699
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Mx2GKKLd;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso47041005e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546702; x=1738151502; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZ/lXKoSkUmuSxtM2ry8mqYHW2bCm5mIiSIX1gifECs=;
        b=Mx2GKKLd4V7V2Hzg33KbUVNFhgK4hSU8WlrV3OFKuI8fb4O9H8TDUBJIAMcoCAbp+e
         9KmJtdmqyAajDLriHcO8n6+k5vVDJ+dvlLEDdgrIvpXWHBdE/uLGn7oQkiuQSjoaN0vU
         PIpbYJHffY9iKZCcVrymW0wLZkR1nRpLHLA0Bva+llJ1oqhn/PyYRqr7+12PdPPv8T5e
         cUOMOdy4A8bgYCj4/tv7YMtUPP9rE2lggJXkrZqhYdtiXOXHjXF/5SYNclj4IHizFdee
         1QMAfIughF/1VdYFccH/SBO9rVeTD3AIsuSAP5AYLOTmJwT21Rp7EEGqQRBgkjyzeAXN
         Gucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546702; x=1738151502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZ/lXKoSkUmuSxtM2ry8mqYHW2bCm5mIiSIX1gifECs=;
        b=pvqsfmwDCN9CMp0i3pfhIuqJRQxxYw2Num6VQGw9+dtKq7HmBGjgc5edKb055onfKD
         GpxRajoVk1yBRJyxFgZ9kB+zJbdiP6vXjIedwUaO1/WOnGOw8Ur5ZUc209ELarAu7hGA
         3JZILL+AxpI3xKLjkELS4A/xPRdXfqWXxVISr/Csqlj/g2AOVf5RWk9zHsdHRx+PhPXO
         XkwGN6YcaemJyGp5qh6GcIhVt9xnd9k8xtVmT7xh2T2+ps342DK0UuISayv5pZMuaeKm
         gUTS/O3VYvByfNi5+tsvSoAg//q+RtFh10KbdBVOIfi+8r4VC5fQKcw5MVLX2yYCHhvG
         USgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOnDaHHwbcaANJn2gsFKMiBFCH/derz1t3JVpKnYmAWft1tpWRi0dBQ3kvpR823Fx6Y/fb2Zkz@lists.cip-project.org
X-Gm-Message-State: AOJu0YyRFBaZFV7sjQZLkiX4aLqFpUveGCIxDQ2y9TtMOuqDPmmkQMfl
	lkCSZI6JRgmEzkzrxEqU0bYwaNksG+L6DDnYkKpw9L2lU8H/5P8W7h+xjZ7Ll6U=
X-Gm-Gg: ASbGncuE4B+X6Kcjw+8hf2WxPHjXSyP+iuB1c5+zJ73rnGoiJ0lzF0tqDkRvoPiwLjH
	Lqu+8ICEXgqf+8u73rP4YOST+ulBUBRdg82+p6+Qwu/x4yVuTdH1gbA3qJ1IyfAqMsv6TGPuPVg
	SRGta6gc8zTcLPjm8IulC4f2yXjDZ64ly4LDeA9JBQWiuLEox/ehy0DKTMmPWCvmqTlB2af/txd
	wvPTazhrrURZ58Ueopt93CgUQTV5tY99PiR39HiQYF+CEsPYePUkAZMPlX/d9SqT+38lHwKeksD
	j3YKperhv0yNFAxmE9qZXmU=
X-Google-Smtp-Source: AGHT+IG3GsErIsa5IWdS5f1dEWJKtwesHaKt6Z4qLG9rKLhY4IOjqECdq74LckbMtM3VNK+pkq/rcQ==
X-Received: by 2002:a05:600c:138f:b0:436:ed50:4f8a with SMTP id 5b1f17b1804b1-438913caeb9mr224241905e9.10.1737546701712;
        Wed, 22 Jan 2025 03:51:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 13/14] arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
Date: Wed, 22 Jan 2025 13:51:18 +0200
Message-ID: <20250122115120.2885015-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17576

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0cd647cd53db0315361e41056e10739a5ee1e668 upstream.

Enable RTC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-9-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


