Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A76D32D65
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:11 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6916.1764945183459164227
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: WtQU2mvYTxShJK2k4sFmdw==
X-CSE-MsgGUID: byritAfJRs+o9yvKnXAHtQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:02 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 53AC84179B99;
	Fri,  5 Dec 2025 23:33:01 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/38] dt-bindings: serial: Add compatible for Renesas RZ/T2H SoC in sci
Date: Fri,  5 Dec 2025 14:32:21 +0000
Message-ID: <20251205143258.13748-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20915

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

commit 25422e8f46c1fd147886f0dc8851eb66c9ba2d48 upstream.

RSCI of RZ/T2H SoC (a.k.a r9a09g077), as a lot
of similarities with SCI in other Renesas SoC like G2L, G3S, V2L;
However, it has a different set of registers, and in addition to serial,
this IP also supports SCIe (encoder), SmartCard, i2c and spi.
This is why the 'renesas,sci' fallback for generic SCI does not apply for it.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Link: https://lore.kernel.org/r/20250403212919.1137670-4-thierry.bultel.yh@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/serial/renesas,rsci.yaml         | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,rsci.yaml

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
new file mode 100644
index 0000000000000..ea879db5f4850
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -0,0 +1,78 @@
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
+  - Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: renesas,r9a09g077-rsci      # RZ/T2H
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Error interrupt
+      - description: Receive buffer full interrupt
+      - description: Transmit buffer empty interrupt
+      - description: Transmit end interrupt
+
+  interrupt-names:
+    items:
+      - const: eri
+      - const: rxi
+      - const: txi
+      - const: tei
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck # UART functional clock
+
+  power-domains:
+    maxItems: 1
+
+  uart-has-rtscts: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+    aliases {
+        serial0 = &sci0;
+    };
+
+    sci0: serial@80005000 {
+        compatible = "renesas,r9a09g077-rsci";
+        reg = <0x80005000 0x400>;
+        interrupts = <GIC_SPI 590 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 591 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 592 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "eri", "rxi", "txi", "tei";
+        clocks = <&cpg CPG_MOD 108>;
+        clock-names = "fck";
+        power-domains = <&cpg>;
+    };
-- 
2.43.0


