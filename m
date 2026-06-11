Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F56ACD98D2
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:46:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42623.1781174768647716122
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:46:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7470E43C1D;
	Thu, 11 Jun 2026 10:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671761F00898;
	Thu, 11 Jun 2026 10:46:07 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 21/21] usb: renesas: Suppress binding attributes
Date: Thu, 11 Jun 2026 13:45:31 +0300
Message-ID: <20260611104532.2532863-22-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:46:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23110

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In v6.1 CIP the drivers that are involved for the USB to work on the
Renesas RZ/G2L based devices are the following:
- rzg2l_usbphy_ctrl
- phy_rcar_gen3_usb2
- ochi, echi, renesas_usbhs

The drivers tree is as follows:

        +-----------------------------------------------------------+
        |                                                           |
       \ /                                                          |
        `                                                           |
rzg2l_usbphy_ctrl <--> phy_rcar_gen3_usb2 <--+--> ohci <------------+
                                             +--> ehci <------------+
                                             +--> renesas_usbhs  <--+

Where:
- rzg2l_usbphy_ctrl provides reset signals to phy_rcar_gen3_usb2 and
  OHCI, EHCI, renesas_usbhs drivers
- phy_rcar_gen3_usb3_usb2 request reset signals from rzg2l_usbphy_ctrl
  and provides PHYs to OHCI, EHCI, renesas_usbhs
- OHCI, EHCI, renesas_usbhs drivers gets resets from rzg2l_usbphy_ctrl
  driver and PHYs from phy_rcar_gen3_usb2

In the current v6.1 CIP tree, unbinding any of the providers in the
mentioned diagram does not force the unbinding of the consumers. In these
scenarios, the consumers remain with stale resources. Subsequent
operations that require resources from the providers will fail, either
silently or loudly (crashes). Rebinding the previously unbound provider
does not resolve the issue either.

The only way the unbind/bind sequence works for the above-mentioned
scenario is to perform the unbind starting with the consumers and ending
with the providers, and to perform the bind starting with the providers
and ending with the consumers.

Suppress the binding attributes.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
index 03d6183a385f..a67a9e688dca 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -903,6 +903,7 @@ static struct platform_driver rcar_gen3_phy_usb2_driv=
er =3D {
 		.name		=3D "phy_rcar_gen3_usb2",
 		.of_match_table	=3D rcar_gen3_phy_usb2_match_table,
 		.pm		=3D pm_ptr(&rcar_gen3_phy_usb2_pm_ops),
+		.suppress_bind_attrs =3D true,
 	},
 	.probe	=3D rcar_gen3_phy_usb2_probe,
 	.remove =3D rcar_gen3_phy_usb2_remove,
diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
index 3f88550a6946..3af61bbe7f98 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -343,6 +343,7 @@ static struct platform_driver rzg2l_usbphy_ctrl_drive=
r =3D {
 		.name		=3D "rzg2l_usbphy_ctrl",
 		.of_match_table	=3D rzg2l_usbphy_ctrl_match_table,
 		.pm		=3D pm_ptr(&rzg2l_usbphy_ctrl_pm_ops),
+		.suppress_bind_attrs =3D true,
 	},
 	.probe	=3D rzg2l_usbphy_ctrl_probe,
 	.remove	=3D rzg2l_usbphy_ctrl_remove,
--=20
2.43.0


