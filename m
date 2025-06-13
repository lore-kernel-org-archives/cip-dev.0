Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC09C71148
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:40 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.7107.1749809791390853217
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=AIOuqZ1W;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-addcea380eeso337299666b.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809790; x=1750414590; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdjUCVpqPUm8ixGqf+F8dk8bdPFxFedEDIckenWkGiA=;
        b=AIOuqZ1Woed5nKc/8YSW6fKZ/zruJA3tmJ1UrysI4cVo4bCDMJJvu94SD/aTVjVs5v
         Rx3am4tX+1yC+dxtCJnCYPdRJW/JcuntntP9ttDf0D+7o+0ifw3cqtFkIK5fPGpheodN
         0NrRyOKTY3DZuXx81R/V1Rxza6rH4f2h4zrG0BcB/vgwGIdw6d+7ZZHwUDObvvpcXwIv
         ox24MJ/WeoO79gNv0wXQeyXN/THrTUrk3iYxEmj1ADs5JKMOBGahbPInJt6cZr94E/oU
         SUheieEZ93ADTEPLHYlCJQxu33rBaO5EK2qKeiprBXD0ODH3PL3UPQIDNfpksrIYjkzj
         ujDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809790; x=1750414590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdjUCVpqPUm8ixGqf+F8dk8bdPFxFedEDIckenWkGiA=;
        b=M6Kkwjigpt4yPr/NJnsWPS6zF2xSQIZz46WaON1fH2ek0XSMPVpFeiMwYVmwaDOknK
         gsfq+0K47QKYOTQZ7UB2kXI0TYviYPgSBbsw0JmSaBUGHQzBt+ZNyNNN7StatHSSReFP
         vRkRLO9x2M7mAegVVKBwDoNqLg521UE2cVc7/g5LguwujYJBhp/ZPKh+lKKjJfsefRuP
         HWZ9xcGp0pE3QjzFLQinpOdDW0eQxcI7Vdyg+HrSkj3Mhz9rXBTJXkGK6glsv6w8MyCZ
         Dc6l874mSAuGlNXA102+voXglurZqSMjerjQwe8Ig8bLHpT3UsC4W2hA04g8Hsy+TRzw
         JP6A==
X-Forwarded-Encrypted: i=1; AJvYcCWLKZss+NJv3ZR27I+7u+tB/Y3Oav9zRhrx7GuDgTBTz0dASAHLZMKtSrfackHLV55QQq4FP31y@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzf0OXEWSSSTDpHV8ancLXKXd76kx0V9aSW6+YtwY+hLyUu++TJ
	+uCpxIrX8PyRCq0G6VHj8MiUZ9R6IFXlYp70hKQSvgr6hg/hGNzNPpL+96HMuvZdyfA=
X-Gm-Gg: ASbGncsBItnL+l4RppSbvQc4DWYVj9tx0SGIBgOJ0bUmCEJQT2y8gRYZururQZLEUWv
	ltecJ9219LE4Q+uhxVkc4bO1G8Y8vNMCnVMMw9vHSMG2PYE0L43hyMB6NIG6xVOC+Rh/8t0n30m
	B7E+HzA1CwaciA/lXrNYK0ikBe3dgW7ioRU5x31J1e+vk7DBetOs8Vbcc9plOVLBOtDKfr3i9iY
	cyj4jcLbLPvq/r71mf/KPZmwvNH8zooLeGnj+phS494gXscwn1eXQFNCIjK8NLEjaoLyxFcyj1C
	nRPk2TmAWW3A+44RL1ttrRIFOiwO7JS9ufUN1X2Pjg698WyuFhJsbetJDAq3Qbi/WWznUdZqQEM
	FKKTddkC90SSohyxn
X-Google-Smtp-Source: AGHT+IEaqK4JQkwa5OuCohg1y22PQC1ylK916FumqT4LYVzs1LuFG7GAee9xVJHM2Nz1AKKsADn6WQ==
X-Received: by 2002:a17:906:7312:b0:ade:2e4b:50d1 with SMTP id a640c23a62f3a-adec568577cmr249869166b.29.1749809789754;
        Fri, 13 Jun 2025 03:16:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 13/14] arm64: dts: renesas: r9a08g045: Add ADC node
Date: Fri, 13 Jun 2025 13:16:12 +0300
Message-ID: <20250613101613.296649-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19082

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 78f2c089d0797fbf677a415aeeba8061b442027b upstream.

Add the device tree node for the ADC IP available on the Renesas RZ/G3S
SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241206111337.726244-15-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 1707d47a09df..d1e228b439df 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -191,6 +191,59 @@ rtc: rtc@1004ec00 {
 			status = "disabled";
 		};
 
+		adc: adc@10058000 {
+			compatible = "renesas,r9a08g045-adc";
+			reg = <0 0x10058000 0 0x1000>;
+			interrupts = <GIC_SPI 312 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A08G045_ADC_ADCLK>,
+				 <&cpg CPG_MOD R9A08G045_ADC_PCLK>;
+			clock-names = "adclk", "pclk";
+			resets = <&cpg R9A08G045_ADC_PRESETN>,
+				 <&cpg R9A08G045_ADC_ADRST_N>;
+			reset-names = "presetn", "adrst-n";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+
+			channel@0 {
+				reg = <0>;
+			};
+
+			channel@1 {
+				reg = <1>;
+			};
+
+			channel@2 {
+				reg = <2>;
+			};
+
+			channel@3 {
+				reg = <3>;
+			};
+
+			channel@4 {
+				reg = <4>;
+			};
+
+			channel@5 {
+				reg = <5>;
+			};
+
+			channel@6 {
+				reg = <6>;
+			};
+
+			channel@7 {
+				reg = <7>;
+			};
+
+			channel@8 {
+				reg = <8>;
+			};
+		};
+
 		vbattb: clock-controller@1005c000 {
 			compatible = "renesas,r9a08g045-vbattb";
 			reg = <0 0x1005c000 0 0x1000>;
-- 
2.43.0


