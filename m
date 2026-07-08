Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8BBC44503
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:11:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3846.1783498264530233577
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:11:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E00C1601EC;
	Wed,  8 Jul 2026 08:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C107C1F000E9;
	Wed,  8 Jul 2026 08:11:02 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 11/27] reset: rzg2l-usbphy-ctrl: Check pwrrdy is valid before using it
Date: Wed,  8 Jul 2026 11:10:30 +0300
Message-ID: <20260708081046.3882290-12-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
References: <20260708081046.3882290-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:11:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23489

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e0cf84109bc6c6768337123f1de24ff56b41c91b upstream.

The pwrrdy regmap_filed is allocated in rzg2l_usbphy_ctrl_pwrrdy_init()
only if the driver data is set to RZG2L_USBPHY_CTRL_PWRRDY. Check that
pwrrdy is valid before using it to avoid "Unable to handle kernel NULL
pointer dereference at virtual address" errors.

Fixes: c5b7cd9adefc ("reset: rzg2l-usbphy-ctrl: Add suspend/resume suppor=
t")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
index 5a8483e44165..4f06654e3133 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -136,6 +136,9 @@ static int rzg2l_usbphy_ctrl_set_pwrrdy(struct regmap=
_field *pwrrdy,
 {
 	u32 val =3D power_on ? 0 : 1;
=20
+	if (!pwrrdy)
+		return 0;
+
 	/* The initialization path guarantees that the mask is 1 bit long. */
 	return regmap_field_update_bits(pwrrdy, 1, val);
 }
--=20
2.43.0


