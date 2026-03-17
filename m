Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B5FFD7082
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:33 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73574.1773746242721092053
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lKJGGvgH;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso50008065e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746241; x=1774351041; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhR9brLyOO9/YFfAeCYjyAxp7+UOce6LVBh+8y8J5cA=;
        b=lKJGGvgHCh07iowf0+U60/stOvLyjEce8QERI8SIpxeRFl55f1ZMpcntcAhGNvAn7r
         nqSlpcV3ds9XLQLcACr6uOADg3ujnaMFKagnoeW+TWTXtChaXX6D2PuJrjIG8fJvTw1z
         GXMfbxxZc3xiEjxa6WOBCqUnQsfLu2LRzfMpAv7Wcco2IHA474nrK7uuGu65mSllKYbH
         /2jndkzO8UUQxhJtQCzsbd/3ZlfNux6dX2+61Xr+okkRu67e1gXfB75WsNa9hplmQnsd
         Fi22mkmMvPGMxtOgdaHvHjl/zu8RikhFYFWpa/L5ETjwiuta88WLHVaRf5dUg9HDuxJy
         vgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746241; x=1774351041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhR9brLyOO9/YFfAeCYjyAxp7+UOce6LVBh+8y8J5cA=;
        b=mibtq/DdiAbNKyPLyoUIXWHcOxNBur9RykB/GWos4tEykt9wLSng2FyALCRY0Wh9Hv
         CoNBGZtnvHIe2nx0CoaO/0HRyaZfFwzL5em6bBMSNtXtuQc8wEDsSDrgxaTE+75itzwM
         zEqbUBTxLdipm72gggOmJ2NJMIdJGkVAdO5dw3V6tjwR+S7UQx/gnqaoXM2oTPkT74h8
         KJjAmhNSYPlOJsgrn9C5BcW1geAviRpfxbMZIQy6xLm6d8lKewNK2nHWAkscTs5CoTLt
         tpJI9D17rYj8Oy41KVjTkcja7MOQC1bajcdObMWRNMEOdpTbC4QCAYJNJ4PbYDxDsFx8
         xfuA==
X-Gm-Message-State: AOJu0Yx4hwRfbJ4P25wsyarZCPth4I4uf4WjRxH5gtISTFTwiuYYVZCi
	2xyoSXVJFeQLo1XtymX4mhckBBLQmOa5/KTnS8d4WbVtPpP0B1asKIs4mpgOKw==
X-Gm-Gg: ATEYQzxhuRBw4vvzWehd+FxJSCP4mxPnsNZut63uCzAZKsvYAFBiBABRuTP6ayP262w
	zJ3/TeWzmRLGSmxU1CEra+CA/x6keEWjGRql5PQOPilN3obcqFDTfwgwwNCLloroOoQ81XAwNDV
	dCVJ1f0AhL6FvHWtk77hLEwT/slSPckOM94CohdDNMEqojw28R4n/hGbGTrDS/BchYwYIbt/4VL
	Nb3PwvBEJmNg/jnK+9gAxYTz5DfMu4b4BZt1rZf+CcKXLsCuTquruELU9193bzu1GOmZEmiBr1i
	UVw+S+DfsJ46GJus/fUwpJzutlelAzJa6Pp6xVNTmfEHvqMfnoAO8S41e4V6gPVeX8beRmuk4sM
	t5nQ0krx7TmWw6/Ugf+yIpkFDbb3h4iYm1C2RJ5OhcODT+Dt6Iz9auvoSTct48CPLXjpRwUCPhS
	A8gK5aeOXiLxbZS7Npm7FD3m1VBGc+fYfWB0+oVp6cN1g3VGBg5jmZDmgL+ZY=
X-Received: by 2002:a05:600c:c0d1:20b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-485570ce1cfmr203257195e9.4.1773746240667;
        Tue, 17 Mar 2026 04:17:20 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:20 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/39] dt-bindings: serial: renesas,rsci: Document RZ/G3E support
Date: Tue, 17 Mar 2026 11:16:26 +0000
Message-ID: <20260317111718.281633-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22434

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

[ Upstream commit 0774c43c006bf6e411514920cc57a42abe9374c1 ]

Add documentation for the serial communication interface (RSCI) found on
the Renesas RZ/G3E (R9A09G047) SoC. The RSCI IP on this SoC is identical
to that on the RZ/T2H (R9A09G077) SoC, but it has a 32-stage FIFO compared
to 16 on RZ/T2H. It supports both FIFO and non-FIFO mode operation. RZ/G3E
has 6 clocks(5 module clocks + 1 external clock) compared to 3 clocks
(2 module clocks + 1 external clock) on RZ/T2H, and it has multiple resets.
It has 6 interrupts compared to 4 on RZ/T2H.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-2-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Squashed the below commits as RZ/G3E RSCI is the first
  device on 6.1.cip:
   Upstream commit 25422e8f46c1fd147886f0dc8851eb66c9ba2d48
   Upstream commit 7dfd023dc7a9050554b28a16a31b8b06f76bb862
   Upstream commit dfa983c98cf76b4f22f3b8e3f30b9672c969f70a
   Upstream commit 64a2e41b8ef7771554374a0ac8386648fc6db2ba
   Upstream commit a6cdfd69ad38997108b862f9aafc547891506701
]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/serial/renesas,rsci.yaml         | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,rsci.yaml

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
new file mode 100644
index 000000000000..1f8cee8171de
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/renesas,rsci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RSCI Serial Communication Interface
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - renesas,r9a09g047-rsci # RZ/G3E
+          - renesas,r9a09g077-rsci # RZ/T2H
+
+      - items:
+          - const: renesas,r9a09g087-rsci # RZ/N2H
+          - const: renesas,r9a09g077-rsci # RZ/T2H
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 4
+    items:
+      - description: Error interrupt
+      - description: Receive buffer full interrupt
+      - description: Transmit buffer empty interrupt
+      - description: Transmit end interrupt
+      - description: Active edge detection interrupt
+      - description: Break field detection interrupt
+
+  interrupt-names:
+    minItems: 4
+    items:
+      - const: eri
+      - const: rxi
+      - const: txi
+      - const: tei
+      - const: aed
+      - const: bfd
+
+  clocks:
+    minItems: 2
+    maxItems: 6
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: operation
+          - const: bus
+          - const: sck # optional external clock input
+
+        minItems: 2
+
+      - items:
+          - const: pclk
+          - const: tclk
+          - const: tclk_div4
+          - const: tclk_div16
+          - const: tclk_div64
+          - const: sck # optional external clock input
+
+        minItems: 5
+
+  resets:
+    items:
+      - description: Input for resetting the APB clock
+      - description: Input for resetting TCLK
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: tresetn
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-rsci
+    then:
+      properties:
+        interrupts:
+          maxItems: 4
+
+        interrupt-names:
+          maxItems: 4
+
+        clocks:
+          minItems: 2
+          maxItems: 3
+
+        clock-names:
+          minItems: 2
+          maxItems: 3
+
+        resets: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-rsci
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+
+        interrupt-names:
+          minItems: 6
+
+        clocks:
+          minItems: 5
+          maxItems: 6
+
+        clock-names:
+          minItems: 5
+          maxItems: 6
+
+      required:
+        - resets
+        - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+    sci0: serial@80005000 {
+        compatible = "renesas,r9a09g077-rsci";
+        reg = <0x80005000 0x400>;
+        interrupts = <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 591 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 592 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "eri", "rxi", "txi", "tei";
+        clocks = <&cpg CPG_MOD 8>, <&cpg CPG_CORE 13>;
+        clock-names = "operation", "bus";
+        power-domains = <&cpg>;
+    };
-- 
2.43.0


