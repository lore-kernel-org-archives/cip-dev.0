Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20118C27C7B
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 10:45:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.5305.1718275500975240680
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 03:45:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="211744110"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Jun 2024 19:44:59 +0900
Received: from localhost.localdomain (unknown [10.226.92.168])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6F1F342D2368;
	Thu, 13 Jun 2024 19:44:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 1/7] dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
Date: Thu, 13 Jun 2024 11:44:47 +0100
Message-Id: <20240613104453.422524-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
References: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 10:45:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16203

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d990e227741692079872a8336d961ef4ab9e8aaf upstream.

The USBHS IP block on the RZ/Five SoC is identical to one found on the
RZ/G2UL SoC. "renesas,usbhs-r9a07g043" compatible string will be used on
the RZ/Five SoC so to make this clear and to keep this file consistent,
update the comment to include RZ/Five SoC.

No driver changes are required as generic compatible string
"renesas,rza2-usbhs" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20231115211407.32067-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index bad55dfb2fa0..40ada78f2328 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -19,7 +19,7 @@ properties:
       - items:
           - enum:
               - renesas,usbhs-r7s9210   # RZ/A2
-              - renesas,usbhs-r9a07g043 # RZ/G2UL
+              - renesas,usbhs-r9a07g043 # RZ/G2UL and RZ/Five
               - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
               - renesas,usbhs-r9a07g054 # RZ/V2L
           - const: renesas,rza2-usbhs
-- 
2.25.1


