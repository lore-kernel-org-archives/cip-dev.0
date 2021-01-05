Return-Path: <SRS0=yUSW=GI=lists.cip-project.org=bounce+64572+6028+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3AEC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 15:11:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4227022B45
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 15:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4227022B45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6028+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 62OsYY4521723xMcOcRi6YtD; Tue, 05 Jan 2021 07:11:08 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.6601.1609859461949547050
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 07:11:08 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="67872244"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Jan 2021 00:11:07 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D620C400A0E0;
	Wed,  6 Jan 2021 00:11:06 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 6/8] pinctrl: renesas: r8a77951: Add QSPI[01] pins, groups and functions
Date: Tue,  5 Jan 2021 15:10:55 +0000
Message-Id: <20210105151057.12752-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105151057.12752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105151057.12752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4LOAu4fRbZzarTER75FLR1PZx4520388AA=
Content-Type: multipart/mixed; boundary="tScVAHAudJJ2cz8CYO2a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609859468;
 bh=QAiZOIExCRL4tWp+Zke9WZfV7p6fnBHWUjlGczLTzag=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BTTjQEum2jz72RQRLRta7bOEFxD6irjA5GsxqTtzGQ0VFJ0AsjtV1F5xbcfDnn5V8YA
 YZ1yHdIvmZUS3e89HEA7QRKV/g3EqBCwu4N+LIRl3CIpP9CwWAp9X+/+oA7Y1p2abpTeE
 BZw6G+SPy7DICobosJ3dM8dFiuurFV+lLDU=

--tScVAHAudJJ2cz8CYO2a

commit 590567bf6f6d989ba9d0fc406282d7a18cf5fa96 upstream.

Add pins, groups and functions for QSPIO[01].

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20201119130926.25692-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77951.c | 75 ++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77951.c b/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
index 034878e17a3b..d434b18d1cf7 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
@@ -3255,6 +3255,57 @@ static const unsigned int pwm6_b_mux[] = {
 	PWM6_B_MARK,
 };
 
+/* - QSPI0 ------------------------------------------------------------------ */
+static const unsigned int qspi0_ctrl_pins[] = {
+	/* QSPI0_SPCLK, QSPI0_SSL */
+	PIN_QSPI0_SPCLK, PIN_QSPI0_SSL,
+};
+static const unsigned int qspi0_ctrl_mux[] = {
+	QSPI0_SPCLK_MARK, QSPI0_SSL_MARK,
+};
+static const unsigned int qspi0_data2_pins[] = {
+	/* QSPI0_MOSI_IO0, QSPI0_MISO_IO1 */
+	PIN_QSPI0_MOSI_IO0, PIN_QSPI0_MISO_IO1,
+};
+static const unsigned int qspi0_data2_mux[] = {
+	QSPI0_MOSI_IO0_MARK, QSPI0_MISO_IO1_MARK,
+};
+static const unsigned int qspi0_data4_pins[] = {
+	/* QSPI0_MOSI_IO0, QSPI0_MISO_IO1 */
+	PIN_QSPI0_MOSI_IO0, PIN_QSPI0_MISO_IO1,
+	/* QSPI0_IO2, QSPI0_IO3 */
+	PIN_QSPI0_IO2, PIN_QSPI0_IO3,
+};
+static const unsigned int qspi0_data4_mux[] = {
+	QSPI0_MOSI_IO0_MARK, QSPI0_MISO_IO1_MARK,
+	QSPI0_IO2_MARK, QSPI0_IO3_MARK,
+};
+/* - QSPI1 ------------------------------------------------------------------ */
+static const unsigned int qspi1_ctrl_pins[] = {
+	/* QSPI1_SPCLK, QSPI1_SSL */
+	PIN_QSPI1_SPCLK, PIN_QSPI1_SSL,
+};
+static const unsigned int qspi1_ctrl_mux[] = {
+	QSPI1_SPCLK_MARK, QSPI1_SSL_MARK,
+};
+static const unsigned int qspi1_data2_pins[] = {
+	/* QSPI1_MOSI_IO0, QSPI1_MISO_IO1 */
+	PIN_QSPI1_MOSI_IO0, PIN_QSPI1_MISO_IO1,
+};
+static const unsigned int qspi1_data2_mux[] = {
+	QSPI1_MOSI_IO0_MARK, QSPI1_MISO_IO1_MARK,
+};
+static const unsigned int qspi1_data4_pins[] = {
+	/* QSPI1_MOSI_IO0, QSPI1_MISO_IO1 */
+	PIN_QSPI1_MOSI_IO0, PIN_QSPI1_MISO_IO1,
+	/* QSPI1_IO2, QSPI1_IO3 */
+	PIN_QSPI1_IO2, PIN_QSPI1_IO3,
+};
+static const unsigned int qspi1_data4_mux[] = {
+	QSPI1_MOSI_IO0_MARK, QSPI1_MISO_IO1_MARK,
+	QSPI1_IO2_MARK, QSPI1_IO3_MARK,
+};
+
 /* - SATA --------------------------------------------------------------------*/
 static const unsigned int sata0_devslp_a_pins[] = {
 	/* DEVSLP */
@@ -4163,7 +4214,7 @@ static const unsigned int vin5_clk_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[320];
+	struct sh_pfc_pin_group common[326];
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 	struct sh_pfc_pin_group automotive[30];
 #endif
@@ -4368,6 +4419,12 @@ static const struct {
 		SH_PFC_PIN_GROUP(pwm5_b),
 		SH_PFC_PIN_GROUP(pwm6_a),
 		SH_PFC_PIN_GROUP(pwm6_b),
+		SH_PFC_PIN_GROUP(qspi0_ctrl),
+		SH_PFC_PIN_GROUP(qspi0_data2),
+		SH_PFC_PIN_GROUP(qspi0_data4),
+		SH_PFC_PIN_GROUP(qspi1_ctrl),
+		SH_PFC_PIN_GROUP(qspi1_data2),
+		SH_PFC_PIN_GROUP(qspi1_data4),
 		SH_PFC_PIN_GROUP(sata0_devslp_a),
 		SH_PFC_PIN_GROUP(sata0_devslp_b),
 		SH_PFC_PIN_GROUP(scif0_data),
@@ -4862,6 +4919,18 @@ static const char * const pwm6_groups[] = {
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
 static const char * const sata0_groups[] = {
 	"sata0_devslp_a",
 	"sata0_devslp_b",
@@ -5050,7 +5119,7 @@ static const char * const vin5_groups[] = {
 };
 
 static const struct {
-	struct sh_pfc_function common[53];
+	struct sh_pfc_function common[55];
 #ifdef CONFIG_PINCTRL_PFC_R8A77951
 	struct sh_pfc_function automotive[4];
 #endif
@@ -5087,6 +5156,8 @@ static const struct {
 		SH_PFC_FUNCTION(pwm4),
 		SH_PFC_FUNCTION(pwm5),
 		SH_PFC_FUNCTION(pwm6),
+		SH_PFC_FUNCTION(qspi0),
+		SH_PFC_FUNCTION(qspi1),
 		SH_PFC_FUNCTION(sata0),
 		SH_PFC_FUNCTION(scif0),
 		SH_PFC_FUNCTION(scif1),
-- 
2.17.1


--tScVAHAudJJ2cz8CYO2a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6028): https://lists.cip-project.org/g/cip-dev/message=
/6028
Mute This Topic: https://lists.cip-project.org/mt/79451758/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--tScVAHAudJJ2cz8CYO2a--
