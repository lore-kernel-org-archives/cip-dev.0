Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.931.1795020145997746026
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C85162C09;
	Wed, 18 Nov 2026 16:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A8F1F000C4;
	Wed, 18 Nov 2026 16:42:24 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 26/35] pinctrl: renesas: rzg2l: Add SD channel POC support for RZ/G3L
Date: Wed, 18 Nov 2026 18:41:37 +0200
Message-ID: <20261118164146.3040784-27-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24989

From: Biju Das <biju.das.jz@bp.renesas.com>

commit d48a308fabd6dc7676d570f0bc971817e39d824c upstream.

Add power-on control (POC) support for SD channels 1 and 2 on the RZ/G3L
SoC (r9a08g046).

Introduce PIN_CFG_IO_VMC_SD2 capability flag (bit 22) and SD_CH2_POC
register offset (0x3024). Extend rzg2l_caps_to_pwr_reg() to return
SD_CH2_POC when PIN_CFG_IO_VMC_SD2 is set.

Replace RZG3L_MPXED_PIN_FUNCS() with RZG2L_MPXED_COMMON_PIN_FUNCS() for
port PG and PH pins, dropping PIN_CFG_SOFT_PS which is inappropriate for
SD pins, and annotate them with PIN_CFG_IO_VMC_SD1 and PIN_CFG_IO_VMC_SD2
respectively.

Annotate all RZ/G3L SD0 dedicated pins (CLK, CMD, RST#, DS, DAT0=E2=80=93=
DAT7)
with PIN_CFG_IO_VMC_SD0 so that power-source register lookups work
correctly for those pins.

Add sd_ch2 field to rzg2l_register_offsets and rzg2l_pinctrl_reg_cache to
save and restore the SD_CH2_POC register across suspend/resume cycles.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260723154154.319674-2-biju.das.jz@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 74 +++++++++++++++++--------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
index f190bb3fbf71..80cb55d84932 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -69,6 +69,7 @@
 #define PIN_CFG_PVDD1833_OTH_AWO_POC	BIT(19) /* known on RZ/G3L only */
 #define PIN_CFG_PVDD1833_OTH_ISO_POC	BIT(20) /* known on RZ/G3L only */
 #define PIN_CFG_WDTOVF_N_POC		BIT(21) /* known on RZ/G3L only */
+#define PIN_CFG_IO_VMC_SD2		BIT(22) /* known on RZ/G3L only */
=20
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
 #define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
@@ -256,6 +257,7 @@ static const struct pin_config_item renesas_rzv2h_con=
f_items[] =3D {
  * struct rzg2l_register_offsets - specific register offsets
  * @pwpr: PWPR register offset
  * @sd_ch: SD_CH register offset
+ * @sd_ch2: SD_CH2_POC register offset
  * @eth_poc: ETH_POC register offset
  * @oen: OEN register offset
  * @qspi: QSPI register offset
@@ -264,6 +266,7 @@ static const struct pin_config_item renesas_rzv2h_con=
f_items[] =3D {
 struct rzg2l_register_offsets {
 	u16 pwpr;
 	u16 sd_ch;
+	u16 sd_ch2;
 	u16 eth_poc;
 	u16 oen;
 	u16 qspi;
@@ -370,6 +373,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @nod: NOD registers cache
  * @clone: Clone register cache
  * @sd_ch: SD_CH registers cache
+ * @sd_ch2: SD_CH2_POC registers cache
  * @eth_poc: ET_POC registers cache
  * @oen: Output Enable register cache
  * @other_poc: OTHER_POC register cache
@@ -388,6 +392,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u32	*nod[2];
 	u32	clone;
 	u8	sd_ch[2];
+	u8	sd_ch2;
 	u8	eth_poc[2];
 	u8	oen;
 	u8	other_poc;
@@ -476,20 +481,32 @@ static const u64 r9a08g046_variable_pin_cfg[] =3D {
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 5, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1=
)),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 6, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1=
)),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 7, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1=
)),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 0, RZG3L_MPXED_PIN_FUNCS(B)),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 1, RZG3L_MPXED_PIN_FUNCS(B) | PIN=
_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 2, RZG3L_MPXED_PIN_FUNCS(B) | PIN=
_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 3, RZG3L_MPXED_PIN_FUNCS(B) | PIN=
_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 4, RZG3L_MPXED_PIN_FUNCS(B) | PIN=
_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 5, RZG3L_MPXED_PIN_FUNCS(B) | PIN=
_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 0, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IO_VMC_SD1),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 1, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 2, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 3, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) | PIN_CFG_IEN |
+				    PIN_CFG_IO_VMC_SD1),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 4, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 5, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 6, RZG3L_MPXED_PIN_FUNCS_POC(B, I=
SO)),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 7, RZG3L_MPXED_PIN_FUNCS_POC(B, I=
SO)),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 0, RZG3L_MPXED_PIN_FUNCS(B)),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 1, RZG3L_MPXED_PIN_FUNCS(B) | PIN=
_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 2, RZG3L_MPXED_PIN_FUNCS(B) | PIN=
_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 3, RZG3L_MPXED_PIN_FUNCS(B) | PIN=
_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 4, RZG3L_MPXED_PIN_FUNCS(B) | PIN=
_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 5, RZG3L_MPXED_PIN_FUNCS(B) | PIN=
_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 0, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IO_VMC_SD2),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 1, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IEN | PIN_CFG_IO_VMC_SD2),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 2, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IEN | PIN_CFG_IO_VMC_SD2),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 3, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IEN | PIN_CFG_IO_VMC_SD2),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 4, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IEN | PIN_CFG_IO_VMC_SD2),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 5, RZG2L_MPXED_COMMON_PIN_FUNCS(B=
) |
+				    PIN_CFG_IEN | PIN_CFG_IO_VMC_SD2),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PJ, 0, RZG3L_MPXED_PIN_FUNCS(A) | PIN=
_CFG_IEN),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PJ, 1, RZG3L_MPXED_PIN_FUNCS(A)),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PJ, 2, RZG3L_MPXED_PIN_FUNCS(A)),
@@ -1055,6 +1072,8 @@ static int rzg2l_caps_to_pwr_reg(const struct rzg2l=
_register_offsets *regs,
 		return SD_CH(regs->sd_ch, 0);
 	if (caps & PIN_CFG_IO_VMC_SD1)
 		return SD_CH(regs->sd_ch, 1);
+	if (caps & PIN_CFG_IO_VMC_SD2)
+		return regs->sd_ch2;
 	if (caps & PIN_CFG_IO_VMC_ETH0)
 		return ETH_POC(regs->eth_poc, 0);
 	if (caps & PIN_CFG_IO_VMC_ETH1)
@@ -2678,28 +2697,28 @@ static const struct rzg2l_dedicated_configs rzg3l=
_dedicated_pins[] =3D {
 	  (PIN_CFG_IOLH_A | PIN_CFG_PUPD | PIN_CFG_PVDD1833_OTH_AWO_POC)) },
 	{ "SCIF0_TXD", RZG2L_SINGLE_PIN_PACK(0x6, 1,
 	  (PIN_CFG_IOLH_A | PIN_CFG_PUPD | PIN_CFG_PVDD1833_OTH_AWO_POC)) },
-	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x9, 0, PIN_CFG_IOLH_B) },
+	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x9, 0, PIN_CFG_IOLH_B | PIN_CFG_IO_=
VMC_SD0) },
 	{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x9, 1,
-	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
-	{ "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x9, 2, PIN_CFG_IOLH_B) },
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD | PIN_CFG_IO_VMC_SD0)) }=
,
+	{ "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x9, 2, PIN_CFG_IOLH_B | PIN_CFG_IO=
_VMC_SD0) },
 	{ "SD0_DS", RZG2L_SINGLE_PIN_PACK(0x9, 5,
-	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD | PIN_CFG_IO_VMC_SD0)) }=
,
 	{ "SD0_DAT0", RZG2L_SINGLE_PIN_PACK(0x0a, 0,
-	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD | PIN_CFG_IO_VMC_SD0)) }=
,
 	{ "SD0_DAT1", RZG2L_SINGLE_PIN_PACK(0x0a, 1,
-	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD | PIN_CFG_IO_VMC_SD0)) }=
,
 	{ "SD0_DAT2", RZG2L_SINGLE_PIN_PACK(0x0a, 2,
-	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD | PIN_CFG_IO_VMC_SD0)) }=
,
 	{ "SD0_DAT3", RZG2L_SINGLE_PIN_PACK(0x0a, 3,
-	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD | PIN_CFG_IO_VMC_SD0)) }=
,
 	{ "SD0_DAT4", RZG2L_SINGLE_PIN_PACK(0x0a, 4,
-	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD | PIN_CFG_IO_VMC_SD0)) }=
,
 	{ "SD0_DAT5", RZG2L_SINGLE_PIN_PACK(0x0a, 5,
-	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD | PIN_CFG_IO_VMC_SD0)) }=
,
 	{ "SD0_DAT6", RZG2L_SINGLE_PIN_PACK(0x0a, 6,
-	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD | PIN_CFG_IO_VMC_SD0)) }=
,
 	{ "SD0_DAT7", RZG2L_SINGLE_PIN_PACK(0x0a, 7,
-	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD | PIN_CFG_IO_VMC_SD0)) }=
,
 };
=20
 static const u32 r9a08g046_clone_channel_data[] =3D {
@@ -3683,6 +3702,9 @@ static int rzg2l_pinctrl_suspend_noirq(struct devic=
e *dev)
 			cache->eth_poc[i] =3D readb(pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
=20
+	if (regs->sd_ch2)
+		cache->sd_ch2 =3D readb(pctrl->base + regs->sd_ch2);
+
 	if (regs->qspi)
 		cache->qspi =3D readb(pctrl->base + regs->qspi);
 	cache->oen =3D readb(pctrl->base + pctrl->data->hwcfg->regs.oen);
@@ -3735,6 +3757,9 @@ static int rzg2l_pinctrl_resume_noirq(struct device=
 *dev)
 	rzg2l_oen_write_with_pwpr(pctrl, cache->oen);
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
=20
+	if (regs->sd_ch2)
+		writeb(cache->sd_ch2, pctrl->base + regs->sd_ch2);
+
 	for (u8 i =3D 0; i < 2; i++) {
 		if (regs->sd_ch)
 			writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
@@ -3802,6 +3827,7 @@ static const struct rzg2l_hwcfg rzg3l_hwcfg =3D {
 	.regs =3D {
 		.pwpr =3D 0x3000,
 		.sd_ch =3D 0x3004,
+		.sd_ch2 =3D 0x3024,
 		.eth_poc =3D 0x3010,
 		.oen =3D 0x3018,
 		.other_poc =3D OTHER_POC,
--=20
2.43.0

