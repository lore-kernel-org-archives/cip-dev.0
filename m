Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23301.1792676429184889311
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2026 06:40:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EeG1TFbX;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so11355835e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676427; x=1793281227; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CcluD7lcF+2pNqOt6BvJNcvOfp2xS3ypgtHRa3vyDWY=;
        b=EeG1TFbXSHLaD8sH9MEeSmSUmD2an+hqtR3xir463LlPwMafHwalzdIATh86kmS0OG
         +UqAwz5sBAZxh2jJwJbTiG4RDWD0QEg3UzNXAnYPIcnDyYyW3+BKvn4GXd/+FTC8xafN
         xP7OA3P+MttVTt9Bo1pV7uo72BoTPkitGbC80dNLPMJARnhSZbKzhnfFE8kD8wtTD7eN
         eUaUvKHwJhxgtQWWboPGFIgmeMYG6bdYJNHVcIlyVG6QajTTOTbjcGEoCH5ysgwc7Ntf
         nQsAgOwVp1tNdAyNFojj90CIkdnBagAMMFMFqsSFmH12Rpl8mUKWYv4mboHSikOSSn7g
         TEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676427; x=1793281227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CcluD7lcF+2pNqOt6BvJNcvOfp2xS3ypgtHRa3vyDWY=;
        b=XSgSO+08Ux0h+iy6RM1LtR9wBrMFBb8cXnH6SGXVaVKxJNdIxAsgjIsDWm0Q8xOr2j
         fyb4E9H2G5WSxesK+8lihNq1/0LApBWrnqQid7Y1Pt7lZze6DyXervUmHjxENs/0GIw2
         IP6B72bysw9oio/HL1OXW+90UBJfB3aLTfExbbOT9eNndDfDyUEekK00ADBd+eaO+PAy
         HOtSxiHhyMy+RrVT6prf201T0ZorHxbAC68kXPcmx/nf5TcjdjE4GJBUkUGpXB1ARDeS
         yWrRyqf4Tada1l1BFqYSoSKWm4NgjlgJx8hmKEvgZz2+mXHzHWOTQHbEDljbnt3nvaJL
         ZlJg==
X-Gm-Message-State: AFq9FYIKy28bBwhkHcCU0kVkmh5d2mBdwJ4eZQKVrRFSbXXgi3Isqg44
	sAqi9RlUbMfh9jbZSXmUS4ETrh4BMaJL8duY1yMwEy3npE693vFczuUGSBI8mg==
X-Gm-Gg: AYBFou1qMJH+hVECwQAWlqClScDKuJVrW7eQX/oobc1I0MaMBv+QkMrHJ6pbRo3Tpup
	I9rLh1shh8rXOZUNfEEYy1tbhud0BHDncQa3ar7cr3kOzWbX79ZrldA0q6iO+S7mr0UPrCXrTkA
	CXSOQAMYCb6MxHrHvFSaFeqbd6SSI+VW/8XsgmKZL2a1X1VA1pa/nCsExrAjvS5P8i1yVzUQi0I
	Dky3boWInGs++dstZgsY1RDK9jsiHABwSyCt93ndpl1Ekg6zmTfhOYjrFGYHMHl6pomLanYzAds
	Kc+DeGzRjxX+Z9gRGqt2d6cdOp8/p84aDkYpCTFG5b9t3yiJuWOl5OSjHe/3s2uHtHmg2qi7s8F
	NkOt5KcYb7UGSCsuPl5E7ZMed0m6eZyWE2xU2NoCGCV+hWXjnCNGI+1wBcUXGLk3pRWowsfi1MY
	WL08l0ajZubHxY9K+IQ0jKkRsYS5kiUfpx64gziko6GWWsda+e+RSbWci0fmKSI01h9IcXdFl0T
	DjhQg5m6xVQLRObLnB3EDDPQ7X4UQ8k7l8msTYOPIasEEMKJSYS5iLNpgtBd58nQzoujqc6QDr5
	XwQpw7il5VEhyp7c6/V5MIl+uAsSxg==
X-Received: by 2002:a05:600c:3e0c:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a204b042e5mr42763355e9.8.1792676427196;
        Thu, 22 Oct 2026 06:40:27 -0700 (PDT)
Return-Path: <biju.das.au@gmail.com>
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3c4e:ba43:9a8e:7e31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203963f3fsm82888415e9.2.2026.10.22.06.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:40:26 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/5] arm64: dts: renesas: r9a08g046: Add rsci{0..3} device nodes
Date: Thu, 22 Oct 2026 14:40:12 +0100
Message-ID: <20261022134021.217964-4-biju.das.au@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134021.217964-1-biju.das.au@gmail.com>
References: <20261022134021.217964-1-biju.das.au@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 13:40:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24512
Content-Type: text/plain; charset="utf-8"

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit daae3ecaeb1b14ba06fe7c0ca1c1d88bdf094d07 ]

Add rsci{0..3} device nodes to the RZ/G3L ("R9A08G046") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260519100022.116318-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 57c63f7ab6d83..c63a857f0e5b0 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -427,6 +427,90 @@ rspi2: spi@100ea000 {
 			status = "disabled";
 		};
 
+		rsci0: serial@100b8000 {
+			compatible = "renesas,r9a08g046-rsci";
+			reg = <0 0x100b8000 0 0x1000>;
+			interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 417 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 418 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD R9A08G046_RSCI0_TCLK>,
+				 <&cpg CPG_MOD R9A08G046_RSCI0_PCLK>;
+			clock-names = "operation", "bus";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_RSCI0_PRESETN>,
+				 <&cpg R9A08G046_RSCI0_TRESETN>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci1: serial@100f1000 {
+			compatible = "renesas,r9a08g046-rsci";
+			reg = <0 0x100f1000 0 0x1000>;
+			interrupts = <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 424 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 426 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD R9A08G046_RSCI1_TCLK>,
+				 <&cpg CPG_MOD R9A08G046_RSCI1_PCLK>;
+			clock-names = "operation", "bus";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_RSCI1_PRESETN>,
+				 <&cpg R9A08G046_RSCI1_TRESETN>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci2: serial@100f2000 {
+			compatible = "renesas,r9a08g046-rsci";
+			reg = <0 0x100f2000 0 0x1000>;
+			interrupts = <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 429 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 430 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD R9A08G046_RSCI2_TCLK>,
+				 <&cpg CPG_MOD R9A08G046_RSCI2_PCLK>;
+			clock-names = "operation", "bus";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_RSCI2_PRESETN>,
+				 <&cpg R9A08G046_RSCI2_TRESETN>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci3: serial@100f3000 {
+			compatible = "renesas,r9a08g046-rsci";
+			reg = <0 0x100f3000 0 0x1000>;
+			interrupts = <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 435 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 438 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD R9A08G046_RSCI3_TCLK>,
+				 <&cpg CPG_MOD R9A08G046_RSCI3_PCLK>;
+			clock-names = "operation", "bus";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_RSCI3_PRESETN>,
+				 <&cpg R9A08G046_RSCI3_TRESETN>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
 		canfd: can@100c0000 {
 			reg = <0 0x100c0000 0 0x20000>;
 			/* placeholder */
-- 
2.43.0

