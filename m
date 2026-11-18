Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.966.1795020141775411482
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 36F9862BFC;
	Wed, 18 Nov 2026 16:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068131F000C4;
	Wed, 18 Nov 2026 16:42:19 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 23/35] pinctrl: renesas: rzg2l: Keep member documentation aligned
Date: Wed, 18 Nov 2026 18:41:34 +0200
Message-ID: <20261118164146.3040784-24-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24986
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b3ea1cac08b25aad9e0a360c694198b37e35706a upstream.

Keep the documentation for struct rzg2l_pinctrl_reg_cache members aligned
with the struct member order.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260528080439.615958-4-claudiu.beznea@ker=
nel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 6fdffa2cf3ae..b15a39619f6a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -363,16 +363,16 @@ struct rzg2l_pinctrl_pin_settings {
  * @pmc: PMC registers cache
  * @pfc: PFC registers cache
  * @iolh: IOLH registers cache
- * @pupd: PUPD registers cache
  * @ien: IEN registers cache
+ * @pupd: PUPD registers cache
  * @smt: SMT registers cache
  * @sr: SR registers cache
  * @nod: NOD registers cache
  * @clone: Clone register cache
  * @sd_ch: SD_CH registers cache
  * @eth_poc: ET_POC registers cache
- * @other_poc: OTHER_POC register cache
  * @oen: Output Enable register cache
+ * @other_poc: OTHER_POC register cache
  * @qspi: QSPI registers cache
  */
 struct rzg2l_pinctrl_reg_cache {
--=20
2.43.0

