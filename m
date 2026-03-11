Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4921061200
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:41 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18313.1773227133268570850
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GDoBqrhs;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so37023175e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227132; x=1773831932; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A+J2QQbuZuhLINoLLdDbRFb8IPOFIKOAsSoLARNphw=;
        b=GDoBqrhshHxgjaINIqcy1THrJIT3UBIP7JrMsfP6SoifoySXxt3oeyFawpMFLM+kQH
         tZIk6POf+LxfUGr1EQy2xDg+5kUY3w6ywXfpJnbRTccIwyXO2YzanVc3ES5cu8cpshjw
         0FwPd1LrF0M032yuVFCEYQRy1XCGNh+BFWAErgdj3bg1B2Xs8zfMMIHBja96UPN8W9xA
         ir5wz+qKRcHxTL9Wd0Fa4mPgQg8XP4Olj5ox+GOTpm1v1wX0cZbyL5JXheflIRtxPij+
         uyofCQB32zwYQFuQ7hAbYU4ID++etda+dNcw3zAKkAyUmBpuyw08eVYidTuRS70k2bb7
         0DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227132; x=1773831932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7A+J2QQbuZuhLINoLLdDbRFb8IPOFIKOAsSoLARNphw=;
        b=qkmX0UhLL2B0KxEHDcTVuwmyC5dndyRCRWp5pWWE2eLDGSxyO52kVrPNFtNWv5KbzY
         pNx2xhuFMONf1jjYb8d+gZX3VAf9Efct2oWgsWMWsuFteKHa8aVTFFYZldggtrqGGs82
         pXDku2zWX+9BgudcCPashmY6TT8Oc8DF9LP8jZ/n68VXAMHIroFBbpokt4/Aw4JupDTB
         cHq894N97NqPmxPIT8SXVxIhXi5Viq8R3khXPZu4o6k7j8QJ08Bjw/A0JoiWDQ8YeK5F
         7k+vSeI6AHkzUHIKn2BYM6RhCkhVRONk2tUlFXzA+1JYgzFY/JbYw3eR7WjBliaBowLv
         joXA==
X-Gm-Message-State: AOJu0YxU2EKjgfpJYvJYERWOvm7euDwYqIMbbrVH9zSZXZASodyE+Q4B
	RJJLn/Lmzbp2oHjMPpuU7FLRSRfNxAleWpXXYOYKUPzp7H+CUryZ5pjGjUZ4Amos4ywZej1FslX
	99wOv
X-Gm-Gg: ATEYQzzLI1TzqsUKObpRIBbVFI9SxNgC8fgSKvqiZvLv3vLm9aJh8JN0Q0Qqq2XMW+q
	q9hZ1F0L31nm8P8cxXQ4AWtcQGUAPjrzvImtZQED1/IqSKgQL2oLmqKqUzhQymEwaH23+5EXaO3
	9E23vA9/qVhM1aS7DjScqgcQ1Y9PCi6EzJ3W+0pR7CMmXLUoYu8n7BPsRVYzwV7qqgGQNTrOQTi
	YgT3uQvfNI1toz5OKEPxDJKp1xC7osIYHeijFu3OA75OpAtA3KcMaDTYXed7yQWwvtU2dNb5iqk
	fjLTeZ6JilhE/3LFZ+kzA/oWZ6MZX/gTikfwk3sMKeyx77LD1ochY0oCQwvqvKQIS57VtOXL5Ka
	UNk420pRl/8ASGE0NGU2CbuSL+0aRS/pAXqbULiDpM0BEGLIp64EbhoQid5bS3tg/7d3xGaRbDd
	7qOaJ8hK2e4J2aWrJYfXDUimMaYVPs3IverehPeCX59NVSh12xKzSy
X-Received: by 2002:a05:600c:8b05:b0:485:303b:c50a with SMTP id 5b1f17b1804b1-4854b0f064emr36525005e9.13.1773227131563;
        Wed, 11 Mar 2026 04:05:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 07/17] dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding
Date: Wed, 11 Mar 2026 13:05:10 +0200
Message-ID: <20260311110520.1938414-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22315

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e7534e790557e9ee18a2c497dc89a6b31e435e48 upstream.

The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
Base Specification 4.0. It is designed for root complex applications and
features a single-lane (x1) implementation. Add binding documentation for
it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20251119143523.977085-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 249 ++++++++++++++++++
 1 file changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
new file mode 100644
index 000000000000..d668782546a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -0,0 +1,249 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/renesas,r9a08g045-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3S PCIe host controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+
+description:
+  Renesas RZ/G3S PCIe host controller complies with PCIe Base Specification
+  4.0 and supports up to 5 GT/s (Gen2).
+
+properties:
+  compatible:
+    const: renesas,r9a08g045-pcie # RZ/G3S
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: System error interrupt
+      - description: System error on correctable error interrupt
+      - description: System error on non-fatal error interrupt
+      - description: System error on fatal error interrupt
+      - description: AXI error interrupt
+      - description: INTA interrupt
+      - description: INTB interrupt
+      - description: INTC interrupt
+      - description: INTD interrupt
+      - description: MSI interrupt
+      - description: Link bandwidth interrupt
+      - description: PME interrupt
+      - description: DMA interrupt
+      - description: PCIe event interrupt
+      - description: Message interrupt
+      - description: All interrupts
+
+  interrupt-names:
+    items:
+      - description: serr
+      - description: ser_cor
+      - description: serr_nonfatal
+      - description: serr_fatal
+      - description: axi_err
+      - description: inta
+      - description: intb
+      - description: intc
+      - description: intd
+      - description: msi
+      - description: link_bandwidth
+      - description: pm_pme
+      - description: dma
+      - description: pcie_evt
+      - description: msg
+      - description: all
+
+  interrupt-controller: true
+
+  clocks:
+    items:
+      - description: System clock
+      - description: PM control clock
+
+  clock-names:
+    items:
+      - description: aclk
+      - description: pm
+
+  resets:
+    items:
+      - description: AXI2PCIe Bridge reset
+      - description: Data link layer/transaction layer reset
+      - description: Transaction layer (ACLK domain) reset
+      - description: Transaction layer (PCLK domain) reset
+      - description: Physical layer reset
+      - description: Configuration register reset
+      - description: Configuration register reset
+
+  reset-names:
+    items:
+      - description: aresetn
+      - description: rst_b
+      - description: rst_gp_b
+      - description: rst_ps_b
+      - description: rst_rsm_b
+      - description: rst_cfg_b
+      - description: rst_load_b
+
+  power-domains:
+    maxItems: 1
+
+  dma-ranges:
+    description:
+      A single range for the inbound memory region.
+    maxItems: 1
+
+  renesas,sysc:
+    description: |
+      System controller registers control and monitor various PCIe
+      functionalities.
+
+      Control:
+      - transition to L1 state
+      - receiver termination settings
+      - RST_RSM_B signal
+
+      Monitor:
+      - clkl1pm clock request state
+      - power off information in L2 state
+      - errors (fatal, non-fatal, correctable)
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+patternProperties:
+  "^pcie@0,[0-0]$":
+    type: object
+    allOf:
+      - $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+      vendor-id:
+        const: 0x1912
+
+      device-id:
+        const: 0x0033
+
+      clocks:
+        items:
+          - description: Reference clock
+
+      clock-names:
+        items:
+          - const: ref
+
+    required:
+      - device_type
+      - vendor-id
+      - device-id
+      - clocks
+      - clock-names
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - interrupts
+  - interrupt-names
+  - interrupt-map
+  - interrupt-map-mask
+  - interrupt-controller
+  - power-domains
+  - "#address-cells"
+  - "#size-cells"
+  - "#interrupt-cells"
+  - renesas,sysc
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a08g045-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@11e40000 {
+            compatible = "renesas,r9a08g045-pcie";
+            reg = <0 0x11e40000 0 0x10000>;
+            ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
+            /* Map all possible DRAM ranges (4 GB). */
+            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
+            bus-range = <0x0 0xff>;
+            interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "serr", "serr_cor", "serr_nonfatal",
+                              "serr_fatal", "axi_err", "inta",
+                              "intb", "intc", "intd", "msi",
+                              "link_bandwidth", "pm_pme", "dma",
+                              "pcie_evt", "msg", "all";
+            #interrupt-cells = <1>;
+            interrupt-controller;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
+                            <0 0 0 2 &pcie 0 0 0 1>, /* INTB */
+                            <0 0 0 3 &pcie 0 0 0 2>, /* INTC */
+                            <0 0 0 4 &pcie 0 0 0 3>; /* INTD */
+            clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
+                     <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
+            clock-names = "aclk", "pm";
+            resets = <&cpg R9A08G045_PCI_ARESETN>,
+                     <&cpg R9A08G045_PCI_RST_B>,
+                     <&cpg R9A08G045_PCI_RST_GP_B>,
+                     <&cpg R9A08G045_PCI_RST_PS_B>,
+                     <&cpg R9A08G045_PCI_RST_RSM_B>,
+                     <&cpg R9A08G045_PCI_RST_CFG_B>,
+                     <&cpg R9A08G045_PCI_RST_LOAD_B>;
+            reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
+                          "rst_rsm_b", "rst_cfg_b", "rst_load_b";
+            power-domains = <&cpg>;
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            renesas,sysc = <&sysc>;
+
+            pcie@0,0 {
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                ranges;
+                clocks = <&versa3 5>;
+                clock-names = "ref";
+                device_type = "pci";
+                vendor-id = <0x1912>;
+                device-id = <0x0033>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+            };
+        };
+    };
+
+...
-- 
2.43.0


