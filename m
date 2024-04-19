Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B952C071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:10 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.18445.1713526747858512305
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mRu2vEad;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571bddd74c1so1631493a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526746; x=1714131546; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNMtA80LBJPkMK90lPXBqNa+7v5qV22QaVTUhq01e0w=;
        b=mRu2vEadiU+36W0xgTdddtO/BLN7ynbqDmcZl5z8G317S8ms2q/iPdrIvL3yljGSxQ
         V7XWajf+6254SjPZRUD6xchH+bmDpKk6SvHPdCmbC6JYdQYseOXmAFw0D2Sph83CUxku
         /13bSndNdkrfqGOL95FuytbAqPY0FdYZblhms75xMuF1aLxM7ZMwOJRrDS7wUeYtprX1
         HimwJxyaY15qL+MQB57PMm41jDVLmnUIsHxkPR29f4GPWd8wY6hUWvWWbIwLDL0K9UXg
         ehTEACiEoxqKte8JrUsIPtzKd/67S9APZ7PFTvb487yalFqhrSEuIMyvWAn2KbIclMnn
         /iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526746; x=1714131546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNMtA80LBJPkMK90lPXBqNa+7v5qV22QaVTUhq01e0w=;
        b=q6sD/Bkbn1mR/ivMZ/JA9wn86atnhiGLzK2xEK7PlQamjv90dVwkwexYsuoa9RCrSc
         EZ5L9wNc2uppxYSKjvrP+BjdaE3Z5ZETnwOl52VnRMkoVBi3Emb75dEGopz1QzBEQeRU
         RwwhpY9w5GIghP0QundhSvr0/goCDtUgdtdC2ojdib4PPz2LiLbLuhy7kedEYxbAtJky
         Dwn3zR8q1NbKyijVFYhpbMEUVXbadPuKxIaMV3zaWxXN/JTJhFxgpfOPo4qoRQI5jzs8
         oFa0e+UhL0+af8DjSrjYlCYmJ8WNOTJRYlv5s8tfh9vbL7aIuG000ipIXzASAIyh45kp
         tD/A==
X-Gm-Message-State: AOJu0YyM0hz4FSo4NP4AsGOPzxudb5vScj6Ej2b3CAMUTZnv/ZgYa//Z
	oFPVXH3x82A+W4gE9N211Dq+vfmI8XE7q1N2fz/kpEQtpfK57hv70/O/hpxveKM=
X-Google-Smtp-Source: AGHT+IHMsCAhXoOHftI/piJ9/IjCmYVrWRSk1aBAmM2o/pjfdA73AxOQ25D4tQGN+qIUvaeF9zEsBA==
X-Received: by 2002:a50:9e05:0:b0:570:369:3e06 with SMTP id z5-20020a509e05000000b0057003693e06mr1200790ede.19.1713526746190;
        Fri, 19 Apr 2024 04:39:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 15/44] dt-bindings: clock: renesas,rzg2l-cpg: Document RZ/G3S SoC
Date: Fri, 19 Apr 2024 14:38:13 +0300
Message-Id: <20240419113842.3675543-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15666

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e372aee8c24957cbcb55d93b14ba386096497bca upstream.

Add documentation for the RZ/G3S CPG.  The RZ/G3S CPG module is almost
identical to the one available in RZ/G2{L,UL}, the exception being some
core clocks as follows:
  - The SD clock is composed of a mux and a divider, and the divider
    has some limitations (div = 1 cannot be set if mux rate is 800MHz),
  - There are 3 SD clocks,
  - The OCTA and TSU clocks are specific to RZ/G3S,
  - PLL1/4/6 are specific to RZ/G3S with its own computation formula.
Even with this RZ/G3S could use the same bindings as RZ/G2L.

Along with documentation bindings for the RZ/G3S (R9A08G045) Clock Pulse
Generator (CPG) core clocks, module clocks and resets were added.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-13-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/clock/renesas,rzg2l-cpg.yaml     |   1 +
 include/dt-bindings/clock/r9a08g045-cpg.h     | 242 ++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 include/dt-bindings/clock/r9a08g045-cpg.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
index 487f74cdc749..461a04a40c81 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
@@ -27,6 +27,7 @@ properties:
       - renesas,r9a07g043-cpg # RZ/G2UL{Type-1,Type-2} and RZ/Five
       - renesas,r9a07g044-cpg # RZ/G2{L,LC}
       - renesas,r9a07g054-cpg # RZ/V2L
+      - renesas,r9a08g045-cpg # RZ/G3S
       - renesas,r9a09g011-cpg # RZ/V2M
 
   reg:
diff --git a/include/dt-bindings/clock/r9a08g045-cpg.h b/include/dt-bindings/clock/r9a08g045-cpg.h
new file mode 100644
index 000000000000..410725b778a8
--- /dev/null
+++ b/include/dt-bindings/clock/r9a08g045-cpg.h
@@ -0,0 +1,242 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R9A08G045_CPG_H__
+#define __DT_BINDINGS_CLOCK_R9A08G045_CPG_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* R9A08G045 CPG Core Clocks */
+#define R9A08G045_CLK_I			0
+#define R9A08G045_CLK_I2		1
+#define R9A08G045_CLK_I3		2
+#define R9A08G045_CLK_S0		3
+#define R9A08G045_CLK_SPI0		4
+#define R9A08G045_CLK_SPI1		5
+#define R9A08G045_CLK_SD0		6
+#define R9A08G045_CLK_SD1		7
+#define R9A08G045_CLK_SD2		8
+#define R9A08G045_CLK_M0		9
+#define R9A08G045_CLK_HP		10
+#define R9A08G045_CLK_TSU		11
+#define R9A08G045_CLK_ZT		12
+#define R9A08G045_CLK_P0		13
+#define R9A08G045_CLK_P1		14
+#define R9A08G045_CLK_P2		15
+#define R9A08G045_CLK_P3		16
+#define R9A08G045_CLK_P4		17
+#define R9A08G045_CLK_P5		18
+#define R9A08G045_CLK_AT		19
+#define R9A08G045_CLK_OC0		20
+#define R9A08G045_CLK_OC1		21
+#define R9A08G045_OSCCLK		22
+#define R9A08G045_OSCCLK2		23
+#define R9A08G045_SWD			24
+
+/* R9A08G045 Module Clocks */
+#define R9A08G045_OCTA_ACLK		0
+#define R9A08G045_OCTA_MCLK		1
+#define R9A08G045_CA55_SCLK		2
+#define R9A08G045_CA55_PCLK		3
+#define R9A08G045_CA55_ATCLK		4
+#define R9A08G045_CA55_GICCLK		5
+#define R9A08G045_CA55_PERICLK		6
+#define R9A08G045_CA55_ACLK		7
+#define R9A08G045_CA55_TSCLK		8
+#define R9A08G045_SRAM_ACPU_ACLK0	9
+#define R9A08G045_SRAM_ACPU_ACLK1	10
+#define R9A08G045_SRAM_ACPU_ACLK2	11
+#define R9A08G045_GIC600_GICCLK		12
+#define R9A08G045_IA55_CLK		13
+#define R9A08G045_IA55_PCLK		14
+#define R9A08G045_MHU_PCLK		15
+#define R9A08G045_SYC_CNT_CLK		16
+#define R9A08G045_DMAC_ACLK		17
+#define R9A08G045_DMAC_PCLK		18
+#define R9A08G045_OSTM0_PCLK		19
+#define R9A08G045_OSTM1_PCLK		20
+#define R9A08G045_OSTM2_PCLK		21
+#define R9A08G045_OSTM3_PCLK		22
+#define R9A08G045_OSTM4_PCLK		23
+#define R9A08G045_OSTM5_PCLK		24
+#define R9A08G045_OSTM6_PCLK		25
+#define R9A08G045_OSTM7_PCLK		26
+#define R9A08G045_MTU_X_MCK_MTU3	27
+#define R9A08G045_POE3_CLKM_POE		28
+#define R9A08G045_GPT_PCLK		29
+#define R9A08G045_POEG_A_CLKP		30
+#define R9A08G045_POEG_B_CLKP		31
+#define R9A08G045_POEG_C_CLKP		32
+#define R9A08G045_POEG_D_CLKP		33
+#define R9A08G045_WDT0_PCLK		34
+#define R9A08G045_WDT0_CLK		35
+#define R9A08G045_WDT1_PCLK		36
+#define R9A08G045_WDT1_CLK		37
+#define R9A08G045_WDT2_PCLK		38
+#define R9A08G045_WDT2_CLK		39
+#define R9A08G045_SPI_HCLK		40
+#define R9A08G045_SPI_ACLK		41
+#define R9A08G045_SPI_CLK		42
+#define R9A08G045_SPI_CLKX2		43
+#define R9A08G045_SDHI0_IMCLK		44
+#define R9A08G045_SDHI0_IMCLK2		45
+#define R9A08G045_SDHI0_CLK_HS		46
+#define R9A08G045_SDHI0_ACLK		47
+#define R9A08G045_SDHI1_IMCLK		48
+#define R9A08G045_SDHI1_IMCLK2		49
+#define R9A08G045_SDHI1_CLK_HS		50
+#define R9A08G045_SDHI1_ACLK		51
+#define R9A08G045_SDHI2_IMCLK		52
+#define R9A08G045_SDHI2_IMCLK2		53
+#define R9A08G045_SDHI2_CLK_HS		54
+#define R9A08G045_SDHI2_ACLK		55
+#define R9A08G045_SSI0_PCLK2		56
+#define R9A08G045_SSI0_PCLK_SFR		57
+#define R9A08G045_SSI1_PCLK2		58
+#define R9A08G045_SSI1_PCLK_SFR		59
+#define R9A08G045_SSI2_PCLK2		60
+#define R9A08G045_SSI2_PCLK_SFR		61
+#define R9A08G045_SSI3_PCLK2		62
+#define R9A08G045_SSI3_PCLK_SFR		63
+#define R9A08G045_SRC_CLKP		64
+#define R9A08G045_USB_U2H0_HCLK		65
+#define R9A08G045_USB_U2H1_HCLK		66
+#define R9A08G045_USB_U2P_EXR_CPUCLK	67
+#define R9A08G045_USB_PCLK		68
+#define R9A08G045_ETH0_CLK_AXI		69
+#define R9A08G045_ETH0_CLK_CHI		70
+#define R9A08G045_ETH0_REFCLK		71
+#define R9A08G045_ETH1_CLK_AXI		72
+#define R9A08G045_ETH1_CLK_CHI		73
+#define R9A08G045_ETH1_REFCLK		74
+#define R9A08G045_I2C0_PCLK		75
+#define R9A08G045_I2C1_PCLK		76
+#define R9A08G045_I2C2_PCLK		77
+#define R9A08G045_I2C3_PCLK		78
+#define R9A08G045_SCIF0_CLK_PCK		79
+#define R9A08G045_SCIF1_CLK_PCK		80
+#define R9A08G045_SCIF2_CLK_PCK		81
+#define R9A08G045_SCIF3_CLK_PCK		82
+#define R9A08G045_SCIF4_CLK_PCK		83
+#define R9A08G045_SCIF5_CLK_PCK		84
+#define R9A08G045_SCI0_CLKP		85
+#define R9A08G045_SCI1_CLKP		86
+#define R9A08G045_IRDA_CLKP		87
+#define R9A08G045_RSPI0_CLKB		88
+#define R9A08G045_RSPI1_CLKB		89
+#define R9A08G045_RSPI2_CLKB		90
+#define R9A08G045_RSPI3_CLKB		91
+#define R9A08G045_RSPI4_CLKB		92
+#define R9A08G045_CANFD_PCLK		93
+#define R9A08G045_CANFD_CLK_RAM		94
+#define R9A08G045_GPIO_HCLK		95
+#define R9A08G045_ADC_ADCLK		96
+#define R9A08G045_ADC_PCLK		97
+#define R9A08G045_TSU_PCLK		98
+#define R9A08G045_PDM_PCLK		99
+#define R9A08G045_PDM_CCLK		100
+#define R9A08G045_PCI_ACLK		101
+#define R9A08G045_PCI_CLKL1PM		102
+#define R9A08G045_SPDIF_PCLK		103
+#define R9A08G045_I3C_PCLK		104
+#define R9A08G045_I3C_TCLK		105
+#define R9A08G045_VBAT_BCLK		106
+
+/* R9A08G045 Resets */
+#define R9A08G045_CA55_RST_1_0		0
+#define R9A08G045_CA55_RST_3_0		1
+#define R9A08G045_CA55_RST_4		2
+#define R9A08G045_CA55_RST_5		3
+#define R9A08G045_CA55_RST_6		4
+#define R9A08G045_CA55_RST_7		5
+#define R9A08G045_CA55_RST_8		6
+#define R9A08G045_CA55_RST_9		7
+#define R9A08G045_CA55_RST_10		8
+#define R9A08G045_CA55_RST_11		9
+#define R9A08G045_CA55_RST_12		10
+#define R9A08G045_SRAM_ACPU_ARESETN0	11
+#define R9A08G045_SRAM_ACPU_ARESETN1	12
+#define R9A08G045_SRAM_ACPU_ARESETN2	13
+#define R9A08G045_GIC600_GICRESET_N	14
+#define R9A08G045_GIC600_DBG_GICRESET_N	15
+#define R9A08G045_IA55_RESETN		16
+#define R9A08G045_MHU_RESETN		17
+#define R9A08G045_DMAC_ARESETN		18
+#define R9A08G045_DMAC_RST_ASYNC	19
+#define R9A08G045_SYC_RESETN		20
+#define R9A08G045_OSTM0_PRESETZ		21
+#define R9A08G045_OSTM1_PRESETZ		22
+#define R9A08G045_OSTM2_PRESETZ		23
+#define R9A08G045_OSTM3_PRESETZ		24
+#define R9A08G045_OSTM4_PRESETZ		25
+#define R9A08G045_OSTM5_PRESETZ		26
+#define R9A08G045_OSTM6_PRESETZ		27
+#define R9A08G045_OSTM7_PRESETZ		28
+#define R9A08G045_MTU_X_PRESET_MTU3	29
+#define R9A08G045_POE3_RST_M_REG	30
+#define R9A08G045_GPT_RST_C		31
+#define R9A08G045_POEG_A_RST		32
+#define R9A08G045_POEG_B_RST		33
+#define R9A08G045_POEG_C_RST		34
+#define R9A08G045_POEG_D_RST		35
+#define R9A08G045_WDT0_PRESETN		36
+#define R9A08G045_WDT1_PRESETN		37
+#define R9A08G045_WDT2_PRESETN		38
+#define R9A08G045_SPI_HRESETN		39
+#define R9A08G045_SPI_ARESETN		40
+#define R9A08G045_SDHI0_IXRST		41
+#define R9A08G045_SDHI1_IXRST		42
+#define R9A08G045_SDHI2_IXRST		43
+#define R9A08G045_SSI0_RST_M2_REG	44
+#define R9A08G045_SSI1_RST_M2_REG	45
+#define R9A08G045_SSI2_RST_M2_REG	46
+#define R9A08G045_SSI3_RST_M2_REG	47
+#define R9A08G045_SRC_RST		48
+#define R9A08G045_USB_U2H0_HRESETN	49
+#define R9A08G045_USB_U2H1_HRESETN	50
+#define R9A08G045_USB_U2P_EXL_SYSRST	51
+#define R9A08G045_USB_PRESETN		52
+#define R9A08G045_ETH0_RST_HW_N		53
+#define R9A08G045_ETH1_RST_HW_N		54
+#define R9A08G045_I2C0_MRST		55
+#define R9A08G045_I2C1_MRST		56
+#define R9A08G045_I2C2_MRST		57
+#define R9A08G045_I2C3_MRST		58
+#define R9A08G045_SCIF0_RST_SYSTEM_N	59
+#define R9A08G045_SCIF1_RST_SYSTEM_N	60
+#define R9A08G045_SCIF2_RST_SYSTEM_N	61
+#define R9A08G045_SCIF3_RST_SYSTEM_N	62
+#define R9A08G045_SCIF4_RST_SYSTEM_N	63
+#define R9A08G045_SCIF5_RST_SYSTEM_N	64
+#define R9A08G045_SCI0_RST		65
+#define R9A08G045_SCI1_RST		66
+#define R9A08G045_IRDA_RST		67
+#define R9A08G045_RSPI0_RST		68
+#define R9A08G045_RSPI1_RST		69
+#define R9A08G045_RSPI2_RST		70
+#define R9A08G045_RSPI3_RST		71
+#define R9A08G045_RSPI4_RST		72
+#define R9A08G045_CANFD_RSTP_N		73
+#define R9A08G045_CANFD_RSTC_N		74
+#define R9A08G045_GPIO_RSTN		75
+#define R9A08G045_GPIO_PORT_RESETN	76
+#define R9A08G045_GPIO_SPARE_RESETN	77
+#define R9A08G045_ADC_PRESETN		78
+#define R9A08G045_ADC_ADRST_N		79
+#define R9A08G045_TSU_PRESETN		80
+#define R9A08G045_OCTA_ARESETN		81
+#define R9A08G045_PDM0_PRESETNT		82
+#define R9A08G045_PCI_ARESETN		83
+#define R9A08G045_PCI_RST_B		84
+#define R9A08G045_PCI_RST_GP_B		85
+#define R9A08G045_PCI_RST_PS_B		86
+#define R9A08G045_PCI_RST_RSM_B		87
+#define R9A08G045_PCI_RST_CFG_B		88
+#define R9A08G045_PCI_RST_LOAD_B	89
+#define R9A08G045_SPDIF_RST		90
+#define R9A08G045_I3C_TRESETN		91
+#define R9A08G045_I3C_PRESETN		92
+#define R9A08G045_VBAT_BRESETN		93
+
+#endif /* __DT_BINDINGS_CLOCK_R9A08G045_CPG_H__ */
-- 
2.39.2


