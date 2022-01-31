Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FB7C433EF
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.31206.1643631558306709663
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:18 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108231902"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D23F84347FE1;
	Mon, 31 Jan 2022 21:19:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/27] dt-bindings: memory: renesas,rpc-if:
 Miscellaneous improvements
Date: Mon, 31 Jan 2022 12:18:45 +0000
Message-Id: <20220131121903.8620-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7530

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit dbe60e5d7f15454ecc9c7d93dce6240fdaa70da9 upstream.

  - Fix rejection of legitimate flash subnodes containing multiple
    compatible values,
  - Add missing list of required properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/d81b59a513c2a5204c8378b4a89cd07f97c46797.1627401508.git.geert+renesas@glider.be
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../memory-controllers/renesas,rpc-if.yaml      | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index 6d6ba608fd22..ebc1052a5e9b 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -57,12 +57,23 @@ patternProperties:
     type: object
     properties:
       compatible:
-        enum:
-          - cfi-flash
-          - jedec,spi-nor
+        contains:
+          enum:
+            - cfi-flash
+            - jedec,spi-nor
 
 unevaluatedProperties: false
 
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - power-domains
+  - resets
+  - '#address-cells'
+  - '#size-cells'
+
 examples:
   - |
     #include <dt-bindings/clock/renesas-cpg-mssr.h>
-- 
2.17.1


