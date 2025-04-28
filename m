Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC03BC369D5
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 05:01:54 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.41016.1745816461902012759
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 22:01:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=G/0sqrdn;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so6664487a12.3
        for <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 22:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745816460; x=1746421260; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYuyLz0XsGutXlsXk+t9HFcKXwwyxm+5FpVrdh1iLYc=;
        b=G/0sqrdnJ6gXG+A4viX0Iu4YBQoPbo5nz2K99uhMrqtHxiz6sDvhTA8ND5pucsLENl
         AYj5bIzGXUUtKSqXS93jUE+7HlzZCQSPT2+kLSp59K0g2BKu2R2LzOwknQJPkrVoanhb
         lZ7h8Ux60Jc7fHc/prdz/UxeHnv8J+6otkmYxd7ADAe0KzIswkDoQ9VinswjcC7fHK2c
         Jbh5oUpRMN8V9/mIOMFpLHO1+Q+WaACVz+BrOe14RHMA7c3ZoFRcrGqjD3P96awif+SM
         86GcZfJUDrSH5QZ2t+xHovyMdbyTIBHXMqoGxmcDflZYxvpIkXlNO7N84d1NWgxEAw/N
         BOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745816460; x=1746421260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYuyLz0XsGutXlsXk+t9HFcKXwwyxm+5FpVrdh1iLYc=;
        b=BojZstadsUsiLBsY9Wx46CjU1GO1a8LGJSNMRdPURWQ2LDc6HOnOs8oaqnQ96XhmCt
         0AjZUGC/Q8qkjRZAzMz9NEOWtYCW+p185tMLlp1cCOEe2W7OwujLIKJoUCNPSbRMj7Ch
         ydGItFa75Nkq9CCrtdJGwjhIHJSdlX/aZymV1bR3dVZLOQvL4A+ANFKBSB/ZnC+4d9Mg
         7cZH5EPmBCE/7gMCwN+uJ9XNcZRPUn3KIXqxLbFIzvJ8yk+Of7i7wumj0pXcpIT4Gvwm
         HWPCGK93mM5QZq2kdLHVum+P+4R/Jpzw1n5zb1o3bQ86N9FIFl17txdfiBtwJ5pbebJD
         sgkw==
X-Forwarded-Encrypted: i=1; AJvYcCUig35HoL2ME91iAOPLoMemboMAzEiC6BTFgAjwG6OLm0jWYFEenvhzr2zMIdyHKWP6AL5UYqfS@lists.cip-project.org
X-Gm-Message-State: AOJu0YzUou2dCJ4IvwfD0DZCYZk7d4h4h+U+Dh6mFkxWBx8m1edPmbAF
	7fws/Cvwvwhb1cirZ347odJ2zIZbga27pTq7up/5CpU71k5zqmqmoikltHHeejs=
X-Gm-Gg: ASbGncuw2kc7e+baUsLXqTd41YD65cggRfi2U59mp4xRfg1cU8f/BNQDzQYbRro6ZW/
	Sy2jmip53dFIjMpVvdNsoyXJusCfNgyS+DYf6e6egV/c4N7Fa9OI1y4FI4Nh4Y1WUIBqhXVpPDr
	5KmEamOTtdTzV147OIaVQuhuxkvYZmVTQvimQyKUtgWZXUWpB+6vf2oQpAUeEXm8ADCVcBYMA/n
	mbHoM1nfnfOEWOiT4Up1n8YWAlVbNhrjfix1JxHAOAtjAdKl/7iiqCzjppgBFV50/UbeO/Xpp+y
	6t12O6fpCvR+D110OEyq9PnrstFu4ETfzDG4FK+AxA/9ryLrhIKZLQmVjIFa9AIGyk4Dw24=
X-Google-Smtp-Source: AGHT+IGfVSq2fgZkDrgk0/lPYyeL+wDYFdKQsFTeWyyl98KjjCLmjSW0kUlbW7Q4vh47DH8IETp9qQ==
X-Received: by 2002:a50:8dc6:0:b0:5f7:98ff:b919 with SMTP id 4fb4d7f45d1cf-5f798ffbaf5mr3621767a12.11.1745816460001;
        Sun, 27 Apr 2025 22:01:00 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7011fc361sm5176645a12.16.2025.04.27.22.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 22:00:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 3/3] arm64: dts: renesas: r9a08g045: Add DMAC node
Date: Mon, 28 Apr 2025 08:00:51 +0300
Message-ID: <20250428050051.3081705-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 05:01:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18672

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


