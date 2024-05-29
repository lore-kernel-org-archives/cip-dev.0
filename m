Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2520CC27C44
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:57 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web10.8666.1716970315938631742
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=noL3Y+T0;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.177, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e974862b00so18447211fa.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970314; x=1717575114; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IDTuuUmMn75Lwct81/xNe16cbwwQxJv0yqy2cX1aHk=;
        b=noL3Y+T0HLwyybwlnpuM3W/ql5EEoFz7JdrGxMl2CEE91xsno1dX/dUvns2gPZLAl3
         a8DSDru+zUPqHW7hoplM9EinIGglsYYPkHIhx4R2BOOiTe29Q6cyfWU1VZ9IlxOZQiLZ
         MgiEVftGsBYULOQqP2kjZzEMYPPl+qSFFSVS5DWvkC/PQl00QlT/tb1iC0iO1a4yq/q0
         uHrIHRElxRb4Yz+Q/YyETHQOUg4WvyUyEutDFJ5dAprHgKkDG1inx2SsG5acvLCNhHQv
         aBFQI/aKVnVxNtMUI5wSFHRGekfmGWLtl6PU3yZ7hqu/OGvPYQem9HyovKS1SaIDquCs
         cSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970314; x=1717575114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IDTuuUmMn75Lwct81/xNe16cbwwQxJv0yqy2cX1aHk=;
        b=ORakpVb2qGdUP8WG2Hm1BC3KAEL3+MkGiRYqNsRnN1b1hsS7+feFwHnnLcxbjM3m2I
         IS8a4ZMsKvPfacEBuRqFP2DIJyhJb8i7H5rKPWYhl/iXJ3q07ZyfsBcxSARFpifOfZ/u
         JvD6z09pMn1+rjlLMBhAzvOZD1ED1c3mx8Aw93y76UE2lxm4lA83Ntm8ftaXZb62M8E+
         powe0aP5eGgurwyjjAVQXPmOTlWG60/m7t0EnBRBD5Jji6GhRdOVUbqe92ZXPFtDepnc
         3HMBmN5B4RQ1Zoqyfuau814T2JOXLaNuHBlluSawfZwVLicw9KzoFGPm75iHgrG2I3Y4
         dkIQ==
X-Gm-Message-State: AOJu0Yxrx7PWeN5xDqZkQJkOugmthQ+P82HfNDhGhvccSwtuJUdJC6R3
	NnEVsPM1pYGBkn0dzQNZxgKwR/StjWMrc0d+CInrvQ4uXozq6jcEvbIO1hH1ccjFEnl5E2bv+Hy
	VhJQ=
X-Google-Smtp-Source: AGHT+IFlmt0QmzW1exxYWUXpP8GOfKdTY5S6+TZs7N0pyrHZIVeVRNrOlo6447g90bJADKzTZ47w4g==
X-Received: by 2002:a2e:3517:0:b0:2e9:87f6:b133 with SMTP id 38308e7fff4ca-2e987f6b269mr27938471fa.3.1716970314207;
        Wed, 29 May 2024 01:11:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 44/47] arm64: dts: renesas: r9a08g045: Add Ethernet nodes
Date: Wed, 29 May 2024 11:10:36 +0300
Message-Id: <20240529081039.639010-45-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16024

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


