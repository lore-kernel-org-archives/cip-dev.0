Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46F7C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 05:02:54 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.41031.1745816483179209581
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 22:01:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rZaSg9T6;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so836213266b.2
        for <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 22:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745816481; x=1746421281; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYuyLz0XsGutXlsXk+t9HFcKXwwyxm+5FpVrdh1iLYc=;
        b=rZaSg9T6IB9e2qNUQq7U65aKhwwJHv6/xmji1QkBrcv7yaxkMEAU954Ay7HVVzQ9T2
         teunDQdSift0m5VjMkhD57C0xkcnrfSwDumYRbAFrNxv0Qawrz+BXVH3wi0Nl6ggxHtc
         Sp0wmH4rNuNuKx3jgXF7I2zMy1rHi+lD3VlxD8G9mKvIDFpf+Q7N0UJMQPY8svk2nqVc
         N8+sEF49vnI0P9UVvLrDDRXkHEEWs7NdzwaOhKLJPFZbGcwaV0tpvkWR3RJIc+4x9/Er
         o1JpOKTR+s0sg/UnCSBzMJ+9NqFV+hhsbbycpIQAwfYgFDR6weMUgVLsZmPpnods/SzL
         pBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745816481; x=1746421281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYuyLz0XsGutXlsXk+t9HFcKXwwyxm+5FpVrdh1iLYc=;
        b=JtBw3YE/nEMR/hnN4pcH1Gl9aJYF9IqTUSqxlytfdFq4SmR+9Ts9VZYSopDa260Jmn
         CnzSjuz3bh8vZh0+EMlDH3iTYTz+qiZsvRoDTvffKzQxhcb7GEjvZB7kmk79teMQ51qC
         +GypoXeIjmSHWIcJQcVX7N/qGPrEOjzysWULH5AgmDaNs1gt4cU4nUgoqQDv0D9pAlpX
         V0IYvlIaM0qg35lM2LRTtiCgnGp4bz9euUMMmLfsKJk6QGgeFYEs1eX7UKkxMD2C3/EA
         fdNDV8603PLAqI1ea0NNCT335/xdmZQ8Q/koHbHgtZ3pFltETVqhjDW9aHq8D/s2gb08
         UT6A==
X-Forwarded-Encrypted: i=1; AJvYcCWg6CH/jxTeUQ5dobIEX8O/JbzunVXenRr2hCiugHdQFM56mR8QefhjKGp4TXWlPH+mVCigM+fh@lists.cip-project.org
X-Gm-Message-State: AOJu0YwnuHJgZwp6EW1It9Zw0hyS/tzofruDODADCmQnxKRUIMEg0+Dq
	ajMMJMl0zuE7WzCUJrsF93oqENJmH8srKsf3FfN/qM9taEhn1VxIYJmix9utbiE=
X-Gm-Gg: ASbGncsOzFKNpvLfTHoaJXfZr8yJjjXpxZOEd5/cJ9Ub6ezqs4n3ACt1Yl9GjwCUTV1
	pIn76ad2P7WD4H7wyd1ER9D47JA+NeylzunHFEBVcprHqPvN6epxSjprK9IIW7R/Ifb2r8VkhV2
	LKKSpileWylEl6oC67dZNWkOXlcE7glGLTmcjYeK8eGaYJI+O3dxs7RPFF4s2u7iPxviZJ39env
	e3AtsKP8WYaLA1wCXBVRK5wJdmxDW+Gh1VkLTgyUxcs+3DrXRNlHGSRE2W5yztbGcIaGe6Rq7x5
	pgyIznSsYYGF6cHkzW7QkDqtXR2tUCDfg/XXby5EfWBVS9DyCBuQZKl/oLTg7xKMgdTfmDI=
X-Google-Smtp-Source: AGHT+IHOjmNwzyJFTRmaBv/kkUn/E8/V1Z9kdDD6oi8HGA7fslAGvvUy8cvy1vh2WYqt8rnSKupmOg==
X-Received: by 2002:a17:907:26c7:b0:aca:a35e:59fe with SMTP id a640c23a62f3a-ace739dce06mr860259466b.1.1745816481590;
        Sun, 27 Apr 2025 22:01:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41cfe8sm566055866b.17.2025.04.27.22.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 22:01:20 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 3/3] arm64: dts: renesas: r9a08g045: Add DMAC node
Date: Mon, 28 Apr 2025 08:01:16 +0300
Message-ID: <20250428050116.3081804-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 05:02:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18676

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 054a83a1548ce30eeebcf95c86951d3ef56e6f7d upstream.

Add DMAC node.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240711123405.2966302-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 3401c1200a1c..3803605d7db0 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -208,6 +208,44 @@ irqc: interrupt-controller@11050000 {
 			resets = <&cpg R9A08G045_IA55_RESETN>;
 		};
 
+		dmac: dma-controller@11820000 {
+			compatible = "renesas,r9a08g045-dmac",
+				     "renesas,rz-dmac";
+			reg = <0 0x11820000 0 0x10000>,
+			      <0 0x11830000 0 0x10000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 112 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 114 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 115 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 116 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 118 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 119 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 120 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 121 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 122 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 123 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 124 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 126 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 127 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD R9A08G045_DMAC_ACLK>,
+				 <&cpg CPG_MOD R9A08G045_DMAC_PCLK>;
+			clock-names = "main", "register";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_DMAC_ARESETN>,
+				 <&cpg R9A08G045_DMAC_RST_ASYNC>;
+			reset-names = "arst", "rst_async";
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
 		sdhi0: mmc@11c00000  {
 			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
-- 
2.43.0


