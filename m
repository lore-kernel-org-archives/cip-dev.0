Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BC3C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:53 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.10341.1746783164061761932
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=M3pdlZ0U;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so3441245a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783162; x=1747387962; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foDCC5P7PMLoQO+0Aake/psx359VR0P/mIHnUpjK+Cc=;
        b=M3pdlZ0Uh93lqIGwxNeO093WteDPErQBNS++TVUzO1gtBkxdnCi4ACXNPR6zDqRqkM
         TqnHOtm5Gwty8ZmMjUMGNR6T/1RXEjhHjjOrk2AXswaa0suK2218pAQ9RR2HXlhUDOYD
         ikMRN0HA4bnSaxJ2dwtGi26J2yhPYFo7YzMivHSDFONeMusIDqERilJ9FreTr7sLICpU
         x8u4mUpcXBJYAD06gvHmlxf17mdVsC/D/UJAr9Y4VFXTDkVZ8NmDvqdPxbXhvgwnh02s
         1g0+QU7uEas43P+LTLRdJqcpolsej5n2xN/6SHrJaXLIz84qCTvAE+POnyb49ENnYXhM
         RNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783162; x=1747387962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foDCC5P7PMLoQO+0Aake/psx359VR0P/mIHnUpjK+Cc=;
        b=jD7nUBvYKrJrtbbvQjO/6dqv779M904NSWFLldUlNutHrmPk6c53Gr8xiWp6RjzN7c
         rKYgYRXSoA1I4AjrM3b2vb1bdwDBYpMITc98niZZis5BxVi8mhxLypzh1N2lu67KZ8e3
         YiAxneoBJPUYpxqDArF+HYdawpiCTT++uKYSohccXIpTqzwN0i9ftQtfwMjtbyL9LHas
         meJ34Zou1t3Tcw2O30kcMogjCI9zQWkhAokF1lXpp/VHYkXcwejxHTLLa0lDW49WRGtD
         2XQG83yhK307izBQmb5Er7T0SkZ5OiN0gX3AVECsHOkTENfZi3lj6Ar8yxysGmxArWND
         t5/w==
X-Forwarded-Encrypted: i=1; AJvYcCUfH5QFfRqZ7kVTCrVSwNcIH8MPPUTV8sflfwV96kx601jY5igh9f/YdfV15eIthJm+M1wzwJ78@lists.cip-project.org
X-Gm-Message-State: AOJu0YzwRoRTNn+UXTeTFEmdM+Y5HBY10CVrd4v0DJURUieX7//SXpXG
	kRA1tf9J/ZJFSpcyLgZbt//zvzHr7PFHrgQ1SKFDprV6Ial6pXbj8aVAt32YJbvBZWNBV4v3n/m
	o
X-Gm-Gg: ASbGncteoaoC2kyjOEcBrkdujWUkyGTS32UMtYyZU200CAFcrkryvTkaRffroiyHgnv
	k8DEsYoM4QTl0bvCOXjCDl/Yb+4p7Fbga7Q9CRG5zh2sXnc8cQWqz5XkI1JQAaHJcf6FUPkwm+L
	Hbf6jmwAgAjmWum4QDyIVveur5MOHbg5NR37ztSgp75xuCelp3Y7yw0dgMYeiIYSrQuNHQlO0XO
	O59S9XjGRSe7tgTHTMB2ey5L2Ab1pZGMP6Kxg636SYXzXFOGL7I6v/667HDO8Urx5stlX6asJr6
	S3zMBHcUkcrov2qQZRuX0ntKaRBA9c7eyFov3XxvQajmQbh2crTx2++HxFPHfAneS+6g4Q==
X-Google-Smtp-Source: AGHT+IGe7z2fij/kyFTS1Jqz34Un+LXGwmGNNDilz7VWfKC9S/jGUMpCYypoYk/dAxQUtgJAgkTxEA==
X-Received: by 2002:a05:6402:90a:b0:5fb:d4a5:a3c2 with SMTP id 4fb4d7f45d1cf-5fca0759839mr2008609a12.10.1746783162458;
        Fri, 09 May 2025 02:32:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 25/29] arm64: dts: renesas: r9a08g045: Add SSI nodes
Date: Fri,  9 May 2025 12:31:59 +0300
Message-ID: <20250509093203.4014750-26-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18812

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
index be8a0a768c65..0e06a4b96c64 100644
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


