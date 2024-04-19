Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223B7C41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:51 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.18471.1713526785213759089
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=M4O5ep2X;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-571c25a329eso2109934a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526783; x=1714131583; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PFkdWL5MtliNa5vgxvGnxJTfoXqABZtjj6NQYhcNzM=;
        b=M4O5ep2Xg0zjFYvQfw2MXBJfOB7iN4aSTipG7TOMd0ctfGD3kdmgYYqn1zH9cVcnAF
         eHCgXnEyRwivhyjQYwZA23qj9Ztx5LoCHf884kl9dUww9X4OQblYEM1VX69egEuRL6wO
         A7VZuc5mrNOhqzOMZhJ0F476/sjRdcMgM7oozj+sv0s6ac58NlrJtmKqjbRQvxxpyQVL
         8Q+PZtGBBXqWSGMxO+Fsjc46N662sHG9BSAFH2HVYO1nO4FQYYukqgclHwNH1gOij0G2
         +kGpiYcQYdkJasrqwRhNeYAUP+NzDNEjWQrBE77HGda4yBL9hT4EG36G8bg7cSGbFA7d
         dyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526783; x=1714131583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PFkdWL5MtliNa5vgxvGnxJTfoXqABZtjj6NQYhcNzM=;
        b=R2yqyNf2fA7nDx3Cejm9s77K8ISt/X17AryvIuo8wuDHoNDmt3DVk5+4r2EHeJHILf
         98ocsedYW/qKPQUftDiIgsFtrDFIze+xhKia0E84Ijvh5nPZxjI1DVQ0W2q13lRwoP/4
         mVIMCvdbjOoPhUkZPsYXjXujNZBsJB4ewDSnhsTfwNg2Y8NK8nljRILF+aycbEbv4KQy
         mEHnyRZRdQttC1aeun6/Sin9IqHYN2Qu8+62+tn/1QFWEidfrdHoM83Kt4KCmHnKkral
         jG1lxQYxlMbEW7ZBiu/W1LyBGlKuSc4PJOjkGcdWYCFVPLET9MGeXY0xbnlyEmN6bH0w
         +a4w==
X-Gm-Message-State: AOJu0YzkYBIi5aWyfxkLAYaPIyed9K+G5zIsOJ8RbsNhzxPlEX/526tZ
	NcYsR1F+DqT927CazRDIbvSy8GBLPK2NAnucosi7Os/DCFqEbPwobcuzrKWDAK1BVooXsNO4yUV
	v
X-Google-Smtp-Source: AGHT+IEr/Wv3/eBWXD7XCzmfv3sopTLTu2ofaLYSw6LabQW4hsM3hsUaptJmxKF8q56eZer3e7vv1Q==
X-Received: by 2002:a50:d65b:0:b0:56d:f29d:c80d with SMTP id c27-20020a50d65b000000b0056df29dc80dmr1819445edj.5.1713526783680;
        Fri, 19 Apr 2024 04:39:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 39/44] arm64: dts: renesas: r9a08g045: Add nodes for SDHI1 and SDHI2
Date: Fri, 19 Apr 2024 14:38:37 +0300
Message-Id: <20240419113842.3675543-40-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15690

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


