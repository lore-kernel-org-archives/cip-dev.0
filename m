Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C57C44501
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:12:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3880.1783498337374511523
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 304E043616;
	Wed,  8 Jul 2026 08:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247D11F000E9;
	Wed,  8 Jul 2026 08:12:15 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 11/22] usb: host: ehci-platform: Call reset assert/deassert on suspend/resume
Date: Wed,  8 Jul 2026 11:11:48 +0300
Message-ID: <20260708081159.3882514-12-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
References: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:12:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23517

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c31a401fe7abedabb5c05b5cbf36e2fdb3e6be63 upstream.

The Renesas RZ/G3S SoC supports a power-saving mode in which power to mos=
t
of the SoC components is turned off, including the USB blocks. On the
resume path, the reset signal must be de-asserted before applying any
settings to the USB registers. To handle this properly, call
reset_control_assert() and reset_control_deassert() during suspend and
resume, respectively.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20251106143625.3050119-3-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[claudiu.beznea: execute the code based on the
 ehci_platform_reset_control_allowed() return value]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- added ehci_platform_reset_control_allowed() and use it in suspend/resum=
e
  path to avoid executing code introduced by commit
  c31a401fe7abedabb5c05b5cbf36e2fdb3e6be63 on targets other than the
  Renesas RZ/G3S

 drivers/usb/host/ehci-platform.c | 39 ++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-pla=
tform.c
index 41e5cd5e42bc..d757a657024b 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -427,6 +427,16 @@ static int ehci_platform_remove(struct platform_devi=
ce *dev)
 	return 0;
 }
=20
+static bool __maybe_unused ehci_platform_reset_control_allowed(void)
+{
+	static const char * const reset_control_allow_list[] =3D {
+		"renesas,r9a08g045", /* Renesas RZ/G3S */
+		NULL
+	};
+
+	return of_machine_compatible_match(reset_control_allow_list);
+}
+
 static int __maybe_unused ehci_platform_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd =3D dev_get_drvdata(dev);
@@ -446,6 +456,20 @@ static int __maybe_unused ehci_platform_suspend(stru=
ct device *dev)
 	if (pdata->power_suspend)
 		pdata->power_suspend(pdev);
=20
+	if (!ehci_platform_reset_control_allowed())
+		return ret;
+
+	ret =3D reset_control_assert(priv->rsts);
+	if (ret) {
+		if (pdata->power_on)
+			pdata->power_on(pdev);
+
+		ehci_resume(hcd, false);
+
+		if (priv->quirk_poll)
+			quirk_poll_init(priv);
+	}
+
 	return ret;
 }
=20
@@ -455,12 +479,23 @@ static int __maybe_unused ehci_platform_resume(stru=
ct device *dev)
 	struct usb_ehci_pdata *pdata =3D dev_get_platdata(dev);
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct ehci_platform_priv *priv =3D hcd_to_ehci_priv(hcd);
+	bool reset_control_allowed =3D ehci_platform_reset_control_allowed();
 	struct device *companion_dev;
+	int err;
+
+	if (reset_control_allowed) {
+		err =3D reset_control_deassert(priv->rsts);
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
+				reset_control_assert(priv->rsts);
 			return err;
+		}
 	}
=20
 	companion_dev =3D usb_of_get_companion_dev(hcd->self.controller);
--=20
2.43.0


