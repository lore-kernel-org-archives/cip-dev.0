Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE52C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:53 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.10267.1746783165416403553
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dnSIOb0p;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso3475181a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783164; x=1747387964; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4acHJ2fedLxmozibcgN4e+UQS8aCHGqoQDPAaHVTO4=;
        b=dnSIOb0pcC2p/SySYRQS+Y1COqg1CfisEk1kOYha308b9fa1n+uh5cpCZ4RF36uDP0
         Xqm1sTjyrSEOMdw7Xhg9cIH/ge0suSsNr9jeN708LvVHdLquoavj71MbIw5iqrgPFd9p
         IfIENZDSZKCrriMM96BCZpxvRG9nCJkaRYKhYCmfJj5/c9wnUp8C2KlcBOUVlJFvv/NQ
         OshJCLISwqBSK6RXaxUoT78gewoQaOgrrIyaOPLF9Lx1Zork0jLCj8K0lIoLnH9fQ4Is
         Fm99N+Ux/8hmBDCH2jt0hW05U/r8x2zTZe7q4/qsJnwIIv5UR5OkMgmdGS0dsy7Gjn0W
         cEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783164; x=1747387964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4acHJ2fedLxmozibcgN4e+UQS8aCHGqoQDPAaHVTO4=;
        b=EypwCgTN5Dy7p5XTCLB3Sls6ILFxHVbRDxwrYNURcIb48Ywgr/VxI6vEVaur/nPmVV
         Jecsl7NYhmrBeyhMQ+DWmFzYeKE+zlzChAmiH7It1zWqXfmRtRQaXM4KXFg4/Rii0tpR
         uH6MAJCLifWhk56sFv10M7MjjCNL6vAmFD/tGPdNB0ufUvbNejOt6PVyeUn1C1x89odM
         eL7ZRmNO4J7c8hQEWx+tKNj1862evbaGdFan8ihyUNPBvx+D9cA3v+DPiip6ixiG8IsN
         BjzsYTrJR4SUXIus4Y4+MfBADirsQ0gXEmapUHLpba+p4hnc2ceVE39A4srFLrqIR78N
         FFSA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0Wj2l0pXeIE7+yTqjMDon1UBUvtDR5wAGY1H27//TZSwaP2fS3PlxParyYSy+viFT4EvZAqv@lists.cip-project.org
X-Gm-Message-State: AOJu0YxXc3cEnLRFd0/K5G/TY6JYGVuetFXH9ZHCoUaOxwirCf7imgLH
	mQNJccKbE7LnPH2yif7qr4Fssq46gux2kG/npKKFTz/5LznsBsgY8YKfoHyDbkbrENpKiWjzRFf
	D
X-Gm-Gg: ASbGncu2pmI5c7FhBe6T4fkXBet8JJmvewFTlJnUXtbDAFDDAKg4Vfc/UflW28V4Vuw
	xfCowrpCJB/epVH27yXCOloKuT5zjR1OBKquwkOdCmg4RBrgArRXDN2ffBoEr8jvH3+n6g9IkJi
	QfX1Xj73I1iq2leyAFTMC7WnJrGN3sQ+bvYX98FmDLA1+nDzaU10Xw/LbHCU0p1fqplR0TMgE6i
	0VM+uldgKseWZPg4YPKed/X3BSW2Mi/ItvQ53tAgYDFGHz2axEgXBPJ+ZPTZZJm7KkMkzbKyD5q
	MR12cvodJdjpTsLcWzoj5YITJniQZs0aLQuxaNUxp+HHoZAbuS1+1rhrOUfnY3Kk7SHHTA==
X-Google-Smtp-Source: AGHT+IGZ/87MfNCk1EyRve5le6Lcz3Pz/ESGFhLBVEM7Uvsvp5DvWSWW6AkXzzCmrz+Ak1llP+q01A==
X-Received: by 2002:a05:6402:5106:b0:5fa:82a4:4879 with SMTP id 4fb4d7f45d1cf-5fca078ee96mr2121766a12.16.1746783163812;
        Fri, 09 May 2025 02:32:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 26/29] arm64: dts: renesas: rzg3s-smarc-som: Add versa3 clock generator node
Date: Fri,  9 May 2025 12:32:00 +0300
Message-ID: <20250509093203.4014750-27-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18813

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a94253232b0454ae3f45e2a941bbc0a1d5bdb955 upstream.

Add versa3 clock generator node. It provides the clocks for the Ethernet
PHY, PCIe, audio devices.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241210170953.2936724-22-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 204d126f5ced..cfbee7f0b4a3 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -87,6 +87,12 @@ vcc_sdhi2: regulator2 {
 		gpios = <&pinctrl RZG2L_GPIO(8, 1) GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	x3_clk: x3-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
 };
 
 #if SW_CONFIG3 == SW_ON
@@ -149,6 +155,30 @@ &extal_clk {
 
 &i2c1 {
 	status = "okay";
+
+	versa3: clock-generator@68 {
+		compatible = "renesas,5l35023";
+		reg = <0x68>;
+		clocks = <&x3_clk>;
+		#clock-cells = <1>;
+		assigned-clocks = <&versa3 0>,
+				  <&versa3 1>,
+				  <&versa3 2>,
+				  <&versa3 3>,
+				  <&versa3 4>,
+				  <&versa3 5>;
+		assigned-clock-rates = <24000000>,
+				       <12288000>,
+				       <11289600>,
+				       <25000000>,
+				       <100000000>,
+				       <100000000>;
+		renesas,settings = [
+		  80 00 11 19 4c 42 dc 2f 06 7d 20 1a 5f 1e f2 27
+		  00 40 00 00 00 00 00 00 06 0c 19 02 3f f0 90 86
+		  a0 80 30 30 9c
+		];
+	};
 };
 
 #if SW_CONFIG2 == SW_ON
-- 
2.43.0


