Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E644C77B75
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 08:54:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.83643.1684140840125071478
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 01:54:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,276,1677510000"; 
   d="scan'208";a="162922197"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 May 2023 17:53:58 +0900
Received: from localhost.localdomain (unknown [10.226.93.20])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A7942400264E;
	Mon, 15 May 2023 17:53:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/4] dt-bindings: dma: rz-dmac: Document clock-names and reset-names
Date: Mon, 15 May 2023 09:53:49 +0100
Message-Id: <20230515085352.25794-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
References: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 08:54:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11447

commit 5aaf9079d740ebe57f10dfefb1850011d6bb7b2a upstream.

Document clock-names and reset-names properties as we have multiple
clocks and resets.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230315064726.22739-1-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 1e25c5b0fb4d..7e472f3d6087 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -54,6 +54,11 @@ properties:
       - description: DMA main clock
       - description: DMA register access clock
 
+  clock-names:
+    items:
+      - const: main
+      - const: register
+
   '#dma-cells':
     const: 1
     description:
@@ -77,16 +82,23 @@ properties:
       - description: Reset for DMA ARESETN reset terminal
       - description: Reset for DMA RST_ASYNC reset terminal
 
+  reset-names:
+    items:
+      - const: arst
+      - const: rst_async
+
 required:
   - compatible
   - reg
   - interrupts
   - interrupt-names
   - clocks
+  - clock-names
   - '#dma-cells'
   - dma-channels
   - power-domains
   - resets
+  - reset-names
 
 additionalProperties: false
 
@@ -124,9 +136,11 @@ examples:
                           "ch12", "ch13", "ch14", "ch15";
         clocks = <&cpg CPG_MOD R9A07G044_DMAC_ACLK>,
                  <&cpg CPG_MOD R9A07G044_DMAC_PCLK>;
+        clock-names = "main", "register";
         power-domains = <&cpg>;
         resets = <&cpg R9A07G044_DMAC_ARESETN>,
                  <&cpg R9A07G044_DMAC_RST_ASYNC>;
+        reset-names = "arst", "rst_async";
         #dma-cells = <1>;
         dma-channels = <16>;
     };
-- 
2.25.1


