Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE39DC41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:58 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.15290.1713514735618631007
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=iP45R4Mf;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a557044f2ddso175617866b.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514734; x=1714119534; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0P4MilH8HeacEUTK1YzrA+vB9TPncTu4uvr1g9bwmk=;
        b=iP45R4MfAFAZRt6EbxVdEupZQVSaVdXXjGMm9k/Z3e2tpCVeZqq3AsKhyqTc192Yy1
         ecFhe5up9rIyVCKql+KWC1criG5NtJorNhMT4h8YbBDpSV1Nf0Uk5KRLaiBj7MjRL6dT
         YdFVLfX1yko6Zss4A+r+1uuAXZfVtJpaBJHcpUGl8loAu/CITY4ogkgoAtVc5P9dTJkD
         pfuO1voagbK8rpS7cCdwBubWRS4oa57ub1h6fhxtj2rcgeUBL7lWH4dITFDIZtvL8GvN
         eRWEZ4YvNKtv2DMkycsYlpSws1hRzazAeDVVBvc1/dXrzWS/Xq32b0oHxnAxXR3R8/v+
         Tu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514734; x=1714119534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0P4MilH8HeacEUTK1YzrA+vB9TPncTu4uvr1g9bwmk=;
        b=Xf9YnZ7hZEyCQftrrtp5pN70Wrgc64AwhjakR+Naadq6a59lw23MCyQa8wh3nKhlJd
         0P04CLxJXT9qJgYTCBd39qq5wosf6xiCTXYnSuwB3AjSaFuN60YV/oN6WsJwnAngbfe6
         JGnFH1JXGlrx8QfXy/kNi+qytgdv6kxspHMLREcZXOocbkoxx8lRd9aoKN4XQBMSkocO
         oahPKF7YQxC+/Lrh3GD0NQCzmxPY8GPRPOKPEcOI7+dR5q++6WgGPZnwltURkbjZAaf+
         8kpAm7Uv5brDKoU5FG39y72+HEBATutYP9wJ2HMf/2vhs2kuIauLtB7e1UNEMAaNz7Ix
         LoVg==
X-Gm-Message-State: AOJu0YzCiks7VtKo1u3lP0Zto8RuDOSTOC0NvVUaN+GGJXaaJRyA37d6
	unHpZDSQgUou9A6bqu9OvbpNcuy8WqfRHC9/T+JHnPryy5njJUo5ggmQLFru/mBIyBGNSQdRaWE
	p
X-Google-Smtp-Source: AGHT+IGZI7toydTlVy/Y/rZ9aEHb8MnLsEQbmRn48LEHs+BRGhZzZ1AvBxnb/YWY9CT4UoWB+jBVvw==
X-Received: by 2002:a17:907:2dac:b0:a52:6fcb:100f with SMTP id gt44-20020a1709072dac00b00a526fcb100fmr1318901ejc.12.1713514734062;
        Fri, 19 Apr 2024 01:18:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 46/53] arm64: dts: renesas: Add initial device tree for RZ SMARC Carrier-II Board
Date: Fri, 19 Apr 2024 11:17:35 +0300
Message-Id: <20240419081742.3496709-47-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15633

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


