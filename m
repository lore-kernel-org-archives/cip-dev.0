Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C33C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:17:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.6206.1682061466156625619
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:17:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="160252344"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2023 16:17:47 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BB2FE41AA647;
	Fri, 21 Apr 2023 16:17:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 06/33] dt-bindings: arm: renesas: Document Renesas RZ/V2M SoC and EVK board
Date: Fri, 21 Apr 2023 08:17:02 +0100
Message-Id: <20230421071729.130347-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:17:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11279

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 358d1cef2a88f590a183a0357b944674097ec0ab upstream.

Details of the SoC can be found here:
https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-cortex-a-mpus/rzv2m-dual-cortex-a53-lpddr4x32bit-ai-accelerator-isp-4k-video-codec-4k-camera-input-fhd-display-output

The RZ/V2M Evaluation Kit (V2MEVK) consists of the RZ/V2M Main Board,
RZ/V2M Base Board, and CIS IMX415 Board (CIS).

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20220330154024.112270-2-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 75e00f50ee5e..9f62712d3237 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -328,6 +328,12 @@ properties:
               - renesas,r9a07g054l2 # Dual Cortex-A55 RZ/V2L
           - const: renesas,r9a07g054
 
+      - description: RZ/V2M (R9A09G011)
+        items:
+          - enum:
+              - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
+          - const: renesas,r9a09g011
+
 additionalProperties: true
 
 ...
-- 
2.25.1


