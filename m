Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6778310611FF
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:51 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18707.1773227144106036380
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=C1mGW5QZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-485392de558so20261165e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227142; x=1773831942; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcsxVlqFXUuOguO2kql7QsTjQIKOCCjkNeXdyOIBg1U=;
        b=C1mGW5QZPY21KZXqeDEk5zgyT6TY8XI26FG2YEt4IwOCf7LrKZGUgs3aXIecKFQ8z7
         Kuyw+5MGPwo+mlEcAJNHEHBnZv7+osmjtbX82JGHgTYSp1X/qTDQEaVQMlZBxo/O15iN
         tYXi6cNxZ9DUI/n2xsA+cssX2k2w51xntja1EKXE37Xev6hwENfxGv8vfNLeRZgXUmuH
         WK0DK1mq+OPvKquVkltko7t1kLGf6NiN8kII3SWYN94xPx+NdQQwdmBlgudUrHgdpuzT
         OjlN1OLfFfQLVjv+mx3CZU8gi8kTTYWjOUYTaYnb1mdgRgBfk8WuCkhYgGuuJuMKlY46
         cdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227142; x=1773831942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jcsxVlqFXUuOguO2kql7QsTjQIKOCCjkNeXdyOIBg1U=;
        b=S/wSf0NaoM6P4osYkOkCMseoD/varzLgI2Z6gr+1ECSVgYF4cuV/OkToREjTH9J9Wz
         Gn+sFRj+tOvo7POZCqwhG5I5aGOxxFoSuVENR4fKNT3Awq1+VXBcxSeTmpb3BLoa+ka8
         Z6fcU74+o5WoabxkJAuI6DvlxTfabGgRXTSPEIZd5Jvd4k0YVgC/IoTpvxVcGjliRiqg
         KybMrVSujtxTxOini0PUH0BXD74NVayA3OH/FFHaLV5XOUH5kduvFLjuxWijYmvlV6y8
         8WpbbCh1Vxzdzvsrk4J7IjVwUe+WKgzlt66fd7VyFu5jo9BRzr8CspBxfI61oh6ekLG0
         RcRQ==
X-Gm-Message-State: AOJu0Yylikk/WesuBL2DjpeJEWwopKovIkmsyMnc8yGJjhGOXlUMvPhL
	PyXIfla0B8wdiSeBnu9x5iibhsWbiC+J8U+fV5t5kQNgMZ8eTdyFY9aOFVsAo5ZuF1+BtCWyIOx
	3lLNl
X-Gm-Gg: ATEYQzyofIu5ISaXjftiYYTcdrM69jSufw7o/ZWhl+98NbmOu1MDHk8sGaKcgfGLvv7
	hvik7rqG6Zck4C76Rd82uDePEd6zbpQZbj5KMx6PU/FN/5yyn43aGuIvVN/jsycRguAlLF4MoDb
	mpsG7bKfQczU2A6iRM4LNciDyFSrXIQOlZOxXxS7gjeQ7JG8R/IMme07na3bQgJrP57+f1046ne
	KXK1J+J+4HyvuK7bZkjp48RCnI1NoNBfoBsOtUrUHX/+lD8VH2klpTjeN/0mN+lesASGbUVmxuI
	nu9Gc5F6O1Vm6L/qPEKWuOUyoaUYk3HhbWNFqNLvw/JNkLIbMiVbL5fdxlpXY0tpM1qnC2Sb2pB
	YbGWQaRj5rqIIZgO/YsneqJDpCJQk84s014AD31mkgFXEA8Zk+xdT9bowXsfsIjHxHP7J86JzHd
	rVJUxGHQv5pgJthKNSkA5u7oJMmnbBHmoPXvzToZc9vsj/jP4FnKZq
X-Received: by 2002:a05:600c:4585:b0:480:1e40:3d2 with SMTP id 5b1f17b1804b1-4854b12ee84mr32122375e9.29.1773227142409;
        Wed, 11 Mar 2026 04:05:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 14/17] arm64: dts: renesas: r9a08g045: Add PCIe node
Date: Wed, 11 Mar 2026 13:05:17 +0200
Message-ID: <20260311110520.1938414-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22322

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
 not yet present in v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index d01f7c9e8e92..df17dd219e91 100644
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


