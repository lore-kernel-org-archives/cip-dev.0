Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8496D3E2CF
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 20:04:24 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.2537.1730145853990506462
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Oct 2024 13:04:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,239,1725289200"; 
   d="scan'208";a="227219282"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Oct 2024 05:04:15 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.179])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F2130408D216;
	Tue, 29 Oct 2024 05:04:07 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/27] media: dt-bindings: Document Renesas RZ/G2L CRU block
Date: Mon, 28 Oct 2024 20:03:31 +0000
Message-ID: <20241028200349.9620-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Oct 2024 20:04:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17092

commit a18004173a087573628ddc9910f0665a3829f48f upstream.

Document the CRU block found on Renesas RZ/G2L (and alike) SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/media/renesas,rzg2l-cru.yaml     | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
new file mode 100644
index 0000000000000..7dde7967c8869
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L (and alike SoC's) Camera Data Receiving Unit (CRU) Image processing
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  The CRU image processing module is a data conversion module equipped with pixel
+  color space conversion, LUT, pixel format conversion, etc. An MIPI CSI-2 input and
+  parallel (including ITU-R BT.656) input are provided as the image sensor interface.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-cru       # RZ/G2{L,LC}
+          - renesas,r9a07g054-cru       # RZ/V2L
+      - const: renesas,rzg2l-cru
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: image_conv
+      - const: image_conv_err
+      - const: axi_mst_err
+
+  clocks:
+    items:
+      - description: CRU Main clock
+      - description: CRU Register access clock
+      - description: CRU image transfer clock
+
+  clock-names:
+    items:
+      - const: video
+      - const: apb
+      - const: axi
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: CRU_PRESETN reset terminal
+      - description: CRU_ARESETN reset terminal
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: aresetn
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port node, single endpoint describing a parallel input source.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              hsync-active: true
+              vsync-active: true
+              bus-width: true
+              data-shift: true
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Input port node, describing the Image Processing module connected to the
+          CSI-2 receiver.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  # Device node example with CSI-2
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cru: video@10830000 {
+        compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
+        reg = <0x10830000 0x400>;
+        interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
+        clocks = <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
+                 <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
+                 <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
+        clock-names = "video", "apb", "axi";
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_CRU_PRESETN>,
+                 <&cpg R9A07G044_CRU_ARESETN>;
+        reset-names = "presetn", "aresetn";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0>;
+
+                cru_parallel_in: endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint= <&ov5642>;
+                    hsync-active = <1>;
+                    vsync-active = <1>;
+                };
+            };
+
+            port@1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <1>;
+
+                cru_csi_in: endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint= <&csi_cru_in>;
+                };
+            };
+        };
+    };
-- 
2.43.0


