Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B6D32D6B
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:11 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7063.1764945182570660387
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: NCfE83TySQ+5Ul0QqKhJRQ==
X-CSE-MsgGUID: q9wtma9/QpeAMTHnQy6ldQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:04 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1600C417A625;
	Fri,  5 Dec 2025 23:33:02 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/38] dt-bindings: serial: renesas,rsci: Add optional secondary clock input
Date: Fri,  5 Dec 2025 14:32:22 +0000
Message-ID: <20251205143258.13748-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20916

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

commit dfa983c98cf76b4f22f3b8e3f30b9672c969f70a upstream.

Update the RSCI binding to support an optional secondary clock input on
the RZ/T2H SoC. At boot, the RSCI operates using the default synchronous
clock (PCLKM core clock), which is enabled by the bootloader. However, to
support a wider range of baud rates, the hardware also requires an
asynchronous external clock input. Clock selection is controlled
internally by the CCR3 register in the RSCI block.

Due to an incomplete understanding of the hardware, the original binding
defined only a single clock ("fck"), which is insufficient to describe the
full capabilities of the RSCI on RZ/T2H. This update corrects the binding
by allowing up to three clocks and defining the `clock-names` as
"operation", "bus", and optionally "sck" for the asynchronous clock input.

This is an ABI change, as it modifies the expected number and names of
clocks. However, since there are no in-kernel consumers of this binding
yet, the change is considered safe and non-disruptive.

Also remove the unneeded `serial0` alias from the DTS example and use
the R9A09G077_CLK_PCLKM macro for core clock.

Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
Link: https://lore.kernel.org/r/20250630202323.279809-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/serial/renesas,rsci.yaml           | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index ea879db5f4850..1bf255407df0e 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -35,10 +35,15 @@ properties:
       - const: tei
 
   clocks:
-    maxItems: 1
+    minItems: 2
+    maxItems: 3
 
   clock-names:
-    const: fck # UART functional clock
+    minItems: 2
+    items:
+      - const: operation
+      - const: bus
+      - const: sck # optional external clock input
 
   power-domains:
     maxItems: 1
@@ -60,10 +65,6 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/renesas-cpg-mssr.h>
 
-    aliases {
-        serial0 = &sci0;
-    };
-
     sci0: serial@80005000 {
         compatible = "renesas,r9a09g077-rsci";
         reg = <0x80005000 0x400>;
@@ -72,7 +73,7 @@ examples:
                      <GIC_SPI 592 IRQ_TYPE_EDGE_RISING>,
                      <GIC_SPI 593 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-names = "eri", "rxi", "txi", "tei";
-        clocks = <&cpg CPG_MOD 108>;
-        clock-names = "fck";
+        clocks = <&cpg CPG_MOD 8>, <&cpg CPG_CORE 13>;
+        clock-names = "operation", "bus";
         power-domains = <&cpg>;
     };
-- 
2.43.0


