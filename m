Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87468C433EF
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 13:31:55 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.5175.1640007108515707926
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 05:31:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,220,1635174000";
   d="scan'208";a="104110963"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Dec 2021 22:31:54 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4A58A40001CB;
	Mon, 20 Dec 2021 22:31:53 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/22] dt-bindings: i2c: renesas,riic: Document
 RZ/G2L I2C controller
Date: Mon, 20 Dec 2021 13:31:27 +0000
Message-Id: <20211220133139.21624-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 13:31:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7207

From: Biju Das <biju.das.jz@bp.renesas.com>

commit a431a0914f9276aa70b7075cb43b9cdc537eaf29 upstream.

Document RZ/G2L I2C controller bindings.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/i2c/renesas,riic.yaml | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index 2d6378164958..52d92ec7ec0b 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/i2c/renesas,riic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/A I2C Bus Interface (RIIC)
+title: Renesas RZ/A and RZ/G2L I2C Bus Interface (RIIC)
 
 maintainers:
   - Chris Brandt <chris.brandt@renesas.com>
@@ -17,9 +17,10 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,riic-r7s72100 # RZ/A1H
-          - renesas,riic-r7s9210  # RZ/A2M
-      - const: renesas,riic-rz    # RZ/A
+          - renesas,riic-r7s72100   # RZ/A1H
+          - renesas,riic-r7s9210    # RZ/A2M
+          - renesas,riic-r9a07g044  # RZ/G2{L,LC}
+      - const: renesas,riic-rz      # RZ/A or RZ/G2L
 
   reg:
     maxItems: 1
@@ -56,6 +57,16 @@ required:
   - '#address-cells'
   - '#size-cells'
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,riic-r9a07g044
+then:
+  required:
+    - resets
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1


