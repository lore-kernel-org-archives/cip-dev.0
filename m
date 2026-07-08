Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7452DC44508
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:12:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3885.1783498342617296519
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6BDF641B66;
	Wed,  8 Jul 2026 08:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E5E1F000E9;
	Wed,  8 Jul 2026 08:12:21 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 15/22] dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
Date: Wed,  8 Jul 2026 11:11:52 +0300
Message-ID: <20260708081159.3882514-16-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
References: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:12:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23521

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
[claudiu.beznea: kept the compatible list sorted by part number]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml =
b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index 76e6cf07a450..fcef9ef03c5f 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -110,6 +110,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - renesas,usb2-phy-r9a08g045
               - renesas,usb2-phy-r9a09g057
               - renesas,rzg2l-usb2-phy
     then:
--=20
2.43.0


