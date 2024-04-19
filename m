Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DC4C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:51 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.18470.1713526781099374375
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JdCoJsEe;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.175, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso23370481fa.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526779; x=1714131579; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0P4MilH8HeacEUTK1YzrA+vB9TPncTu4uvr1g9bwmk=;
        b=JdCoJsEeEIQoUsokEaM4+sxegQ9KMuwbATcAyAOTHFk20x6/E5YjQsv6bVw2HjgFX3
         OFFQ9S1l3igLFkAzakwxXenPDA+mn6imiocXBIUOrRZNclnub19sDW+dyt70DWRKmGiS
         BZ5QPgPeKdP688bSwMCNsiv8IVupBVF56xa5Usid9Le/66rejMn91FPm+6pPd+j7c3P4
         Cyx/WrhJPaOnnyqmykzH218KRXy43EEGi6oEkGvwkshyUORPdbDt6K/YJwXyQUyKBNA6
         Bir0zIue0tfcCmI7iao9/D1J5sGkleX6G5nvhZ+wg1kfbMzZlqnlEFo+JUxlNFCz+E3f
         Ui2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526779; x=1714131579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0P4MilH8HeacEUTK1YzrA+vB9TPncTu4uvr1g9bwmk=;
        b=ATTQ/N9D9wDHScVGvUr+VWHUJiU/IWHEMjaAJcDWIfOmVEZX6daGYyLX1e73quqUGu
         ekK/zXESzN1iXmWxzMhVnnocv/I2qNQ9AAEeKXCAKYW5FDkX6Q6DzTN5TWJXB8+lUzvC
         chU7S5eFPmkrpF9IDXUYpzDtI2mjo3Fk6GujZ/mg37PnsTDGhBIMwVgjJgt1IrIODTxo
         GfM3tx7Xae2vPczBn0FYrcpL5TxEt3nstmLgR/Y+mT7EepzroRjsWhBzRZTq16MnsOpj
         EztR270Qy1hRsMD52+zptnUtvdLDgJV624FSy4eMpvKJHvH6DSkSlvR1cObfStyFNSH/
         CNFQ==
X-Gm-Message-State: AOJu0YyhwptFU3UC3ft/evc/1ZlfeYRxwVOtEAka7NYOBtwVNefjiqvh
	zmQc2lx3vzWZ8iEJUtwSLwwDLCnXZTUlBPknwGTDuD1VRB1bqiDpnPgY+ZTD+p4=
X-Google-Smtp-Source: AGHT+IGw2mBYqTPWtKJVroJApLQwIQoP0b3+aR6McIPhxY8tmP52xg5ueDTRSpqR/BQu5SPwiXZN8A==
X-Received: by 2002:a2e:9a95:0:b0:2d2:869a:55af with SMTP id p21-20020a2e9a95000000b002d2869a55afmr1089287lji.17.1713526779357;
        Fri, 19 Apr 2024 04:39:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:38 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 37/44] arm64: dts: renesas: Add initial device tree for RZ SMARC Carrier-II Board
Date: Fri, 19 Apr 2024 14:38:35 +0300
Message-Id: <20240419113842.3675543-38-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15688

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d1ae4200bb268fda8cf885e053306c2bd7deb62a upstream.

Add the initial device tree for the RZ SMARC Carrier-II.  At the moment
it contains only the serial interface.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-26-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
new file mode 100644
index 000000000000..e7073a09ed2e
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ SMARC Carrier-II Board.
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+/ {
+	aliases {
+		serial0 = &scif0;
+	};
+};
+
+&pinctrl {
+	scif0_pins: scif0 {
+		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* RXD */
+			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
+	};
+};
+
+&scif0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif0_pins>;
+	status = "okay";
+};
-- 
2.39.2


