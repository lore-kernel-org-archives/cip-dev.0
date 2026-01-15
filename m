Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B84D41144
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:42 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31323.1768466194617501478
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=F+jLDfsk;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so1057866a12.1
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466193; x=1769070993; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zptoHHy4ZTDFi1mgdHAf9pUqr5ngphtpWC/OsyVBWc=;
        b=F+jLDfsksGW97ICXtWvZdDiiwTWcAf4OFiklt03T7zAUdHsDM9o3e0B0zOWqlEFvdJ
         KL4TYWCUUdCbDXqCwvvyj9QqHoYz/RRnRWVbrtaD81tN8jLyoHW54+jNRnkjhs+02Ilp
         gFsCLaizRa4hoOy7klpIukej3Jm+gpU6fycIoMGFA65eu/M0v6S/95nYeHT7Ao4gG9UA
         5ttVBdPheFm0zT3hovglxcoMXWYY5G8I5b7CFCOKIi4XGO1phMkb6Cuy0KbFU+M+rzF1
         wNwEaRnrqXBHs8gK2/97eBbRuKYXBT987bxWRgzu9VwdVqdNur01D81X3inCH2awhwH4
         8G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466193; x=1769070993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1zptoHHy4ZTDFi1mgdHAf9pUqr5ngphtpWC/OsyVBWc=;
        b=PPrPWj4hNmKXbEEzXi6aX9NrU2iMs+1qN977X3wNGhRCy7F+tmdbaLVWt1xXxf/TAW
         xfEIj1im8Hk+JE+SG6LQyzBe/OXpWnRU5Ej0XiNpnvfOFo+Ux3Zx7SK0zjPsD1ASsaNO
         oPEt0l17BBsm20HIrecZnQQGPoc7OYK/pC2pfVXOL3NX/tA5t1nVKiVY/0ofMApip1ji
         ODa+oLS1T43uI21qX2zQNFkO0oMrqjzp3gkhhFXz/enRxrm4OL87i8tNHmKSP//s9XtP
         kwX/l+aNGGsDFwIVKkLiX8LSYehHlD5lGv0ypcC4SnVYwMybkr4raUYmsKh3VELLjCPi
         ZyTA==
X-Gm-Message-State: AOJu0Yx7J+fRi2nAoJvE6EgKM1YK7RQcAK1WigNyZFjdH0qC86IG6Zvu
	LOwXEWVjHRgle8ZgX3ACog9nWlFS1MWjoudsqMVWrIGMgjesR7OSwmqRxUL/MPYd84o=
X-Gm-Gg: AY/fxX7FIQqVBiV/o70zOe12fYOI/loE7aMWg12wiWyfYCQTXHqcbkFHM7NEmMI51pk
	gVMLTW745KYpGPdEKyYDDZXYO7aNSPwfh+dbL7iG9ZTbaGaTVOgLSNV0rI10zT3scRonCKAAjEB
	6Z8nkCsV6b+Vh+l8hR29AcLDf12qZ6+3+CUt1FEjz1TblCvaSG0E1NPAjLUZ15WR9gJt5WftKfB
	jRNwJ3QbOYKJ+TJeuJ8hMOyDCRd0OMnnkoWJ4giciXcrf6LyGzytM9wBUa4Us1Paf8tgot2wTW+
	55mjwhMIaGqSN2krdVbgTGYir0sR6aq9Dy1DMmBMvi6Ux6qB2vb0oIPzQjC5+cls0BmiWEzjRcR
	6Hfv7/Gu2N69oUcuJB2gve3RfHITcpGXl1FRhSOPMUEJFeCkucKo/CDp/AKrYzI3gLA2MQeFAtG
	ccOcvBUX4kPQigpe6EjLcIhTusl246gt0JbiFib+05bCL3/puqLIMm00RVw46MZ/ZEMg==
X-Received: by 2002:a05:6402:27ce:b0:64b:7c0e:1841 with SMTP id 4fb4d7f45d1cf-653ec46f719mr4076471a12.31.1768466191755;
        Thu, 15 Jan 2026 00:36:31 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:31 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 14/19] dt-bindings: clock: rzg2l: Drop power domain IDs
Date: Thu, 15 Jan 2026 10:35:58 +0200
Message-ID: <20260115083604.1064260-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21614

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 4a59e02a5aa178f80d065ad0368d29f25620c334 upstream.

Since the configuration order between the individual MSTOP and CLKON
bits cannot be preserved with the power domain abstraction, drop the
power domain IDs.  The corresponding code has also been removed.
Currently, there are no device tree users for these IDs.

Acked-by: "Rob Herring (Arm)" <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250527112403.1254122-8-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by dropping all the power domain IDs]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/dt-bindings/clock/r9a07g043-cpg.h | 53 -----------------
 include/dt-bindings/clock/r9a07g044-cpg.h | 58 -------------------
 include/dt-bindings/clock/r9a07g054-cpg.h | 58 -------------------
 include/dt-bindings/clock/r9a08g045-cpg.h | 70 -----------------------
 4 files changed, 239 deletions(-)

diff --git a/include/dt-bindings/clock/r9a07g043-cpg.h b/include/dt-bindings/clock/r9a07g043-cpg.h
index 131993343777..e1f65f1928cf 100644
--- a/include/dt-bindings/clock/r9a07g043-cpg.h
+++ b/include/dt-bindings/clock/r9a07g043-cpg.h
@@ -200,57 +200,4 @@
 #define R9A07G043_AX45MP_CORE0_RESETN	78	/* RZ/Five Only */
 #define R9A07G043_IAX45_RESETN		79	/* RZ/Five Only */
 
-/* Power domain IDs. */
-#define R9A07G043_PD_ALWAYS_ON		0
-#define R9A07G043_PD_GIC		1	/* RZ/G2UL Only */
-#define R9A07G043_PD_IA55		2	/* RZ/G2UL Only */
-#define R9A07G043_PD_MHU		3	/* RZ/G2UL Only */
-#define R9A07G043_PD_CORESIGHT		4	/* RZ/G2UL Only */
-#define R9A07G043_PD_SYC		5	/* RZ/G2UL Only */
-#define R9A07G043_PD_DMAC		6
-#define R9A07G043_PD_GTM0		7
-#define R9A07G043_PD_GTM1		8
-#define R9A07G043_PD_GTM2		9
-#define R9A07G043_PD_MTU		10
-#define R9A07G043_PD_POE3		11
-#define R9A07G043_PD_WDT0		12
-#define R9A07G043_PD_SPI		13
-#define R9A07G043_PD_SDHI0		14
-#define R9A07G043_PD_SDHI1		15
-#define R9A07G043_PD_ISU		16	/* RZ/G2UL Only */
-#define R9A07G043_PD_CRU		17	/* RZ/G2UL Only */
-#define R9A07G043_PD_LCDC		18	/* RZ/G2UL Only */
-#define R9A07G043_PD_SSI0		19
-#define R9A07G043_PD_SSI1		20
-#define R9A07G043_PD_SSI2		21
-#define R9A07G043_PD_SSI3		22
-#define R9A07G043_PD_SRC		23
-#define R9A07G043_PD_USB0		24
-#define R9A07G043_PD_USB1		25
-#define R9A07G043_PD_USB_PHY		26
-#define R9A07G043_PD_ETHER0		27
-#define R9A07G043_PD_ETHER1		28
-#define R9A07G043_PD_I2C0		29
-#define R9A07G043_PD_I2C1		30
-#define R9A07G043_PD_I2C2		31
-#define R9A07G043_PD_I2C3		32
-#define R9A07G043_PD_SCIF0		33
-#define R9A07G043_PD_SCIF1		34
-#define R9A07G043_PD_SCIF2		35
-#define R9A07G043_PD_SCIF3		36
-#define R9A07G043_PD_SCIF4		37
-#define R9A07G043_PD_SCI0		38
-#define R9A07G043_PD_SCI1		39
-#define R9A07G043_PD_IRDA		40
-#define R9A07G043_PD_RSPI0		41
-#define R9A07G043_PD_RSPI1		42
-#define R9A07G043_PD_RSPI2		43
-#define R9A07G043_PD_CANFD		44
-#define R9A07G043_PD_ADC		45
-#define R9A07G043_PD_TSU		46
-#define R9A07G043_PD_PLIC		47	/* RZ/Five Only */
-#define R9A07G043_PD_IAX45		48	/* RZ/Five Only */
-#define R9A07G043_PD_NCEPLDM		49	/* RZ/Five Only */
-#define R9A07G043_PD_NCEPLMT		50	/* RZ/Five Only */
-
 #endif /* __DT_BINDINGS_CLOCK_R9A07G043_CPG_H__ */
diff --git a/include/dt-bindings/clock/r9a07g044-cpg.h b/include/dt-bindings/clock/r9a07g044-cpg.h
index e209f96f92b7..0bb17ff1a01a 100644
--- a/include/dt-bindings/clock/r9a07g044-cpg.h
+++ b/include/dt-bindings/clock/r9a07g044-cpg.h
@@ -217,62 +217,4 @@
 #define R9A07G044_ADC_ADRST_N		82
 #define R9A07G044_TSU_PRESETN		83
 
-/* Power domain IDs. */
-#define R9A07G044_PD_ALWAYS_ON		0
-#define R9A07G044_PD_GIC		1
-#define R9A07G044_PD_IA55		2
-#define R9A07G044_PD_MHU		3
-#define R9A07G044_PD_CORESIGHT		4
-#define R9A07G044_PD_SYC		5
-#define R9A07G044_PD_DMAC		6
-#define R9A07G044_PD_GTM0		7
-#define R9A07G044_PD_GTM1		8
-#define R9A07G044_PD_GTM2		9
-#define R9A07G044_PD_MTU		10
-#define R9A07G044_PD_POE3		11
-#define R9A07G044_PD_GPT		12
-#define R9A07G044_PD_POEGA		13
-#define R9A07G044_PD_POEGB		14
-#define R9A07G044_PD_POEGC		15
-#define R9A07G044_PD_POEGD		16
-#define R9A07G044_PD_WDT0		17
-#define R9A07G044_PD_WDT1		18
-#define R9A07G044_PD_SPI		19
-#define R9A07G044_PD_SDHI0		20
-#define R9A07G044_PD_SDHI1		21
-#define R9A07G044_PD_3DGE		22
-#define R9A07G044_PD_ISU		23
-#define R9A07G044_PD_VCPL4		24
-#define R9A07G044_PD_CRU		25
-#define R9A07G044_PD_MIPI_DSI		26
-#define R9A07G044_PD_LCDC		27
-#define R9A07G044_PD_SSI0		28
-#define R9A07G044_PD_SSI1		29
-#define R9A07G044_PD_SSI2		30
-#define R9A07G044_PD_SSI3		31
-#define R9A07G044_PD_SRC		32
-#define R9A07G044_PD_USB0		33
-#define R9A07G044_PD_USB1		34
-#define R9A07G044_PD_USB_PHY		35
-#define R9A07G044_PD_ETHER0		36
-#define R9A07G044_PD_ETHER1		37
-#define R9A07G044_PD_I2C0		38
-#define R9A07G044_PD_I2C1		39
-#define R9A07G044_PD_I2C2		40
-#define R9A07G044_PD_I2C3		41
-#define R9A07G044_PD_SCIF0		42
-#define R9A07G044_PD_SCIF1		43
-#define R9A07G044_PD_SCIF2		44
-#define R9A07G044_PD_SCIF3		45
-#define R9A07G044_PD_SCIF4		46
-#define R9A07G044_PD_SCI0		47
-#define R9A07G044_PD_SCI1		48
-#define R9A07G044_PD_IRDA		49
-#define R9A07G044_PD_RSPI0		50
-#define R9A07G044_PD_RSPI1		51
-#define R9A07G044_PD_RSPI2		52
-#define R9A07G044_PD_CANFD		53
-#define R9A07G044_PD_ADC		54
-#define R9A07G044_PD_TSU		55
-
 #endif /* __DT_BINDINGS_CLOCK_R9A07G044_CPG_H__ */
diff --git a/include/dt-bindings/clock/r9a07g054-cpg.h b/include/dt-bindings/clock/r9a07g054-cpg.h
index 2c99f89397c4..43f4dbda872c 100644
--- a/include/dt-bindings/clock/r9a07g054-cpg.h
+++ b/include/dt-bindings/clock/r9a07g054-cpg.h
@@ -226,62 +226,4 @@
 #define R9A07G054_TSU_PRESETN		83
 #define R9A07G054_STPAI_ARESETN		84
 
-/* Power domain IDs. */
-#define R9A07G054_PD_ALWAYS_ON		0
-#define R9A07G054_PD_GIC		1
-#define R9A07G054_PD_IA55		2
-#define R9A07G054_PD_MHU		3
-#define R9A07G054_PD_CORESIGHT		4
-#define R9A07G054_PD_SYC		5
-#define R9A07G054_PD_DMAC		6
-#define R9A07G054_PD_GTM0		7
-#define R9A07G054_PD_GTM1		8
-#define R9A07G054_PD_GTM2		9
-#define R9A07G054_PD_MTU		10
-#define R9A07G054_PD_POE3		11
-#define R9A07G054_PD_GPT		12
-#define R9A07G054_PD_POEGA		13
-#define R9A07G054_PD_POEGB		14
-#define R9A07G054_PD_POEGC		15
-#define R9A07G054_PD_POEGD		16
-#define R9A07G054_PD_WDT0		17
-#define R9A07G054_PD_WDT1		18
-#define R9A07G054_PD_SPI		19
-#define R9A07G054_PD_SDHI0		20
-#define R9A07G054_PD_SDHI1		21
-#define R9A07G054_PD_3DGE		22
-#define R9A07G054_PD_ISU		23
-#define R9A07G054_PD_VCPL4		24
-#define R9A07G054_PD_CRU		25
-#define R9A07G054_PD_MIPI_DSI		26
-#define R9A07G054_PD_LCDC		27
-#define R9A07G054_PD_SSI0		28
-#define R9A07G054_PD_SSI1		29
-#define R9A07G054_PD_SSI2		30
-#define R9A07G054_PD_SSI3		31
-#define R9A07G054_PD_SRC		32
-#define R9A07G054_PD_USB0		33
-#define R9A07G054_PD_USB1		34
-#define R9A07G054_PD_USB_PHY		35
-#define R9A07G054_PD_ETHER0		36
-#define R9A07G054_PD_ETHER1		37
-#define R9A07G054_PD_I2C0		38
-#define R9A07G054_PD_I2C1		39
-#define R9A07G054_PD_I2C2		40
-#define R9A07G054_PD_I2C3		41
-#define R9A07G054_PD_SCIF0		42
-#define R9A07G054_PD_SCIF1		43
-#define R9A07G054_PD_SCIF2		44
-#define R9A07G054_PD_SCIF3		45
-#define R9A07G054_PD_SCIF4		46
-#define R9A07G054_PD_SCI0		47
-#define R9A07G054_PD_SCI1		48
-#define R9A07G054_PD_IRDA		49
-#define R9A07G054_PD_RSPI0		50
-#define R9A07G054_PD_RSPI1		51
-#define R9A07G054_PD_RSPI2		52
-#define R9A07G054_PD_CANFD		53
-#define R9A07G054_PD_ADC		54
-#define R9A07G054_PD_TSU		55
-
 #endif /* __DT_BINDINGS_CLOCK_R9A07G054_CPG_H__ */
diff --git a/include/dt-bindings/clock/r9a08g045-cpg.h b/include/dt-bindings/clock/r9a08g045-cpg.h
index 8281e9caf3a9..410725b778a8 100644
--- a/include/dt-bindings/clock/r9a08g045-cpg.h
+++ b/include/dt-bindings/clock/r9a08g045-cpg.h
@@ -239,74 +239,4 @@
 #define R9A08G045_I3C_PRESETN		92
 #define R9A08G045_VBAT_BRESETN		93
 
-/* Power domain IDs. */
-#define R9A08G045_PD_ALWAYS_ON		0
-#define R9A08G045_PD_GIC		1
-#define R9A08G045_PD_IA55		2
-#define R9A08G045_PD_MHU		3
-#define R9A08G045_PD_CORESIGHT		4
-#define R9A08G045_PD_SYC		5
-#define R9A08G045_PD_DMAC		6
-#define R9A08G045_PD_GTM0		7
-#define R9A08G045_PD_GTM1		8
-#define R9A08G045_PD_GTM2		9
-#define R9A08G045_PD_GTM3		10
-#define R9A08G045_PD_GTM4		11
-#define R9A08G045_PD_GTM5		12
-#define R9A08G045_PD_GTM6		13
-#define R9A08G045_PD_GTM7		14
-#define R9A08G045_PD_MTU		15
-#define R9A08G045_PD_POE3		16
-#define R9A08G045_PD_GPT		17
-#define R9A08G045_PD_POEGA		18
-#define R9A08G045_PD_POEGB		19
-#define R9A08G045_PD_POEGC		20
-#define R9A08G045_PD_POEGD		21
-#define R9A08G045_PD_WDT0		22
-#define R9A08G045_PD_XSPI		23
-#define R9A08G045_PD_SDHI0		24
-#define R9A08G045_PD_SDHI1		25
-#define R9A08G045_PD_SDHI2		26
-#define R9A08G045_PD_SSI0		27
-#define R9A08G045_PD_SSI1		28
-#define R9A08G045_PD_SSI2		29
-#define R9A08G045_PD_SSI3		30
-#define R9A08G045_PD_SRC		31
-#define R9A08G045_PD_USB0		32
-#define R9A08G045_PD_USB1		33
-#define R9A08G045_PD_USB_PHY		34
-#define R9A08G045_PD_ETHER0		35
-#define R9A08G045_PD_ETHER1		36
-#define R9A08G045_PD_I2C0		37
-#define R9A08G045_PD_I2C1		38
-#define R9A08G045_PD_I2C2		39
-#define R9A08G045_PD_I2C3		40
-#define R9A08G045_PD_SCIF0		41
-#define R9A08G045_PD_SCIF1		42
-#define R9A08G045_PD_SCIF2		43
-#define R9A08G045_PD_SCIF3		44
-#define R9A08G045_PD_SCIF4		45
-#define R9A08G045_PD_SCIF5		46
-#define R9A08G045_PD_SCI0		47
-#define R9A08G045_PD_SCI1		48
-#define R9A08G045_PD_IRDA		49
-#define R9A08G045_PD_RSPI0		50
-#define R9A08G045_PD_RSPI1		51
-#define R9A08G045_PD_RSPI2		52
-#define R9A08G045_PD_RSPI3		53
-#define R9A08G045_PD_RSPI4		54
-#define R9A08G045_PD_CANFD		55
-#define R9A08G045_PD_ADC		56
-#define R9A08G045_PD_TSU		57
-#define R9A08G045_PD_OCTA		58
-#define R9A08G045_PD_PDM		59
-#define R9A08G045_PD_PCI		60
-#define R9A08G045_PD_SPDIF		61
-#define R9A08G045_PD_I3C		62
-#define R9A08G045_PD_VBAT		63
-
-#define R9A08G045_PD_DDR		64
-#define R9A08G045_PD_TZCDDR		65
-#define R9A08G045_PD_OTFDE_DDR		66
-
 #endif /* __DT_BINDINGS_CLOCK_R9A08G045_CPG_H__ */
-- 
2.43.0


