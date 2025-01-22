Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCD6C0218F
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:50 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.41712.1737546761453391369
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Mv6ZxM17;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4362f61757fso69879815e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546760; x=1738151560; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TDhDVdmrLyUjwA3Rd9ZKV50+C7dveaBYHkQzItSHlw=;
        b=Mv6ZxM176sGauquhQg/U7rD4vbWDi0xsu2qD3zvtN6ligjOawP2EpePbGhZcI0mCO/
         cEbzsaGyekijmRKvRA6ZHDTWqCoquZsI76Ab/ruMYTeNaerX5Ks/KmNavxWH9gHBxLC/
         ooVzNQElZifIjYCdvnQcclDfLrALUrkDcSDZJin0UsXckmlcK8Z9kW/phoNgUhxUxNUO
         9ew6VsBXIwPJZfYTXQaxUfoPKz+RdFb0U7FTT4hw29b5f3ZDIGa5DBMGWSqFCbUwIV1Q
         kgxyzBq4PkCtRQLhPM2KA5ZmJTK3VrU/gLUNvn17+Du/+PHJCx1oQNimLwlCNIokodxX
         V75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546760; x=1738151560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TDhDVdmrLyUjwA3Rd9ZKV50+C7dveaBYHkQzItSHlw=;
        b=WhmSYjShlEU5WmJG7de+fCPlEiA9yIK71qKXYh8LIqlXfNCbX6uet5+nuIpb4vMKp/
         2gVFJew4cplHzfMs8A2wenGknvAmifm8SHqqw7+BdAg+Dj1xB0ZfjIDi8Ok+ViHp6O+5
         btJj3RmIqBef9VNYgDVnonH5g1rW2Y4vorkwBastQpP9VbuXJ2D/CrJrsR6+CT9eAZPZ
         AoQkbIA7p3j41prDnspLs4EkKTDmYqYV1EmBmK1la2tdG9D2RRXlJxE84z5//jizLBQ8
         ykltfF4ZZCESjZQafhIkG/XDuqGfALbextuCKO+GKRbg6vVGIz8W9mUbRpuovElrGW4X
         Tbuw==
X-Forwarded-Encrypted: i=1; AJvYcCX3iUu6T5Xyj66jNeLJ9mi2AyZXShyoq4G3A7G95677kJn9UkCc7eyTvfXVQWJ12q6QZHxkTlHX@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxwrwc3W5RJOX6XIbw2LdhCdPYsHs6HPtUFmIB4/zYEgSc8nTqW
	xLWPmN3dZHOhb7VFbpVedggJKigyEJ5KP67kHcoHoThKkTrND+Yu7VDo3LC1uDg=
X-Gm-Gg: ASbGnctoYOa/cG+Am+QuHZJeVREmBPlaXLkW16VO2Wjhp/zIP1UZWOwaWVwK7GsPNDq
	eKmfQLXyJyv8s8DmJcC4jlC2afAacLHK+/oUQ/n2X6Z4jYA/pSIGpshIYIoQhhATaOvJGLaI3Os
	t/Hhd2D/p7xOudEXQX/ax3gahSxKHhySJNpYogMZQf59NlEpD5Eu+dlDNGfF315PK0bw0kNhmrY
	kvL/o0TMJqeaOcn9YOO1Thcyjs+5tlCzYpXIWcFwpJbYm0+a+eeMzBNA94MmGliJuQSXC66cGod
	nOOfZGRaiam5wIJ+uhGybtU=
X-Google-Smtp-Source: AGHT+IE8camX+bLd2Jf/XoZM7mN2ErTsszytxIIZe5yp9mipEPWFMMvPJegeP37nA5S52hEhdNqRog==
X-Received: by 2002:a05:600c:4e12:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-438913bdcd2mr179760515e9.4.1737546759861;
        Wed, 22 Jan 2025 03:52:39 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:39 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 06/16] dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
Date: Wed, 22 Jan 2025 13:52:20 +0200
Message-ID: <20250122115230.2885344-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17584

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


