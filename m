Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B59C3ABAD
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:37 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web11.20362.1745934512631516964
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:48:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TtCZGOhi;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acacb8743a7so1029128366b.1
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934511; x=1746539311; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPx+3sBkvagC5Q7d+iZ1y7YgfI6zVB65uRKyq7aeqYk=;
        b=TtCZGOhi7KZp2dp17s1YqBdz4gk84DyphiD9p6xfq6J+H8dL2MmJ5cS2fsmNY7kQtr
         8/IIuOw5vWLCasaQ7MWjQ6PaMAVmpIp+0fWMz87cFT/egBINUr79n1vWkMVwfPJHpmYz
         KIePgepZDmJ1mZs7YSXwfYbtrUnFLkHZLcjixm1WlFBRS0q1lIt7riwe7qL7IhpG7uIX
         Fo4MB3PMAGy/ymUd2Be27xizlSelVpGWEFtWMYhZQiQWf+eAjF8Sk82AALPKQH953JXF
         0hdJj1jdkYHh3V/smawzZ43tF6ObWni3kdNF+8k5uYJv6cZ3vZXVpgCKpDidmkO3xtIB
         oGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934511; x=1746539311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPx+3sBkvagC5Q7d+iZ1y7YgfI6zVB65uRKyq7aeqYk=;
        b=UvMdttDfmbqi2BL/9FtplgAnDJHrI6kbg1BODvwdJ3AWEyQEJVTbOVtcgXhjQVgFEw
         xn0ucNHhsh9/hjAZ+X3d4nPKu6vjX5WBWGk7hjoPvJ+t0Gaymo2Gw7au2snvNAhB3sxP
         jeiH+vEmjomII19amMzt2R3VB1t9kJAy1nI6fWqTBH8hy1jXlX2mT3zUHLjQRnm+qKoy
         ThejqCQEY4vGSZ1JVTCRfBdiTVJX3qxN8rRuTSkaJjSRIGdeJe248M2GnPlB3l3wsC2H
         yQEBDmzPdpFex1s80jbciwNLPnziF+eZPtpvPvueJcKYoslQCjK3v3IsYC1cXUfwYgq4
         Fv4w==
X-Forwarded-Encrypted: i=1; AJvYcCUuEAdZx0+9porVO3U1OrTPHKPQMJWP2amL+Tl7uW8lSP02mqLbS3AAiZRK5RxqaLUZuRKcpBNX@lists.cip-project.org
X-Gm-Message-State: AOJu0YwWthX9sEMNFdsy7lYkDi2unfQShsIt9EH9sMn+at4P8qzwMxZW
	YhGfP9yEqNDYT9SRDQdHFJw/E1DczEIyRNHxkV6RySt/50NWtGXTa0XneZLIKNA=
X-Gm-Gg: ASbGnctpBDhJ03tg+bc/Bn1pEG1J/qednpCFFy/AYNOR2TQ0eRXdaGX54ZYN54g554E
	AEE8ZeaG3AUu1W2T7akbx/ngN98L28eB0+fxi7wH9kpIO2zVV3KgJw2tzXJxmztkmTw5SO6Lg79
	4BqEgvDRRTbRWrV7eUDv0ejyDZPhWk6ZpCPJWtM8HnwNySA84CcmToXk+lbjwg1aAO0DeE1g51i
	gEXVQt3dQyjsOMkVI9RTVSd7+2Ig9WbntsjCmoojJEK6VB1Em3T73Ve7TbH9o9otxM5SsrBgd5W
	sPkg7QTkycaHS9K55K2rf+IU7tRn6ay1CQg5OdBZAhoEidOpsZE8PZDGnvu0QtxmoA6vNpU=
X-Google-Smtp-Source: AGHT+IGsvjudKxm6LzOFlmCTQPE4Khht2cgM9GDEPZsluaqPHaO23q2fdcS1Px+wteLyAU+Ln50cvw==
X-Received: by 2002:a17:907:3fa5:b0:acb:37ae:619c with SMTP id a640c23a62f3a-acec6a76958mr342229766b.15.1745934511015;
        Tue, 29 Apr 2025 06:48:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c898sm780033466b.7.2025.04.29.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:48:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 2/4] arm64: dts: renesas: r9a08g045: Add I2C nodes
Date: Tue, 29 Apr 2025 16:48:24 +0300
Message-ID: <20250429134826.2429916-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18737

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a502d6e7840367929e9a4cecc83448f0b52d3276 upstream.

The Renesas RZ/G3S SoC has 4 I2C channels. Add DT nodes for them.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240820101918.2384635-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict b/w vbattb, rtc nodes and i2c nodes; all
 nodes were kept]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 4df26337778e..a1240d9d5455 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -99,6 +99,94 @@ vbattb: clock-controller@1005c000 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@10090000 {
+			compatible = "renesas,riic-r9a08g045", "renesas,riic-r9a09g057";
+			reg = <0 0x10090000 0 0x400>;
+			interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 263 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G045_I2C0_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G045_I2C0_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@10090400 {
+			compatible = "renesas,riic-r9a08g045", "renesas,riic-r9a09g057";
+			reg = <0 0x10090400 0 0x400>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 272 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G045_I2C1_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G045_I2C1_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@10090800 {
+			compatible = "renesas,riic-r9a08g045", "renesas,riic-r9a09g057";
+			reg = <0 0x10090800 0 0x400>;
+			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 279 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 280 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G045_I2C2_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G045_I2C2_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@10090c00 {
+			compatible = "renesas,riic-r9a08g045", "renesas,riic-r9a09g057";
+			reg = <0 0x10090c00 0 0x400>;
+			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 287 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 288 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G045_I2C3_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G045_I2C3_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a08g045-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.43.0


