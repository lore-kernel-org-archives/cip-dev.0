Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D52C3DA7E
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.59142.1722267074879486248
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:31:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213908938"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:31:19 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 839574006A90;
	Tue, 30 Jul 2024 00:31:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/13] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document USB VBUS regulator
Date: Mon, 29 Jul 2024 16:30:42 +0100
Message-ID: <20240729153109.510325-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
References: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16657

commit f64f2d6fdda459b10bc8f774ed87e9980a5021e5 upstream.

The VBUS enable can be controlled by the VBOUT bit of the VBUS control
register. This register is part of usbphy-ctrl IP.

Document the USB VBUS regulator object.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20240702180032.207275-2-biju.das.jz@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
index 731b8ce01525..ca6a3002546e 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
+++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
@@ -42,6 +42,12 @@ properties:
       0 = Port 1 Phy reset
       1 = Port 2 Phy reset
 
+  regulator-vbus:
+    type: object
+    description: USB VBUS regulator
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -49,6 +55,7 @@ required:
   - resets
   - power-domains
   - '#reset-cells'
+  - regulator-vbus
 
 additionalProperties: false
 
@@ -64,4 +71,7 @@ examples:
         resets = <&cpg R9A07G044_USB_PRESETN>;
         power-domains = <&cpg>;
         #reset-cells = <1>;
+        regulator-vbus {
+            regulator-name = "vbus";
+        };
     };
-- 
2.43.0


