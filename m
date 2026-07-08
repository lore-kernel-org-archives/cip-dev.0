Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146F9C43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:12:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3726.1783498336607219213
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F309A6001A;
	Wed,  8 Jul 2026 08:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C999F1F000E9;
	Wed,  8 Jul 2026 08:12:14 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 10/22] usb: host: Do not check priv->clks[clk]
Date: Wed,  8 Jul 2026 11:11:47 +0300
Message-ID: <20260708081159.3882514-11-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
References: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:12:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23516

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


