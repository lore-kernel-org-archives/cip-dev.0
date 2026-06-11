Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCADCD98D7
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:47:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42696.1781174824273165622
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:47:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 175AA4166E;
	Thu, 11 Jun 2026 10:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096521F00893;
	Thu, 11 Jun 2026 10:47:02 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 03/17] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
Date: Thu, 11 Jun 2026 13:46:42 +0300
Message-ID: <20260611104656.2533096-4-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104656.2533096-1-claudiu.beznea@tuxon.dev>
References: <20260611104656.2533096-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:47:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23114

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 819ac6b055350c559dbb111f970a96e2c1c812ff upstream.

The Renesas RZ/G3S SoC USB PHY HW block receives as input the USB PWRRDY
signal from the system controller. Add support for the Renesas RZ/G3S SoC=
.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
index dcc8c2dde3f8..4d51213e59ba 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -96,6 +96,10 @@ static int rzg2l_usbphy_ctrl_status(struct reset_contr=
oller_dev *rcdev,
=20
 static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] =3D {
 	{ .compatible =3D "renesas,rzg2l-usbphy-ctrl" },
+	{
+		.compatible =3D "renesas,r9a08g045-usbphy-ctrl",
+		.data =3D (void *)RZG2L_USBPHY_CTRL_PWRRDY
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_usbphy_ctrl_match_table);
--=20
2.43.0


