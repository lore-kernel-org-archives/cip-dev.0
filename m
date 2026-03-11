Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7982010611EA
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18285.1773227074027326355
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MbpkyTwZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so37663685e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227072; x=1773831872; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+Mm77qajuNeS1u+NgA83AcrjLqlGaGp6M7PqQPvvWg=;
        b=MbpkyTwZt39ampg5y1CGoWWZq5/7PNwyXYb39xHb5rXiLlkPsH1qiJZx2On9fDS/hL
         xSFtvM7qZRmdDDAP2HMK2/uGe93PAo1F/rYCz5FypzVl2qb8dO7/SnyQps0vqe3WNd53
         k1PYFzqqMMZzitAu1iLraSNgSAZZ1oym84GCdEvmpB3Ck7ZG442gYVoeyVrm+SKWO1QO
         5IwvCmvPFWWXtqZH1ia/nbJNj2e8uLg8ON2LyLl3eJ9IATpKxvYUcsIVMJOby/jQabb2
         /poGwhzkI2f+kSAmrB7T4US7ff067rbJ38l6Z/dbDgkE/Xo5+yYr+nuGx3t2lC6rD+wB
         FmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227072; x=1773831872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+Mm77qajuNeS1u+NgA83AcrjLqlGaGp6M7PqQPvvWg=;
        b=PbPb0rXndXnh1817T5D9IC970VtI6KJm/Oo7Z1ePK7XbaliNkT+BNZvaJXOtlC5t29
         5vF3GyvrFpT+RYt3QzAZzqn/97DHQmMcLsk3o9Q1UYp2o6ApYhcBKC2tV4rrOQJDabfo
         ev33ZU06Yxo93Gt/Zsg0lX67bHRXD27LVs2RG3Dr26SKolT4J0dPziDERLWZQei8VzZB
         qYRoM39TxVg9XP3A9Z5iL2rle9f7FuOndf0bnSx2VOUzS/ajkFHc5my3zMsMxJ2WjUIb
         Yr90CqxlfTPIsiLxxA7Vm8gNVOfJKTfAmGAt/HjYC/y+iXLMfR1g6XfgHXCWm3VOOb6h
         utYg==
X-Gm-Message-State: AOJu0Yyv0pO9sYCAyS9c5BH5xPUdse5SV7u4gP3xdN/hs6QXTz+Cx50J
	/YYFxEKYqHweg2AKhlcYLaLarieORzEyYhgKkNQy6Jzlngfxyi7LjrPU2nQpf6xdHGQ=
X-Gm-Gg: ATEYQzzh/anMMDEMGAuXDQ2Vo9+OKrXcdnNP3UT/YPyP9bqs0qGQaQWBlgn8+ReTOzi
	kUgEN834UYRHSe9WXFGeQrpr8ur8GAm3gKu6WumuE8b5kD9SZvid9iF7nkiIBt8PuREX67cCgIm
	0SLnMSuhu8vZf+bTFsur2jAPTMhA6QlyrHgaMcNLwNqnO/pnRGr2HzwoD3EQs7pjjO9ZfcFgjxi
	jqU/5eNMn6KUW/YFeA4iLzFllOCxlh2gSaEC2pY9EYd2kajCq4DkXtEMTNixSw+avPTiihSFGKr
	abU5jl3BqYuCEjEkk2um5lSwjcnMzshJrgG9RBxzhpVMuuvkkLl/VcnepWP2ndWIr4OnR6ebX/t
	/7tYQGHgiM5jAVYarXDv9af6pmW+hTJ9Eho9VANpVVs4fCyjoPR8aFtadjptmD9DMDTMXLzAlAL
	KJ0V0f0OcXXiamXEOdG5JgP2xO7doIZxKUPoCvifrayQMRuP//eZSA
X-Received: by 2002:a05:600c:1d06:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-4854b0acca6mr31763145e9.3.1773227072254;
        Wed, 11 Mar 2026 04:04:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 25/28] arm64: dts: renesas: r9a08g045: Add PCIe node
Date: Wed, 11 Mar 2026 13:03:54 +0200
Message-ID: <20260311110357.1938200-26-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22304

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 40a4c75e7f7170f4dc9f077ae480fe5775a780a1 upstream.

The RZ/G3S SoC has a variant (R9A08G045S33) which supports PCIe. Add the
PCIe node.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251119143523.977085-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by dropping the USB nodes as these are
 not yet present in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 8d90ea8a82c9..ecca25467163 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -691,6 +691,71 @@ eth1: ethernet@11c40000 {
 			status = "disabled";
 		};
 
+		pcie: pcie@11e40000 {
+			compatible = "renesas,r9a08g045-pcie";
+			reg = <0 0x11e40000 0 0x10000>;
+			ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
+			/* Map all possible DRAM ranges (4 GB). */
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
+			bus-range = <0x0 0xff>;
+			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "serr", "serr_cor", "serr_nonfatal",
+					  "serr_fatal", "axi_err", "inta",
+					  "intb", "intc", "intd", "msi",
+					  "link_bandwidth", "pm_pme", "dma",
+					  "pcie_evt", "msg", "all";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
+					<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
+					<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
+					<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
+			clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
+				 <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
+			clock-names = "aclk", "pm";
+			resets = <&cpg R9A08G045_PCI_ARESETN>,
+				 <&cpg R9A08G045_PCI_RST_B>,
+				 <&cpg R9A08G045_PCI_RST_GP_B>,
+				 <&cpg R9A08G045_PCI_RST_PS_B>,
+				 <&cpg R9A08G045_PCI_RST_RSM_B>,
+				 <&cpg R9A08G045_PCI_RST_CFG_B>,
+				 <&cpg R9A08G045_PCI_RST_LOAD_B>;
+			reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
+				      "rst_rsm_b", "rst_cfg_b", "rst_load_b";
+			power-domains = <&cpg>;
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			renesas,sysc = <&sysc>;
+			status = "disabled";
+
+			pcie_port0: pcie@0,0 {
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				ranges;
+				device_type = "pci";
+				vendor-id = <0x1912>;
+				device-id = <0x0033>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+			};
+		};
+
 		gic: interrupt-controller@12400000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.43.0


