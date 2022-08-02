Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC9BC3F6B0
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:31 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4832.1659438534534175527
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:09:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="130054372"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 20:09:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3784D4004934;
	Tue,  2 Aug 2022 20:09:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 15/24] dt-bindings: pinctrl: renesas: Document
 RZ/V2L pinctrl
Date: Tue,  2 Aug 2022 12:08:41 +0100
Message-Id: <20220802110850.1496057-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9012

commit c07b19de2f7ac91662aa99767815a258da6ef16f upstream.

Document Renesas RZ/V2L pinctrl bindings.  The RZ/V2L SoC is package-
and pin-compatible with RZ/G2L.  No driver changes are required as the
RZ/G2L compatible string "renesas,r9a07g044-pinctrl" will be used as a
fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220110134659.30424-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 83488cd8673d..e4849a3680e0 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/pinctrl/renesas,rzg2l-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/G2L combined Pin and GPIO controller
+title: Renesas RZ/{G2L,V2L} combined Pin and GPIO controller
 
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
   - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 
 description:
-  The Renesas SoCs of the RZ/G2L series feature a combined Pin and GPIO
+  The Renesas SoCs of the RZ/{G2L,V2L} series feature a combined Pin and GPIO
   controller.
   Pin multiplexing and GPIO configuration is performed on a per-pin basis.
   Each port features up to 8 pins, each of them configurable for GPIO function
@@ -20,8 +20,15 @@ description:
 
 properties:
   compatible:
-    enum:
-      - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
+
+      - items:
+          - enum:
+              - renesas,r9a07g054-pinctrl     # RZ/V2L
+          - const: renesas,r9a07g044-pinctrl  # RZ/G2{L,LC} fallback for RZ/V2L
 
   reg:
     maxItems: 1
-- 
2.25.1


