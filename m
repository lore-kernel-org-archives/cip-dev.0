Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9D0C7EE23
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:41 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.34984.1685631867442791752
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="165350513"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:31 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0EA3140078AA;
	Fri,  2 Jun 2023 00:04:29 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 07/19] dt-bindings: usb: renesas,usb3-peri: Document RZ/V2MA bindings
Date: Thu,  1 Jun 2023 16:03:58 +0100
Message-Id: <20230601150410.124773-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11737

commit 2c5502a4dc9ffb9145ef80e642be0f1f03c037e8 upstream.

Document RZ/V2MA usb3-peri bindings. RZ/V2MA usb3-peri is identical
to one found on the RZ/V2M SoC. No driver changes are required as
generic compatible string "renesas,rzv2m-usb3-peri" will be used as
a fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230121145853.4792-4-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
index fbbbc3de3ec0..2767358cf4ac 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml
@@ -28,6 +28,7 @@ properties:
       - items:
           - enum:
               - renesas,r9a09g011-usb3-peri # RZ/V2M
+              - renesas,r9a09g055-usb3-peri # RZ/V2MA
           - const: renesas,rzv2m-usb3-peri
 
   reg:
-- 
2.25.1


