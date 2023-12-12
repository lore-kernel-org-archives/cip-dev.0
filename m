Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A7C4167B
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 12:40:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.630.1702384840537154755
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Dec 2023 04:40:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,270,1695654000"; 
   d="scan'208";a="190069298"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 12 Dec 2023 21:40:43 +0900
Received: from localhost.localdomain (unknown [10.226.93.124])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BFACB40001D0;
	Tue, 12 Dec 2023 21:40:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 02/14] dt-bindings: gpu: mali-bifrost: Document RZ/V2L SoC
Date: Tue, 12 Dec 2023 12:40:23 +0000
Message-Id: <20231212124035.151367-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
References: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Dec 2023 12:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14045

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5dc6ce767dc8ba173534fa75c66a9e2a13b969d1 upstream.

The Renesas RZ/V2L SoC (a.k.a R9A07G054) has a Bifrost Mali-G31 GPU,
add a compatible string for it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220308211543.3081-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 3b32d34f5a8e..d4b83bc46263 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -19,6 +19,7 @@ properties:
           - amlogic,meson-g12a-mali
           - realtek,rtd1619-mali
           - renesas,r9a07g044-mali
+          - renesas,r9a07g054-mali
           - rockchip,px30-mali
       - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
 
@@ -85,7 +86,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a07g044-mali
+            enum:
+              - renesas,r9a07g044-mali
+              - renesas,r9a07g054-mali
     then:
       properties:
         interrupts:
-- 
2.25.1


