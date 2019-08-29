From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:47 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 42/51] pinctrl: sh-pfc:
	r8a77995: Remove unused PINMUX_IPSR_{MSEL2, PHYS}()
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-43-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 341fe38975211e73c4b1e9b44d5ccbdf7960466b upstream.

The PINMUX_IPSR_MSEL2() and PINMUX_IPSR_PHYS() macros are unused, and
will conflict with generic macros that are to be added.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index b3e65dd..621f50f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -472,12 +472,6 @@ enum {
 #undef FM
 };
 
-#define PINMUX_IPSR_MSEL2(ipsr, fn, msel1, msel2) \
-	PINMUX_DATA(fn##_MARK, FN_##msel1, FN_##msel2, FN_##fn, FN_##ipsr)
-
-#define PINMUX_IPSR_PHYS(ipsr, fn, msel) \
-	PINMUX_DATA(fn##_MARK, FN_##msel)
-
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(),
 
-- 
2.7.4
