Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF65C67868
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 08:02:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.9630.1662019297178432331
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 01:01:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,280,1654527600";
   d="scan'208";a="133337181"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 17:01:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.226])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2573C40083EF;
	Thu,  1 Sep 2022 17:01:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 03/13] dt-bindings: usb: renesas,usbhs: Document
 RZ/G2UL bindings
Date: Thu,  1 Sep 2022 09:01:18 +0100
Message-Id: <20220901080128.2147891-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
References: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 08:02:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9407

commit 7a60fa06e80596dba5381fb018f5102ae4897658 upstream.

Document RZ/G2ULSoC bindings. USBHS block is identical to one
found on RZ/A2 SoC. No driver changes are required as generic compatible
string "renesas,rza2-usbhs" will be used as a fallback.

While at it, make the resets property required on RZ/{G2L,G2UL,V2L} SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220425140215.186797-1-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index a123a5056d74..18c301ef9698 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -19,6 +19,7 @@ properties:
       - items:
           - enum:
               - renesas,usbhs-r7s9210   # RZ/A2
+              - renesas,usbhs-r9a07g043 # RZ/G2UL
               - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
               - renesas,usbhs-r9a07g054 # RZ/V2L
           - const: renesas,rza2-usbhs
@@ -123,6 +124,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - renesas,usbhs-r9a07g043
               - renesas,usbhs-r9a07g044
               - renesas,usbhs-r9a07g054
     then:
@@ -133,6 +135,8 @@ allOf:
             - description: U2P_INT_DMA[0]
             - description: U2P_INT_DMA[1]
             - description: U2P_INT_DMAERR
+      required:
+        - resets
     else:
       properties:
         interrupts:
-- 
2.25.1


