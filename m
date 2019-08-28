From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:58 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 31/41] pinctrl: sh-pfc: r8a77990:
	Fix MOD_SEL0 bit16 when using NFALE and NFRB_N
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-32-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit 943ff71281c6ce44ca48ea1b08c55f1e63648d00 upstream.

According to the R-Car Gen3 Hardware Manual Errata for Rev 1.00 of Aug
24, 2018, the MOD_SEL0 bit16 must be set to 0 when the NFALE_A and
NFRB_N_A pin functions are selected.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index a3f22ff..fba0c22 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -1037,7 +1037,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP10_23_20,		NFCLE),
 
 	PINMUX_IPSR_GPSR(IP10_27_24,		SD0_CD),
-	PINMUX_IPSR_GPSR(IP10_27_24,		NFALE_A),
+	PINMUX_IPSR_MSEL(IP10_27_24,		NFALE_A,	SEL_NDFC_0),
 	PINMUX_IPSR_GPSR(IP10_27_24,		SD3_CD),
 	PINMUX_IPSR_MSEL(IP10_27_24,		RIF0_CLK_B,	SEL_DRIF0_1),
 	PINMUX_IPSR_MSEL(IP10_27_24,		SCL2_B,		SEL_I2C2_1),
@@ -1046,7 +1046,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP10_27_24,		TS_SCK0),
 
 	PINMUX_IPSR_GPSR(IP10_31_28,		SD0_WP),
-	PINMUX_IPSR_GPSR(IP10_31_28,		NFRB_N_A),
+	PINMUX_IPSR_MSEL(IP10_31_28,		NFRB_N_A,	SEL_NDFC_0),
 	PINMUX_IPSR_GPSR(IP10_31_28,		SD3_WP),
 	PINMUX_IPSR_MSEL(IP10_31_28,		RIF0_D0_B,	SEL_DRIF0_1),
 	PINMUX_IPSR_MSEL(IP10_31_28,		SDA2_B,		SEL_I2C2_1),
-- 
2.7.4
