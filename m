Return-Path: <SRS0=+hCF=LP=lists.cip-project.org=bounce+64572+6551+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBA3C48BE5
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E087460E0B
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E087460E0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6551+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id t4v4YY4521723xp1qi1cuw0u; Mon, 21 Jun 2021 10:09:35 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.50307.1624295372909229575
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 10:09:35 -0700
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="85077290"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jun 2021 02:09:34 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D3A6D400C4DB;
	Tue, 22 Jun 2021 02:09:33 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 5.10.y-cip 05/16] pinctrl: renesas: r8a77951: Optimize pinctrl image size for R8A774E1
Date: Mon, 21 Jun 2021 18:09:14 +0100
Message-Id: <20210621170925.11328-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: k9gGSQEfBYvWr8QEEhUvc4x4x4520388AA=
Content-Type: multipart/mixed; boundary="jA45D1DCfMrAw8OmmONX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624295375;
 bh=93S7RsttG3teheHDwzsnmolsRMp35l6SzBHDfYkQc78=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bIaL1qYd7EMuLtF4YC0YMPLlyRoV7F8U+s6XbmA5dtf/Q66SrYvmKxd+s01BvJEytqN
 9k2BVhaHo9IxOJddBXz9FD2g5csR17vKOXsDecMiOswbVlCXJB87NQc8eqQZl5oS/Pfjg
 X6U41wF8JBwpngGb7RTzPMOeVGX0VgrQ7CI=

--jA45D1DCfMrAw8OmmONX

From: Biju Das <biju.das.jz@bp.renesas.com>

commit b8029394efccf48687d9a7fae6c4747b81e35261 upstream.

This driver supports both RZ/G2H and R-Car H3 ES2 SoCs.
Optimize pinctrl image size for RZ/G2H, when support for R-Car H3 ES2
(R8A77951) is not enabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20201019124258.4574-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pfc-r8a77951.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77951.c b/drivers/pinctrl/renesas/pfc-r8a77951.c
index a94ebe0bf5d0..8d1262c170af 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77951.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77951.c
@@ -1827,6 +1827,7 @@ static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK,         CANFD1_RX_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 /* - DRIF0 --------------------------------------------------------------- */
 static const unsigned int drif0_ctrl_a_pins[] = {
 	/* CLK, SYNC */
@@ -2041,6 +2042,7 @@ static const unsigned int drif3_data1_b_pins[] = {
 static const unsigned int drif3_data1_b_mux[] = {
 	RIF3_D1_B_MARK,
 };
+#endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
@@ -4159,7 +4161,9 @@ static const unsigned int vin5_clk_mux[] = {
 
 static const struct {
 	struct sh_pfc_pin_group common[320];
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 	struct sh_pfc_pin_group automotive[30];
+#endif
 } pinmux_groups = {
 	.common = {
 		SH_PFC_PIN_GROUP(audio_clk_a_a),
@@ -4483,6 +4487,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_clkenb),
 		SH_PFC_PIN_GROUP(vin5_clk),
 	},
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 	.automotive = {
 		SH_PFC_PIN_GROUP(drif0_ctrl_a),
 		SH_PFC_PIN_GROUP(drif0_data0_a),
@@ -4515,7 +4520,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(drif3_data0_b),
 		SH_PFC_PIN_GROUP(drif3_data1_b),
 	}
-
+#endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 };
 
 static const char * const audio_clk_groups[] = {
@@ -4574,6 +4579,7 @@ static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 static const char * const drif0_groups[] = {
 	"drif0_ctrl_a",
 	"drif0_data0_a",
@@ -4615,6 +4621,7 @@ static const char * const drif3_groups[] = {
 	"drif3_data0_b",
 	"drif3_data1_b",
 };
+#endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
 static const char * const du_groups[] = {
 	"du_rgb666",
@@ -5041,7 +5048,9 @@ static const char * const vin5_groups[] = {
 
 static const struct {
 	struct sh_pfc_function common[53];
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 	struct sh_pfc_function automotive[4];
+#endif
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
@@ -5098,13 +5107,14 @@ static const struct {
 		SH_PFC_FUNCTION(vin4),
 		SH_PFC_FUNCTION(vin5),
 	},
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 	.automotive = {
 		SH_PFC_FUNCTION(drif0),
 		SH_PFC_FUNCTION(drif1),
 		SH_PFC_FUNCTION(drif2),
 		SH_PFC_FUNCTION(drif3),
 	}
-
+#endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.17.1


--jA45D1DCfMrAw8OmmONX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6551): https://lists.cip-project.org/g/cip-dev/message=
/6551
Mute This Topic: https://lists.cip-project.org/mt/83693872/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jA45D1DCfMrAw8OmmONX--
