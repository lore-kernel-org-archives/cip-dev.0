Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B8FCD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:45:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42614.1781174754990857479
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:45:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5CA4760212;
	Thu, 11 Jun 2026 10:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3861F00893;
	Thu, 11 Jun 2026 10:45:52 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 12/21] dt-bindings: usb: renesas,usbhs: Document RZ/G3S SoC
Date: Thu, 11 Jun 2026 13:45:22 +0300
Message-ID: <20260611104532.2532863-13-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:45:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23101

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3b56774fa25d46bd2ff3707546e30829f52dde9e upstream.

The USBHS IP block on RZ/G3S SoC is identitcal to the one found on the
RZ/G2L device. Document the RZ/G3S USBHS IP block.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20241126092050.1825607-7-claudiu.beznea.u=
j@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[claudiu.beznea:
 - fixed conflict in compatible section by keeping RZ/V2H, RZ/V2N and
   RZ/G3S; at the same time, moved RZ/G3S compatible to have the list
   sorted by part number
 - fixed conflict in allOf section by keeping the code from v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/D=
ocumentation/devicetree/bindings/usb/renesas,usbhs.yaml
index 533b40f8aaae..47a74dd11892 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -26,6 +26,7 @@ properties:
               - renesas,usbhs-r9a07g043 # RZ/G2UL and RZ/Five
               - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
               - renesas,usbhs-r9a07g054 # RZ/V2L
+              - renesas,usbhs-r9a08g045 # RZ/G3S
               - renesas,usbhs-r9a09g056 # RZ/V2N
               - renesas,usbhs-r9a09g057 # RZ/V2H(P)
           - const: renesas,rzg2l-usbhs
--=20
2.43.0


