Return-Path: <SRS0=6X98=GI=lists.cip-project.org=bounce+64572+6024+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8DAC433E6
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 15:11:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC85E22B45
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 15:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC85E22B45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6024+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PHShYY4521723xqovTYGvAUu; Tue, 05 Jan 2021 07:11:08 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.6601.1609859461949547050
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 07:11:02 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="67872231"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Jan 2021 00:11:02 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 93AC7400A0E0;
	Wed,  6 Jan 2021 00:11:01 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/8] pinctrl: renesas: r8a77951: Optimize pinctrl image size for R8A774E1
Date: Tue,  5 Jan 2021 15:10:51 +0000
Message-Id: <20210105151057.12752-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105151057.12752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105151057.12752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6Ih3brapWjNfw7z7X4mVCnsWx4520388AA=
Content-Type: multipart/mixed; boundary="4le3eMZN7ACDJUoWOwQ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609859468;
 bh=JPMQBj19wUWb9UrE+10O1FVn2yYogG7nJ3M62Vpbf4U=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZJEy2rcCprCJzCj0wdFP4JvG9iVGaTe7Wq4d+svuNVBvfd++20bl1ocq/bdBYp7JZVu
 n/7iYSsnq6EGBiktMP7k0+NBc9ln5fjbh20/FU8j5FykQ0HxYZyoBVZD5Fsd02CJ3V9mn
 Tpw3Dwzsjd5EpPNNU+lzjJN9FjfKUZtC7JA=

--4le3eMZN7ACDJUoWOwQ1

From: Biju Das <biju.das.jz@bp.renesas.com>

commit b8029394efccf48687d9a7fae6c4747b81e35261 upstream.

This driver supports both RZ/G2H and R-Car H3 ES2 SoCs.
Optimize pinctrl image size for RZ/G2H, when support for R-Car H3 ES2
(R8A77951) is not enabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20201019124258.4574-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77951.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77951.c b/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
index c2d0269417ea..034878e17a3b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
@@ -1830,6 +1830,7 @@ static const unsigned int canfd1_data_mux[] = {
 	CANFD1_TX_MARK,         CANFD1_RX_MARK,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 /* - DRIF0 --------------------------------------------------------------- */
 static const unsigned int drif0_ctrl_a_pins[] = {
 	/* CLK, SYNC */
@@ -2044,6 +2045,7 @@ static const unsigned int drif3_data1_b_pins[] = {
 static const unsigned int drif3_data1_b_mux[] = {
 	RIF3_D1_B_MARK,
 };
+#endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
 /* - DU --------------------------------------------------------------------- */
 static const unsigned int du_rgb666_pins[] = {
@@ -4162,7 +4164,9 @@ static const unsigned int vin5_clk_mux[] = {
 
 static const struct {
 	struct sh_pfc_pin_group common[320];
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 	struct sh_pfc_pin_group automotive[30];
+#endif
 } pinmux_groups = {
 	.common = {
 		SH_PFC_PIN_GROUP(audio_clk_a_a),
@@ -4486,6 +4490,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin5_clkenb),
 		SH_PFC_PIN_GROUP(vin5_clk),
 	},
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 	.automotive = {
 		SH_PFC_PIN_GROUP(drif0_ctrl_a),
 		SH_PFC_PIN_GROUP(drif0_data0_a),
@@ -4518,7 +4523,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(drif3_data0_b),
 		SH_PFC_PIN_GROUP(drif3_data1_b),
 	}
-
+#endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 };
 
 static const char * const audio_clk_groups[] = {
@@ -4577,6 +4582,7 @@ static const char * const canfd1_groups[] = {
 	"canfd1_data",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 static const char * const drif0_groups[] = {
 	"drif0_ctrl_a",
 	"drif0_data0_a",
@@ -4618,6 +4624,7 @@ static const char * const drif3_groups[] = {
 	"drif3_data0_b",
 	"drif3_data1_b",
 };
+#endif /* CONFIG_PINCTRL_PFC_R8A77951 */
 
 static const char * const du_groups[] = {
 	"du_rgb666",
@@ -5044,7 +5051,9 @@ static const char * const vin5_groups[] = {
 
 static const struct {
 	struct sh_pfc_function common[53];
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 	struct sh_pfc_function automotive[4];
+#endif
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
@@ -5101,13 +5110,14 @@ static const struct {
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


--4le3eMZN7ACDJUoWOwQ1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6024): https://lists.cip-project.org/g/cip-dev/message=
/6024
Mute This Topic: https://lists.cip-project.org/mt/79451748/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4le3eMZN7ACDJUoWOwQ1--
