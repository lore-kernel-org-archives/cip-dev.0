Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFE3C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:14 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.10387.1746783246066551728
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P6scMXud;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fc5bc05f99so3293512a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783244; x=1747388044; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5y4RI12F4lET5LGQ0arDPvjMrZ3fCaoDAgEuoFEitU=;
        b=P6scMXudv27t2X31Dh80mNfR/PujAcPC/OORdV1SKOV2QU+h6RVkd85Wb7X94Hb4pB
         UWOvak6+Gw9msW03btPPPDjK8ND8GSIiOD83hsPAFgUpxVgoCFlyQXkBb6cVuBQ8gtSP
         Yqdn+knOROgKAf13kd8PoIoh7NHt2MIBMHFTDKsU2WYmrYZY/6jQTWRelkcFPLFVuBRc
         cJxmbK4Ie4Ux4nGN1zyPbRD9vf99uPKJLrz9fCSA0CjphWLyEpcppAFkRcRp9YW5AD7R
         5MbQi9mdVQH0mjjpCmBuhiaEi5T7bzz5c1Q7Zb/aA5tAtqViIOUoI+mjigfQ47dtahXa
         JGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783244; x=1747388044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5y4RI12F4lET5LGQ0arDPvjMrZ3fCaoDAgEuoFEitU=;
        b=U4p1g8mxQvYzseDZlErweyiR7Opoy8Dl4YZ2v4pI0+fRC7G6lJrN2LFKt+tOgu65zl
         4UQ9eJrWNDAAQG+AeXqRmVjfoL2xAmbiqYj0S+gzLrAaOvXejgW5c0gX16BGGwrlf+86
         ZY7e5D4zdZ0ijFe+zyLOYXUP4ftaDuqiB7XKLyp/Bod8A7XXBp33wL5O8ZpgOdjKdSJy
         ZyOhzDn1ROPcmYW9zwXOvaos71m8p9UQVpYtUNfa+iugSmLX4JPUfeYs5hVEQjOaQeew
         RWEQcZLJQ1AkAP/44p4GngHJ8lz1KoxKj9zNEYcSN/Z95jsBCLdc9IiNF0jK6nWf4b84
         12Qw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4MFQ3rPjdJiIK2t1kFWJM6LE0pzFNlOHmH0Bni+FYZRuC2j87InSpZtshGYzKl3WXHugElL/@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxpg/GJvwAgO7mnYzVu38TcrvhmGk/UVra9V2O1WP2jK4i82ESm
	SpReLzNzTWt5wRIJufHdWhwNUY01c+Fw5SpOV8oO3m5sWq/CeTzTBsN8ChVA4Rw=
X-Gm-Gg: ASbGncslJwxZ4iWr6GbGDPWrlBMlnxL8cqfzPOhC5gyZsgI9RQCbZkyi10ezz8pVrbs
	arD+IDjrgqab+cvjv85MmpYiQpTLPOLvOmuWnGVnZQrsfgSbi4ZWbumD7cdM9gjMbIB+NRdyiEq
	z6Mj86UlVPRRn8jePpj4XXV4VoBd/cVGMai6gIwIlfrYCrmy89VW9K6GUQkCF4Edqbm9150xDWf
	0QtaVJ7+v57ONOld1ZFSDp/6ZAu+EN/qV+xG02iyxhSoFB6BZNw0GqhLZlQaIVCUVNDe6wTT0lV
	q7ziei8IbV1PEBEJdNCNAEkeQK/ie7QOpJozOp0ewe1ATgrxDJ+miRv5ieptwQHd5Vg6hbUKEID
	P/sk3
X-Google-Smtp-Source: AGHT+IGqwtnN2JXqAYxmrtNgvip55ZcIPl/Pv3SogywRkBmrbbhwj93g0HptR968EKpE9wtX/mlpUA==
X-Received: by 2002:a05:6402:1e88:b0:5fc:4121:e8c3 with SMTP id 4fb4d7f45d1cf-5fca073137amr2112984a12.4.1746783244383;
        Fri, 09 May 2025 02:34:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 30/34] arm64: dts: renesas: r9a08g045: Add SSI nodes
Date: Fri,  9 May 2025 12:33:14 +0300
Message-ID: <20250509093318.4014916-31-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18847

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
index a1240d9d5455..c317c23adc50 100644
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


