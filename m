Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA0C4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 16:53:04 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.40932.1702486373796692929
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Dec 2023 08:52:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,273,1695654000"; 
   d="scan'208";a="186369279"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2023 01:52:51 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.80])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 065074021F9B;
	Thu, 14 Dec 2023 01:52:49 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip] ASoC: dt-bindings: renesas,rz-ssi: Update interrupts and interrupt-names properties
Date: Wed, 13 Dec 2023 16:52:48 +0000
Message-Id: <20231213165248.975443-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Dec 2023 16:53:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14070

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
Hi All,

All the relevant driver patches and DT changes are already present v6.1-cip, just
the binding patch was missing.
- f3f3218a63af ("ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels")
- e83e635becb9 ("arm64: dts: renesas: r9a07g054: Update IRQ numbers for SSI channels")
- 684fecd4f332 ("arm64: dts: renesas: r9a07g044: Update IRQ numbers for SSI channel")

Cheers,
Prabhakar
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


