Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F2FCF9C67
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 17:04:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1527.1763658244305288022
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 09:04:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: bZ2+T3p2QbeVWFZz62ZuYA==
X-CSE-MsgGUID: PaXOfkbLQnOX8h3knm+lBw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2025 02:04:03 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1269F40614F0;
	Fri, 21 Nov 2025 02:04:01 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 02/10] dt-bindings: reset: Document RZ/V2H(P) USB2PHY reset
Date: Thu, 20 Nov 2025 17:03:49 +0000
Message-ID: <20251120170357.18342-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120170357.18342-1-ovidiu.panait.rb@renesas.com>
References: <20251120170357.18342-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 17:04:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20649

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 261f3ff29a2b15ad70bf2530550421ad9a9a5966 upstream.

Add a device tree binding document for the Renesas RZ/V2H(P) USB2PHY reset
controller. This block manages the reset and power-down of the USB 2.0 PHY,
which is used in both host and function modes.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://lore.kernel.org/r/20250415195131.281060-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../reset/renesas,rzv2h-usb2phy-reset.yaml    | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/renesas,rzv2h-usb2phy-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzv2h-usb2phy-reset.yaml b/Documentation/devicetree/bindings/reset/renesas,rzv2h-usb2phy-reset.yaml
new file mode 100644
index 000000000000..c79f61c2373b
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/renesas,rzv2h-usb2phy-reset.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/renesas,rzv2h-usb2phy-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2H(P) USB2PHY Port reset Control
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  The RZ/V2H(P) USB2PHY Control mainly controls Port reset and power down of the
+  USB2.0 PHY.
+
+properties:
+  compatible:
+    const: renesas,r9a09g057-usb2phy-reset     # RZ/V2H(P)
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - power-domains
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g057-cpg.h>
+
+    reset-controller@15830000 {
+        compatible = "renesas,r9a09g057-usb2phy-reset";
+        reg = <0x15830000 0x10000>;
+        clocks = <&cpg CPG_MOD 0xb6>;
+        resets = <&cpg 0xaf>;
+        power-domains = <&cpg>;
+        #reset-cells = <0>;
+    };
-- 
2.51.0


