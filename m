Return-Path: <SRS0=Li46=GQ=lists.cip-project.org=bounce+64572+6072+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A33DC433E0
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFD223433
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFD223433
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6072+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id am6nYY4521723xdfHYE3dcpX; Wed, 13 Jan 2021 08:01:07 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.10141.1610553666445693623
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 08:01:06 -0800
X-IronPort-AV: E=Sophos;i="5.79,344,1602514800"; 
   d="scan'208";a="68896924"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jan 2021 01:01:05 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A69CB4009652;
	Thu, 14 Jan 2021 01:01:04 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 1/9] pinctrl: renesas: r8a7790: Optimize pinctrl image size for R8A7742
Date: Wed, 13 Jan 2021 16:00:54 +0000
Message-Id: <20210113160102.16310-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pWrIMZFf7QJWBT1SLFnBJtEBx4520388AA=
Content-Type: multipart/mixed; boundary="sEGoq0kLgl02EbTKWlDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610553667;
 bh=2nE0yqqTMKXi1VJB0eBXj30/O6H+gKY3ar8e5V1UNuc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KVGvQoFiH86g7ozYEbcODr549Vo0EMJzAxFJJEL/ngH4LrquwvTAvevoCPbCqtsSjTS
 89ahy3pD68aCP5xCzjbEGLOKopP72PjNK2YZaXV7c1WDw8yr79NXhvmdxPFr0nA00QZl5
 J7lQPTtVQOmXQixFJadQOeRME639TTZzC/Q=

--sEGoq0kLgl02EbTKWlDz

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 529b8eecb5c3b61cc53a21b72a12304a03e83c9f upstream.

This driver supports both RZ/G1H and R-Car H2 SoCs.
Optimize pinctrl image size for RZ/G1H, when support for R-Car H2
(R8A7790) is not enabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20201019124258.4574-6-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index f85bd1623d46..62e3664ff227 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -2412,6 +2412,8 @@ static const unsigned int intc_irq3_pins[] = {
 static const unsigned int intc_irq3_mux[] = {
 	IRQ3_MARK,
 };
+
+#ifdef CONFIG_PINCTRL_PFC_R8A7790
 /* - MLB+ ------------------------------------------------------------------- */
 static const unsigned int mlb_3pin_pins[] = {
 	RCAR_GP_PIN(4, 0), RCAR_GP_PIN(4, 1), RCAR_GP_PIN(4, 2),
@@ -2419,6 +2421,8 @@ static const unsigned int mlb_3pin_pins[] = {
 static const unsigned int mlb_3pin_mux[] = {
 	MLB_CLK_MARK, MLB_SIG_MARK, MLB_DAT_MARK,
 };
+#endif /* CONFIG_PINCTRL_PFC_R8A7790 */
+
 /* - MMCIF0 ----------------------------------------------------------------- */
 static const unsigned int mmc0_data1_pins[] = {
 	/* D[0] */
@@ -4046,7 +4050,9 @@ static const unsigned int vin3_clk_mux[] = {
 
 static const struct {
 	struct sh_pfc_pin_group common[298];
+#ifdef CONFIG_PINCTRL_PFC_R8A7790
 	struct sh_pfc_pin_group automotive[1];
+#endif
 } pinmux_groups = {
 	.common = {
 		SH_PFC_PIN_GROUP(audio_clk_a),
@@ -4348,9 +4354,11 @@ static const struct {
 		SH_PFC_PIN_GROUP(vin3_clkenb),
 		SH_PFC_PIN_GROUP(vin3_clk),
 	},
+#ifdef CONFIG_PINCTRL_PFC_R8A7790
 	.automotive = {
 		SH_PFC_PIN_GROUP(mlb_3pin),
 	}
+#endif /* CONFIG_PINCTRL_PFC_R8A7790 */
 };
 
 static const char * const audio_clk_groups[] = {
@@ -4494,9 +4502,11 @@ static const char * const intc_groups[] = {
 	"intc_irq3",
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A7790
 static const char * const mlb_groups[] = {
 	"mlb_3pin",
 };
+#endif /* CONFIG_PINCTRL_PFC_R8A7790 */
 
 static const char * const mmc0_groups[] = {
 	"mmc0_data1",
@@ -4831,7 +4841,9 @@ static const char * const vin3_groups[] = {
 
 static const struct {
 	struct sh_pfc_function common[58];
+#ifdef CONFIG_PINCTRL_PFC_R8A7790
 	struct sh_pfc_function automotive[1];
+#endif
 } pinmux_functions = {
 	.common = {
 		SH_PFC_FUNCTION(audio_clk),
@@ -4893,9 +4905,11 @@ static const struct {
 		SH_PFC_FUNCTION(vin2),
 		SH_PFC_FUNCTION(vin3),
 	},
+#ifdef CONFIG_PINCTRL_PFC_R8A7790
 	.automotive = {
 		SH_PFC_FUNCTION(mlb),
 	}
+#endif /* CONFIG_PINCTRL_PFC_R8A7790 */
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.17.1


--sEGoq0kLgl02EbTKWlDz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6072): https://lists.cip-project.org/g/cip-dev/message=
/6072
Mute This Topic: https://lists.cip-project.org/mt/79653998/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--sEGoq0kLgl02EbTKWlDz--
