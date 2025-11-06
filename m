Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2604BCCFA1C
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 10:40:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11710.1762425627318172200
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 02:40:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: YD/2H4LvREusJUIA94xtcA==
X-CSE-MsgGUID: OytJyO8oR92PX0asrPBGgg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2025 19:40:34 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.83])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C0401400B9FB;
	Thu,  6 Nov 2025 19:40:32 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 4/9] dt-bindings: net: Define interrupt constraints for DWMAC vendor bindings
Date: Thu,  6 Nov 2025 10:40:19 +0000
Message-ID: <20251106104024.28947-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
References: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 10:40:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20454

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5a1dddd2944492edb1e61c5db1cc386e5419fcf4 upstream.

The `snps,dwmac.yaml` binding currently sets `maxItems: 3` for the
`interrupts` and `interrupt-names` properties, but vendor bindings
selecting `snps,dwmac.yaml` do not impose these limits.

Define constraints for `interrupts` and `interrupt-names` properties in
various DWMAC vendor bindings to ensure proper validation and consistency.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Link: https://patch.msgid.link/20250309003301.1152228-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/net/amlogic,meson-dwmac.yaml   |  6 ++++++
 .../devicetree/bindings/net/intel,dwmac-plat.yaml      |  6 ++++++
 .../devicetree/bindings/net/mediatek-dwmac.yaml        |  6 ++++++
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml         |  8 ++++++++
 .../devicetree/bindings/net/rockchip-dwmac.yaml        | 10 ++++++++++
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 10 ++++++++++
 .../bindings/net/toshiba,visconti-dwmac.yaml           |  6 ++++++
 7 files changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index d1e2bca3c503..125b44953bf0 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -152,6 +152,12 @@ properties:
           The second range is is for the Amlogic specific configuration
           (for example the PRG_ETHERNET register range on Meson8b and newer)
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/net/intel,dwmac-plat.yaml b/Documentation/devicetree/bindings/net/intel,dwmac-plat.yaml
index 42a0bc94312c..62c1da36a2b5 100644
--- a/Documentation/devicetree/bindings/net/intel,dwmac-plat.yaml
+++ b/Documentation/devicetree/bindings/net/intel,dwmac-plat.yaml
@@ -41,6 +41,12 @@ properties:
       - const: ptp_ref
       - const: tx_clk
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
 required:
   - compatible
   - clocks
diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
index ed9d845f6008..3aab21b8e8de 100644
--- a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
@@ -64,6 +64,12 @@ properties:
       - const: rmii_internal
       - const: mac_cg
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
   power-domains:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
index 87bc4416eadf..e5db346beca9 100644
--- a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
@@ -56,6 +56,14 @@ properties:
         - tx
         - mem
 
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+
   intf_mode:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index f8a576611d6c..891396140a7f 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -58,6 +58,16 @@ properties:
               - rockchip,rv1126-gmac
           - const: snps,dwmac-4.20a
 
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+
   clocks:
     minItems: 5
     maxItems: 8
diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index bf23838fe6e8..297ac150b1ea 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -54,6 +54,16 @@ properties:
     items:
       - const: stmmaceth
 
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+
   clocks:
     minItems: 3
     items:
diff --git a/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml b/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
index 052f636158b3..f0f32e18fc85 100644
--- a/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
@@ -42,6 +42,12 @@ properties:
       - const: stmmaceth
       - const: phy_ref_clk
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
 required:
   - compatible
   - reg
-- 
2.51.0


