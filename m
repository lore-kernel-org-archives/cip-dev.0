Return-Path: <SRS0=8E8f=CG=lists.cip-project.org=bounce+64572+5311+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A12C2BC0E
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3892E20872
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TjEq3pwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3892E20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5311+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VAzcYY4521723xZWM96jWOEq; Fri, 28 Aug 2020 09:07:53 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.45502.1598629362920331040
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:43 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587885"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:42 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C7131400C4F0;
	Sat, 29 Aug 2020 00:42:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 21/30] pinctrl: sh-pfc: r8a7790: Add SCIF_CLK support
Date: Fri, 28 Aug 2020 16:41:46 +0100
Message-Id: <20200828154155.5827-22-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qAdJ3P2O7H4IlBAAyhDDvr4Sx4520388AA=
Content-Type: multipart/mixed; boundary="4pqXqNzAFIjKOM1bmeNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630873;
 bh=AzJVNRo/B9m9gJKKogHsCQq/F9w2Ie/fqJqusx8xDF8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TjEq3pwoqoqI/YkA3Laj3LmmZAbZXG2r75iaLTwl+BUpQASRZE0/xjznVknky2/QIMn
 YQhI/LHqv8kvsc8aMj/IP2I3Xy5frXHN3koEh7DbrYBpJtFvJw2A/R6ZWpQfWaIw+CoyB
 jrDXJb5iGjuGVjvoFTECGSEPWYTI8F6Km6A=

--4pqXqNzAFIjKOM1bmeNd

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 53ec9ccd1c62b644d81674e013b1800dd88ec92b upstream.

Add pins, groups, and a function for SCIF_CLK, which is the external
clock source for the Baud Rate Generator for External Clock (BRG) on
(H)SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 1acad99d6466..0602ae4ec039 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3236,6 +3236,21 @@ static const unsigned int scifb2_data_c_pins[] = {
 static const unsigned int scifb2_data_c_mux[] = {
 	SCIFB2_RXD_C_MARK, SCIFB2_TXD_C_MARK,
 };
+/* - SCIF Clock ------------------------------------------------------------- */
+static const unsigned int scif_clk_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(4, 26),
+};
+static const unsigned int scif_clk_mux[] = {
+	SCIF_CLK_MARK,
+};
+static const unsigned int scif_clk_b_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(5, 4),
+};
+static const unsigned int scif_clk_b_mux[] = {
+	SCIF_CLK_B_MARK,
+};
 /* - SDHI0 ------------------------------------------------------------------ */
 static const unsigned int sdhi0_data1_pins[] = {
 	/* D0 */
@@ -4139,6 +4154,8 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb2_clk_b),
 	SH_PFC_PIN_GROUP(scifb2_ctrl_b),
 	SH_PFC_PIN_GROUP(scifb2_data_c),
+	SH_PFC_PIN_GROUP(scif_clk),
+	SH_PFC_PIN_GROUP(scif_clk_b),
 	SH_PFC_PIN_GROUP(sdhi0_data1),
 	SH_PFC_PIN_GROUP(sdhi0_data4),
 	SH_PFC_PIN_GROUP(sdhi0_ctrl),
@@ -4555,6 +4572,11 @@ static const char * const scifb2_groups[] = {
 	"scifb2_data_c",
 };
 
+static const char * const scif_clk_groups[] = {
+	"scif_clk",
+	"scif_clk_b",
+};
+
 static const char * const sdhi0_groups[] = {
 	"sdhi0_data1",
 	"sdhi0_data4",
@@ -4729,6 +4751,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scifb0),
 	SH_PFC_FUNCTION(scifb1),
 	SH_PFC_FUNCTION(scifb2),
+	SH_PFC_FUNCTION(scif_clk),
 	SH_PFC_FUNCTION(sdhi0),
 	SH_PFC_FUNCTION(sdhi1),
 	SH_PFC_FUNCTION(sdhi2),
-- 
2.17.1


--4pqXqNzAFIjKOM1bmeNd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5311): https://lists.cip-project.org/g/cip-dev/message=
/5311
Mute This Topic: https://lists.cip-project.org/mt/76477099/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--4pqXqNzAFIjKOM1bmeNd--
