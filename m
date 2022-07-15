Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C05C43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:22:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.3865.1657869771063039530
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:22:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127955780"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:22:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D88BE40158E5;
	Fri, 15 Jul 2022 16:22:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/24] dt-bindings: power: renesas,rzg2l-sysc:
 Document RZ/V2L SoC
Date: Fri, 15 Jul 2022 08:22:22 +0100
Message-Id: <20220715072244.2298757-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:22:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8788

commit 4b4a0fd666303a06bbe159552bc055b490b77cdc upstream.

Add DT binding documentation for the SYSC controller found on the RZ/V2L
SoC.  This SYSC controller is almost identical to the one found on the
RZ/G2L SoC, the only difference being that SYSC on RZ/V2L has an
additional register to control the DRP-AI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220110134659.30424-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/power/renesas,rzg2l-sysc.yaml      | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
index 84ddc772b003..bb433e75a0ee 100644
--- a/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
@@ -4,14 +4,14 @@
 $id: "http://devicetree.org/schemas/power/renesas,rzg2l-sysc.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Renesas RZ/G2L System Controller (SYSC)
+title: Renesas RZ/{G2L,V2L} System Controller (SYSC)
 
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
 description:
-  The RZ/G2L System Controller (SYSC) performs system control of the LSI and
-  supports following functions,
+  The RZ/{G2L,V2L} System Controller (SYSC) performs system control of the LSI
+  and supports following functions,
   - External terminal state capture function
   - 34-bit address space access function
   - Low power consumption control
@@ -21,6 +21,7 @@ properties:
   compatible:
     enum:
       - renesas,r9a07g044-sysc # RZ/G2{L,LC}
+      - renesas,r9a07g054-sysc # RZ/V2L
 
   reg:
     maxItems: 1
-- 
2.25.1


