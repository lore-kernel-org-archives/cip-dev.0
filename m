Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D1C55179
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:12 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2457.1785575708438872099
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lhRHIsv1;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49557167508so4838505e9.1
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575707; x=1786180507; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PyBZIpS33N0OWbgJQa6rFdimiUZNNmry2zMEcDqsq8o=;
        b=lhRHIsv1Ljs0DgrY2criHClwnpaUu/IVEHGOQtaFeUgyaFIbUj7wtYEjKWBBrXlx8K
         54jp1TAuQP+Ux+Eyh52x41+OMDGRakHSmbgWEWD+ZF1Um83zqTs8Luese2lYPqXr1+Oa
         PHlF1gNC4U3Oylkl5xeFv88m5A+TrulfrFCHGnbiAryOSwNfnwQLhTEzmfVFb3dZqVGq
         oKyRD8Zwf+bgzTRllSrm53JiyqoZZEuB6pVXlk4PaN++iGcm8NlH7BbCaviGwxHUGkmr
         sKShttY+0mxeJgFJD0ko+2XdOzD3nAwVwesYzphjkBcSXv0RQ/Brk/glkrA8B99nQVQp
         C2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575707; x=1786180507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PyBZIpS33N0OWbgJQa6rFdimiUZNNmry2zMEcDqsq8o=;
        b=kZ15iMKnWvcOCVO/cDul/R0l+jL6v0gqDCmg2qpJxYQBGtJR5NAfMJf3jd2LiE3ZNH
         rZizxSK5lF4cuIf4cws6zugR2W4Eux41ZVzFWbO+RY3ingIj+tnWwrjz7FWi9bAUSR85
         Ny+glLcpirFodlLwJjjgF7WTWeUZLRUybCA7yYBGxQVkY0TUQaHY8iIfnEbajYn7DYOH
         kR9KGusobpKkngtNjsgSXJMNc+e0TqU0FK4g9YtwP9r4gl0Vy2JNF89Bs5bzC/2rliyx
         nmyIrV1+oq3wVoCKXG7q0J0YNVJlYjTrOVZXnpcdGzJpJjJ0OeOntuT0or77QHOa418T
         3zKQ==
X-Gm-Message-State: AOJu0Yx36OirRiCK7W+z9QeZBxqkovkN2yiDo3qzx8ZE3FSWzLTmOIza
	PaqS3NT45w29nmI7COfD2DfGkVPWDIafgOYnFkZ6y+11tO6ttsZSYPTr99SqwA==
X-Gm-Gg: AR+sD12SE23kM0YIOIF+KdEbDi2SR58diKmxUF+AlzEHrco9etyaCav86TwXHi6JWQG
	X0Ht2a9VfuHx8jZp4eijgkSv6f0YEXKKJ+mb4z9u6RqZrV/vniw3/kUcx4M9TF3/JTd9p+QmqVl
	BYInb8kW9LornaQFWQ55HJ0zUkRbfIMX+j1X9fHIL5DpyJKHHO/HswjrxQOMb0ZDE89DP2SEpr1
	AZn/F6/aB/b2V3h1wHFKh1+NSCLahZ+Vi0uo/l6fLENsbfheKv+UA33QVMrM0Xrb7S2bx+fXBdN
	pB0eeeRgi8SWiO5SSrdDQF68siKTTo1pW3z2qr7+UUXjPSApI+5JT3+Tho5cYHmQ/q/5CeKr9gg
	+PiwJ858Kdug0GWlyv+BmjL1u3Bnb0O9RNbJTiO7bmn55ekVxknwEQaid8W0qVEArh/br438pPK
	zYTlceKSqT0sJ0/P9DnJCfvaAOEX5Jn43OUFaf7ccKeO6NWsh2Sjxbou3xxKWYioScAlzV+zR/r
	I7Ef6KOu+hjXQ==
X-Received: by 2002:a05:600c:354a:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-4980c67d71emr33357215e9.19.1785575706526;
        Sat, 01 Aug 2026 02:15:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:06 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/19] arm64: dts: renesas: r9a08g046: Add wdt device node
Date: Sat,  1 Aug 2026 10:14:40 +0100
Message-ID: <20260801091458.14026-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23836

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 8e46bc6370d08a21cc43bb747aef8ffae45df7d7 ]

The RZ/G3L SOC has 3 watchdog timer channels:
  - channel0 (wdt0) for Cortex-A55-CPU Non-Secure,
  - channel1 (wdt1) for Cortex-A55 CPU Secure,
  - channel2 (wdt2) for Cortex-M33 CPU.

Add wdt0 node to RZ/G3L ("R9A08G046") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260505125921.149682-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 7a7c11ab4903..19f2c9f29f5c 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -667,6 +667,20 @@ gic: interrupt-controller@12400000 {
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
+
+		wdt0: watchdog@12800800 {
+			compatible = "renesas,r9a08g046-wdt", "renesas,rzg2l-wdt";
+			reg = <0 0x12800800 0 0x400>;
+			clocks = <&cpg CPG_MOD R9A08G046_WDT0_PCLK>,
+				 <&cpg CPG_MOD R9A08G046_WDT0_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A08G046_WDT0_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
 	};
 
 	stmmac_axi_setup: stmmac-axi-config {
-- 
2.43.0


