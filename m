Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5452C07C79
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:58 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web11.15293.1713514738195747151
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=PbcjRwIY;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a53f131d9deso197549266b.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514736; x=1714119536; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PFkdWL5MtliNa5vgxvGnxJTfoXqABZtjj6NQYhcNzM=;
        b=PbcjRwIY9fx6TPfOioNOP7UM+6l5qJPaw2GRNWtAE5L4xB8/8112zGRtES2oqJ0/KI
         JtT7NwqS+bwORrNsfAdY/CKSbAZPKSW0O2k4pJObK/WpA+kTvSP2o8Blj4m2nXqMVjnS
         XQ2mBbMqqUgOu8aPxRuZsFFRDoCL2bT2BjGNvbUuseW1t8jmgasuPbCb4L69wSwdDBIw
         C1mTfXJt9w9hHJ4doWG2qtDe+e8wxETHt5IKQwWqu6CacAkxD2WgPxcgaRi6aZAeH3XQ
         IzqW+ZfXAr32y6y6TtJYT+JSuYcOur9DCx7ZxhFyOm9kYhVvA4wBKBziypMkcW1hyjOE
         5apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514736; x=1714119536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PFkdWL5MtliNa5vgxvGnxJTfoXqABZtjj6NQYhcNzM=;
        b=QOZNz1JPhtQJaIUKZA7DaN0cP/71b9Cs8J5DekWvEoq+Za/nBFa5uqRc6wbQH+Egm0
         joRF0tAye8w4EtLnhoKhMXI02rDG02R7P1SnrfwtN5IuVaFQQabWTfolWdltJKU4NK3l
         5AUSu6ITmQzZNzAB7N8P+WiJhEMo84IFERUhJb/rEf37LiBgQakF3Eovd7nhZmcYQpnj
         vv2byOPDn4PLtnhkz/kxFVXph/o7doIC3vrx8ltDDI014NLI7uJ5vZ3grQm2sGrsSsMo
         sTZyvRdFJ4O4PnDcWLHxGG5h0G2dyTHsTHN0QHS79PueZZdWqotocfmd/CKdwehnpEHc
         LSfA==
X-Gm-Message-State: AOJu0Yxz0FUtajjKn8Fmh4lWQXKPv/f7kSuIU6v2KP3Mw4AUpxzdUhUH
	p3nlZgFC1q4maaenD9Rss9PoQQcNzNOzYHXklu2wqdUA5dlI5xNlusk5/PhRF64agFmEJxHxm2j
	s
X-Google-Smtp-Source: AGHT+IF+WgozN/O8ahFO4RlikNkzlFsAnv86Zj5RyPEYwxHaASeWn3u997mdrHkYhf0kGt7LCQMipg==
X-Received: by 2002:a17:907:3e1a:b0:a55:8c0b:bc00 with SMTP id hp26-20020a1709073e1a00b00a558c0bbc00mr363726ejc.62.1713514736690;
        Fri, 19 Apr 2024 01:18:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:56 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 48/53] arm64: dts: renesas: r9a08g045: Add nodes for SDHI1 and SDHI2
Date: Fri, 19 Apr 2024 11:17:37 +0300
Message-Id: <20240419081742.3496709-49-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15635

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 6a35583085a70bbf37e8f905e098a1dae5711165 upstream.

Add DT nodes for SDHI1 and SDHI2 available on RZ/G3S (R9A08G045).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231010132701.1658737-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 7971e44a5a0a..534b728a8e14 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -118,6 +118,36 @@ sdhi0: mmc@11c00000  {
 			status = "disabled";
 		};
 
+		sdhi1: mmc@11c10000 {
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x11c10000 0 0x10000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_SDHI1_IMCLK>,
+				 <&cpg CPG_MOD R9A08G045_SDHI1_CLK_HS>,
+				 <&cpg CPG_MOD R9A08G045_SDHI1_IMCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SDHI1_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A08G045_SDHI1_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sdhi2: mmc@11c20000 {
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x11c20000 0 0x10000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_SDHI2_IMCLK>,
+				 <&cpg CPG_MOD R9A08G045_SDHI2_CLK_HS>,
+				 <&cpg CPG_MOD R9A08G045_SDHI2_IMCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SDHI2_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A08G045_SDHI2_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@12400000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.39.2


