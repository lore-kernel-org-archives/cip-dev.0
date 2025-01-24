Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B11FC3DA4A
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:21 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.7428.1737709218516165697
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CAY39Jcn;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43626213fffso18866945e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709217; x=1738314017; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TDhDVdmrLyUjwA3Rd9ZKV50+C7dveaBYHkQzItSHlw=;
        b=CAY39Jcn4PECHGAqpXOZDJYI7NlQT2LqRFxQm16UqWC08yOBVQcMZum39CpWnEUuOK
         VQltYuQoFcot3ZXfTHKP4Y93hXPbFnFyFeQLHGlMoErSyKipmMa2EcNROaKsZhadHmES
         M5EdKxv7wpGeg1maAR2d8A1MOR4r8boYMxT2iaYdnNLjnU4st/0PWLER+0dGYt0bGAdP
         czADYfUvBB+Vnn4B0bsVA7KWNp30AouojcgA6faCsOVHvOMtx4d8SpcOj51NnQwSRc2L
         SwLIDo3hThf3yHWfkn9SID76thTs+LxCxaEeDaR5u/rlOmtC3Utos36AU8ugo5QQpdOO
         cQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709217; x=1738314017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TDhDVdmrLyUjwA3Rd9ZKV50+C7dveaBYHkQzItSHlw=;
        b=EBgyNYhWa/3ZMpPG4l0//Z/n8MxqW0t4r66+AsSLnVJZr8smlJXw0AbEIXpp0mJptx
         mIa6yH5tcnIUGBQ3BlU6ROYOfUMUiJeAAzUmecTsqlL/P/IvZATGa7pdStIshTUEJNMR
         wTTj6WmrgyZ3CVaBvgqLBCdzNv5Se/gEiyE8su9iMqTs2I9PomDLiLTjcS+dqDVu6O7R
         uJ4RrvQOzGfjGt7cS8Af8MjdoCnpfxHqUZgZxbkEWu+mPZQvVpKCNvZWNl+Tnm4pdC+Q
         TyuLtsMEza2Et4OI2v8qxBRhBrJVr0+laUw8Lqrpr9HOgusGk8eKHOdE0S3zd0vTnObV
         hY2A==
X-Forwarded-Encrypted: i=1; AJvYcCX6nZqrAtYGsFtoK5p8RF7yPPRQCJXSOekPbIzC1MKGrncTEYGyN/k7vMRCe85+VlE1hnE5rT8+@lists.cip-project.org
X-Gm-Message-State: AOJu0YxTrk7FEai9QGYtgFyx1miTt8Mjzh24AktC6R5QJ/IJxyG2ftqq
	dz9DpvPmhfRBbqfW2PPAWWOr5Hv7YV2ZqBMpZP6kIA+28145ipVTkjx2is1wEAQ=
X-Gm-Gg: ASbGncvWFen9N2sThfzac82aBLMnL/QigtTQR91FIZbJX6VMgviOJ/rvpqjekJtPt1x
	YWt/dl7ye9zLrWH3noxnKBwQ53Tj6JLkgSkqJ7RwGGKFx/FabuuhfgF3I1KR+a3ZTBin35UCXTk
	xYbECsgbqcAu4krYqiOi7e83YxxcXDDoF3bKmR099QrJ+1dTruZ47L61HRcQkHmygcp3N5xl//3
	DHmql2oamZJsg4T1SOyXKbakgBo3GI0DpqGlze7pdyInlauyEqGgx6VATgzzNVIXXIQLwf8srFR
	OykmRxNxOqD9Qzy0rgRqr0yCWyt70CSd2g==
X-Google-Smtp-Source: AGHT+IFbC4rrkRzV4tb2RJqY3VvFxwkG+AeY3BcKVTOyktVlVCkteJWbxbibIejysSCa3f22wxQ0rA==
X-Received: by 2002:a05:600c:3b87:b0:436:2155:be54 with SMTP id 5b1f17b1804b1-438bd052e25mr20984545e9.1.1737709216962;
        Fri, 24 Jan 2025 01:00:16 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 05/14] dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
Date: Fri, 24 Jan 2025 10:59:56 +0200
Message-ID: <20250124090008.1401077-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17627

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cdfd5daf90af8363fb1f58e08c829a775b2e2fc5 upstream.

The VBATTB IP of the Renesas RZ/G3S SoC controls the clock for RTC,
the tamper detector and a small general usage memory of 128B.

The VBATTB controller controls the clock for the RTC on the Renesas
RZ/G3S. The HW block diagram for the clock logic is as follows:

           +----------+ XC   `\
RTXIN  --->|          |----->| \       +----+  VBATTCLK
           | 32K clock|      |  |----->|gate|----------->
           | osc      | XBYP |  |      +----+
RTXOUT --->|          |----->| /
           +----------+      ,/

One could connect as input to this HW block either a crystal or
an external clock device. This is board specific.

After discussions w/ Stephen Boyd the clock tree associated with this
hardware block was exported in Linux as:

input-xtal
  xbyp
  xc
     mux
        vbattclk

where:
- input-xtal is the input clock (connected to RTXIN, RTXOUT pins)
- xc, xbyp are mux inputs
- mux is the internal mux
- vbattclk is the gate clock that feeds in the end the RTC

to allow selecting the input of the MUX though assigned-clock DT
properties, using the already existing clock drivers and avoid adding
other DT properties.

This allows select the input of the mux based on the type of the
connected input clock:
- if the 32768 crystal is connected as input for the VBATTB,
  the input of the mux should be xc
- if an external clock device is connected as input for the VBATTB the
  input of the mux should be xbyp

Add bindings for the VBATTB controller.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../clock/renesas,r9a08g045-vbattb.yaml       | 84 +++++++++++++++++++
 .../clock/renesas,r9a08g045-vbattb.h          | 13 +++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
 create mode 100644 include/dt-bindings/clock/renesas,r9a08g045-vbattb.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
new file mode 100644
index 000000000000..3707e4118949
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,r9a08g045-vbattb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas Battery Backup Function (VBATTB)
+
+description:
+  Renesas VBATTB is an always on powered module (backed by battery) which
+  controls the RTC clock (VBATTCLK), tamper detection logic and a small
+  general usage memory (128B).
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+
+properties:
+  compatible:
+    const: renesas,r9a08g045-vbattb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: tamper detector interrupt
+
+  clocks:
+    items:
+      - description: VBATTB module clock
+      - description: RTC input clock (crystal or external clock device)
+
+  clock-names:
+    items:
+      - const: bclk
+      - const: rtx
+
+  '#clock-cells':
+    const: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: VBATTB module reset
+
+  quartz-load-femtofarads:
+    description: load capacitance of the on board crystal
+    enum: [ 4000, 7000, 9000, 12500 ]
+    default: 4000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - power-domains
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a08g045-cpg.h>
+    #include <dt-bindings/clock/renesas,r9a08g045-vbattb.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    clock-controller@1005c000 {
+        compatible = "renesas,r9a08g045-vbattb";
+        reg = <0x1005c000 0x1000>;
+        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb_xtal>;
+        clock-names = "bclk", "rtx";
+        assigned-clocks = <&vbattb VBATTB_MUX>;
+        assigned-clock-parents = <&vbattb VBATTB_XC>;
+        #clock-cells = <1>;
+        power-domains = <&cpg>;
+        resets = <&cpg R9A08G045_VBAT_BRESETN>;
+        quartz-load-femtofarads = <12500>;
+    };
diff --git a/include/dt-bindings/clock/renesas,r9a08g045-vbattb.h b/include/dt-bindings/clock/renesas,r9a08g045-vbattb.h
new file mode 100644
index 000000000000..67774eafad06
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r9a08g045-vbattb.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__
+#define __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__
+
+#define VBATTB_XC		0
+#define VBATTB_XBYP		1
+#define VBATTB_MUX		2
+#define VBATTB_VBATTCLK		3
+
+#endif /* __DT_BINDINGS_CLOCK_R9A08G045_VBATTB_H__ */
-- 
2.43.0


