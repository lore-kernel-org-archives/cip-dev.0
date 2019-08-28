From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:31 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 04/41] pinctrl: sh-pfc: Validate
	pins/marks in pin groups at build time
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 9925e879572680125c5d00ad8b807aec720b1cb6 upstream.

Add a build-time check, to ensure the number of pins and pin marks in a
pin group matches.  This helps catching bugs early.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 8a06ebc..6d3430c 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -44,7 +44,8 @@ struct sh_pfc_pin {
 		.name = #alias,				\
 		.pins = n##_pins,			\
 		.mux = n##_mux,				\
-		.nr_pins = ARRAY_SIZE(n##_pins),	\
+		.nr_pins = ARRAY_SIZE(n##_pins) +	\
+		BUILD_BUG_ON_ZERO(sizeof(n##_pins) != sizeof(n##_mux)), \
 	}
 #define SH_PFC_PIN_GROUP(n)	SH_PFC_PIN_GROUP_ALIAS(n, n)
 
-- 
2.7.4
