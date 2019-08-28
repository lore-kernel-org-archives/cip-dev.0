From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:22:08 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 41/41] pinctrl: sh-pfc: r8a7796:
	Remove placeholder I2C pin data
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-42-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Ulrich Hecht <uli+renesas@fpond.eu>

commit f05603fa6aa30430f444620344a2f75adeeddbd2 upstream.

Pin data for I2C controllers 0, 3 and 5 is properly defined already.

Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index 797f919..9d2c963 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -1545,11 +1545,6 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP18_7_4,	FMIN_C,			SEL_FM_2),
 	PINMUX_IPSR_MSEL(IP18_7_4,	FMIN_D,			SEL_FM_3),
 
-	/* I2C */
-	PINMUX_IPSR_NOGP(0,		I2C_SEL_0_1),
-	PINMUX_IPSR_NOGP(0,		I2C_SEL_3_1),
-	PINMUX_IPSR_NOGP(0,		I2C_SEL_5_1),
-
 /*
  * Static pins can not be muxed between different functions but
  * still need mark entries in the pinmux list. Add each static
-- 
2.7.4
