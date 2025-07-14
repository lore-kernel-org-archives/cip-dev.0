Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D938DC83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74858.1752487721947632755
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: ltvEN1WRTAWA55EHFRusoA==
X-CSE-MsgGUID: 1n9sRxQsReOrBH4tf8IXUQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EA1BD41D45A9;
	Mon, 14 Jul 2025 19:08:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 18/57] dt-bindings: can: renesas,rcar-canfd: R-Car V3U is R-Car Gen4
Date: Mon, 14 Jul 2025 11:06:59 +0100
Message-ID: <20250714100802.80035-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19446

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit e8b98168761fab16ff35eac0d27d9ca21eb42788 upstream.

Despite the name, R-Car V3U is the first member of the R-Car Gen4
family.  Hence generalize this by introducing a family-specific
compatible value for R-Car Gen4.

While at it, replace "both channels" by "all channels", as the numbers
of channels may differ from two.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/all/4dea4b7dd76d4f859ada85f97094b7adeef5169f.1674499048.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml          | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 1eb98c9a1a26..899efa8a0614 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -28,6 +28,11 @@ properties:
               - renesas,r8a77995-canfd     # R-Car D3
           - const: renesas,rcar-gen3-canfd # R-Car Gen3 and RZ/G2
 
+      - items:
+          - enum:
+              - renesas,r8a779a0-canfd     # R-Car V3U
+          - const: renesas,rcar-gen4-canfd # R-Car Gen4
+
       - items:
           - enum:
               - renesas,r9a07g043-canfd    # RZ/G2UL and RZ/Five
@@ -35,8 +40,6 @@ properties:
               - renesas,r9a07g054-canfd    # RZ/V2L
           - const: renesas,rzg2l-canfd     # RZ/G2L family
 
-      - const: renesas,r8a779a0-canfd      # R-Car V3U
-
   reg:
     maxItems: 1
 
@@ -60,7 +63,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
       The controller can operate in either CAN FD only mode (default) or
-      Classical CAN only mode.  The mode is global to both the channels.
+      Classical CAN only mode.  The mode is global to all channels.
       Specify this property to put the controller in Classical CAN only mode.
 
   assigned-clocks:
@@ -159,7 +162,7 @@ allOf:
         properties:
           compatible:
             contains:
-              const: renesas,r8a779a0-canfd
+              const: renesas,rcar-gen4-canfd
     then:
       patternProperties:
         "^channel[2-7]$": false
-- 
2.43.0


