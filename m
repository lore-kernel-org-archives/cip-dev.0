Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E99C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:14:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5186.1745583290157660139
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 05:14:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: EdGPN+3tQsmelUty4sTkPg==
X-CSE-MsgGUID: USlx+pt7T82YIELZc9d0OQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Apr 2025 21:14:50 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 41ECA42D7EC7;
	Fri, 25 Apr 2025 21:14:49 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 01/21] dt-bindings: soc: renesas: Document Renesas RZ/V2H(P) SoC variants
Date: Fri, 25 Apr 2025 13:14:25 +0100
Message-ID: <20250425121445.62818-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 12:14:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18623

commit 66010ba94c9b9c273eb9682132d6b809440b9013 upstream.

Document Renesas RZ/V2H(P) (R9A09G057) SoC variants.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240227232531.218159-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 05a96ac138b80..4c8fc474fbcb1 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -502,6 +502,14 @@ properties:
               - renesas,r9a09g047e58 # Quad Cortex-A55 + Cortex-M33 + Ethos-U55 (21mm BGA)
           - const: renesas,r9a09g047
 
+      - description: RZ/V2H(P) (R9A09G057)
+        items:
+          - enum:
+              - renesas,r9a09g057h41 # RZ/V2H
+              - renesas,r9a09g057h42 # RZ/V2H with Mali-G31 support
+              - renesas,r9a09g057h44 # RZ/V2HP with Mali-G31 + Mali-C55 support
+          - const: renesas,r9a09g057
+
 additionalProperties: true
 
 ...
-- 
2.43.0


