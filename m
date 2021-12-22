Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634BEC4332F
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 13:49:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.19261.1640180997453629537
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 05:49:58 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000";
   d="scan'208";a="104366603"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 22:49:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C4666430F437;
	Wed, 22 Dec 2021 22:49:56 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 03/21] dt-bindings: reset: Document RZ/G2L USBPHY
 Control bindings
Date: Wed, 22 Dec 2021 13:49:33 +0000
Message-Id: <20211222134951.19432-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 13:49:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7237

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 18931afe5b4fb7f91da43043c867e504e742a781 upstream.

Add device tree binding document for RZ/G2L USBPHY Control Device.
It mainly controls reset and power down of the USB/PHY.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210719121938.6532-4-biju.das.jz@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
new file mode 100644
index 000000000000..b13514e6783d
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/renesas,rzg2l-usbphy-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L USBPHY Control
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description:
+  The RZ/G2L USBPHY Control mainly controls reset and power down of the
+  USB/PHY.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
+      - const: renesas,rzg2l-usbphy-ctrl
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
+    const: 1
+    description: |
+      The phandle's argument in the reset specifier is the PHY reset associated
+      with the USB port.
+      0 = Port 1 Phy reset
+      1 = Port 2 Phy reset
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
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    phyrst: usbphy-ctrl@11c40000 {
+        compatible = "renesas,r9a07g044-usbphy-ctrl",
+                     "renesas,rzg2l-usbphy-ctrl";
+        reg = <0x11c40000 0x10000>;
+        clocks = <&cpg CPG_MOD R9A07G044_USB_PCLK>;
+        resets = <&cpg R9A07G044_USB_PRESETN>;
+        power-domains = <&cpg>;
+        #reset-cells = <1>;
+    };
-- 
2.17.1


