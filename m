Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDAEFD709F
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:56 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73452.1773746270768135493
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=N1ZMNIBi;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so65602665e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746269; x=1774351069; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XToOWv+452vYLydqdmnWLFiKK3HRu7vsccAAzvbElgw=;
        b=N1ZMNIBiW/EO53pdmpSf7BVCulj21gixLE/SZMpPobIQ7oucsD3H1ufHeqCzxT4OAG
         UTh6hn1gVGZ+f57sCEuUMldyYisx6Sk3hwLq1nMGEeakuCdadcdcvSNSHm1UvqY4rbHy
         nldy4rO436641/NDT9UtPEijCKsG/qjECXfvWT6kUnsdg5tQUPVgwevkNuvq7bOVbxpS
         VrG1g9clp80kg/w2wuQax5SnwjhMs0wOugz1Ds6soxzToKSafHlMxYIBaJwJIwt++kNU
         ejy8PhQiGPMRfRYqADlvJBHq6imIihIZbd2RU/U929RmqWqMmibpv/eOJc5+XuvUCXHg
         bvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746269; x=1774351069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XToOWv+452vYLydqdmnWLFiKK3HRu7vsccAAzvbElgw=;
        b=rJQ8rr2vt0iKfIjifhvEnkNk/IA7QVDoSLJXNOlLjA6lJrrosmikYIa/8XbiysauMe
         GkGSn4r3P/Ee+UDfiXRN1KxugNg3BCLNy1vliYCLUdKKl3ofrSQ18CcHCQ8mUHlsBO+/
         w40TdIHFQaCu2ZZiPeLDfOmYoqClUy0HpkrAFlwD5LT6llKCo7rDNLaLArtXb5edj7wr
         YcdmAUk8R619uJf1h+KfC0ydiEIbeneIKI2FhYFF5nT7hsL7H4QJ/CS/T+yaa3ArQ+tf
         WPqgpjgbJ2Lc38sqkqzsR2rdoqY7PKbCZzG4FCfv5NS0dAq/su8oDyE+lRCafpoNiUZ/
         AqYA==
X-Gm-Message-State: AOJu0YyipM2K0depSwH+L5TEy5LcLp2B9dFn1qaML6jTR0N0Eh4kjeit
	tRkk4cErutuyl2UTm+o1hr/zSkQQBWejO4mRuv1GxCQAo987nx2PuGl9uVpulQ==
X-Gm-Gg: ATEYQzzp15R8hVNjs+NU3YicbHnj+1u5k4l+uHlZ/a3lRvuk0nIJwXu4A0quTThzA+A
	UDHyWX+psrCcAgMetpOElFIH9XQEBinIGywfEXM5ipdQmBnxJo8eOmBcyggUabftixg/6OhsKy4
	jR4db99wm11kGT7V4ABhHZgATF7yw45gPGXds6NIx0HzDyAFFoT6+3U+mogBbGr2H7g3OAKUWlq
	j0cq4SFKMx35PaQ7SG5n68/llZOZ94P9nmDj76U9EcEMiuYL8skK6ClwoCRmzqsR+IAtQ6iZMI8
	ltYih4BjCcsvZdbpb3I/gaNv9N8M17alpPBmc/4ityJBKJ7HkixKjVDZCPFwuyuPwqtbCUDgirT
	MWkAMWqEKc22/TMiVlXlewokb95xmfjwroCNCFjKaYZ8g+i/lB2bHiY8k1snEyub5gjb49LQpOT
	izVBIHbD15Ue4DB8k9KVmnVrvYDtUcWl7yamfQZA343RDM+m3W
X-Received: by 2002:a05:600c:a45:b0:485:4006:960c with SMTP id 5b1f17b1804b1-48556702a7dmr294708285e9.16.1773746268705;
        Tue, 17 Mar 2026 04:17:48 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:48 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 37/39] arm64: dts: renesas: r9a09g047: Add RSCI nodes
Date: Tue, 17 Mar 2026 11:17:02 +0000
Message-ID: <20260317111718.281633-38-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22470

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit ef601dbb5b80a0240dc479ca0aa5fbd746f23ca7 ]

Add RSCI nodes to RZ/G3E ("R9A09G047") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251129185203.380002-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 220 +++++++++++++++++++++
 1 file changed, 220 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index bd15725f2c22..addcc9ed8661 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -591,6 +591,226 @@ channel5 {
 			};
 		};
 
+		rsci0: serial@12800c00 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12800c00 0 0x400>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 116 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x5d>, <&cpg CPG_MOD 0x5e>,
+				 <&cpg CPG_MOD 0x61>, <&cpg CPG_MOD 0x60>,
+				 <&cpg CPG_MOD 0x5f>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x81>, <&cpg 0x82>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci1: serial@12801000 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12801000 0 0x400>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 122 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x62>, <&cpg CPG_MOD 0x63>,
+				 <&cpg CPG_MOD 0x66>, <&cpg CPG_MOD 0x65>,
+				 <&cpg CPG_MOD 0x64>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x83>, <&cpg 0x84>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci2: serial@12801400 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12801400 0 0x400>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 128 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x67>, <&cpg CPG_MOD 0x68>,
+				 <&cpg CPG_MOD 0x6b>, <&cpg CPG_MOD 0x6a>,
+				 <&cpg CPG_MOD 0x69>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x85>, <&cpg 0x86>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci3: serial@12801800 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12801800 0 0x400>;
+			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x6c>, <&cpg CPG_MOD 0x6d>,
+				 <&cpg CPG_MOD 0x70>, <&cpg CPG_MOD 0x6f>,
+				 <&cpg CPG_MOD 0x6e>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x87>, <&cpg 0x88>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci4: serial@12801c00 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12801c00 0 0x400>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 139 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x71>, <&cpg CPG_MOD 0x72>,
+				 <&cpg CPG_MOD 0x75>, <&cpg CPG_MOD 0x74>,
+				 <&cpg CPG_MOD 0x73>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x89>, <&cpg 0x8a>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci5: serial@12802000 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12802000 0 0x400>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 146 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x76>, <&cpg CPG_MOD 0x77>,
+				 <&cpg CPG_MOD 0x7a>, <&cpg CPG_MOD 0x79>,
+				 <&cpg CPG_MOD 0x78>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x8b>, <&cpg 0x8c>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci6: serial@12802400 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12802400 0 0x400>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 154 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x7b>, <&cpg CPG_MOD 0x7c>,
+				 <&cpg CPG_MOD 0x7f>, <&cpg CPG_MOD 0x7e>,
+				 <&cpg CPG_MOD 0x7d>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x8d>, <&cpg 0x8e>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci7: serial@12802800 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12802800 0 0x400>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 157 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 160 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x80>, <&cpg CPG_MOD 0x81>,
+				 <&cpg CPG_MOD 0x84>, <&cpg CPG_MOD 0x83>,
+				 <&cpg CPG_MOD 0x82>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x8f>, <&cpg 0x90>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci8: serial@12802c00 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12802c00 0 0x400>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 163 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 164 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x85>, <&cpg CPG_MOD 0x86>,
+				 <&cpg CPG_MOD 0x89>, <&cpg CPG_MOD 0x88>,
+				 <&cpg CPG_MOD 0x87>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x91>, <&cpg 0x92>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci9: serial@12803000 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12803000 0 0x400>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x8a>, <&cpg CPG_MOD 0x8b>,
+				 <&cpg CPG_MOD 0x8e>, <&cpg CPG_MOD 0x8d>,
+				 <&cpg CPG_MOD 0x8c>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x93>, <&cpg 0x94>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
 		wdt1: watchdog@14400000 {
 			compatible = "renesas,r9a09g047-wdt", "renesas,r9a09g057-wdt";
 			reg = <0 0x14400000 0 0x400>;
-- 
2.43.0


