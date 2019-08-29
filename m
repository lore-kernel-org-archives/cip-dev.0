From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 29 Aug 2019 18:02:48 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip v2 43/51] pinctrl: sh-pfc: r8a7740:
	Add missing REF125CK pin to gether_gmii group
In-Reply-To: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567098176-1242-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567098176-1242-44-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1ebc589a7786f17f97b9e87b44e0fb4d0290d8f8 upstream.

The gether_gmii_mux[] array contains the REF125CK pin mark, but the
gether_gmii_pins[] array lacks the corresponding pin number.

Fixes: bae11d30d0cafdc5 ("sh-pfc: r8a7740: Add GETHER pin groups and functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index c07fdad..5903686 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -1982,7 +1982,7 @@ static const unsigned int gether_gmii_pins[] = {
 	 */
 	185, 186, 187, 188, 189, 190, 191, 192, 174, 161, 204,
 	171, 170, 169, 168, 167, 166, 173, 172, 176, 184, 183, 203,
-	205, 163, 206, 207,
+	205, 163, 206, 207, 158,
 };
 static const unsigned int gether_gmii_mux[] = {
 	ET_ERXD0_MARK, ET_ERXD1_MARK, ET_ERXD2_MARK, ET_ERXD3_MARK,
-- 
2.7.4
