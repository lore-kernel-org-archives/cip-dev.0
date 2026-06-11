Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5B2CD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:43:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42537.1781174609040381369
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:43:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CCCBF434BC;
	Thu, 11 Jun 2026 10:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA471F00893;
	Thu, 11 Jun 2026 10:43:27 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 12/26] usb: host: ehci-platform: Call reset assert/deassert on suspend/resume
Date: Thu, 11 Jun 2026 13:42:53 +0300
Message-ID: <20260611104307.2532466-13-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
References: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:43:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23074

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/usb/host/ehci-platform.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-pla=
tform.c
index 9140f6aade89..a53922a784b0 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -442,6 +442,17 @@ static int __maybe_unused ehci_platform_suspend(stru=
ct device *dev)
 	if (pdata->power_suspend)
 		pdata->power_suspend(pdev);
=20
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
@@ -452,11 +463,18 @@ static int __maybe_unused ehci_platform_resume(stru=
ct device *dev)
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct ehci_platform_priv *priv =3D hcd_to_ehci_priv(hcd);
 	struct device *companion_dev;
+	int err;
+
+	err =3D reset_control_deassert(priv->rsts);
+	if (err)
+		return err;
=20
 	if (pdata->power_on) {
-		int err =3D pdata->power_on(pdev);
-		if (err < 0)
+		err =3D pdata->power_on(pdev);
+		if (err < 0) {
+			reset_control_assert(priv->rsts);
 			return err;
+		}
 	}
=20
 	companion_dev =3D usb_of_get_companion_dev(hcd->self.controller);
--=20
2.43.0


