Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1090CCD98D5
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:43:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42539.1781174610803877003
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:43:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 98FA4440D5;
	Thu, 11 Jun 2026 10:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B7C1F00893;
	Thu, 11 Jun 2026 10:43:29 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 13/26] usb: host: ohci-platform: Call reset assert/deassert on suspend/resume
Date: Thu, 11 Jun 2026 13:42:54 +0300
Message-ID: <20260611104307.2532466-14-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
References: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:43:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23075

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e4d9da32bf6059cb485caac4c9c0a2e36cdd5573 upstream.

The Renesas RZ/G3S SoC supports a power-saving mode in which power to mos=
t
of the SoC components is turned off, including the USB blocks. On the
resume path, the reset signal must be de-asserted before applying any
settings to the USB registers. To handle this properly, call
reset_control_assert() and reset_control_deassert() during suspend and
resume, respectively.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251106143625.3050119-4-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/usb/host/ohci-platform.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-pla=
tform.c
index d8242a681ff3..bba2604393cf 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -272,6 +272,7 @@ static int ohci_platform_suspend(struct device *dev)
 	struct usb_hcd *hcd =3D dev_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata =3D dev->platform_data;
 	struct platform_device *pdev =3D to_platform_device(dev);
+	struct ohci_platform_priv *priv =3D hcd_to_ohci_priv(hcd);
 	bool do_wakeup =3D device_may_wakeup(dev);
 	int ret;
=20
@@ -282,6 +283,14 @@ static int ohci_platform_suspend(struct device *dev)
 	if (pdata->power_suspend)
 		pdata->power_suspend(pdev);
=20
+	ret =3D reset_control_assert(priv->resets);
+	if (ret) {
+		if (pdata->power_on)
+			pdata->power_on(pdev);
+
+		ohci_resume(hcd, false);
+	}
+
 	return ret;
 }
=20
@@ -290,11 +299,19 @@ static int ohci_platform_resume(struct device *dev)
 	struct usb_hcd *hcd =3D dev_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata =3D dev_get_platdata(dev);
 	struct platform_device *pdev =3D to_platform_device(dev);
+	struct ohci_platform_priv *priv =3D hcd_to_ohci_priv(hcd);
+	int err;
+
+	err =3D reset_control_deassert(priv->resets);
+	if (err)
+		return err;
=20
 	if (pdata->power_on) {
-		int err =3D pdata->power_on(pdev);
-		if (err < 0)
+		err =3D pdata->power_on(pdev);
+		if (err < 0) {
+			reset_control_assert(priv->resets);
 			return err;
+		}
 	}
=20
 	ohci_resume(hcd, false);
--=20
2.43.0


