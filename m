Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFCBC27C50
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:28 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.8701.1716970526981396620
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kiYeB6cs;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-421140314d5so14315485e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970525; x=1717575325; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IDTuuUmMn75Lwct81/xNe16cbwwQxJv0yqy2cX1aHk=;
        b=kiYeB6csE2QdRASiwfNrVJHOoBtV7kHftDlftudEHASaQoeSeWgIdDaQh+WitTmvH/
         xPD7MAUTUsuR18OWLcSck3zhpIY6t2CLwECmupCypsuvecul2bNJxQtAQBxKtlAON5eG
         O8U2AF559of94OUXyVLWa0hg8zyMhQOrXEeHndkA03EuVZ6RayYVSIV2e92/GfhgpgcG
         x+9On0CctsGjHKbUmvwi/cYfM5fb2JuNXKmtsvrLKwE8za2HgfukJ1SQ5tMgOy8EO6jt
         N6chUz9LBm3v2us+DEIZ5+/8kgfqPuoATI4/YzT8qeOCldcr3ihHmKU8THmivmRg6FLp
         9PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970525; x=1717575325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IDTuuUmMn75Lwct81/xNe16cbwwQxJv0yqy2cX1aHk=;
        b=sn2w1npYVPjQtin0nSXDgf6dSAZ/moa4j+8Yl1caaxjcbkOxMs7h9or8BL0pIhzv7I
         jngELFfknZFp1CHq5cFCMUV62rJak/n5u66pmSWEicdifUrIRBt98mAOKToAEgCUMS0R
         V8Bhz8ybv2nmh6jxFzyDCsKimYUBF/0PuJiiV4Wv+ZjHDRd5KfapdrZrE97jC6YZ7S6L
         +4YuUgzsdRhlS0mLXrbZmJCLw7gQo0XEqUedxXq7YYJ9FOWxSuMcpu99xYtgdOekX9v0
         sR4/iAi7HVg9NERRly27GswpG9xa0QOFALC5aSd0oP0FNiiZS+2SU2+dBOQqRmw2fJ02
         Ji6A==
X-Gm-Message-State: AOJu0Yw6GEW9cse+TBUhJgBvTTOzqRyNRFx81rt3Y6aepbCqPs0GLR4t
	+l3M1TOai2002cPjxLe0yYnDAq0oTIo6JjvcagTImmgkCGSV/Sl8fmFfeOGJeBw=
X-Google-Smtp-Source: AGHT+IGq/iklyaHgHanAFhacaBnjjBcl8Z3S0DCFShYa1urYKsYuVI8TX7gmKAXdXaWVZrDiunawZw==
X-Received: by 2002:a05:600c:5110:b0:421:15f:186a with SMTP id 5b1f17b1804b1-42108a12b4fmr99744735e9.39.1716970525433;
        Wed, 29 May 2024 01:15:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 30/33] arm64: dts: renesas: r9a08g045: Add Ethernet nodes
Date: Wed, 29 May 2024 11:14:31 +0300
Message-Id: <20240529081434.639519-31-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16058

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit aefd220c5791ea3471fc920feba380aacd2dcfa7 upstream.

Add the Ethernet nodes available on RZ/G3S (R9A08G045).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 6c7b29b69d0e..aaab5739c134 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -149,6 +149,44 @@ sdhi2: mmc@11c20000 {
 			status = "disabled";
 		};
 
+		eth0: ethernet@11c30000 {
+			compatible = "renesas,r9a08g045-gbeth", "renesas,rzg2l-gbeth";
+			reg = <0 0x11c30000 0 0x10000>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mux", "fil", "arp_ns";
+			phy-mode = "rgmii";
+			clocks = <&cpg CPG_MOD R9A08G045_ETH0_CLK_AXI>,
+				 <&cpg CPG_MOD R9A08G045_ETH0_CLK_CHI>,
+				 <&cpg CPG_MOD R9A08G045_ETH0_REFCLK>;
+			clock-names = "axi", "chi", "refclk";
+			resets = <&cpg R9A08G045_ETH0_RST_HW_N>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		eth1: ethernet@11c40000 {
+			compatible = "renesas,r9a08g045-gbeth", "renesas,rzg2l-gbeth";
+			reg = <0 0x11c40000 0 0x10000>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mux", "fil", "arp_ns";
+			phy-mode = "rgmii";
+			clocks = <&cpg CPG_MOD R9A08G045_ETH1_CLK_AXI>,
+				 <&cpg CPG_MOD R9A08G045_ETH1_CLK_CHI>,
+				 <&cpg CPG_MOD R9A08G045_ETH1_REFCLK>;
+			clock-names = "axi", "chi", "refclk";
+			resets = <&cpg R9A08G045_ETH1_RST_HW_N>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@12400000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.39.2


