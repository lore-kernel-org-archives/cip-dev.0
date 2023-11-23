Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EF9C624B4
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 18:29:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.101862.1700764164791607983
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 10:29:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,222,1695654000"; 
   d="scan'208";a="187858472"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Nov 2023 03:29:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.37])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 210734055795;
	Fri, 24 Nov 2023 03:29:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 10/12] dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt names
Date: Thu, 23 Nov 2023 18:28:52 +0000
Message-Id: <20231123182854.422379-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123182854.422379-1-biju.das.jz@bp.renesas.com>
References: <20231123182854.422379-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 18:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13683

commit b7a8f1f7a8a25e09aaefebb6251a77f44cda638b upstream.

As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3 overflow/underflow
interrupt names starts with 'tci' instead of 'tgi'.

Fix this documentation issue by replacing below overflow/underflow
interrupt names:
 - tgiv0->tciv0
 - tgiv1->tciv1
 - tgiu1->tciu1
 - tgiv2->tciv2
 - tgiu2->tciu2
 - tgiv3->tciv3
 - tgiv4->tciv4
 - tgiv6->tciv6
 - tgiv7->tciv7
 - tgiv8->tciv8
 - tgiu8->tciu8

Fixes: 0a9d6b54297e ("dt-bindings: timer: Document RZ/G2L MTU3a bindings")
Cc: stable@kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230727081848.100834-2-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/timer/renesas,rz-mtu3.yaml       | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index bffdab0b0185..fbac40b958dd 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -169,27 +169,27 @@ properties:
       - const: tgib0
       - const: tgic0
       - const: tgid0
-      - const: tgiv0
+      - const: tciv0
       - const: tgie0
       - const: tgif0
       - const: tgia1
       - const: tgib1
-      - const: tgiv1
-      - const: tgiu1
+      - const: tciv1
+      - const: tciu1
       - const: tgia2
       - const: tgib2
-      - const: tgiv2
-      - const: tgiu2
+      - const: tciv2
+      - const: tciu2
       - const: tgia3
       - const: tgib3
       - const: tgic3
       - const: tgid3
-      - const: tgiv3
+      - const: tciv3
       - const: tgia4
       - const: tgib4
       - const: tgic4
       - const: tgid4
-      - const: tgiv4
+      - const: tciv4
       - const: tgiu5
       - const: tgiv5
       - const: tgiw5
@@ -197,18 +197,18 @@ properties:
       - const: tgib6
       - const: tgic6
       - const: tgid6
-      - const: tgiv6
+      - const: tciv6
       - const: tgia7
       - const: tgib7
       - const: tgic7
       - const: tgid7
-      - const: tgiv7
+      - const: tciv7
       - const: tgia8
       - const: tgib8
       - const: tgic8
       - const: tgid8
-      - const: tgiv8
-      - const: tgiu8
+      - const: tciv8
+      - const: tciu8
 
   clocks:
     maxItems: 1
@@ -285,16 +285,16 @@ examples:
                    <GIC_SPI 211 IRQ_TYPE_EDGE_RISING>,
                    <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
                    <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
-      interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0", "tgiv0", "tgie0",
+      interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0", "tciv0", "tgie0",
                         "tgif0",
-                        "tgia1", "tgib1", "tgiv1", "tgiu1",
-                        "tgia2", "tgib2", "tgiv2", "tgiu2",
-                        "tgia3", "tgib3", "tgic3", "tgid3", "tgiv3",
-                        "tgia4", "tgib4", "tgic4", "tgid4", "tgiv4",
+                        "tgia1", "tgib1", "tciv1", "tciu1",
+                        "tgia2", "tgib2", "tciv2", "tciu2",
+                        "tgia3", "tgib3", "tgic3", "tgid3", "tciv3",
+                        "tgia4", "tgib4", "tgic4", "tgid4", "tciv4",
                         "tgiu5", "tgiv5", "tgiw5",
-                        "tgia6", "tgib6", "tgic6", "tgid6", "tgiv6",
-                        "tgia7", "tgib7", "tgic7", "tgid7", "tgiv7",
-                        "tgia8", "tgib8", "tgic8", "tgid8", "tgiv8", "tgiu8";
+                        "tgia6", "tgib6", "tgic6", "tgid6", "tciv6",
+                        "tgia7", "tgib7", "tgic7", "tgid7", "tciv7",
+                        "tgia8", "tgib8", "tgic8", "tgid8", "tciv8", "tciu8";
       clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
       power-domains = <&cpg>;
       resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
-- 
2.25.1


