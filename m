Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53C1CD98D9
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:43:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42594.1781174596121253247
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:43:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7A4AD60212;
	Thu, 11 Jun 2026 10:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0651F00893;
	Thu, 11 Jun 2026 10:43:13 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 03/26] pinctrl: renesas: rzg2l: Add suspend/resume support for pull up/down
Date: Thu, 11 Jun 2026 13:42:44 +0300
Message-ID: <20260611104307.2532466-4-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
References: <20260611104307.2532466-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:43:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23065

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b2bd65fbb617353e3c46ba5206b3b030fa0f260c upstream.

The Renesas RZ/G3S supports a power-saving mode where power to most of
the SoC components is lost, including the PIN controller.  Save and
restore the pull-up/pull-down register contents to ensure the
functionality is preserved after a suspend/resume cycle.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250205100116.2032765-1-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict in rzg2l_pinctrl_pm_setup_regs()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index 16e32a090131..404b96d4d54d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -275,6 +275,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @pmc: PMC registers cache
  * @pfc: PFC registers cache
  * @iolh: IOLH registers cache
+ * @pupd: PUPD registers cache
  * @ien: IEN registers cache
  * @sd_ch: SD_CH registers cache
  * @eth_poc: ET_POC registers cache
@@ -288,6 +289,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u32	*pfc;
 	u32	*iolh[2];
 	u32	*ien[2];
+	u32	*pupd[2];
 	u8	sd_ch[2];
 	u8	eth_poc[2];
 	u8	eth_mode;
@@ -2256,6 +2258,11 @@ static int rzg2l_pinctrl_reg_cache_alloc(struct rz=
g2l_pinctrl *pctrl)
 		if (!cache->ien[i])
 			return -ENOMEM;
=20
+		cache->pupd[i] =3D devm_kcalloc(pctrl->dev, nports, sizeof(*cache->pup=
d[i]),
+					      GFP_KERNEL);
+		if (!cache->pupd[i])
+			return -ENOMEM;
+
 		/* Allocate dedicated cache. */
 		dedicated_cache->iolh[i] =3D devm_kcalloc(pctrl->dev, n_dedicated_pins=
,
 							sizeof(*dedicated_cache->iolh[i]),
@@ -2498,7 +2505,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2=
l_pinctrl *pctrl, bool suspen
 	u32 port;
=20
 	for (port =3D 0; port < nports; port++) {
-		bool has_iolh, has_ien;
+		bool has_iolh, has_ien, has_pupd;
 		u32 off, caps;
 		u8 pincnt;
 		u64 cfg;
@@ -2510,6 +2517,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2=
l_pinctrl *pctrl, bool suspen
 		caps =3D FIELD_GET(PIN_CFG_MASK, cfg);
 		has_iolh =3D !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH=
_C));
 		has_ien =3D !!(caps & PIN_CFG_IEN);
+		has_pupd =3D !!(caps & PIN_CFG_PUPD);
=20
 		if (suspend)
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PFC(off), cache->pfc[=
port]);
@@ -2528,6 +2536,15 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg=
2l_pinctrl *pctrl, bool suspen
 			}
 		}
=20
+		if (has_pupd) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PUPD(off),
+						 cache->pupd[0][port]);
+			if (pincnt >=3D 4) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PUPD(off),
+							 cache->pupd[1][port]);
+			}
+		}
+
 		RZG2L_PCTRL_REG_ACCESS16(suspend, pctrl->base + PM(off), cache->pm[por=
t]);
 		RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + P(off), cache->p[port])=
;
=20
--=20
2.43.0


