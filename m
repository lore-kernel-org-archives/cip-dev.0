Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A785ACD98D5
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:47:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42660.1781174839421459075
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:47:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C5D7D6020D;
	Thu, 11 Jun 2026 10:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732B81F00893;
	Thu, 11 Jun 2026 10:47:17 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 12/17] usb: renesas_usbhs: Assert/de-assert reset signals on suspend/resume
Date: Thu, 11 Jun 2026 13:46:51 +0300
Message-ID: <20260611104656.2533096-13-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104656.2533096-1-claudiu.beznea@tuxon.dev>
References: <20260611104656.2533096-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:47:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23123

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3578b1cde59496efc4625ba3fbd14eb2918807a2 upstream.

The Renesas RZ/G3S SoC supports a power-saving mode in which power to mos=
t
SoC components is turned off, including the USB subsystem.

To properly restore from such a state, the reset signal needs to be
asserted/de-asserted during suspend/resume. Add reset assert/de-assert on
suspend/resume.

The resume code has been moved into a separate function to allow reusing
it in case reset_control_assert() from suspend fails.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251106143625.3050119-5-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[claudiu.beznea:
 - fixed conflict by keeping usbhsc_restore() function introduced by
   commit 3578b1cde59496efc4625ba3fbd14eb2918807a2
 - kept __maybe_unused on suspend/resume functions]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 35 ++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usb=
hs/common.c
index f4a58686bf1e..c0976265b8e6 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -836,10 +836,26 @@ static void usbhs_remove(struct platform_device *pd=
ev)
 	pm_runtime_disable(&pdev->dev);
 }
=20
+static void usbhsc_restore(struct device *dev)
+{
+	struct usbhs_priv *priv =3D dev_get_drvdata(dev);
+	struct platform_device *pdev =3D usbhs_priv_to_pdev(priv);
+
+	if (!usbhs_get_dparam(priv, runtime_pwctrl)) {
+		usbhsc_power_ctrl(priv, 1);
+		usbhs_mod_autonomy_mode(priv);
+	}
+
+	usbhs_platform_call(priv, phy_reset, pdev);
+
+	usbhsc_schedule_notify_hotplug(pdev);
+}
+
 static __maybe_unused int usbhsc_suspend(struct device *dev)
 {
 	struct usbhs_priv *priv =3D dev_get_drvdata(dev);
 	struct usbhs_mod *mod =3D usbhs_mod_get_current(priv);
+	int ret;
=20
 	if (mod) {
 		usbhs_mod_call(priv, stop, priv);
@@ -849,22 +865,23 @@ static __maybe_unused int usbhsc_suspend(struct dev=
ice *dev)
 	if (mod || !usbhs_get_dparam(priv, runtime_pwctrl))
 		usbhsc_power_ctrl(priv, 0);
=20
-	return 0;
+	ret =3D reset_control_assert(priv->rsts);
+	if (ret)
+		usbhsc_restore(dev);
+
+	return ret;
 }
=20
 static __maybe_unused int usbhsc_resume(struct device *dev)
 {
 	struct usbhs_priv *priv =3D dev_get_drvdata(dev);
-	struct platform_device *pdev =3D usbhs_priv_to_pdev(priv);
-
-	if (!usbhs_get_dparam(priv, runtime_pwctrl)) {
-		usbhsc_power_ctrl(priv, 1);
-		usbhs_mod_autonomy_mode(priv);
-	}
+	int ret;
=20
-	usbhs_platform_call(priv, phy_reset, pdev);
+	ret =3D reset_control_deassert(priv->rsts);
+	if (ret)
+		return ret;
=20
-	usbhsc_schedule_notify_hotplug(pdev);
+	usbhsc_restore(dev);
=20
 	return 0;
 }
--=20
2.43.0


