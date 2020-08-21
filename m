Return-Path: <SRS0=aF/L=B7=lists.cip-project.org=bounce+64572+5183+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BCCC433DF
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD67207BB
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pEcxpG6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD67207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5183+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iipNYY4521723xvRz5I2SzGx; Fri, 21 Aug 2020 03:58:32 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131152.1598003016916343991
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:51 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954593"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:50 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 84A70423206F;
	Fri, 21 Aug 2020 18:43:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 19/36] pinctrl: sh-pfc: r8a7795-es1: Add I2C{0,3,5} pins, groups and functions
Date: Fri, 21 Aug 2020 10:42:55 +0100
Message-Id: <20200821094312.3249-20-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KuWXjJlOLUlrD8H741baN4Vtx4520388AA=
Content-Type: multipart/mixed; boundary="gnng4SciezkalDRN29BL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007512;
 bh=Lq1DQf9kk2Sib2VPDRLaJN9wBCNgOsosRf5T+HBRnM0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pEcxpG6a2HS3lTJhSROczP0edFDFEUSE2r0HS7njAHAJJ1s4/k4fcEiJ9OdFdiNMmIU
 vQ8eMLusAYUOBSf4q+9tg5hNg1+BsRVPhIszMbAVdnYopaHDn/OtV8Zzp8f2mgKWhuPop
 /zaY9UilHiHoovZ2z/pvcuuEIL+ZnKUEgnA=

--gnng4SciezkalDRN29BL

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit e244ff6f913f6ce4c77a00647462bc34c4221f46 upstream.

This patch adds I2C{0,3,5} pins, groups and functions to
the R8A7795 ES1.x SoC.

These pins are physically muxed with other pins. Therefore, setup of
MOD_SEL is needed for exclusive control with other pins.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 97 ++++++++++++++++++------
 1 file changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index d8404ca600f3..897b7923074f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -539,6 +539,9 @@ MOD_SEL0_2_1		MOD_SEL1_2 \
 	FM(DU_DOTCLKIN0) FM(DU_DOTCLKIN1) FM(DU_DOTCLKIN2) FM(DU_DOTCLKIN3) \
 	FM(TMS) FM(TDO) FM(ASEBRK) FM(MLB_REF) FM(TDI) FM(TCK) FM(TRST) FM(EXTALR)
 
+#define PINMUX_PHYS \
+	FM(SCL0) FM(SDA0) FM(SCL3) FM(SDA3) FM(SCL5) FM(SDA5)
+
 enum {
 	PINMUX_RESERVED = 0,
 
@@ -564,6 +567,7 @@ enum {
 	PINMUX_IPSR
 	PINMUX_MOD_SELS
 	PINMUX_STATIC
+	PINMUX_PHYS
 	PINMUX_MARK_END,
 #undef F_
 #undef FM
@@ -576,9 +580,6 @@ static const u16 pinmux_data[] = {
 	PINMUX_SINGLE(AVS2),
 	PINMUX_SINGLE(GP7_02),
 	PINMUX_SINGLE(GP7_03),
-	PINMUX_SINGLE(I2C_SEL_0_1),
-	PINMUX_SINGLE(I2C_SEL_3_1),
-	PINMUX_SINGLE(I2C_SEL_5_1),
 	PINMUX_SINGLE(MSIOF0_RXD),
 	PINMUX_SINGLE(MSIOF0_SCK),
 	PINMUX_SINGLE(MSIOF0_TXD),
@@ -610,13 +611,15 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP0_15_12,	MSIOF2_SCK_C,		SEL_MSIOF2_2),
 	PINMUX_IPSR_MSEL(IP0_15_12,	TX4_A,			SEL_SCIF4_0),
 
-	PINMUX_IPSR_MSEL(IP0_19_16,	AVB_AVTP_MATCH_A,	SEL_ETHERAVB_0),
-	PINMUX_IPSR_MSEL(IP0_19_16,	MSIOF2_RXD_C,		SEL_MSIOF2_2),
-	PINMUX_IPSR_MSEL(IP0_19_16,	CTS4_N_A,		SEL_SCIF4_0),
+	PINMUX_IPSR_PHYS_MSEL(IP0_19_16, AVB_AVTP_MATCH_A,	I2C_SEL_5_0,	SEL_ETHERAVB_0),
+	PINMUX_IPSR_PHYS_MSEL(IP0_19_16, MSIOF2_RXD_C,		I2C_SEL_5_0,	SEL_MSIOF2_2),
+	PINMUX_IPSR_PHYS_MSEL(IP0_19_16, CTS4_N_A,		I2C_SEL_5_0,	SEL_SCIF4_0),
+	PINMUX_IPSR_PHYS(IP0_19_16,	SCL5,			I2C_SEL_5_1),
 
-	PINMUX_IPSR_MSEL(IP0_23_20,	AVB_AVTP_CAPTURE_A,	SEL_ETHERAVB_0),
-	PINMUX_IPSR_MSEL(IP0_23_20,	MSIOF2_TXD_C,		SEL_MSIOF2_2),
-	PINMUX_IPSR_MSEL(IP0_23_20,	RTS4_N_TANS_A,		SEL_SCIF4_0),
+	PINMUX_IPSR_PHYS_MSEL(IP0_23_20, AVB_AVTP_CAPTURE_A,	I2C_SEL_5_0,	SEL_ETHERAVB_0),
+	PINMUX_IPSR_PHYS_MSEL(IP0_23_20, MSIOF2_TXD_C,		I2C_SEL_5_0,	SEL_MSIOF2_2),
+	PINMUX_IPSR_PHYS_MSEL(IP0_23_20, RTS4_N_TANS_A,		I2C_SEL_5_0,	SEL_SCIF4_0),
+	PINMUX_IPSR_PHYS(IP0_23_20,	SDA5,			I2C_SEL_5_1),
 
 	PINMUX_IPSR_GPSR(IP0_27_24,	IRQ0),
 	PINMUX_IPSR_GPSR(IP0_27_24,	QPOLB),
@@ -666,16 +669,18 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_MSEL(IP1_19_16,	VI4_DATA6_B,		SEL_VIN4_1),
 	PINMUX_IPSR_MSEL(IP1_19_16,	IECLK_B,		SEL_IEBUS_1),
 
-	PINMUX_IPSR_MSEL(IP1_23_20,	PWM1_A,			SEL_PWM1_0),
-	PINMUX_IPSR_GPSR(IP1_23_20,	A21),
-	PINMUX_IPSR_MSEL(IP1_23_20,	HRX3_D,			SEL_HSCIF3_3),
-	PINMUX_IPSR_MSEL(IP1_23_20,	VI4_DATA7_B,		SEL_VIN4_1),
-	PINMUX_IPSR_MSEL(IP1_23_20,	IERX_B,			SEL_IEBUS_1),
+	PINMUX_IPSR_PHYS_MSEL(IP1_23_20, PWM1_A,		I2C_SEL_3_0,	SEL_PWM1_0),
+	PINMUX_IPSR_MSEL(IP1_23_20,	A21,			I2C_SEL_3_0),
+	PINMUX_IPSR_PHYS_MSEL(IP1_23_20, HRX3_D,		I2C_SEL_3_0,	SEL_HSCIF3_3),
+	PINMUX_IPSR_PHYS_MSEL(IP1_23_20, VI4_DATA7_B,		I2C_SEL_3_0,	SEL_VIN4_1),
+	PINMUX_IPSR_PHYS_MSEL(IP1_23_20, IERX_B,		I2C_SEL_3_0,	SEL_IEBUS_1),
+	PINMUX_IPSR_PHYS(IP0_23_20,	SCL3,			I2C_SEL_3_1),
 
-	PINMUX_IPSR_MSEL(IP1_27_24,	PWM2_A,			SEL_PWM2_0),
-	PINMUX_IPSR_GPSR(IP1_27_24,	A20),
-	PINMUX_IPSR_MSEL(IP1_27_24,	HTX3_D,			SEL_HSCIF3_3),
-	PINMUX_IPSR_MSEL(IP1_27_24,	IETX_B,			SEL_IEBUS_1),
+	PINMUX_IPSR_PHYS_MSEL(IP1_27_24, PWM2_A,		I2C_SEL_3_0,	SEL_PWM2_0),
+	PINMUX_IPSR_MSEL(IP1_27_24,	A20,			I2C_SEL_3_0),
+	PINMUX_IPSR_PHYS_MSEL(IP1_27_24, HTX3_D,		I2C_SEL_3_0,	SEL_HSCIF3_3),
+	PINMUX_IPSR_PHYS_MSEL(IP1_27_24, IETX_B,		I2C_SEL_3_0,	SEL_IEBUS_1),
+	PINMUX_IPSR_PHYS(IP1_27_24,	SDA3,			I2C_SEL_3_1),
 
 	PINMUX_IPSR_GPSR(IP1_31_28,	A0),
 	PINMUX_IPSR_GPSR(IP1_31_28,	LCDOUT16),
@@ -1069,11 +1074,13 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP10_15_12,	SD0_WP),
 	PINMUX_IPSR_MSEL(IP10_15_12,	SDA2_B,			SEL_I2C2_1),
 
-	PINMUX_IPSR_GPSR(IP10_19_16,	SD1_CD),
-	PINMUX_IPSR_MSEL(IP10_19_16,	SIM0_CLK_B,		SEL_SIMCARD_1),
+	PINMUX_IPSR_MSEL(IP10_19_16,	SD1_CD,			I2C_SEL_0_0),
+	PINMUX_IPSR_PHYS_MSEL(IP10_19_16, SIM0_CLK_B,		I2C_SEL_0_0,	SEL_SIMCARD_1),
+	PINMUX_IPSR_PHYS(IP10_19_16,	SCL0,			I2C_SEL_0_1),
 
-	PINMUX_IPSR_GPSR(IP10_23_20,	SD1_WP),
-	PINMUX_IPSR_MSEL(IP10_23_20,	SIM0_D_B,		SEL_SIMCARD_1),
+	PINMUX_IPSR_MSEL(IP10_23_20,	SD1_WP,			I2C_SEL_0_0),
+	PINMUX_IPSR_PHYS_MSEL(IP10_23_20, SIM0_D_B,		I2C_SEL_0_0,	SEL_SIMCARD_1),
+	PINMUX_IPSR_PHYS(IP10_23_20,	SDA0,			I2C_SEL_0_1),
 
 	PINMUX_IPSR_GPSR(IP10_27_24,	SCK0),
 	PINMUX_IPSR_MSEL(IP10_27_24,	HSCK1_B,		SEL_HSCIF1_1),
@@ -2250,6 +2257,15 @@ static const unsigned int hscif4_data_b_mux[] = {
 };
 
 /* - I2C -------------------------------------------------------------------- */
+static const unsigned int i2c0_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15),
+};
+
+static const unsigned int i2c0_mux[] = {
+	SCL0_MARK, SDA0_MARK,
+};
+
 static const unsigned int i2c1_a_pins[] = {
 	/* SDA, SCL */
 	RCAR_GP_PIN(5, 11), RCAR_GP_PIN(5, 10),
@@ -2278,6 +2294,25 @@ static const unsigned int i2c2_b_pins[] = {
 static const unsigned int i2c2_b_mux[] = {
 	SDA2_B_MARK, SCL2_B_MARK,
 };
+
+static const unsigned int i2c3_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 7), RCAR_GP_PIN(2, 8),
+};
+
+static const unsigned int i2c3_mux[] = {
+	SCL3_MARK, SDA3_MARK,
+};
+
+static const unsigned int i2c5_pins[] = {
+	/* SCL, SDA */
+	RCAR_GP_PIN(2, 13), RCAR_GP_PIN(2, 14),
+};
+
+static const unsigned int i2c5_mux[] = {
+	SCL5_MARK, SDA5_MARK,
+};
+
 static const unsigned int i2c6_a_pins[] = {
 	/* SDA, SCL */
 	RCAR_GP_PIN(1, 8), RCAR_GP_PIN(1, 11),
@@ -3918,10 +3953,13 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(hscif4_clk),
 	SH_PFC_PIN_GROUP(hscif4_ctrl),
 	SH_PFC_PIN_GROUP(hscif4_data_b),
+	SH_PFC_PIN_GROUP(i2c0),
 	SH_PFC_PIN_GROUP(i2c1_a),
 	SH_PFC_PIN_GROUP(i2c1_b),
 	SH_PFC_PIN_GROUP(i2c2_a),
 	SH_PFC_PIN_GROUP(i2c2_b),
+	SH_PFC_PIN_GROUP(i2c3),
+	SH_PFC_PIN_GROUP(i2c5),
 	SH_PFC_PIN_GROUP(i2c6_a),
 	SH_PFC_PIN_GROUP(i2c6_b),
 	SH_PFC_PIN_GROUP(i2c6_c),
@@ -4283,6 +4321,10 @@ static const char * const hscif4_groups[] = {
 	"hscif4_data_b",
 };
 
+static const char * const i2c0_groups[] = {
+	"i2c0",
+};
+
 static const char * const i2c1_groups[] = {
 	"i2c1_a",
 	"i2c1_b",
@@ -4293,6 +4335,14 @@ static const char * const i2c2_groups[] = {
 	"i2c2_b",
 };
 
+static const char * const i2c3_groups[] = {
+	"i2c3",
+};
+
+static const char * const i2c5_groups[] = {
+	"i2c5",
+};
+
 static const char * const i2c6_groups[] = {
 	"i2c6_a",
 	"i2c6_b",
@@ -4623,8 +4673,11 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(hscif2),
 	SH_PFC_FUNCTION(hscif3),
 	SH_PFC_FUNCTION(hscif4),
+	SH_PFC_FUNCTION(i2c0),
 	SH_PFC_FUNCTION(i2c1),
 	SH_PFC_FUNCTION(i2c2),
+	SH_PFC_FUNCTION(i2c3),
+	SH_PFC_FUNCTION(i2c5),
 	SH_PFC_FUNCTION(i2c6),
 	SH_PFC_FUNCTION(intc_ex),
 	SH_PFC_FUNCTION(msiof0),
-- 
2.17.1


--gnng4SciezkalDRN29BL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5183): https://lists.cip-project.org/g/cip-dev/message=
/5183
Mute This Topic: https://lists.cip-project.org/mt/76326722/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--gnng4SciezkalDRN29BL--
