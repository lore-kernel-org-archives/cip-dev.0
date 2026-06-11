Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFCACD98D7
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:43:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42544.1781174617479186566
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:43:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 495BA40056;
	Thu, 11 Jun 2026 10:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9771F00893;
	Thu, 11 Jun 2026 10:43:35 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 17/26] dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
Date: Thu, 11 Jun 2026 13:42:58 +0300
Message-ID: <20260611104307.2532466-18-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
References: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:43:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23079

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit bc6f8b756c89d831c91a65ef9f3b5ceabdbae441 upstream.

The reset lines are mandatory for the Renesas RZ/G3S platform and must be
explicitly defined in device tree.

Fixes: f3c849855114 ("dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S=
 phy bindings")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251023135810.1688415-2-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict in allOf section using an enum with
 renesas,usb2-phy-r9a08g045 and renesas,rzg2l-usb2-phy]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml =
b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index e623fd21898f..358f543cd36e 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -108,7 +108,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,rzg2l-usb2-phy
+            enum:
+              - renesas,usb2-phy-r9a08g045
+              - renesas,rzg2l-usb2-phy
     then:
       required:
         - resets
--=20
2.43.0


