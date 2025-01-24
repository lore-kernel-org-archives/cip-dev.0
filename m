Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E51C0218E
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:11 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.7454.1737709265048820694
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:01:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JylTvlsk;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaeec07b705so365364766b.2
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709263; x=1738314063; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpGb7kiQv4TjwfE0PIXkbdbDly9aR6lFb2N3C6Ml7lo=;
        b=JylTvlskRNPKVi7+jZUDJgMWDOPPDKQHCRRmLuAMffkBZj/nh9KeXP4zz8Q3ZtMqiR
         MPkP11YRHqoGfcA49kFTDQf7wKEa2RuYtLwFYsRfBT6Ouc3S/1tl+lYcjM7n+VrZP1LF
         F11QMw66AL2PZvhviM9zpIwPqMWHIYi0nFeSmdJmyyu8XsXDhM1fpRNZO8a7W20vjGr9
         vLenLf5O2U+cQe04TsBiQVQ0a4FiaK/3Cji4qt/d2Eh7QGY/AL2p1fnJAD6lnSa4pcN3
         tq3cEYBLuTdmEWvBXvFzEJHc4+q8UhNR0P+HjHz+LMG2vuvzmvSMreMBzjPzXY9/G29z
         /yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709263; x=1738314063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpGb7kiQv4TjwfE0PIXkbdbDly9aR6lFb2N3C6Ml7lo=;
        b=nRbv+Zs4ap/88VHwD3Iky4HsaETTrs5rsp/SiSZsTWU/+U+v5NPO8t8bMcSyBM9WFg
         D/xt92ZYB8oxYDMNANetZs7Noc7fxHmbGSjo46pP4TsEFpfDmMylSmLo0ViC4GWd034H
         1SXVjUsW2Ks4G10ouJIFMZ0MbbHiRvnFNNGAZEV0MZive845KKxcESbXU90cM7IQAQIE
         mf+UjFiFrCahPYsiufKLJlHIOO62hEqSQcgTchtHxe6DugskyZMhWZnXuaonEYC26gRc
         RRmtJD/LiGuR1QLy4HhVWagRXnaFJNVGD4aLClpXpV5PJ9MhAHE1XELEPeIT4X7sitIR
         Cdsg==
X-Forwarded-Encrypted: i=1; AJvYcCVi9g4XV4utSGzPERIDdGyZF2BscAkehJ6+KK3xJSM3LYUi0Pavjmyh+wMF9E8CJmvYOaJDgTn5@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw/UQOvtrbL6f0aurfG2Gic/O5wwe0wTGr8qVOhX096LPAWlRG+
	XXXgYSi66x0ALcUNL3tv2FUFG+yuBW0tkREdHqjqmkEAfWpXOXZx+LZ4qGYjkXc=
X-Gm-Gg: ASbGncspKc6T2vm4nUfxCYcIRSHgMl3bX9u15SFnbfHW1B5CjnucWbdHS+rS21Fa2LZ
	fnuMmAu3vV2VGC30LPK2uwbwTOXBw3dG4dEfGhxwJd8BEbYzLhX+4UU5N6+eOHWrhJzVan/6QcA
	vNUbd0BLnZDC9QAOtm4LxIF1VIrwQxvNSyNiAS3VvpVaw/X/vMQmcrPUgZUZ+ZDD6ZDCGlLqE21
	W7ZTOBfS6yjuIXIgl/CixjnZPwubMGe4rz+DrrzEohWTFHzLhj/EAsu5gl6CGIQxbzTE+VLkgjy
	W4zxQp0+VbWDav2Vn/2T5SdVReLnAyeWAQ==
X-Google-Smtp-Source: AGHT+IGAvW+vjymxnSM9TwyLuqNr+iIO8acr2Zo7ljuUPAntSYDlwcNl1BtviaENWwqeULPiOju+sQ==
X-Received: by 2002:a17:907:c1c:b0:ab6:726b:580 with SMTP id a640c23a62f3a-ab6726b05f6mr297691366b.8.1737709263455;
        Fri, 24 Jan 2025 01:01:03 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:01:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 14/16] arm64: dts: renesas: r9a08g045: Add RTC node
Date: Fri, 24 Jan 2025 11:00:39 +0200
Message-ID: <20250124090041.1401132-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:01:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17651

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2d768aee9f5294d2023e824c0906e2e7d1414629 upstream.

Add the DT node for the RTC IP available on the Renesas RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 7bc8969a7b5a..3401c1200a1c 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/r9a08g045-cpg.h>
+#include <dt-bindings/clock/renesas,r9a08g045-vbattb.h>
 
 / {
 	compatible = "renesas,r9a08g045";
@@ -72,6 +73,20 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		rtc: rtc@1004ec00 {
+			compatible = "renesas,r9a08g045-rtca3", "renesas,rz-rtca3";
+			reg = <0 0x1004ec00 0 0x400>;
+			interrupts = <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "alarm", "period", "carry";
+			clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb VBATTB_VBATTCLK>;
+			clock-names = "bus", "counter";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_VBAT_BRESETN>;
+			status = "disabled";
+		};
+
 		vbattb: clock-controller@1005c000 {
 			compatible = "renesas,r9a08g045-vbattb";
 			reg = <0 0x1005c000 0 0x1000>;
-- 
2.43.0


