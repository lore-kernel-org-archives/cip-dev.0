Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE04C4332F
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 00:46:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.34462.1639529178973052996
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Dec 2021 16:46:19 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,206,1635174000";
   d="scan'208";a="103952845"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Dec 2021 09:46:18 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2C50D41657F0;
	Wed, 15 Dec 2021 09:46:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/7] dt-bindings: arm: renesas: Document Renesas
 RZ/G2{L,LC} SoC variants
Date: Wed, 15 Dec 2021 00:46:07 +0000
Message-Id: <20211215004612.13289-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Dec 2021 00:46:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7102

commit 2cd22416745fe1f0f6b6fa70c09438f85e20c693 upstream.

Add device tree bindings documentation for Renesas RZ/G2{L,LC}
SoC variants.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20210609153230.6967-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 0f8e38833de6..2355c5f285a0 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -306,6 +306,15 @@ properties:
               - renesas,r9a07g043u12 # RZ/G2UL Type-2
           - const: renesas,r9a07g043
 
+      - description: RZ/G2{L,LC} (R9A07G044)
+        items:
+          - enum:
+              - renesas,r9a07g044c1 # Single Cortex-A55 RZ/G2LC
+              - renesas,r9a07g044c2 # Dual Cortex-A55 RZ/G2LC
+              - renesas,r9a07g044l1 # Single Cortex-A55 RZ/G2L
+              - renesas,r9a07g044l2 # Dual Cortex-A55 RZ/G2L
+          - const: renesas,r9a07g044
+
 additionalProperties: true
 
 ...
-- 
2.17.1


