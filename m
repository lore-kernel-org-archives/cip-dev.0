Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B5DC48299
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:41:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.61465.1707136901139683711
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:41:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="192915804"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2024 21:41:40 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C475940065B6;
	Mon,  5 Feb 2024 21:41:38 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/48] ASoC: dt-bindings: renesas,rz-ssi: Update interrupts and interrupt-names properties
Date: Mon,  5 Feb 2024 12:40:48 +0000
Message-Id: <20240205124135.14779-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:41:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14670

commit 56a3840486ae22c42176828e25d4073712837bfd upstream.

From R01UH0914EJ0120 Rev.1.20 HW manual, for full duplex channels
(SSI0/1/3) dma_rt interrupt has now being marked as reserved and similarly
for half duplex channel (SSI2) dma_rx and dma_tx interrupts have now being
marked as reserved (this applies to RZ/G2L and alike SoC's). This patch
updates the binding doc to match the same.

While at it also updated the example node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230217185225.43310-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/sound/renesas,rz-ssi.yaml        | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 0d9840375132..5bd86a685cf7 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -22,14 +22,18 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 4
+    minItems: 2
+    maxItems: 3
 
   interrupt-names:
-    items:
-      - const: int_req
-      - const: dma_rx
-      - const: dma_tx
-      - const: dma_rt
+    oneOf:
+      - items:
+          - const: int_req
+          - const: dma_rx
+          - const: dma_tx
+      - items:
+          - const: int_req
+          - const: dma_rt
 
   clocks:
     maxItems: 4
@@ -103,9 +107,8 @@ examples:
             reg = <0x10049c00 0x400>;
             interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
-                         <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
-                         <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
-            interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+                         <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "int_req", "dma_rx", "dma_tx";
             clocks = <&cpg CPG_MOD R9A07G044_SSI0_PCLK2>,
                      <&cpg CPG_MOD R9A07G044_SSI0_PCLK_SFR>,
                      <&audio_clk1>,
-- 
2.34.1


