Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE21C44507
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:11:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3696.1783498268605892548
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:11:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F137F6001A;
	Wed,  8 Jul 2026 08:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AD51F000E9;
	Wed,  8 Jul 2026 08:11:06 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 14/27] usb: host: ohci-platform: Call reset assert/deassert on suspend/resume
Date: Wed,  8 Jul 2026 11:10:33 +0300
Message-ID: <20260708081046.3882290-15-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
References: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:11:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23492

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
[claudiu.beznea: execute the code based on the
 ohci_platform_reset_control_allowed() return value]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- added ohci_platform_reset_control_allowed() and use it in suspend/resum=
e
  path to avoid executing code introduced by commit
  e4d9da32bf6059cb485caac4c9c0a2e36cdd5573 on targets other than the
  Renesas RZ/G3S

 drivers/usb/host/ohci-platform.c | 38 ++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-pla=
tform.c
index d8242a681ff3..4b2da3290fbf 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -267,11 +267,22 @@ static int ohci_platform_remove(struct platform_dev=
ice *dev)
 }
=20
 #ifdef CONFIG_PM_SLEEP
+static bool ohci_platform_reset_control_allowed(void)
+{
+	static const char * const reset_control_allow_list[] =3D {
+		"renesas,r9a08g045", /* Renesas RZ/G3S */
+		NULL
+	};
+
+	return of_machine_compatible_match(reset_control_allow_list);
+}
+
 static int ohci_platform_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd =3D dev_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata =3D dev->platform_data;
 	struct platform_device *pdev =3D to_platform_device(dev);
+	struct ohci_platform_priv *priv =3D hcd_to_ohci_priv(hcd);
 	bool do_wakeup =3D device_may_wakeup(dev);
 	int ret;
=20
@@ -282,6 +293,17 @@ static int ohci_platform_suspend(struct device *dev)
 	if (pdata->power_suspend)
 		pdata->power_suspend(pdev);
=20
+	if (!ohci_platform_reset_control_allowed())
+		return ret;
+
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
@@ -290,11 +312,23 @@ static int ohci_platform_resume(struct device *dev)
 	struct usb_hcd *hcd =3D dev_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata =3D dev_get_platdata(dev);
 	struct platform_device *pdev =3D to_platform_device(dev);
+	struct ohci_platform_priv *priv =3D hcd_to_ohci_priv(hcd);
+	bool reset_control_allowed =3D ohci_platform_reset_control_allowed();
+	int err;
+
+	if (reset_control_allowed) {
+		err =3D reset_control_deassert(priv->resets);
+		if (err)
+			return err;
+	}
=20
 	if (pdata->power_on) {
-		int err =3D pdata->power_on(pdev);
-		if (err < 0)
+		err =3D pdata->power_on(pdev);
+		if (err < 0) {
+			if (reset_control_allowed)
+				reset_control_assert(priv->resets);
 			return err;
+		}
 	}
=20
 	ohci_resume(hcd, false);
--=20
2.43.0


