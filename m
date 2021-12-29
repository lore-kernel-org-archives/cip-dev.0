Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD466C4332F
	for <webhook@archiver.kernel.org>; Wed, 29 Dec 2021 10:15:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.49427.1640772936777967170
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Dec 2021 02:15:37 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,244,1635174000";
   d="scan'208";a="105602426"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Dec 2021 19:15:33 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 15F25423D00D;
	Wed, 29 Dec 2021 19:15:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/31] ASoC: dt-bindings: Document RZ/G2L bindings
Date: Wed, 29 Dec 2021 10:15:00 +0000
Message-Id: <20211229101530.22783-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Dec 2021 10:15:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7277

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 2b761f476f3a6e0a212c8c88e7855f66edb177e0 upstream.

Document RZ/G2L ASoC serial sound interface bindings.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210719134040.7964-2-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/sound/renesas,rz-ssi.yaml        | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
new file mode 100644
index 000000000000..891f381ee5b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/renesas,rz-ssi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L ASoC Sound Serial Interface (SSIF-2)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
+      - const: renesas,rz-ssi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: int_req
+      - const: dma_rx
+      - const: dma_tx
+      - const: dma_rt
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: ssi
+      - const: ssi_sfr
+      - const: audio_clk1
+      - const: audio_clk2
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    ssi0: ssi@10049c00 {
+        compatible = "renesas,r9a07g044-ssi",
+                     "renesas,rz-ssi";
+            reg = <0x10049c00 0x400>;
+            interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+            clocks = <&cpg CPG_MOD R9A07G044_SSI0_PCLK2>,
+                     <&cpg CPG_MOD R9A07G044_SSI0_PCLK_SFR>,
+                     <&audio_clk1>,
+                     <&audio_clk2>;
+            clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+            power-domains = <&cpg>;
+            resets = <&cpg R9A07G044_SSI0_RST_M2_REG>;
+            #sound-dai-cells = <0>;
+    };
-- 
2.17.1


