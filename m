Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FD6CF9C51
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1330.1763657851749142333
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 08:57:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: lQTcdDPST9K8Oo7nQf3pYA==
X-CSE-MsgGUID: MBE0e0PiS3qKzsmD2EQ6kw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2025 01:57:31 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E568F405D4C7;
	Fri, 21 Nov 2025 01:57:29 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 1/9] dt-bindings: usb: renesas,usbhs: Add RZ/V2H(P) SoC support
Date: Thu, 20 Nov 2025 16:57:18 +0000
Message-ID: <20251120165726.18296-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
References: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 16:57:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20638

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c0a1d1e9a48f36086ef5a2863844175476bd3b8e upstream.

Document the Renesas USBHS controller found on the Renesas RZ/V2H(P) SoC.
The USBHS block on RZ/V2H(P) is functionally identical to the one on the
RZ/G2L family, so no driver changes are needed. The existing
"renesas,rzg2l-usbhs" fallback compatible will continue to be used for
handling this IP.

In addition, update the schema validation logic by replacing the enum list
of SoC-specific compatibles with a const "renesas,rzg2l-usbhs" as all
listed SoCs share identical USBHS hardware and already include the fallback
compatible. This will help to simplify the schema and avoid redundancy.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250414165201.362262-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index c63db3ebd07b..45d133253094 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -26,6 +26,7 @@ properties:
               - renesas,usbhs-r9a07g043 # RZ/G2UL and RZ/Five
               - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
               - renesas,usbhs-r9a07g054 # RZ/V2L
+              - renesas,usbhs-r9a09g057 # RZ/V2H(P)
           - const: renesas,rzg2l-usbhs
 
       - items:
@@ -122,10 +123,7 @@ allOf:
       properties:
         compatible:
           contains:
-            enum:
-              - renesas,usbhs-r9a07g043
-              - renesas,usbhs-r9a07g044
-              - renesas,usbhs-r9a07g054
+            const: renesas,rzg2l-usbhs
     then:
       properties:
         interrupts:
-- 
2.51.0


