Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E981E1061217
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:51 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18745.1773227209347286803
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VRTDmuUc;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439af7d77f0so9182855f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227208; x=1773832008; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iP8PkA1s/PH2nHwURzjjhasIar7CuEPQb5SfNrG8sQ=;
        b=VRTDmuUcIuuP2IZAM/PXxZkWlQA/EuRbZFOusnPY45eevRKLPMduV+eNTG49nDtJRe
         tKgjcfwIS4Zl7Wv9NC2zvWBrvTOv4iFmHl/dw5wNrAVXv+xczgI05Wr/FQy2YvawIxg6
         YIbQVgiEcuyLsXzzWsPBTDGNjAm+vlcc4njzPo+C1zGrsnc5av70UW1hwAVLgekwEWEn
         Nvn5uCm79Rw7eW8OWF2G2M23fW78lxJduTYCKQoUt5MS6UMwgt3yY6jNFcOxQoMCl/75
         vZC7r6VTQBPeeTph98cyjTszQ5OruV2wrqcI0Ld2dKW3KpSzOhP60L2WmSV/U6KMViFx
         1tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227208; x=1773832008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0iP8PkA1s/PH2nHwURzjjhasIar7CuEPQb5SfNrG8sQ=;
        b=LUeHdiMGVfI0z164a0mOMChNJGkSF7yVp6gWax/+eb/zbKdCa2Hvm9M/m93hkrsfwt
         NFsNgqY4zNrFGOoxY9TrBCjyT1OzhzqMM+lg3nN7w1VV9bIglYCrCKMPXKgX1Pj3lXu+
         bUQlwUaawjRPPcwiJVUQiuHAGsva3lZE0cQzhZJEKA2iG1+eHU48tLnknYXZn66pk/jG
         gtvywWUSFZDapRSWuBs2zBjgx2fR2PuiPhl7OE352Ade6/6hd8hC1aX+EHRH+5IFLgGS
         ApVWP1mqDu+XnVwUm8bjTiLkKsOSvc2QARG0A2ks9G2Ox0Ml8YOQnWespl05BrHjXRG5
         ecFA==
X-Gm-Message-State: AOJu0Yxfui57j7m0Lyy+qL9sPplag3Azx6dCkIlusFclmMMkCFsKvla2
	qxXPFUBXTy94+NJM5k98n4J/0CiW4uWn49+/dmXCn3V+k8wJ88JXhFMjoYcvRArllvn6hOIN4kf
	g3iDu
X-Gm-Gg: ATEYQzw8bNG0D6zmquGs3ZNNwrCgitD9ey8K1KFB4gOUbkKGOUqQK3OmCoceWylsE3B
	6dsypaEnkkx8VGUp0ISqT69ZhcIB3JyufoRQJR+fcknOQBLtk+WgmwKf3MopymW9xJ0Anf0LNHM
	VgT8QXrMiIdGPonh/UVkBAj0ykTuVUPMs0naDf51YzL17E9OLmVdgKMTuE+cxIXkQ9CLd/CZQUJ
	YkY8J8i8iY6Loo0EVFAZlVRAvNQzMxmZmIjBoEz90Bb7STMAw2HJftS7JpJjoY3EG6rE53ra+cW
	PzdeGg08n7zf/HOM5Rq9WhurAQswDxFGA3khSHxlXfJVKXFs6neprJngtMye1OlElR4rXbR90qf
	tAZ9iaxLsODihFf8JIRzF6X5MN/o5BF0TWo/dzgAV3aDVWuvyCSMOH3UnhcxwwVEbIcetP1pPM6
	mN/7ltUJSkWN+l/rDM6AnueKECCWzSK419IXgxoeot0tMOPMF2ck30
X-Received: by 2002:a05:6000:2dc6:b0:439:ccd7:cdcd with SMTP id ffacd0b85a97d-439f81f23b2mr4078636f8f.7.1773227207677;
        Wed, 11 Mar 2026 04:06:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 10/13] arm64: dts: renesas: r9a08g045: Add PCIe node
Date: Wed, 11 Mar 2026 13:06:30 +0200
Message-ID: <20260311110633.1938579-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22336

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
 not yet present in v6.12 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 1a2e6f20e113..cb7dae9f7dd6 100644
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


