Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EE8C0218D
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:53:00 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.41717.1737546771791624648
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hI3RV+t0;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43621d27adeso46603165e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546770; x=1738151570; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT9gIUiudDAAdT7+/KwLCRVApT8O0rjggfgBvSy6a4o=;
        b=hI3RV+t0nGPa4NwnZKWSgOlPLA5f0RltzXKGzySgJmYJChEYddf07S3Hr/AOo8TKc6
         v4I2XvrBf3g7+9jvNMtu8EbeLAKtqHG4Kp1LhsZgJFAQNdCyAUwYAzl8DeP7IXIMxHJI
         uPXplcoM4HvteCYAnUOWHl1+3bnJFTb8XhdkSRyclP5zs6PhpYmUsaCYbqH3EaEGi4ay
         L2FeESdq6Y6iQIFFttnHklBN4f1/8dx3iWd02OlOhe+evA0Ns/uWAGKV2gx6JNR/CIQh
         cVSdtTgJM0r8uqg0GeLZAizDGfUUic16/AbLFKSzXWu7LJN7TCkToRuydEAYDARzu4jB
         V79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546770; x=1738151570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT9gIUiudDAAdT7+/KwLCRVApT8O0rjggfgBvSy6a4o=;
        b=jTfxUMXPeYwlcogAaqY8/J/a8+NP0CZFfH59KgS1l2pXXcyPaDAyAMHUpFcE+Qz/Gw
         nee1osNXEIR+kfDiGvb2yXd5puwjr6aXMuxvU5XEhthOxN891axvSAvZZIflf9HyUvRR
         bX0XS5nvgvxvPKn+9cLqcr/Nm180+IJ6VVaO4SbnlJUdVqPLipAqttG5KkT3pHhYfNPX
         q+pvQiVRTJarJHsScM+YTW+16tZmtIGUyq8f7Qvk7zmQKh1mJsBTkIm4r81Rjcoh4AMW
         aKgKbL3n/oampbHH71RlqIbLnljfluxK2AnWDii2Km6R1e6C6lQkunhqRFIxMPvdStnq
         W8yA==
X-Forwarded-Encrypted: i=1; AJvYcCUEgcnvZF9Vaavp/32kvXNctcXR67onvo4UxYWKdaEG1VGphF7/Hfr0bnfjRClCqxoov2iHIwlv@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy95SwkADZ1o7tC1zhXwpHm3/BvSIJQIZP+vaeIEqAUZOqFX3Wu
	tZyYg3j34auX1JVufW3nkq9Ee0NLBOZ9m27LV31D+6h1pe1VZDJAwTb9cSn2kYVRr5WAAVzmDDX
	k
X-Gm-Gg: ASbGnctWzJDqU7vbKjFxDJ3X2sfrc5cFDJ7ExWJ//+TZbcg4YR2eBr2sIvSVhwxA1Ma
	B1zqn3Lj8Z8spmPV7dV/EAbns4KpQFRqifijYsICfH5OLn+lQ12+RKdQdcU9jSsHflio7PkpFUg
	gFBzk3HMKJ34wjqkCsZ1mlAahjAyghNyrAO9/+QmhWlFyCOo1waBPGz7leLXQlW7lWUuQCC29dP
	ISd+2EGKH/HxrCTr/SWveLMCjUl23hINqIWB1VRWmQ+NVGeljcHgRztmvS383tglnV/7gJQTP0z
	Ap9XUxV9qgoRJS1VURvELAQ=
X-Google-Smtp-Source: AGHT+IFR+U5oP4L1kFyCNZhfsDHBTpYE5eY7ZYsP/zGjFqnEiQZBxHoB3gNmyxc6iVbN+p5L+k1OXA==
X-Received: by 2002:a05:600c:450d:b0:436:840b:261c with SMTP id 5b1f17b1804b1-438914340afmr177955635e9.19.1737546770228;
        Wed, 22 Jan 2025 03:52:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:49 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 14/16] arm64: dts: renesas: r9a08g045: Add RTC node
Date: Wed, 22 Jan 2025 13:52:28 +0200
Message-ID: <20250122115230.2885344-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:53:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17592

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


