Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD9C44501
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:12:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3720.1783498327591677162
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6513442CC0;
	Wed,  8 Jul 2026 08:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2101F000E9;
	Wed,  8 Jul 2026 08:12:06 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 04/22] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S support
Date: Wed,  8 Jul 2026 11:11:41 +0300
Message-ID: <20260708081159.3882514-5-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
References: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:12:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23510

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 20eee0f69c9034a0f613528f829dcaca192740d5 upstream.

The Renesas USB PHY hardware block needs to have the PWRRDY bit in the
system controller set before applying any other settings. The PWRRDY bit
must be controlled during power-on, power-off, and system suspend/resume
sequences as follows:
- during power-on/resume, it must be set to zero before enabling clocks a=
nd
  modules
- during power-off/suspend, it must be set to one after disabling clocks
  and modules

Add the renesas,sysc-pwrrdy device tree property, which allows the
reset-rzg2l-usbphy-ctrl driver to parse, map, and control the system
controller PWRRDY bit at the appropriate time. Along with it add a new
compatible for the RZ/G3S SoC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
[claudiu.beznea: fixed conflict by dropping the "and RZ/Five" string
 from the description of renesas,r9a07g043-usbphy-ctrl compatible]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy=
-ctrl.yaml b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy=
-ctrl.yaml
index ca6a3002546e..c04176315af1 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.y=
aml
+++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.y=
aml
@@ -15,12 +15,14 @@ description:
=20
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL
-          - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
-          - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
-      - const: renesas,rzg2l-usbphy-ctrl
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL
+              - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
+              - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
+          - const: renesas,rzg2l-usbphy-ctrl
+      - const: renesas,r9a08g045-usbphy-ctrl # RZ/G3S
=20
   reg:
     maxItems: 1
@@ -48,6 +50,20 @@ properties:
     $ref: /schemas/regulator/regulator.yaml#
     unevaluatedProperties: false
=20
+  renesas,sysc-pwrrdy:
+    description:
+      The system controller PWRRDY indicates to the USB PHY if the power=
 supply
+      is ready. PWRRDY needs to be set during power-on before applying a=
ny
+      other settings. It also needs to be set before powering off the US=
B.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description:
+              System controller phandle required by USB PHY CTRL driver =
to set
+              PWRRDY
+          - description: Register offset associated with PWRRDY
+          - description: Register bitmask associated with PWRRDY
+
 required:
   - compatible
   - reg
@@ -57,6 +73,19 @@ required:
   - '#reset-cells'
   - regulator-vbus
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-usbphy-ctrl
+    then:
+      required:
+        - renesas,sysc-pwrrdy
+    else:
+      properties:
+        renesas,sysc-pwrrdy: false
+
 additionalProperties: false
=20
 examples:
--=20
2.43.0


