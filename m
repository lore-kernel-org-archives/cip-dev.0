Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.968.1795020144170411210
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D62D842485;
	Wed, 18 Nov 2026 16:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6621F000C4;
	Wed, 18 Nov 2026 16:42:22 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 25/35] pinctrl: renesas: rzg2l: Use raw_spinlock_irqsave() on power source update
Date: Wed, 18 Nov 2026 18:41:36 +0200
Message-ID: <20261118164146.3040784-26-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24988
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 14270179806b876fecefcbf35905e512b56a5867 upstream.

The rest of the driver uses raw_spin_lock_irqsave() and
raw_spin_unlock_irqrestore() for locking.  To avoid concurrency issues
or deadlocks, use raw_spinlock_irqsave() via the scoped_guard() helper
for power source updates as well.

Fixes: bbe2277dedbe ("pinctrl: renesas: rzg2l: Add support for selecting =
power source for {WDT,AWO,ISO}")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260603151642.4075678-2-claudiu.beznea@ke=
rnel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index bd6dee9960a3..f190bb3fbf71 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1139,7 +1139,7 @@ static int rzg2l_set_power_source(struct rzg2l_pinc=
trl *pctrl, u32 pin, u32 caps
 		return pwr_reg;
=20
 	if (pwr_reg =3D=3D OTHER_POC) {
-		scoped_guard(raw_spinlock, &pctrl->lock) {
+		scoped_guard(raw_spinlock_irqsave, &pctrl->lock) {
 			val =3D readb(pctrl->base + pwr_reg);
 			if (poc_val)
 				val |=3D mask;
--=20
2.43.0

