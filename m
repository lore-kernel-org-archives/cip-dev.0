Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12300CF9C4F
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1331.1763657853816003082
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 08:57:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: yYTrChVXTyqzloxC3R8Zkw==
X-CSE-MsgGUID: e/1b2DMZR6mNZfHOHn2qAA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Nov 2025 01:57:36 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 39B13405DC26;
	Fri, 21 Nov 2025 01:57:34 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 4/9] dt-bindings: phy: renesas,usb2-phy: Add clock constraint for RZ/G2L family
Date: Thu, 20 Nov 2025 16:57:21 +0000
Message-ID: <20251120165726.18296-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
References: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 16:57:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20641

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 31eebeef8cdd4c9bddc9d34053cab6553616d0b7 upstream.

The RZ/G2L family requires two clocks for USB2 PHY, which are already
defined in the DTSI files. Add a constraint in the DT binding document
to ensure validation with `dtbs_check`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250414145729.343133-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index f82649a55e91..af9ed41c00c5 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -105,6 +105,9 @@ allOf:
           contains:
             const: renesas,rzg2l-usb2-phy
     then:
+      properties:
+        clocks:
+          minItems: 2
       required:
         - resets
 
-- 
2.51.0


