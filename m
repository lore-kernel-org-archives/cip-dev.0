From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Aug 2017 14:14:59 +0100
Subject: [cip-dev] [PATCH 06/11] pinctrl: sh-pfc: r8a7791: Add missing
	HSCIF1 pinmux data
In-Reply-To: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
References: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502370904-41653-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The R8A7791 PFC driver  was apparently based on the preliminary revisions
of  the  user's manual, which  omitted the HSCIF1 group E signals in  the
IPSR4 register description. This would cause HSCIF1's probe  to fail with
the messages like below:

sh-pfc e6060000.pfc: cannot locate data/mark enum_id for mark 1989
sh-sci e62c8000.serial: Error applying setting, reverse things back
sh-sci: probe of e62c8000.serial failed with error -22

Add the neceassary PINMUX_IPSR_MSEL() invocations for the HSCK1_E,
HCTS1#_E, and HRTS1#_E signals...

Fixes: 508845196238 ("pinctrl: sh-pfc: r8a7791 PFC support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit da7a692fbbab07f4e9798b5b52798f6e3256dd8f)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Conflicts:
	drivers/pinctrl/sh-pfc/pfc-r8a7791.c
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 9884967..233cdbf 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -1014,14 +1014,17 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP4_12_10, SCL2, SEL_IIC2_0),
 	PINMUX_IPSR_MSEL(IP4_12_10, GPS_CLK_B, SEL_GPS_1),
 	PINMUX_IPSR_MSEL(IP4_12_10, GLO_Q0_D, SEL_GPS_3),
+	PINMUX_IPSR_MSEL(IP4_12_10, HSCK1_E, SEL_HSCIF1_4),
 	PINMUX_IPSR_DATA(IP4_15_13, SSI_WS2),
 	PINMUX_IPSR_MSEL(IP4_15_13, SDA2, SEL_IIC2_0),
 	PINMUX_IPSR_MSEL(IP4_15_13, GPS_SIGN_B, SEL_GPS_1),
 	PINMUX_IPSR_MSEL(IP4_15_13, RX2_E, SEL_SCIF2_4),
 	PINMUX_IPSR_MSEL(IP4_15_13, GLO_Q1_D, SEL_GPS_3),
+	PINMUX_IPSR_MSEL(IP4_15_13, HCTS1_N_E, SEL_HSCIF1_4),
 	PINMUX_IPSR_DATA(IP4_18_16, SSI_SDATA2),
 	PINMUX_IPSR_MSEL(IP4_18_16, GPS_MAG_B, SEL_GPS_1),
 	PINMUX_IPSR_MSEL(IP4_18_16, TX2_E, SEL_SCIF2_4),
+	PINMUX_IPSR_MSEL(IP4_18_16, HRTS1_N_E, SEL_HSCIF1_4),
 	PINMUX_IPSR_DATA(IP4_19, SSI_SCK34),
 	PINMUX_IPSR_DATA(IP4_20, SSI_WS34),
 	PINMUX_IPSR_DATA(IP4_21, SSI_SDATA3),
-- 
1.9.1
