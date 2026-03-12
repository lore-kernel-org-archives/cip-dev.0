Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E434106704D
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:32 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24575.1773329727852272186
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AtyjGx22;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so11486025e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329726; x=1773934526; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BbP3C7K/bOsdoFT6sLaef/35j0inasrlT9xXMmNHEg=;
        b=AtyjGx22WtvFpOZWzDEXqTai19uNloQvL2b38zzjZ3VPfsuvXIW1ujpBFw5OAgNTYQ
         OA5ByWIQaqNH4nKd0UiyrNZj3Rtcx6ZHq1HwR4k7vIGcOdATqSX6KjDpQCRrb3Iz0Xwu
         5ryDUgyb8HvA63UG/a6VAYgEByVIiWtlBL0N1DfZ0ChYBBHqEa6roKFf4zfD0eGOwxX6
         0K/FuB0V9dNSs/3dEs22rROzw/XdLySC6HImQsQezY6gqb7eTbVNzFBfwsQ9T9eTu+X7
         mYsmpiI2HcIKoZhvwPpiijsjmLGhb/z/TeaCoKEaCEG++bGp013ljIhoYhRftmF2fP0x
         oXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329726; x=1773934526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/BbP3C7K/bOsdoFT6sLaef/35j0inasrlT9xXMmNHEg=;
        b=IE+L69TQn/o+qrEkKn69fBNOinC/77XxBkIQGjzpimL5seWlSJMMvl8rafvKcd2f0h
         3mTCg9GDGsJ3peOTKFC1SWhzc4muhoPX10XweoUVNJHKYaquN5clDMcEm6WGOMvpqLJw
         IkLtYPjModlEvaaAY87KDttrfhWfuBXV+CsKbLHZIBcIGL9rWkrisDRh5Sxo+Y34Mek+
         fmqEggjqMtNI5S//der6UNol/RfPQuH4jcNXAyaiV9SG53OtL9SZJxAo/CnlDqolY7yz
         K2xQow5iatnSLSkaArZp1QiedpE7n6zEGodJDtpgGFymFDSW5uq/T/VMFysA5xR4LAb+
         BQRQ==
X-Gm-Message-State: AOJu0Yz3JnSnzv0j2fVfRc/M1D3SMVnCDhEkv0eCrw4aqXICc0Nj/49e
	zMUQ4J9C79e3FqjMd/TPJu8XN+DzA2qNpkiG+AmK3HSeWWvj4vtPfTOB49ghSg==
X-Gm-Gg: ATEYQzyUX3ThHIYuHSXau3UmuWEqPdWIqAX79LkY7kjOyV+Pv2evjpRqx3l2/aL/E+F
	MRuiG92p7dsfqn0aXYYVGBQmZseWp93gvnj/IOdCu0lqsNX6VPcOn4HAhrc88Ad9t0R3c0MGcRD
	owVim+J7e9t1FWqlQYaTWu4hm/3uHkF9Oalytz6YY8kyELAsnZWoahoNyUkzV3Q14X5SQHWkrxp
	/WmkkAA2G1QpDGNfN6oIt6co4uLbjxKE2WUm13SCxPk6KEr+QbedBBHeZcqXcjMOX1ezvsbo/dT
	r6pEkP49bqu1vkJOf8cnxr0HK3Lgp+Caivgmor1a5muceF1DXiqxcLMZ+ciKjphQayJta2kzxdI
	hnnQwxoMl4vgRFbfvN2PN7V3BVkLvp75XBKex8PJUohLXvx/mytRz76gYvU1Ng49Kwny4t7mBrJ
	xrprJ+8NUNOHwMTxTrDxoed1SI6FDUU4GpDCUbL/f0NPXp3Zs=
X-Received: by 2002:a05:600c:3b18:b0:482:e5d4:b7ca with SMTP id 5b1f17b1804b1-4854b0b32d8mr122128455e9.8.1773329725848;
        Thu, 12 Mar 2026 08:35:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:25 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/11] dt-bindings: usb: Document Renesas RZ/G3E USB3HOST
Date: Thu, 12 Mar 2026 15:35:08 +0000
Message-ID: <20260312153522.1131675-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22359

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


