Return-Path: <SRS0=+vgp=E6=lists.cip-project.org=bounce+64572+5848+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5DC6379D
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13FE20715
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oT2MvYee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13FE20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5848+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fBY0YY4521723xghn6zQqlIh; Tue, 24 Nov 2020 09:11:37 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.27.1606237790034661248
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:09:50 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63738831"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Nov 2020 02:09:49 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1ED8B40ABFEE;
	Wed, 25 Nov 2020 02:09:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 8/9] pinctrl: sh-pfc: r8a7790: Add USB1 PWEN pin and group
Date: Tue, 24 Nov 2020 17:09:31 +0000
Message-Id: <20201124170932.13588-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jPyeToJPz66kXhWEt9gzbzlTx4520388AA=
Content-Type: multipart/mixed; boundary="1t70xRxRImIspwEZQOfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606237897;
 bh=Pn9Ew5/wyKCzoFOF/JmaLKJPlSETx3sSnM/64XtBcSA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=oT2MvYeeqnsRhWg0am9dEPHyYTLi3bVVODUIb0ELAMzNhJrlTpnIwXx038O9DM7OhEY
 QT0sl2Pr++hM84sULmIjGu4ZoPpjZ5Pvk6Yz/B4W0dKk0mxPK9qj/EtttrvugXZpSvjwL
 6/7tH5mIzPmOEBV/puFux68Te2a4AFpQWKY=

--1t70xRxRImIspwEZQOfJ

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 417e24986935f6bd6afa38010cc981cf4d7a7bef upstream.

Add USB1 PWEN pin and group for USB1 interface.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/1595005225-11519-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: updated pin group common index]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index d87f9dbbb302..f85bd1623d46 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3710,6 +3710,13 @@ static const unsigned int usb1_pins[] = {
 static const unsigned int usb1_mux[] = {
 	USB1_PWEN_MARK, USB1_OVC_MARK,
 };
+static const unsigned int usb1_pwen_pins[] = {
+	/* PWEN */
+	RCAR_GP_PIN(5, 20),
+};
+static const unsigned int usb1_pwen_mux[] = {
+	USB1_PWEN_MARK,
+};
 /* - USB2 ------------------------------------------------------------------- */
 static const unsigned int usb2_pins[] = {
 	/* PWEN, OVC */
@@ -4038,7 +4045,7 @@ static const unsigned int vin3_clk_mux[] = {
 };
 
 static const struct {
-	struct sh_pfc_pin_group common[297];
+	struct sh_pfc_pin_group common[298];
 	struct sh_pfc_pin_group automotive[1];
 } pinmux_groups = {
 	.common = {
@@ -4300,6 +4307,7 @@ static const struct {
 		SH_PFC_PIN_GROUP(usb0),
 		SH_PFC_PIN_GROUP(usb0_ovc_vbus),
 		SH_PFC_PIN_GROUP(usb1),
+		SH_PFC_PIN_GROUP(usb1_pwen),
 		SH_PFC_PIN_GROUP(usb2),
 		VIN_DATA_PIN_GROUP(vin0_data, 24),
 		VIN_DATA_PIN_GROUP(vin0_data, 20),
@@ -4764,6 +4772,7 @@ static const char * const usb0_groups[] = {
 
 static const char * const usb1_groups[] = {
 	"usb1",
+	"usb1_pwen",
 };
 
 static const char * const usb2_groups[] = {
-- 
2.17.1


--1t70xRxRImIspwEZQOfJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5848): https://lists.cip-project.org/g/cip-dev/message=
/5848
Mute This Topic: https://lists.cip-project.org/mt/78481730/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1t70xRxRImIspwEZQOfJ--
