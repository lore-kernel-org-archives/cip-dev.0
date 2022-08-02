Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC73C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:31 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4832.1659438534534175527
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:09:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="130054363"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 20:09:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B1637400D4CE;
	Tue,  2 Aug 2022 20:09:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 13/24] dt-bindings: serial: renesas,scif: Document
 RZ/V2L SoC
Date: Tue,  2 Aug 2022 12:08:39 +0100
Message-Id: <20220802110850.1496057-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9010

commit b0c86a6083229db0518e2754b2b6298e40e8d637 upstream.

Add SCIF binding documentation for Renesas RZ/V2L SoC. SCIF block on RZ/V2L
is identical to one found on the RZ/G2L SoC. No driver changes are required
as RZ/G2L compatible string "renesas,scif-r9a07g044" will be used as a
fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20211221094717.16187-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 701cb4936f3c..d1fd82aac212 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -66,6 +66,12 @@ properties:
       - items:
           - enum:
               - renesas,scif-r9a07g044      # RZ/G2{L,LC}
+              - renesas,scif-r9a07g054      # RZ/V2L
+
+      - items:
+          - enum:
+              - renesas,scif-r9a07g054      # RZ/V2L
+          - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback for RZ/V2L
 
   reg:
     maxItems: 1
@@ -151,6 +157,7 @@ if:
           - renesas,rcar-gen2-scif
           - renesas,rcar-gen3-scif
           - renesas,scif-r9a07g044
+          - renesas,scif-r9a07g054
 then:
   required:
     - resets
-- 
2.25.1


