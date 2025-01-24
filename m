Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51951C0218C
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:31 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.7428.1737709227698908432
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hK73FmXc;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso12145985e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709226; x=1738314026; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzGO9ARih/R7OvarGAIo/MMNukwFVP28FODqkLvyhug=;
        b=hK73FmXcMYOSTpepdHbHnCq88cRXixEPQIQH865FQ3rxz6DGIy3nvZ5C3bkb1g3NRS
         YYIUXOkH9zS2d8gUHVcn2PnUVovCfzkCRei4EwlotJxZckpim3WPmpXkj8URuLCepn3N
         i+jS8VPGJ5Z0sFjDritrOkxwvr0F8V3dekkKcCNWFG7zzPR2KIKjfqmgcHzAi7npnKbS
         a//uMhhsN4+GETMuLQ3qDSY7IYPzsWcAQ/jG+Q6DonSmIlMmdT2PxUf7DbWrMUHH3JaX
         4CFK08u4rFvSGfD9BgWXziIUApg+8J/UZZPb2m6sgooYrx7aGc2ARo/M8cvcuyeIZs1w
         uTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709226; x=1738314026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzGO9ARih/R7OvarGAIo/MMNukwFVP28FODqkLvyhug=;
        b=WuinJ5cYRApttaxrpQJFLL+HM+j/O+FK7VwZBmpn/KTpXBAuAVQsf5PqBZ7JbcGglE
         0f0cgQpPKCXUHYVh2VUb88CoJxt1adRl2G/SKIR36+63FmLv/xPLlQEygLK069f677eW
         gMrTLFZVmn+zl+Tn5diNHog1P2CfgVheMZ+NDOCn9Tc39j/9K6Nd3hLGVNEzjvNFSjLG
         F8pkDOUiBC9YgFz3GValhRIFgVODjWrCisCW6y2ASGawbACvV5FL2eW7Bm+abO3EsJdW
         s20axM1tloxHn59xN0Q51L/1fw5MHTqeoOKiu1grEOSvaPNMz2R778HBgnMU91C1+xnj
         tx9g==
X-Forwarded-Encrypted: i=1; AJvYcCVpPKTfoKdUQ+5Xw3vQZkl4mE4Ne8srP+OFdkhnQfw0jGy8Ua/rsMqHDjiD4wKpW2hHOb0SjwLd@lists.cip-project.org
X-Gm-Message-State: AOJu0YwJvKDkxUhB1F1tYVktgIssoKxbVLDWTxPD2eADXzi9RMfs3mQN
	iEzaxL3jXkWGK/5xp6wXpbna+tjPDaJP/m353tx6/epGdrZx3IdE0QNWVl3V8Pc=
X-Gm-Gg: ASbGnct4G+ujcu0n4oQqFyo7nOiy2227x2yJ7KL7NK5DlsWM3SZoFLcIXfVPg+ITTvN
	lP/I0EJU2xUMn6OhGoe4i+cFLg+srXrHEq+jHNx8h2vYGlzrcDQJrAcnIcwwnpOW8Pi93BAvvCD
	X63APSYZ4T+XtGbSgZouGkxaEeaamP7n/iv5K4k/lFw65SO53qL4RHlZUkep84KHefiLCTp/LPb
	lK2NUw8NSEVOYPSTy6Snx2FT+ET0eoGctSog2QeEIGPBpqs35f90cDQjXwjwKe1NRKXQem9/P0k
	rHVyDMJFpijOeW27LKCJ6jkh+H8xqulZmQ==
X-Google-Smtp-Source: AGHT+IGKypmj4TbhX93YxgvXYu10q8J4rVZnQ4bZtF2Ac+C9XP9UEQXc1vrPZigJbRlOxP3niEvJFw==
X-Received: by 2002:a5d:5848:0:b0:38b:dbf0:34f2 with SMTP id ffacd0b85a97d-38bf59f03c7mr28311526f8f.52.1737709226180;
        Fri, 24 Jan 2025 01:00:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:25 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 10/14] arm64: dts: renesas: r9a08g045: Add VBATTB node
Date: Fri, 24 Jan 2025 11:00:01 +0200
Message-ID: <20250124090008.1401077-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17632

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 23c44956bce5aa79c060fc3e5d51843735e6eda6 upstream.

Add the DT node for the VBATTB IP along with DT bindings for the clock
it provides.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: the backported patch has references for i2c nodes;
 the i2c nodes are not available in v6.1 cip, thus fixed conflict by
 dropping the i2c nodes]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index f5f3f4f4c8d6..7bc8969a7b5a 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -72,6 +72,18 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		vbattb: clock-controller@1005c000 {
+			compatible = "renesas,r9a08g045-vbattb";
+			reg = <0 0x1005c000 0 0x1000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb_xtal>;
+			clock-names = "bclk", "rtx";
+			#clock-cells = <1>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_VBAT_BRESETN>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a08g045-cpg";
 			reg = <0 0x11010000 0 0x10000>;
@@ -296,4 +308,11 @@ timer {
 				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	vbattb_xtal: vbattb-xtal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
 };
-- 
2.43.0


