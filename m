Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A27BC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:40:01 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.18476.1713526791442206673
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=OUG4axSX;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51967f75763so2183808e87.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526789; x=1714131589; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhGnexjjrSUz4tSsD3nUG33MJNdufwhBsCqIhPflCFw=;
        b=OUG4axSXFWMKWyWr3LpOeEFG4+LxPGbiQe9tkTewPEqHP6g2/iEMYI4Ix1y0arc4ge
         kqgRnS8n+eJ12YLTVpgPd6vBvig8fs03P0Qwjb6Td9qOmEf+FlSY2lkEHlRz6CTLI6e+
         45jmNGvz57rUnFrkXzI+JgGbUYLr81Eihe4NogKHeDwOUJcD46NBiW1k6he8cBxpdaiB
         TRWAxTXzPWl+c+LkJrYV5PAPICdQXRp3fkIIJZXbQFrUeb9iIfAhmyExJVTNYRUt8U/W
         z4fJLc8SP+R1vJes1nzQ7baH+5+nt0+tKzmpK2TnmwOAwij4yBjLGIedtGBO5B0VVJrw
         fruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526789; x=1714131589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhGnexjjrSUz4tSsD3nUG33MJNdufwhBsCqIhPflCFw=;
        b=acSs63GleBN9cZ/JFUlcmf2PxGsxpwyrUW+o6wG94hI/Sp+FnNTpr7JA8J/Mk2S+op
         gAaZAwDK96OGmfaD76SkYrelSFIfHw95CDwFlT0TQoF5yvDLDcLlkk+8Xt3xseUsIJva
         5tI2Um+dPKXURStrn6QisL5HQtg8runXplcekFlOF2sYpwTsEMFKQ6JsnHYQn7dYJJV1
         QoKbzGiSMj1rORXPAGKteXYLRUjgqcGIfP8thAI0Rft4c/uCmjyzTy5SZ4BJp5X6PDKK
         j8uUZqoIsLGh+SfXXgg0Lk7HtdWBbc1lE970OcISmiqIRwbduztnwd3OjFYI5JGKHalV
         SI2Q==
X-Gm-Message-State: AOJu0YxrFsTyOYIBArDSzNePqAtGGe++0rqhzVLlxzgj6IBwxf8wp2lf
	B96GbXs3iwsH1lJGoZaQy5C5vk93GMvrGF7bbGAH41oSDz8lCx1WJocV5h1wNn6w2pmJh/T0tXE
	7
X-Google-Smtp-Source: AGHT+IFNYxnP+e/5/Dfk/MT0cFfYl33K10N/nQTS17zguPVZTy0E0o+O8cZxYWTyeUWeIC3zr2FNkg==
X-Received: by 2002:a19:8c18:0:b0:518:a9bf:73ec with SMTP id o24-20020a198c18000000b00518a9bf73ecmr1133145lfd.35.1713526789574;
        Fri, 19 Apr 2024 04:39:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 43/44] arm64: dts: renesas: rzg3s-smarc: Enable SDHI1
Date: Fri, 19 Apr 2024 14:38:41 +0300
Message-Id: <20240419113842.3675543-44-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:40:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15694

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 993a207c114e137159c8d255576badfcd9defba8 upstream.

Add SDHI1 to RZ/G3S Smarc Carrier-II board. This is connected to a uSD
interface. Although Vccq doesn't cross the boundary of SoM it has
been added to RZ/G3S Smarc Carrier-II dtsi to have all the bits related to
SDHI1 in a single place. At the moment SoM is used only with RZ/G3S Smarc
Carrier-II board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231016105344.294096-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 65 ++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index e7073a09ed2e..214520137230 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -11,6 +11,26 @@
 / {
 	aliases {
 		serial0 = &scif0;
+		mmc1 = &sdhi1;
+	};
+
+	vcc_sdhi1: regulator-vcc-sdhi1 {
+		compatible = "regulator-fixed";
+		regulator-name = "SDHI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZG2L_GPIO(2, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi1: regulator-vccq-sdhi1 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZG2L_GPIO(4, 2) GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>, <1800000 0>;
 	};
 };
 
@@ -19,6 +39,38 @@ scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* RXD */
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
 	};
+
+	sdhi1_pins: sd1 {
+		data {
+			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
+			power-source = <3300>;
+		};
+
+		ctrl {
+			pins = "SD1_CLK", "SD1_CMD";
+			power-source = <3300>;
+		};
+
+		cd {
+			pinmux = <RZG2L_PORT_PINMUX(0, 2, 1)>; /* SD1_CD */
+		};
+	};
+
+	sdhi1_pins_uhs: sd1-uhs {
+		data {
+			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
+			power-source = <1800>;
+		};
+
+		ctrl {
+			pins = "SD1_CLK", "SD1_CMD";
+			power-source = <1800>;
+		};
+
+		cd {
+			pinmux = <RZG2L_PORT_PINMUX(0, 2, 1)>; /* SD1_CD */
+		};
+	};
 };
 
 &scif0 {
@@ -26,3 +78,16 @@ &scif0 {
 	pinctrl-0 = <&scif0_pins>;
 	status = "okay";
 };
+
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-1 = <&sdhi1_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&vcc_sdhi1>;
+	vqmmc-supply = <&vccq_sdhi1>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	max-frequency = <125000000>;
+	status = "okay";
+};
-- 
2.39.2


