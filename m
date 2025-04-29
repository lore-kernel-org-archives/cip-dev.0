Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B820C3ABAD
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:07 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.20350.1745934484190544538
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:48:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=FyWDTPKM;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1019280066b.3
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934482; x=1746539282; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwmhCT1O7Lt9CDkv/1B+o9vVSM9Ezs6Z5CMkWzIs6hk=;
        b=FyWDTPKMQiPtTzYiKKaWdnFf+3bOERnrI/0hgBlIA/5j/31d2WVnED1JesQbriW9B8
         XMSkcNSkC7yXwdck3Y2c7p9gqlOUZ+eY9aioJLyu8rzMkxULaZLfQa9Ad1BeKY7c0bp1
         UtmiDQn5EdnAn5AWNrXeN1j8odv2cAz5G6wDnpz1wOm6uD4sxRPT95Cwaegkct+BfSTB
         fs6mhF+pH+T63TA0zPhdt2SA6CCxd3SVEP2s+o3WpvAIrq1rkgOi+BJMaHyDoyQMqHv4
         r/FTL6OOVz4Mvbyn0L9jQ+L7xGiok/L0jIgZA6bJqguizrNNSrUXHnznGJw7+ykXFsf5
         VkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934482; x=1746539282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwmhCT1O7Lt9CDkv/1B+o9vVSM9Ezs6Z5CMkWzIs6hk=;
        b=AAUApYbZhKk2TgyRMFueNMvGybiHdIZqYrldIJfvF3ZU6qa9xHmkMNynWD+6A92r3f
         7+V09/QC9Of9mjhDiidjxKuCmONZrd+aLYo7xkIjiv2+RanN/XH3Ut+dPORwPRrpKNPR
         /ESd5F1zNNdihiWSChNIL04SUcKpfltv5FpVCsMosGPwPTcbbCX9Nw+u3EFkntIC3mvN
         WswlD9ERdKb6J4UAyWKvmoLVEVmDCVaYP2HUV0sL896MeyaOHIwg6jMA8/ywWfpayOrJ
         1x7q5wd6SCIcZOwqfji4tLVhiM5kZb5AyeSfNAr+aCHKjikrHsLjev5X1OpV0uBG/ZBp
         gzaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbWez6lFSi24aLunenVx1YMbuAqA8PfYaK0p8jYA09YLkTLqjvDctKNF3a/Jk5Zkt6VXZ3eW5Z@lists.cip-project.org
X-Gm-Message-State: AOJu0YzjGwmf2dRvhaaYxSS0fgEwuwWSWpWcnwFEkc57gNja8k1k9MIO
	8I9HqnJ5Ip8YjWL2uyw/d0ZG0kSHGkq6NlmbgNAE1XGZ/RB1XYBsBcaAmbOvqJA=
X-Gm-Gg: ASbGnctYDUtmkFd3y2jL3BDCggj2nu6wgy2Msg3V/dEGmjVR/QhK/LLV9k+aMJTDIMt
	ZkpiYPzbGliDVjUeC11nR1KpTW7Km8LeXAiI5CRUTYEs6/EZcwmSDHNYASdzlJTjB8LIc9JcCOP
	9+iJvHChicprf8iTABCFAYGF459mwGuCalXY5cDUngmn2GG5F1OoQ90el5KezzYsvNM/2bfwzUV
	BzIBnKsI6i/dcnA45Dgnt+/CWYB1oU5o4Jlii+ZMdF6cRz5Z/FymwlCn2h58Ll4wuLIVkWzQ4ZH
	xJLmWY9UgHuX1zD9BxWQOCfMl08IE3cm1WQr7fQ+xD5jyjjKzE+z2aNz8Gt8bvOLVFZVVTaiE4v
	9xUyGiA==
X-Google-Smtp-Source: AGHT+IFsdzPxJBQlV9B77FzGXS4F4FnMgrjcVVuKxHQ6S47oi5qmahlgxc4RLqSxtmUKg6QJ8x9uKQ==
X-Received: by 2002:a17:907:1005:b0:ace:cbe0:2d67 with SMTP id a640c23a62f3a-acecbe03050mr208924466b.55.1745934482507;
        Tue, 29 Apr 2025 06:48:02 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:48:01 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 19/21] arm64: dts: renesas: r9a08g045: Add I2C nodes
Date: Tue, 29 Apr 2025 16:47:25 +0300
Message-ID: <20250429134727.2429662-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18732

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
index 3803605d7db0..496394ca141c 100644
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


