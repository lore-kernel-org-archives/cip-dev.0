Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD3CD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:43:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42613.1781174623976016660
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:43:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C1CFF4410B;
	Thu, 11 Jun 2026 10:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FE41F00893;
	Thu, 11 Jun 2026 10:43:42 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 21/26] phy: renesas: rcar-gen3-usb2: Fix an error handling path in rcar_gen3_phy_usb2_probe()
Date: Thu, 11 Jun 2026 13:43:02 +0300
Message-ID: <20260611104307.2532466-22-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
References: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:43:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23083

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 662bb179d3381c7c069e44bb177396bcaee31cc8 upstream.

If an error occurs after the reset_control_deassert(),
reset_control_assert() must be called, as already done in the remove
function.

Use devm_add_action_or_reset() to add the missing call and simplify the
.remove() function accordingly.

While at it, drop struct rcar_gen3_chan::rstc as it is not used aymore.

[claudiu.beznea: removed "struct reset_control *rstc =3D data;" from
 rcar_gen3_reset_assert(), dropped struct rcar_gen3_chan::rstc]

Fixes: 4eae16375357 ("phy: renesas: rcar-gen3-usb2: Add support to initia=
lize the bus")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251023135810.1688415-3-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
index b7f5305b6b38..1dc6abe7fa5b 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -120,7 +120,6 @@ struct rcar_gen3_chan {
 	struct extcon_dev *extcon;
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
-	struct reset_control *rstc;
 	struct work_struct work;
 	spinlock_t lock;	/* protects access to hardware and driver data structu=
re. */
 	enum usb_dr_mode dr_mode;
@@ -680,21 +679,31 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struc=
t device_node *np)
 	return candidate;
 }
=20
+static void rcar_gen3_reset_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
 {
 	struct device *dev =3D channel->dev;
+	struct reset_control *rstc;
 	int ret;
 	u32 val;
=20
-	channel->rstc =3D devm_reset_control_array_get_shared(dev);
-	if (IS_ERR(channel->rstc))
-		return PTR_ERR(channel->rstc);
+	rstc =3D devm_reset_control_array_get_shared(dev);
+	if (IS_ERR(rstc))
+		return PTR_ERR(rstc);
=20
 	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
=20
-	ret =3D reset_control_deassert(channel->rstc);
+	ret =3D reset_control_deassert(rstc);
+	if (ret)
+		goto rpm_put;
+
+	ret =3D devm_add_action_or_reset(dev, rcar_gen3_reset_assert, rstc);
 	if (ret)
 		goto rpm_put;
=20
@@ -838,7 +847,6 @@ static int rcar_gen3_phy_usb2_remove(struct platform_=
device *pdev)
 	if (channel->is_otg_channel)
 		device_remove_file(&pdev->dev, &dev_attr_role);
=20
-	reset_control_assert(channel->rstc);
 	pm_runtime_disable(&pdev->dev);
=20
 	return 0;
--=20
2.43.0


