Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DCEC0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:31 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.7438.1737709230540899769
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rfEhgX+V;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso12146365e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709229; x=1738314029; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT9gIUiudDAAdT7+/KwLCRVApT8O0rjggfgBvSy6a4o=;
        b=rfEhgX+VyfpzLDA2x6uZ7/4PpCo51+tQ7qWcYDCBUifRPVCmm5OImHWx+zciAe2t0y
         L+4YQ2LDNQ9dsVy1A/0JktG8GssLMSJG+MDogSX6BhQz4Uj1tAcf4ga/n9SpGqa2yUYV
         k/fa88qWFqfcAq5UFcrITAIkwN3mv3IU1lLshGuGxDdhPKT4xL6lu6p3y2dAu+0N0tqX
         YN8UN9Vo9zEpH98sTGT0nf6Sl3e00nE2UogrSV30YDwDXKbRFFdIJJr3ljJQI/Tl16fM
         jHAeHzthA7td4w3LZSvO8Y5w91ybHQfG5D/63dAGmfFO3xHqA5aPqsmMTE1vw1nge75U
         jc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709229; x=1738314029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT9gIUiudDAAdT7+/KwLCRVApT8O0rjggfgBvSy6a4o=;
        b=v8yUlKzPc7HK0OgR/155ftEAVDdQbl0vW+6VcB5ih1fdT2A9P8x+2NRjMAOSnqRX0R
         oZ/s4RRmaLJV8+vtBLniP+dImLDh4rGLKC7nNYqjncYiBetDqVGd85UpMCLwtYi0dshM
         U4dsQiGna4+GjqzY8EL7Yx1d/tMbkyqPb5h3d+IsJxcDPMOwj0vRKuWKhhaV8EKp2lhE
         orkYZD24qive60Nhp5PE431Pjhyfn2fVsdsOh3vcYp2lspnFFo8wY06jwoj/dbhgYvtn
         trMQ9yJ9hOds0bkKtdXMlw9XUrgFxHvN56pPHQQdgR6OeS0p2os+0ocPV28XVQR447d2
         V9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU4qhJNr2v442YF1kojG3mCp4+33uCW1P3YHc1xBQ2d1pdexvSlBZRJmzyqs0aUHejU4DnSzDWK@lists.cip-project.org
X-Gm-Message-State: AOJu0YyLuCC7TYC6VdwScQf1xcTrESfSUJEO+Na/t7YUTUH1GTy8s+yD
	Hk/R3hHRPeO13woB0W2pa6TIkKsnzRzWqUlMi9xflODChTyM74GzCVUlKl0UtTo=
X-Gm-Gg: ASbGncuhG0eabN29Bk5NXEZ3L7Vgt3eDZDGz/GhhkpSWhFHNMTRSkB3Dx2wgOTo+FzF
	w1GeSHx2hrpUw5Km/EBPgEc+cbmxxaRQ+xa7Iw7LCrixsV8hNgomj+vFOxObVrmkFrRa3neiTE/
	UTo4LUe3OJ5OmYnq8PPD+wkVxq45QeiU8gv/UQy7rQYu1jL49UQ9m3RE9Ev87+8CD80SE3gv7NR
	Jiyz0Zeww4HvN0CkNed7A5w/VcOhhZMij4WO1FOmcWIedDEXA5TefthFDLw9eZLENG/RhN2OOtD
	3f/+x9Q7vYmb8ajxuPJ0of16mhRJvhQuCw==
X-Google-Smtp-Source: AGHT+IEvIRBMVcLeWm30GPCjET410L/nZBg0LznQIElnf5j+QBEgZHAiUbRjb4pZmap6GyyYtk6puQ==
X-Received: by 2002:a05:600c:3149:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4389144e70fmr279274955e9.29.1737709228969;
        Fri, 24 Jan 2025 01:00:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:28 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 12/14] arm64: dts: renesas: r9a08g045: Add RTC node
Date: Fri, 24 Jan 2025 11:00:03 +0200
Message-ID: <20250124090008.1401077-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17634

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2d768aee9f5294d2023e824c0906e2e7d1414629 upstream.

Add the DT node for the RTC IP available on the Renesas RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


