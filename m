Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC85FD489B8
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 12:52:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34123.1768827110577540923
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 04:51:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: c5MesoqLTGKAwbH+oS4t8Q==
X-CSE-MsgGUID: JRFpM639RR28OXQoLQIBuA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jan 2026 21:51:55 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D78C5401BC1B;
	Mon, 19 Jan 2026 21:51:53 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 3/6] dt-bindings: usb: renesas,usbhs: Add RZ/V2N SoC support
Date: Mon, 19 Jan 2026 12:51:44 +0000
Message-ID: <20260119125147.32175-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119125147.32175-1-ovidiu.panait.rb@renesas.com>
References: <20260119125147.32175-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 12:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21655

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 1857571e4f50323da9f24f63b8095286d83d490c upstream.

Document the Renesas USBHS controller found on the Renesas RZ/V2N
(R9A09G056) SoC. The USBHS block on RZ/V2N is functionally identical to
the one on the RZ/G2L family, so no driver changes are needed. The
existing "renesas,rzg2l-usbhs" fallback compatible will continue to be
used for handling this IP.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250528133440.168133-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index 45d133253094..533b40f8aaae 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -26,6 +26,7 @@ properties:
               - renesas,usbhs-r9a07g043 # RZ/G2UL and RZ/Five
               - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
               - renesas,usbhs-r9a07g054 # RZ/V2L
+              - renesas,usbhs-r9a09g056 # RZ/V2N
               - renesas,usbhs-r9a09g057 # RZ/V2H(P)
           - const: renesas,rzg2l-usbhs
 
-- 
2.51.0


