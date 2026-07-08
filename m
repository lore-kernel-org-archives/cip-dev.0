Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C358C44501
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:11:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3694.1783498265928282206
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:11:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4D2E5601D9;
	Wed,  8 Jul 2026 08:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA781F000E9;
	Wed,  8 Jul 2026 08:11:03 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 12/27] usb: host: Do not check priv->clks[clk]
Date: Wed,  8 Jul 2026 11:10:31 +0300
Message-ID: <20260708081046.3882290-13-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
References: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:11:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23490

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a7d5fe02059af66c9759cbf9199e7ed381cc592a upstream.

There is no need to check the entries in priv->clks[] array before passin=
g
it to clk_disable_unprepare() as the clk_disable_unprepare() already
check if it receives a NULL or error pointer as argument. Remove this
check. This makes the code simpler.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251106143625.3050119-2-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/usb/host/ehci-platform.c | 3 +--
 drivers/usb/host/ohci-platform.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-pla=
tform.c
index 2dcfc67f2ba8..9140f6aade89 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -114,8 +114,7 @@ static void ehci_platform_power_off(struct platform_d=
evice *dev)
 	int clk;
=20
 	for (clk =3D EHCI_MAX_CLKS - 1; clk >=3D 0; clk--)
-		if (priv->clks[clk])
-			clk_disable_unprepare(priv->clks[clk]);
+		clk_disable_unprepare(priv->clks[clk]);
 }
=20
 static struct hc_driver __read_mostly ehci_platform_hc_driver;
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-pla=
tform.c
index 365021e608d5..d8242a681ff3 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -70,8 +70,7 @@ static void ohci_platform_power_off(struct platform_dev=
ice *dev)
 	int clk;
=20
 	for (clk =3D OHCI_MAX_CLKS - 1; clk >=3D 0; clk--)
-		if (priv->clks[clk])
-			clk_disable_unprepare(priv->clks[clk]);
+		clk_disable_unprepare(priv->clks[clk]);
 }
=20
 static struct hc_driver __read_mostly ohci_platform_hc_driver;
--=20
2.43.0


