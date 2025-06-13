Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A4CC71153
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:20 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.7076.1749809717247095073
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=U6rR50Mx;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad574992fcaso297806366b.1
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809716; x=1750414516; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1fIxfOQsb5k+rcIKqGxC4JEI2+jmqg4RxTXqvnUDcM=;
        b=U6rR50MxCIZ/UCdBldbAGXdvet4ex1kXpkWNPfutsJ6ejohXcmAa9ruQcbwp5VEdgx
         ejx+p9Q+fpoChXcw0g4DuezpTkyQ6VDyXE+A22kyXt7Jvvro7MTHOvcjqGd9CFSRHScv
         hAz7tnRa6Vu39TUS3tHJkF+LtawcLOnbwEC5R0kkIRHqEpttqZUWLbTOMdScCh9By1x5
         KBPOvUuOIZGME2Q0XUZpcldEaL+dpBIqqZ1LoBgzOxXYpvsaJTrqWJjuwfCdm+r+AO5z
         Ta46ZKKj8zeYQ49q1TGSs/Jhn9ahvO8R7QPv02LvklRDubfXAt1Q3Z5dO5UiGTIvhkyk
         153w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809716; x=1750414516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1fIxfOQsb5k+rcIKqGxC4JEI2+jmqg4RxTXqvnUDcM=;
        b=R6chB0MV/0rw31hdRkV58i28M5PFA9JMyOZUSQgQKZAM6bOhAMxeKNmLx8TdVLGf4u
         J/aGdOkF8azZZwp5Rucumo/F8GKWtAWIxEBFQn/OdzCHBydFgsjmARvtD0JugqPgugOi
         vAsISZp2oLUTzwaWXZooAJ0qi8natGPMVfkjhhhGJ9KUojSsyWHlimc8i1apMnamlmR/
         LUf78VqEfslkto14MT+CA+Jggfbe0VQAhW6MVj9JQTObHOGDS4Pp3q0yaZfrCxtxHc6E
         a1LGVcAMPQxEqtpnrcLW6pHk38JhnMmlPkiaOHeErsTjt+Fp7cmyEFpC4wEaBNuZRxld
         u1fw==
X-Forwarded-Encrypted: i=1; AJvYcCVddPiUSr9wt3KWgNQUbzvIXsnYbhJCOlJIa5NmxZeQHt9unA2umkIvGvHOJAT5XdS7ls90RTTP@lists.cip-project.org
X-Gm-Message-State: AOJu0YyjY20Vt2IIUWwKhaWJcgdlB4MaNCEAvkDvfqVmj36MHky1em9O
	5Lt1ODa+4kWT/Eigqcc4Y1REWXJmByFiYPfezBtKILXELP+qLgFWyFUvP4ggxlHRmJ4PCad5il5
	pGowM
X-Gm-Gg: ASbGncuJKvm8W4g+BwpNoDARG5HIjWx2k7xZ3F58nA6zd4XljVIDT49t2dwcOF+1qDU
	L2GSvLhJdl3plEUaZkykV+YqPOr9b/jgVlj6uJQrq8ShsuWFHbuDeIWtqGo6f84Ja2Vhv6Gw1eu
	GsW6EXo7tw1dfELW1BXb5ruXI3i/irXZxdyv8bTSxagpuquf1yNVGEoJknZKMgcGCv7rXsnZM/p
	vWMM2RV54Rvg1ynNqNM9+gsIkw9kWArofBCOxnGz1aFjdr3RGGzwzhWwkOXc56XILEfTnZrVTX7
	5W380jQf8WT/q1qLUv2uNx7FHgKkVKW+ASfZSBCVXDEnm9OwqC2pmWoyhSJCS0GN7wPLvl+ijSV
	EmllpNBOSgBQ+Vl5+pHHMvYeazEA=
X-Google-Smtp-Source: AGHT+IFJdiK7L490PIAOs5wTQl8Mz8it+tBHiSjmUwr1HSmWV5EqjhcWqZnHORxnUwYS20kSRLHCtQ==
X-Received: by 2002:a17:907:3d03:b0:ad5:61fb:265 with SMTP id a640c23a62f3a-adec5be1b4cmr206374366b.47.1749809715577;
        Fri, 13 Jun 2025 03:15:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 11/12] arm64: dts: renesas: r9a08g045: Add ADC node
Date: Fri, 13 Jun 2025 13:15:00 +0300
Message-ID: <20250613101501.262091-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19052

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
index 3a8ddfbe1aff..89c129f9c1c9 100644
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


