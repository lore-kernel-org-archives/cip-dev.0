Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89479C3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:35 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web11.10371.1746783333729263990
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MTRSl80T;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad21c5d9db2so117527866b.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783332; x=1747388132; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9g2hf2sbktVlMbhEjWOCWKLi+ZAFRelq76h2FfEJhQ=;
        b=MTRSl80TeEsdrlZPhf0Kx+TRqGMyzqd+LdZ/9zEmauwy9pLcrLs4g+8ovquu+/G6oY
         EXR/vWJWtNJ9zutcuczKLz+ADtfObDkViPIkT2ohb46zGaZfo6scUaHWBk8RUs1JsWJ8
         UXd8qdatu9DyP2yh8d40LMmbhrUEzB38Z9A5zftG5h0LbXcXYBzd8Z4tJQARmGqJ/vEG
         70h2lBLoWQV1nKqyFQjCi9DXmG9QjAS2/dB31gtHuj99kKQ3rz3uABz+doeTx2HCx0lk
         NedM636s0jBlzCoF2p4xqrYzrVkKrjhO6ny+OVDqQVlbCuQZ/QNdllIG2piWmL2yIrzX
         j6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783332; x=1747388132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9g2hf2sbktVlMbhEjWOCWKLi+ZAFRelq76h2FfEJhQ=;
        b=p1Svua9hGT3jIxPOOEQLQA3KleWSkLKuMlYPrmcAn0VgaxPl6LbZblKcrfxxlK9vjQ
         c6TPO1QcmNS5cncxuCAHoCnVrgKiQ8SlMiW6jfTn8iqOG2LX9qtTGyoyzibwoomm8sMs
         P9Aq9ZfGLYdhjeiK1EjrigNIqLnAZ9HJA6UFuVnjSJGXK+/pq10Oep+6/r7JV302Vfff
         TuTG8BxLh9Icu+5lQK0XMec6eyLTO0QGwKMWYpkydlLRZh4mAwMrdph7ua6d/RDmre7Q
         7pFzwIsfSKWnQgRgBm9XgaMQ+YWyQm2wYQV9s9BrBI+rmd4ntPtEctn96wD9TEe/Esem
         HObw==
X-Forwarded-Encrypted: i=1; AJvYcCX13SggrtyVbwx6ThFO44OnC/pi0epc0OnAhs0Q3dJpWDZ4Rcp9xwhK/IK4rpF08HnUFiLczyo8@lists.cip-project.org
X-Gm-Message-State: AOJu0YxSZs5aZxfkjFgKiLvoTdQP/qyQB/wik2ojOz7C2mdihDCl1RbE
	3yJtTUwJdzPipJKQTva/4/OA1HLTc0npjkyYNi+cePRItzvwI1OS3p70FHi5NTnsm6QyZMRzdmX
	c
X-Gm-Gg: ASbGnctVwWXeY3vWZIUGC/UFEMpMQGocys8WL6aOVsxszm98xWfkydUrbzB8mUugjGV
	/JflFY/ImVGVbAlrY7nPco55bIVBoTJp1TorDTd037DXBdzVSIx4nYCO0N4gBIkk5czidzbH1gq
	nV9/AbCnAAMgyTYODnmu0qOSLYGglQsFjjsiS8zBVxHxUNyEydYxy2pXz3ZiXTloamSNLWT5kxM
	juCE9n7Ei+rxgppHrCQmJxZKFRoogJ5W857wzon8BOFlrH8HnlFDW9BXNVKRDinYPC9S7kwb/Wq
	l0KTPr+d21gAqvbxFoDVSNi09uwYVGd7oD9ppz9Lab0EdQ143fd7gA09qmRd3fZ+t0HPLg==
X-Google-Smtp-Source: AGHT+IGrZPNMZKrb7vd+1yQR6dXw30ekhnTHhYv/R5nEYWHFzFh9344xm/q8CZCIe8YQhS7H+//0FA==
X-Received: by 2002:a17:907:3445:b0:ace:c50a:f87 with SMTP id a640c23a62f3a-ad2192a8811mr186579866b.46.1746783332068;
        Fri, 09 May 2025 02:35:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:31 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 33/37] arm64: dts: renesas: r9a08g045: Add SSI nodes
Date: Fri,  9 May 2025 12:34:38 +0300
Message-ID: <20250509093442.4015145-34-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18885

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 880f6c84701cb7735d19f20db89e757086a8fcfa upstream.

Add DT nodes for the SSI IPs available on the Renesas RZ/G3S SoC. Along
with it external audio clocks were added. Board device tree could use it
and update the frequencies.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241210170953.2936724-21-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 496394ca141c..7913820d88e7 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -14,6 +14,20 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	audio_clk1: audio1-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by boards that provide it. */
+		clock-frequency = <0>;
+	};
+
+	audio_clk2: audio2-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by boards that provide it. */
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -187,6 +201,86 @@ i2c3: i2c@10090c00 {
 			status = "disabled";
 		};
 
+		ssi0: ssi@100a8000 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8000 0 0x400>;
+			interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 242 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI0_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI0_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI0_RST_M2_REG>;
+			dmas = <&dmac 0x2665>, <&dmac 0x2666>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi1: ssi@100a8400 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8400 0 0x400>;
+			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 244 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 245 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI1_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI1_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI1_RST_M2_REG>;
+			dmas = <&dmac 0x2669>, <&dmac 0x266a>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi2: ssi@100a8800 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8800 0 0x400>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 248 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI2_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI2_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI2_RST_M2_REG>;
+			dmas = <&dmac 0x266d>, <&dmac 0x266e>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi3: ssi@100a8c00 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8c00 0 0x400>;
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 251 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI3_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI3_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI3_RST_M2_REG>;
+			dmas = <&dmac 0x2671>, <&dmac 0x2672>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a08g045-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.43.0


