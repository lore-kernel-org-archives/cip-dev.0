Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CF1C71153
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:00 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.7108.1749809755656318106
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=iNRaSO1l;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso3723069a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809754; x=1750414554; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA+hC4g5j7ph+nGLwg0OzXKEPzN/QyBeFp3OYOMdiC8=;
        b=iNRaSO1lVLxCDQ8BsBJnUT/b8LAnoS8gGxygDMu89isc25idZ+h4qtFnCDcnH4/7Tl
         RmdbIctCfmX9pKf/grN16JxnpB9ENi6xVqOL46InwfAh0lcwow62viT96h1PuX7rm5Fd
         71K8pdtMrZvYYIk9sQpSew7//oyuToo6Z5kuMyvWjJuG3ucxHEzaYjPxWJw1n+2wiFHV
         ChpYGZ1bszwCrImixLojaU41VGKPcR2G3bj16UDvxd4DFKa0/eRI+idPGbO/dBrDdYk7
         9aNUQZrx/uS1/LI84WX5RRBw1JuDqaFUmTqcS/gxD+fZokqQokMNpsj/VCNywEHaiStQ
         MWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809754; x=1750414554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BA+hC4g5j7ph+nGLwg0OzXKEPzN/QyBeFp3OYOMdiC8=;
        b=QCC/DqgHv8GbNQ/HQdwYaYxQmMorJlGpxIcIX87ZyeDj26Lbf32fWJQm6/VE3QUlsP
         IHzLfjpOky72MogL8FdLTo5GrJ+zEsp+1jAsjVX+YM0C28tY6J6E1Q+Pw9NB5toLRVLq
         MpwAPfIa9fx3JwPktmSAae3rcN/iMT/0QQPmcO78Zxtzt8qkEyb+tHaMzxNwzR5KPbVK
         vn52HJ2h2whniVFlytSK+NJvwUK35gsuz4T/HQC45+/LGo9u/s7+jF1GdKTi8Mdpv9gA
         QlLiRINzsTrx4XksD0STWP2vyHotjPMcZvPcGQAjWfmB07STcMW1SFt97NDmv5vIxS5k
         fZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXwn3LcAQ930e9+plN4EEWwMhsk1p+Fe88ZGGrsMS1MMH7dDsv1TvHkppaOFUFIBoO2CuigIvd0@lists.cip-project.org
X-Gm-Message-State: AOJu0YyOwVDoPXR112ig1Kl6479FAWl9Ai1h3ioFVF1ZMJy3y4GcmtTe
	X3ZnmyDmbAG/fiZbfm+tTElodD9WWCViihjTdRFk3/yVb6WMCX1Qp8W1jWtKAIH+LV4=
X-Gm-Gg: ASbGncsZGGAgbP0qUnESvX3sfuDZNbt8jxYa01Fjjoy+TSxTvgNP/tVcRVbE28z/w7O
	S0HfNmjYExZlE1HRNN+S0S0mwVIJmgSpRRtybqBe5DYKa25QVq//BXF6SRkXwFRRrWPckdqGsBI
	kqh2LCnZ/G4oZ+LKepmW8z71ppj6z/cHsWEFaSBQSOD06stusDCFLJsAhdM8Th09RWgVMVOUTHd
	ZhcIX9omqCxWAkmJDRmNhWtd5kXjYy6Ohv+a0/niME9WBcKU1i9cjJIWFXiDDBcOHD3eiyx4naC
	6AmZ2lB8MS5D8if3NAz7IlVWq1kS1ZBfIoTpI2L/ThrseMebwkanMHNVopclNdX2tXhHwct/GlC
	mQmQxTd33+/rho2Zd
X-Google-Smtp-Source: AGHT+IGhR2jKmXqCB1EP/8Dr5wbrX/q4frmgtDVGvharAudDnSi/XofShpKbB+GONQL3+MQzo1ycBw==
X-Received: by 2002:a05:6402:348b:b0:607:6057:9006 with SMTP id 4fb4d7f45d1cf-608b48f79a2mr2172492a12.8.1749809753994;
        Fri, 13 Jun 2025 03:15:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 13/14] arm64: dts: renesas: r9a08g045: Add ADC node
Date: Fri, 13 Jun 2025 13:15:35 +0300
Message-ID: <20250613101537.279131-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19067

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
index 5634eff1e921..55ee6195bacc 100644
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


