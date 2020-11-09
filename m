Return-Path: <SRS0=+0M7=EP=lists.cip-project.org=bounce+64572+5778+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742F8C388F7
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD74206C0
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="c4yCF53d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD74206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5778+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AUHyYY4521723xXOek0ki9Wx; Mon, 09 Nov 2020 07:50:26 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.13504.1604937019730124247
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:26 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="61913721"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:25 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7BF8140078A1;
	Tue, 10 Nov 2020 00:50:24 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 09/14] pinctrl: sh-pfc: r8a7790: Add CAN pins, groups and functions
Date: Mon,  9 Nov 2020 15:50:06 +0000
Message-Id: <20201109155011.10291-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ilfcxn2aYlMcl5kZaPopyvuQx4520388AA=
Content-Type: multipart/mixed; boundary="cxKMuMJY28WbxkuYIyui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937026;
 bh=rWf/oPQxrq3IWe1DoW+npNN7xh3tx8/4/pquzx/a0+A=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=c4yCF53d4nqhwEkJzkdpADI9hk/Y0hrH/mouLNvRioCDnMjH0D4NnglETt4EMiNZy0u
 t9y6+6AWjiaCi7anOHfucOw3/jzHTyEGbuIP6sd8mlyZS5b+qim7zMjyCx9HEAA9hX13B
 bDLLk8+gZGCNOuNfPTLJXZJNJ6OUE3ZlRaE=

--cxKMuMJY28WbxkuYIyui

commit bbf369d4e59a248ed715041267951f5cd051b317 upstream.

Add pins, groups and functions for the CAN{0,1} interface.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200825095448.13093-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 112 ++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 00b64c5ec866..d87f9dbbb302 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -1890,6 +1890,86 @@ static const unsigned int avb_gmii_mux[] = {
 	AVB_TX_EN_MARK, AVB_TX_ER_MARK, AVB_TX_CLK_MARK,
 	AVB_COL_MARK,
 };
+/* - CAN0 ----------------------------------------------------------------- */
+static const unsigned int can0_data_pins[] = {
+	/* CAN0 RX */
+	RCAR_GP_PIN(1, 17),
+	/* CAN0 TX */
+	RCAR_GP_PIN(1, 19),
+};
+static const unsigned int can0_data_mux[] = {
+	CAN0_RX_MARK,
+	CAN0_TX_MARK,
+};
+static const unsigned int can0_data_b_pins[] = {
+	/* CAN0 RXB */
+	RCAR_GP_PIN(4, 5),
+	/* CAN0 TXB */
+	RCAR_GP_PIN(4, 4),
+};
+static const unsigned int can0_data_b_mux[] = {
+	CAN0_RX_B_MARK,
+	CAN0_TX_B_MARK,
+};
+static const unsigned int can0_data_c_pins[] = {
+	/* CAN0 RXC */
+	RCAR_GP_PIN(4, 26),
+	/* CAN0 TXC */
+	RCAR_GP_PIN(4, 23),
+};
+static const unsigned int can0_data_c_mux[] = {
+	CAN0_RX_C_MARK,
+	CAN0_TX_C_MARK,
+};
+static const unsigned int can0_data_d_pins[] = {
+	/* CAN0 RXD */
+	RCAR_GP_PIN(4, 26),
+	/* CAN0 TXD */
+	RCAR_GP_PIN(4, 18),
+};
+static const unsigned int can0_data_d_mux[] = {
+	CAN0_RX_D_MARK,
+	CAN0_TX_D_MARK,
+};
+/* - CAN1 ----------------------------------------------------------------- */
+static const unsigned int can1_data_pins[] = {
+	/* CAN1 RX */
+	RCAR_GP_PIN(1, 22),
+	/* CAN1 TX */
+	RCAR_GP_PIN(1, 18),
+};
+static const unsigned int can1_data_mux[] = {
+	CAN1_RX_MARK,
+	CAN1_TX_MARK,
+};
+static const unsigned int can1_data_b_pins[] = {
+	/* CAN1 RXB */
+	RCAR_GP_PIN(4, 7),
+	/* CAN1 TXB */
+	RCAR_GP_PIN(4, 6),
+};
+static const unsigned int can1_data_b_mux[] = {
+	CAN1_RX_B_MARK,
+	CAN1_TX_B_MARK,
+};
+/* - CAN Clock -------------------------------------------------------------- */
+static const unsigned int can_clk_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(1, 21),
+};
+
+static const unsigned int can_clk_mux[] = {
+	CAN_CLK_MARK,
+};
+
+static const unsigned int can_clk_b_pins[] = {
+	/* CLK */
+	RCAR_GP_PIN(4, 3),
+};
+
+static const unsigned int can_clk_b_mux[] = {
+	CAN_CLK_B_MARK,
+};
 /* - DU RGB ----------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
 	/* R[7:2], G[7:2], B[7:2] */
@@ -3958,7 +4038,7 @@ static const unsigned int vin3_clk_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[289];
+	struct sh_pfc_pin_group common[297];
 	struct sh_pfc_pin_group automotive[1];
 } pinmux_groups = {
 	.common = {
@@ -3975,6 +4055,14 @@ static const struct {
 		SH_PFC_PIN_GROUP(avb_mdio),
 		SH_PFC_PIN_GROUP(avb_mii),
 		SH_PFC_PIN_GROUP(avb_gmii),
+		SH_PFC_PIN_GROUP(can0_data),
+		SH_PFC_PIN_GROUP(can0_data_b),
+		SH_PFC_PIN_GROUP(can0_data_c),
+		SH_PFC_PIN_GROUP(can0_data_d),
+		SH_PFC_PIN_GROUP(can1_data),
+		SH_PFC_PIN_GROUP(can1_data_b),
+		SH_PFC_PIN_GROUP(can_clk),
+		SH_PFC_PIN_GROUP(can_clk_b),
 		SH_PFC_PIN_GROUP(du_rgb666),
 		SH_PFC_PIN_GROUP(du_rgb888),
 		SH_PFC_PIN_GROUP(du_clk_out_0),
@@ -4276,6 +4364,23 @@ static const char * const avb_groups[] = {
 	"avb_gmii",
 };
 
+static const char * const can0_groups[] = {
+	"can0_data",
+	"can0_data_b",
+	"can0_data_c",
+	"can0_data_d",
+};
+
+static const char * const can1_groups[] = {
+	"can1_data",
+	"can1_data_b",
+};
+
+static const char * const can_clk_groups[] = {
+	"can_clk",
+	"can_clk_b",
+};
+
 static const char * const du_groups[] = {
 	"du_rgb666",
 	"du_rgb888",
@@ -4716,13 +4821,16 @@ static const char * const vin3_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[55];
+	struct sh_pfc_function common[58];
 	struct sh_pfc_function automotive[1];
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
 		SH_PFC_FUNCTION(avb),
 		SH_PFC_FUNCTION(du),
+		SH_PFC_FUNCTION(can0),
+		SH_PFC_FUNCTION(can1),
+		SH_PFC_FUNCTION(can_clk),
 		SH_PFC_FUNCTION(du0),
 		SH_PFC_FUNCTION(du1),
 		SH_PFC_FUNCTION(du2),
-- 
2.17.1


--cxKMuMJY28WbxkuYIyui
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5778): https://lists.cip-project.org/g/cip-dev/message=
/5778
Mute This Topic: https://lists.cip-project.org/mt/78138436/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--cxKMuMJY28WbxkuYIyui--
