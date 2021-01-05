Return-Path: <SRS0=Uk0i=GI=lists.cip-project.org=bounce+64572+6027+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA78C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 15:11:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BAE22B45
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 15:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BAE22B45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6027+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Y3nwYY4521723xBdqqm7dupo; Tue, 05 Jan 2021 07:11:07 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.6688.1609859461253190014
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 07:11:07 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="68089580"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jan 2021 00:11:06 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7BBE44009F7E;
	Wed,  6 Jan 2021 00:11:05 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 5/8] pinctrl: renesas: r8a77990: Add QSPI[01] pins, groups and functions
Date: Tue,  5 Jan 2021 15:10:54 +0000
Message-Id: <20210105151057.12752-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105151057.12752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105151057.12752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LrGI2YBChus4HgpyeyNH1fYcx4520388AA=
Content-Type: multipart/mixed; boundary="LbxnuqRvfGEs53n1y6uF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609859467;
 bh=4MwLBKfwyZVJwWUnIfarlhs9oN2KLFIBuey/OS91umc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DVjR9VdxYuNHvqr603yWH+aLBg6I8u86erjO2U+V82Z3UKqHl4nSY2nqEzDP99xT0rn
 g9J3BYVtK3c1nt7y0hBVaUcI/l86iJxhTGX+B/f7zI8VDp4Wda633MoxuldzxCl+jOkWK
 cNE9rgDWZVjrZGXjW37+qK8wv93wkbahUvA=

--LbxnuqRvfGEs53n1y6uF

commit 89ad953e1e727640e85beb82db3c71d45a59b177 upstream.

Add pins, groups and functions for QSPIO[01].

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20201119130926.25692-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 75 ++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 18049e1c49a6..41ee72e06abb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -2807,6 +2807,57 @@ static const unsigned int pwm6_b_mux[] = {
 	PWM6_B_MARK,
 };
 
+/* - QSPI0 ------------------------------------------------------------------ */
+static const unsigned int qspi0_ctrl_pins[] = {
+	/* QSPI0_SPCLK, QSPI0_SSL */
+	RCAR_GP_PIN(2, 0), RCAR_GP_PIN(2, 5),
+};
+static const unsigned int qspi0_ctrl_mux[] = {
+	QSPI0_SPCLK_MARK, QSPI0_SSL_MARK,
+};
+static const unsigned int qspi0_data2_pins[] = {
+	/* QSPI0_MOSI_IO0, QSPI0_MISO_IO1 */
+	RCAR_GP_PIN(2, 1), RCAR_GP_PIN(2, 2),
+};
+static const unsigned int qspi0_data2_mux[] = {
+	QSPI0_MOSI_IO0_MARK, QSPI0_MISO_IO1_MARK,
+};
+static const unsigned int qspi0_data4_pins[] = {
+	/* QSPI0_MOSI_IO0, QSPI0_MISO_IO1 */
+	RCAR_GP_PIN(2, 1), RCAR_GP_PIN(2, 2),
+	/* QSPI0_IO2, QSPI0_IO3 */
+	RCAR_GP_PIN(2, 3), RCAR_GP_PIN(2, 4),
+};
+static const unsigned int qspi0_data4_mux[] = {
+	QSPI0_MOSI_IO0_MARK, QSPI0_MISO_IO1_MARK,
+	QSPI0_IO2_MARK, QSPI0_IO3_MARK,
+};
+/* - QSPI1 ------------------------------------------------------------------ */
+static const unsigned int qspi1_ctrl_pins[] = {
+	/* QSPI1_SPCLK, QSPI1_SSL */
+	RCAR_GP_PIN(2, 6), RCAR_GP_PIN(2, 11),
+};
+static const unsigned int qspi1_ctrl_mux[] = {
+	QSPI1_SPCLK_MARK, QSPI1_SSL_MARK,
+};
+static const unsigned int qspi1_data2_pins[] = {
+	/* QSPI1_MOSI_IO0, QSPI1_MISO_IO1 */
+	RCAR_GP_PIN(2, 7), RCAR_GP_PIN(2, 8),
+};
+static const unsigned int qspi1_data2_mux[] = {
+	QSPI1_MOSI_IO0_MARK, QSPI1_MISO_IO1_MARK,
+};
+static const unsigned int qspi1_data4_pins[] = {
+	/* QSPI1_MOSI_IO0, QSPI1_MISO_IO1 */
+	RCAR_GP_PIN(2, 7), RCAR_GP_PIN(2, 8),
+	/* QSPI1_IO2, QSPI1_IO3 */
+	RCAR_GP_PIN(2, 9), RCAR_GP_PIN(2, 10),
+};
+static const unsigned int qspi1_data4_mux[] = {
+	QSPI1_MOSI_IO0_MARK, QSPI1_MISO_IO1_MARK,
+	QSPI1_IO2_MARK, QSPI1_IO3_MARK,
+};
+
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_a_pins[] = {
 	/* RX, TX */
@@ -3759,7 +3810,7 @@ static const unsigned int vin5_clk_b_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[247];
+	struct sh_pfc_pin_group common[253];
 #ifdef CONFIG_PINCTRL_PFC_R8A77990
 	struct sh_pfc_pin_group automotive[21];
 #endif
@@ -3907,6 +3958,12 @@ static const struct {
 		SH_PFC_PIN_GROUP(pwm5_b),
 		SH_PFC_PIN_GROUP(pwm6_a),
 		SH_PFC_PIN_GROUP(pwm6_b),
+		SH_PFC_PIN_GROUP(qspi0_ctrl),
+		SH_PFC_PIN_GROUP(qspi0_data2),
+		SH_PFC_PIN_GROUP(qspi0_data4),
+		SH_PFC_PIN_GROUP(qspi1_ctrl),
+		SH_PFC_PIN_GROUP(qspi1_data2),
+		SH_PFC_PIN_GROUP(qspi1_data4),
 		SH_PFC_PIN_GROUP(scif0_data_a),
 		SH_PFC_PIN_GROUP(scif0_clk_a),
 		SH_PFC_PIN_GROUP(scif0_ctrl_a),
@@ -4310,6 +4367,18 @@ static const char * const pwm6_groups[] = {
 	"pwm6_b",
 };
 
+static const char * const qspi0_groups[] = {
+	"qspi0_ctrl",
+	"qspi0_data2",
+	"qspi0_data4",
+};
+
+static const char * const qspi1_groups[] = {
+	"qspi1_ctrl",
+	"qspi1_data2",
+	"qspi1_data4",
+};
+
 static const char * const scif0_groups[] = {
 	"scif0_data_a",
 	"scif0_clk_a",
@@ -4464,7 +4533,7 @@ static const char * const vin5_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[47];
+	struct sh_pfc_function common[49];
 #ifdef CONFIG_PINCTRL_PFC_R8A77990
 	struct sh_pfc_function automotive[4];
 #endif
@@ -4501,6 +4570,8 @@ static const struct {
 		SH_PFC_FUNCTION(pwm4),
 		SH_PFC_FUNCTION(pwm5),
 		SH_PFC_FUNCTION(pwm6),
+		SH_PFC_FUNCTION(qspi0),
+		SH_PFC_FUNCTION(qspi1),
 		SH_PFC_FUNCTION(scif0),
 		SH_PFC_FUNCTION(scif1),
 		SH_PFC_FUNCTION(scif2),
-- 
2.17.1


--LbxnuqRvfGEs53n1y6uF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6027): https://lists.cip-project.org/g/cip-dev/message=
/6027
Mute This Topic: https://lists.cip-project.org/mt/79451757/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LbxnuqRvfGEs53n1y6uF--
