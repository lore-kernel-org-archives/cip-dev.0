Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1678FCEEB8
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:12:42 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43799.1772021557809195659
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 04:12:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: O9+cz9WaTiWQw32TB6CJgg==
X-CSE-MsgGUID: 047tUoC+QEqQ9ayEQnodlQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Feb 2026 21:12:37 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0DF89400D0F2;
	Wed, 25 Feb 2026 21:12:35 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 01/24] dt-bindings: display: bridge: renesas,dsi: allow properties from dsi-controller
Date: Wed, 25 Feb 2026 12:12:09 +0000
Message-ID: <20260225121232.129678-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
References: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 12:12:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21958

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

commit 3e3169e64e3154770f263451cc821b4c3f043cc0 upstream.

Allow to inherit valid properties from the dsi-controller. This fixes the
following warning when adding a panel property:

rzg2lc.dtb: dsi@10850000: '#address-cells', '#size-cells', 'panel@0' do not
    match any of the regexes: 'pinctrl-[0-9]+'
    from schema $id:
        http://devicetree.org/schemas/display/bridge/renesas,dsi.yaml#

Also add a panel property to the example.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250520151112.3278569-1-hugo@hugovil.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../bindings/display/bridge/renesas,dsi.yaml  | 67 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
index e08c24633926..5a99d9b9635e 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
@@ -128,7 +128,7 @@ required:
   - power-domains
   - ports
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -180,4 +180,69 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi1: dsi@10860000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "renesas,r9a07g044-mipi-dsi", "renesas,rzg2l-mipi-dsi";
+        reg = <0x10860000 0x20000>;
+        interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "seq0", "seq1", "vin1", "rcv",
+                          "ferr", "ppi", "debug";
+        clocks = <&cpg CPG_MOD R9A07G044_MIPI_DSI_PLLCLK>,
+                 <&cpg CPG_MOD R9A07G044_MIPI_DSI_SYSCLK>,
+                 <&cpg CPG_MOD R9A07G044_MIPI_DSI_ACLK>,
+                 <&cpg CPG_MOD R9A07G044_MIPI_DSI_PCLK>,
+                 <&cpg CPG_MOD R9A07G044_MIPI_DSI_VCLK>,
+                 <&cpg CPG_MOD R9A07G044_MIPI_DSI_LPCLK>;
+        clock-names = "pllclk", "sysclk", "aclk", "pclk", "vclk", "lpclk";
+        resets = <&cpg R9A07G044_MIPI_DSI_CMN_RSTB>,
+                 <&cpg R9A07G044_MIPI_DSI_ARESET_N>,
+                 <&cpg R9A07G044_MIPI_DSI_PRESET_N>;
+        reset-names = "rst", "arst", "prst";
+        power-domains = <&cpg>;
+
+        panel@0 {
+            compatible = "rocktech,jh057n00900";
+            reg = <0>;
+            vcc-supply = <&reg_2v8_p>;
+            iovcc-supply = <&reg_1v8_p>;
+            reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi1_out>;
+                };
+            };
+        };
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                dsi1_in: endpoint {
+                    remote-endpoint = <&du_out_dsi1>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                dsi1_out: endpoint {
+                    data-lanes = <1 2 3 4>;
+                    remote-endpoint = <&panel_in>;
+                };
+            };
+        };
+    };
 ...
-- 
2.51.0


