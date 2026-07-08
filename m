Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81774C43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 08:12:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3876.1783498325487552753
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 01:12:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ttbc=fc=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D62DC600C3;
	Wed,  8 Jul 2026 08:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9B01F000E9;
	Wed,  8 Jul 2026 08:12:03 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 02/22] clk: renesas: rzg2l: Deassert reset on assert timeout
Date: Wed,  8 Jul 2026 11:11:39 +0300
Message-ID: <20260708081159.3882514-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
References: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 08:12:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23508

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 0b0201f259e1158a875c5fd01adf318ae5d32352 upstream.

If the assert() fails due to timeout error, set the reset register bit
back to deasserted state. This change is needed especially for handling
assert error in suspend() callback that expect the device to be in
operational state in case of failure.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260108123433.104464-2-biju.das.jz@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/clk/renesas/rzg2l-cpg.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-=
cpg.c
index e8ea65446890..4d61a39e48cc 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1769,6 +1769,8 @@ static int rzg2l_cpg_assert(struct reset_controller=
_dev *rcdev,
 	u32 mask =3D BIT(info->resets[id].bit);
 	s8 monbit =3D info->resets[id].monbit;
 	u32 value =3D mask << 16;
+	u32 mon;
+	int ret;
=20
 	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
=20
@@ -1785,8 +1787,14 @@ static int rzg2l_cpg_assert(struct reset_controlle=
r_dev *rcdev,
 		return 0;
 	}
=20
-	return readl_poll_timeout_atomic(priv->base + reg, value,
-					 value & mask, 10, 200);
+	ret =3D readl_poll_timeout_atomic(priv->base + reg, mon,
+					!!(mon & mask), 10, 200);
+	if (ret) {
+		value ^=3D mask;
+		writel(value, priv->base + CLK_RST_R(info->resets[id].off));
+	}
+
+	return ret;
 }
=20
 static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
--=20
2.43.0


