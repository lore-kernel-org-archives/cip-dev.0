Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7F6C44509
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:11:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3697.1783498269264854947
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:11:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 13F04407D6;
	Wed,  8 Jul 2026 08:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218C21F000E9;
	Wed,  8 Jul 2026 08:11:07 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 15/27] dt-bindings: usb: renesas,usbhs: Document RZ/G3S SoC
Date: Wed,  8 Jul 2026 11:10:34 +0300
Message-ID: <20260708081046.3882290-16-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
References: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:11:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23493

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/D=
ocumentation/devicetree/bindings/usb/renesas,usbhs.yaml
index c83b6e8e2040..c93459fe6245 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -26,6 +26,7 @@ properties:
               - renesas,usbhs-r9a07g043 # RZ/G2UL and RZ/Five
               - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
               - renesas,usbhs-r9a07g054 # RZ/V2L
+              - renesas,usbhs-r9a08g045 # RZ/G3S
           - const: renesas,rzg2l-usbhs
=20
       - items:
@@ -131,6 +132,7 @@ allOf:
               - renesas,usbhs-r9a07g043
               - renesas,usbhs-r9a07g044
               - renesas,usbhs-r9a07g054
+              - renesas,usbhs-r9a08g045
     then:
       properties:
         interrupts:
--=20
2.43.0


