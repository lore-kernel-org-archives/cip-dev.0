From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Aug 2017 14:15:01 +0100
Subject: [cip-dev] [PATCH 08/11] pinctrl: sh-pfc: r8a7791: Fix SCIF2 pinmux
	data
In-Reply-To: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
References: <1502370904-41653-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502370904-41653-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

PINMUX_IPSR_MSEL() macro invocation for the TX2 signal has apparently wrong
1st argument -- most probably a result of cut&paste programming...

Fixes: 508845196238 ("pinctrl: sh-pfc: r8a7791 PFC support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 58439280f84e6b39fd7d61f25ab30489c1aaf0a9)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 1c8dd39..8232305 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -1107,7 +1107,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP6_5_3, FMIN_E, SEL_FM_4),
 	PINMUX_IPSR_DATA(IP6_7_6, AUDIO_CLKOUT),
 	PINMUX_IPSR_MSEL(IP6_7_6, MSIOF1_SS1_B, SEL_SOF1_1),
-	PINMUX_IPSR_MSEL(IP6_5_3, TX2, SEL_SCIF2_0),
+	PINMUX_IPSR_MSEL(IP6_7_6, TX2, SEL_SCIF2_0),
 	PINMUX_IPSR_MSEL(IP6_7_6, SCIFA2_TXD, SEL_SCIFA2_0),
 	PINMUX_IPSR_DATA(IP6_9_8, IRQ0),
 	PINMUX_IPSR_MSEL(IP6_9_8, SCIFB1_RXD_D, SEL_SCIFB1_3),
-- 
1.9.1
