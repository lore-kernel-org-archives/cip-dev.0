Return-Path: <SRS0=bNeM=B7=lists.cip-project.org=bounce+64572+5208+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E24C433E4
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57645207BB
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UgKzvEu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57645207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5208+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5LijYY4521723xo61pTOGhNf; Fri, 21 Aug 2020 03:58:45 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131152.1598003016916343991
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:55 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954600"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:54 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3E303423206F;
	Fri, 21 Aug 2020 18:43:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 21/36] pinctrl: sh-pfc: r8a7795: Deduplicate VIN5 pin definitions
Date: Fri, 21 Aug 2020 10:42:57 +0100
Message-Id: <20200821094312.3249-22-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UKJDIcJ8zrmvjpLhKB0Qbburx4520388AA=
Content-Type: multipart/mixed; boundary="Cl4asJYyc2f1NNJUMQU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007525;
 bh=IJuUzLZ3eLEjW+DocpkEGpq7NR7+6Y/wBGHMKxhCmfQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UgKzvEu0RNx6kruRSdvTU3Fm2XP4phVTuwNMi47xIGW0HHpHIe1SHZg51z47x6P8qcW
 HwXZ84iPBn/RpVTJzZaN7oLPmkZUtVjXC6GVpRAUZcALIBnOdKWKIvGz0+8t29jGOsK27
 W1nXRPGjnTjCCcjSYcmzgpgtR77C9Z3h21s=

--Cl4asJYyc2f1NNJUMQU0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 99fdb920f5534d1c2f4b30c12eca4224ea260198 upstream.

Use union vin_data16 and VIN_DATA_PIN_GROUP() to reduce redundancies in
pin definitions for the VIN5 channel.

This reduces kernel size by 240 bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 90 ++++++++--------------------
 1 file changed, 26 insertions(+), 64 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 6f5bbdce8fb4..8edeb4d823f0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -4082,67 +4082,29 @@ static const unsigned int vin4_clk_mux[] = {
 };
 
 /* - VIN5 ------------------------------------------------------------------- */
-static const unsigned int vin5_data8_pins[] = {
-	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
-	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
-	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
-	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
-};
-static const unsigned int vin5_data8_mux[] = {
-	VI5_DATA0_MARK, VI5_DATA1_MARK,
-	VI5_DATA2_MARK, VI5_DATA3_MARK,
-	VI5_DATA4_MARK, VI5_DATA5_MARK,
-	VI5_DATA6_MARK, VI5_DATA7_MARK,
-};
-static const unsigned int vin5_data10_pins[] = {
-	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
-	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
-	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
-	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
-	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
-};
-static const unsigned int vin5_data10_mux[] = {
-	VI5_DATA0_MARK, VI5_DATA1_MARK,
-	VI5_DATA2_MARK, VI5_DATA3_MARK,
-	VI5_DATA4_MARK, VI5_DATA5_MARK,
-	VI5_DATA6_MARK, VI5_DATA7_MARK,
-	VI5_DATA8_MARK,  VI5_DATA9_MARK,
-};
-static const unsigned int vin5_data12_pins[] = {
-	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
-	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
-	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
-	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
-	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
-	RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
-};
-static const unsigned int vin5_data12_mux[] = {
-	VI5_DATA0_MARK, VI5_DATA1_MARK,
-	VI5_DATA2_MARK, VI5_DATA3_MARK,
-	VI5_DATA4_MARK, VI5_DATA5_MARK,
-	VI5_DATA6_MARK, VI5_DATA7_MARK,
-	VI5_DATA8_MARK,  VI5_DATA9_MARK,
-	VI5_DATA10_MARK, VI5_DATA11_MARK,
-};
-static const unsigned int vin5_data16_pins[] = {
-	RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
-	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
-	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
-	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
-	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
-	RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
-	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
-	RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+static const union vin_data16 vin5_data_pins = {
+	.data16 = {
+		RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
+		RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
+		RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
+		RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
+		RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
+		RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
+		RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
+		RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+	},
 };
-static const unsigned int vin5_data16_mux[] = {
-	VI5_DATA0_MARK, VI5_DATA1_MARK,
-	VI5_DATA2_MARK, VI5_DATA3_MARK,
-	VI5_DATA4_MARK, VI5_DATA5_MARK,
-	VI5_DATA6_MARK, VI5_DATA7_MARK,
-	VI5_DATA8_MARK,  VI5_DATA9_MARK,
-	VI5_DATA10_MARK, VI5_DATA11_MARK,
-	VI5_DATA12_MARK, VI5_DATA13_MARK,
-	VI5_DATA14_MARK, VI5_DATA15_MARK,
+static const union vin_data16 vin5_data_mux = {
+	.data16 = {
+		VI5_DATA0_MARK, VI5_DATA1_MARK,
+		VI5_DATA2_MARK, VI5_DATA3_MARK,
+		VI5_DATA4_MARK, VI5_DATA5_MARK,
+		VI5_DATA6_MARK, VI5_DATA7_MARK,
+		VI5_DATA8_MARK,  VI5_DATA9_MARK,
+		VI5_DATA10_MARK, VI5_DATA11_MARK,
+		VI5_DATA12_MARK, VI5_DATA13_MARK,
+		VI5_DATA14_MARK, VI5_DATA15_MARK,
+	},
 };
 static const unsigned int vin5_sync_pins[] = {
 	/* HSYNC#, VSYNC# */
@@ -4512,10 +4474,10 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(vin4_field),
 	SH_PFC_PIN_GROUP(vin4_clkenb),
 	SH_PFC_PIN_GROUP(vin4_clk),
-	SH_PFC_PIN_GROUP(vin5_data8),
-	SH_PFC_PIN_GROUP(vin5_data10),
-	SH_PFC_PIN_GROUP(vin5_data12),
-	SH_PFC_PIN_GROUP(vin5_data16),
+	VIN_DATA_PIN_GROUP(vin5_data, 8),
+	VIN_DATA_PIN_GROUP(vin5_data, 10),
+	VIN_DATA_PIN_GROUP(vin5_data, 12),
+	VIN_DATA_PIN_GROUP(vin5_data, 16),
 	SH_PFC_PIN_GROUP(vin5_sync),
 	SH_PFC_PIN_GROUP(vin5_field),
 	SH_PFC_PIN_GROUP(vin5_clkenb),
-- 
2.17.1


--Cl4asJYyc2f1NNJUMQU0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5208): https://lists.cip-project.org/g/cip-dev/message=
/5208
Mute This Topic: https://lists.cip-project.org/mt/76326748/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Cl4asJYyc2f1NNJUMQU0--
