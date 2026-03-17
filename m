Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC39EFD875C
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:36:57 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73932.1773747408675027296
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:36:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kw2+5h2F;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so59424435e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747406; x=1774352206; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BbP3C7K/bOsdoFT6sLaef/35j0inasrlT9xXMmNHEg=;
        b=kw2+5h2FyjMVyPn+8vrYBUzSdnrYq9s/jln8kltcIlRZq9sd151Wkjpfbn/b/espLK
         EGotwS2hTEII/KZ8tg8fk23xel6AMJbgPtXumP9/WtzokAg5RSOU8dLq+NfHAGzM34PJ
         n0DcOkWd3lXC7kOJyOGsNuWAdO44wkN7rTdSI2zalJTMIeda2+VvQnY5RSBG2DLekyPW
         WSYFUFosu34Yc8PU/g03ijABYHYcP2c6WVCUvVUkk3cK6JtJwDFKWu2uV6FakklT1Ji1
         kGKmsqGRKWVYO0WYHMGPI3uBAoOaHIOKirnmUuOuedWQ/ajKl6F2BSuGQNNnPBs3LJsz
         nfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747406; x=1774352206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/BbP3C7K/bOsdoFT6sLaef/35j0inasrlT9xXMmNHEg=;
        b=OtpfszDkpMQ/fc1PwkXJZokw1lihmFeJmFNV/bhiXnqitpFvy2Z8oIB9l+kCmyH6A3
         kkKgYbce4K7g0W2CzDCiFIXUq6NJau19xjUSP1uPLcyv5Q4PS+cnkw8u7naH5FPJfuCJ
         uppK+3TuDupkLa5Z7XxnS+fagGbDIMWuPm3faxTNR+2mwB5nd3A7SZQU1Cv9CZavSDG7
         R1lnQhT/qElTh8Y5jJmlJ70/T743dVPAj9BGRVb+51lRnb89Wmu6dj5IhQKSkgsZwZeE
         4P58PkOJuvpUsuoMP5sy5FAUEKUttO1NgZZm+Lf4m9vkRXwpA4XfJ0CTRXJXahHWxjfN
         2MTA==
X-Gm-Message-State: AOJu0YyN2xR/UtMoB38aPPp1iCSJzeI9sCewRqWmnCKnFp0l6/OWMl3/
	vv9TDzV9Duo6bXACC5RVLMHpDoYf9Bt0BWRqXIpN7Ju4SS/JF9/JEvm/O11c+Q==
X-Gm-Gg: ATEYQzxbZmUVhO7FqSZujduReihcheNiaoj31j0LYY8m1BiyNVDW3f2t72tLGYD1VTA
	n0UlvQBrXHKidstCqgOrWoJMw2+vUBo/FKHV09Sm5Z84GL/97XkZsk5JX4siAmX2evboRvpey4t
	c4YE9smlG/x9OwCkmNvh6H+R09t67FqEWBGGaEBQed+RKYYttY4g8lS4FJ7iyxJAQUM/HBX75KN
	bCCaDcdZ8OrXNP7BVCOqA4cuXDZwrYLnirgnZT1sznCenn7MEXe/hpATNL02poXkB0/2xtVyngC
	nFhUsEJiB1ONG7FVvD+Vwme0iy1zKExJSegF+EDmKh6gWZFkLBDhaYv1zWFMquIQHq/SZkW2myT
	1yNpbHj9oQWfZ14xlmyK5s4Sq5pXiq0aq0Vip6+V6NWdDIUW0LKSnEXbr8SnxggyL/zuO+lOZUT
	ENCk10ayFPwpSjadHIusJIcgtxuwVYSlMD2RwGi6yghL/3Fn4d
X-Received: by 2002:a05:600c:1f16:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-485566ddb1cmr284729985e9.15.1773747406309;
        Tue, 17 Mar 2026 04:36:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97af2sm57469965e9.4.2026.03.17.04.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:36:46 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/11] dt-bindings: usb: Document Renesas RZ/G3E USB3HOST
Date: Tue, 17 Mar 2026 11:36:30 +0000
Message-ID: <20260317113643.311192-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22477

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit dd0d2618e3f815a030622599e540d3be1964a888 ]

Document the Renesas RZ/G3E USB3.2 Gen2 Host Controller (a.k.a USB3HOST).
The USB3HOST is compliant with the Universal Serial Bus 3.2 Specification
Revision 1.0.
 - Supports 1 downstream USB receptacles
     - Number of SSP Gen2 or SS ports: 1
     - Number of HS or FS or LS ports: 1
 - Supports Super Speed Plus Gen2x1 (10 Gbps), Super Speed (5 Gbps),
   High Speed (480 Mbps), Full Speed (12Mbps), and Low Speed (1.5 Mbps).
 - Supports all transfer-types: Control, Bulk, Interrupt, Isochronous, and
   these split-transactions.
 - Supports Power Control and Over Current Detection.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250916150255.4231-4-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/usb/renesas,rzg3e-xhci.yaml      | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml

diff --git a/Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml b/Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml
new file mode 100644
index 000000000000..98260f9fb442
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/renesas,rzg3e-xhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3E USB 3.2 Gen2 Host controller
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    const: renesas,r9a09g047-xhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Logical OR of all interrupt signals.
+      - description: System management interrupt
+      - description: Host system error interrupt
+      - description: Power management event interrupt
+      - description: xHC interrupt
+
+  interrupt-names:
+    items:
+      - const: all
+      - const: smi
+      - const: hse
+      - const: pme
+      - const: xhc
+
+  clocks:
+    maxItems: 1
+
+  phys:
+    maxItems: 2
+
+  phy-names:
+    items:
+      - const: usb2-phy
+      - const: usb3-phy
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - power-domains
+  - resets
+  - phys
+  - phy-names
+
+allOf:
+  - $ref: usb-xhci.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@15850000 {
+      compatible = "renesas,r9a09g047-xhci";
+      reg = <0x15850000 0x10000>;
+      interrupts = <GIC_SPI 759 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 758 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 757 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 756 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 755 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "all", "smi", "hse", "pme", "xhc";
+      clocks = <&cpg CPG_MOD 0xaf>;
+      power-domains = <&cpg>;
+      resets = <&cpg 0xaa>;
+      phys = <&usb3_phy>, <&usb3_phy>;
+      phy-names = "usb2-phy", "usb3-phy";
+    };
-- 
2.43.0


