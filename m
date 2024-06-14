Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA36C27C79
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 10:13:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.8281.1718360006029977314
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 03:13:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="211895911"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jun 2024 19:13:32 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CCE0B428BB2E;
	Fri, 14 Jun 2024 19:13:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 08/14] dt-bindings: display: renesas,rzg2l-du: Document RZ/V2L DU bindings
Date: Fri, 14 Jun 2024 11:13:02 +0100
Message-Id: <20240614101308.40407-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
References: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 10:13:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16241

commit ac23216bb1f5caa5ae6f3ac70aa7f78a5b50f88d upstream.

Document DU found in RZ/V2L SoC. The DU block is identical to RZ/G2L
SoC and therefore use RZ/G2L fallback to avoid any driver changes.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240218164840.57662-3-biju.das.jz@bp.renesas.com
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/display/renesas,rzg2l-du.yaml    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index c0ad194c538d..08e5b9478051 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -16,8 +16,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - renesas,r9a07g044-du # RZ/G2{L,LC}
+    oneOf:
+      - enum:
+          - renesas,r9a07g044-du # RZ/G2{L,LC}
+      - items:
+          - enum:
+              - renesas,r9a07g054-du    # RZ/V2L
+          - const: renesas,r9a07g044-du # RZ/G2L fallback
 
   reg:
     maxItems: 1
-- 
2.25.1


