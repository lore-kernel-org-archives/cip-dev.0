Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9CACD98D2
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:45:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42665.1781174749846043991
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:45:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A1D4F4386A;
	Thu, 11 Jun 2026 10:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBA91F00893;
	Thu, 11 Jun 2026 10:45:48 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 09/21] usb: host: Do not check priv->clks[clk]
Date: Thu, 11 Jun 2026 13:45:19 +0300
Message-ID: <20260611104532.2532863-10-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:45:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23098

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
 drivers/usb/host/ehci-platform.c | 3 +--
 drivers/usb/host/ohci-platform.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-pla=
tform.c
index fe497c876d76..41e5cd5e42bc 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -111,8 +111,7 @@ static void ehci_platform_power_off(struct platform_d=
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
index 523428967fe6..614b7cf5155c 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -69,8 +69,7 @@ static void ohci_platform_power_off(struct platform_dev=
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


