From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 14:55:42 +0100
Subject: [cip-dev] [PATCH 4.19y 05/10] pinctrl: sh-pfc: r8a77990: Fix
	MOD_SEL0 bit3 when using TX0
In-Reply-To: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554126947-32747-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554126947-32747-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit 699c7d1346fbef69e60ca7647c50bbebc483d1c8 upstream.

According to the R-Car Gen3 Hardware Manual Errata for Rev 1.00 of
Aug 24, 2018, the MOD_SEL0 bit3 is set to 0 when TX0_A pin function is
selected, and the MOD_SEL0 bit3 is set to 1 when TX0_B pin function is
selected.

Fixes: 6d4036a1e3b3ac0f ("pinctrl: sh-pfc: Initial R8A77990 PFC support")
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index cb11e7d..1bc9b71 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -1060,7 +1060,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP11_11_8,		RIF1_SYNC),
 	PINMUX_IPSR_GPSR(IP11_11_8,		TS_SCK1),
 
-	PINMUX_IPSR_GPSR(IP11_15_12,		TX0_A),
+	PINMUX_IPSR_MSEL(IP11_15_12,		TX0_A,		SEL_SCIF0_0),
 	PINMUX_IPSR_GPSR(IP11_15_12,		HTX1_A),
 	PINMUX_IPSR_MSEL(IP11_15_12,		SSI_WS2_A,	SEL_SSI2_0),
 	PINMUX_IPSR_GPSR(IP11_15_12,		RIF1_D0),
@@ -1170,7 +1170,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP13_19_16,		SIM0_D_A,	SEL_SIMCARD_0),
 
 	PINMUX_IPSR_GPSR(IP13_23_20,		MLB_DAT),
-	PINMUX_IPSR_GPSR(IP13_23_20,		TX0_B),
+	PINMUX_IPSR_MSEL(IP13_23_20,		TX0_B,		SEL_SCIF0_1),
 	PINMUX_IPSR_MSEL(IP13_23_20,		RIF0_SYNC_A,	SEL_DRIF0_0),
 	PINMUX_IPSR_GPSR(IP13_23_20,		SIM0_CLK_A),
 
-- 
2.7.4
