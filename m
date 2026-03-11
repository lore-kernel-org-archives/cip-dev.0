Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA8D1061206
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:41 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18737.1773227200309546261
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mtNCErjR;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so10557512f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227199; x=1773831999; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A+J2QQbuZuhLINoLLdDbRFb8IPOFIKOAsSoLARNphw=;
        b=mtNCErjRSILJL44WyyDi7AYDQyaHzoynStTckzfaMxT2OhGrcpZ3/li2Y7w+/finu1
         UN9uNQ0L6E3IWVte1Vq/w92MONuPDVd/Rhg6F0iWPtd+tKuM8bPiRc1Zpq+nIDA0w4OO
         vmB44bDyqV/CUGDbhjWR+CVqsHYoRa594+d5cikeScQydOLxoaYYL/Y40xZGFPGjBhO1
         wQDNhWHv3TArCpKJyDp/1HzZQdgLlmyxbaStHfMv6RlEGTTuPlulwYStpFhKHhWz8490
         EwKf+OLLBQPThpIsv4EkdVAMAK5b5JY1VpnWyFENOxlGD1kuZ7nskpN/JWo4nPHjqqdP
         E+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227199; x=1773831999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7A+J2QQbuZuhLINoLLdDbRFb8IPOFIKOAsSoLARNphw=;
        b=cmkQoF3GzWwWGA/BxK9tN6GVCMDPHdDhqpBR3U49C9Gq0uZM0iCibQ2kG3sl2yMid5
         Gx2ELmaBpVYUsm9QVPuzq4WZSNO8jvCOBEm2u55bW0fH3wHsGlqynKJC0ZlemSCfa0J2
         +PNt57G28IQbYdm7OO0anXmGOfqAdZRyB9IUY+NRp+A1bho5e3q9BfoIkonMa3h4sB7Z
         x/d1lhWtAEBZs8Fv+lcFo/pdI+oZMay4dQ2OatlpJrQWsuwOD7Zg1fitNuiw/uD+suQ3
         t39Ma39g4YgKfiljUmu6aAIYYUrFg2cjdJ0wU+uXvk/ZyA+mC2u6rTK+qS52HcqeC/fq
         Ys+Q==
X-Gm-Message-State: AOJu0YyEfY7r4OdPq3v9gJcWMpNdzj7oUTtBCkCOBCyVJ/GlKU4ZAbMU
	F9mqi4vM9eDMtiYYJfCp4PQvAdusi8CYKLviMyiMOglwSH7LZxy4VxyXoVQN+xz+Oio=
X-Gm-Gg: ATEYQzw2d3ITIr64IJG0e/MbRYgdcF8CiHDa/o7+Q+N1bL+J/mDQWirV43YOQXB0mx9
	HP/bpGIgcmLHZikHRBvXE4rvp3u0T0oCHirFqzyTetM+5adyd+uLJ6Q/nNR34DPmj5m6KA41lK+
	fQNy9NjGBIK+kWVFxjjy9W7UnFOblsxGpNXSEGqjKC5NTAg2L1N81V0WxwyHyGWvpl/Sd6KSIUQ
	TkqWa8tZHEpbM712/uuHCShqb8Uvoo3EJrvL8tGQoDfZ39IC9sWkswkET5qq5qqvney6viEPTTf
	qDdE8dIb1597Ewf9/M6HbLeax6XG/BoqA7GRMTxxw5JYP9/dvpngjhSjS5WEngEudeTCRFi78Hs
	2p+RSg+QDUA/kesUq3UdZLKM1Yy+Nvu99mTVR0J4kztIZyE9201FYd3GpjPOD/3bOHBH1lWZV4A
	rIaaVGME+X96oqefqMEh/mESvCnMkCIdlA89NaT4v2kn1TtmuTXpUx
X-Received: by 2002:a05:6000:40c7:b0:439:bdd7:425f with SMTP id ffacd0b85a97d-439f8209958mr4050399f8f.35.1773227198675;
        Wed, 11 Mar 2026 04:06:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:38 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 03/13] dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding
Date: Wed, 11 Mar 2026 13:06:23 +0200
Message-ID: <20260311110633.1938579-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22329

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


