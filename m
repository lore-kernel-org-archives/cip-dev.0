Return-Path: <SRS0=QuOa=B7=lists.cip-project.org=bounce+64572+5192+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F36CC433DF
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506AC2072D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EdhA4JQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506AC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5192+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lwnQYY4521723xfaLtoPd7G4; Fri, 21 Aug 2020 03:58:36 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131152.1598003016916343991
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:49 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954588"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:49 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B6C324232061;
	Fri, 21 Aug 2020 18:43:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 18/36] pinctrl: sh-pfc: r8a7795: Fix VIN versioned groups
Date: Fri, 21 Aug 2020 10:42:54 +0100
Message-Id: <20200821094312.3249-19-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZiOqGX5xOYvWFW36f7sxUlW1x4520388AA=
Content-Type: multipart/mixed; boundary="rNSBD2yNDVT0Vi515Z7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007516;
 bh=dSowEboldv/EbhnXq23iexdYqPU39yuo0lfLsgMYTSA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EdhA4JQ1D/xh2BnNeTCA3bd4IErMeKgIb5LCF7+4kBhiJXSCOEtKtPi6kGTqNxMchnS
 YN6/LcxAF1pVe9UhQav69mXwbZFlgoVCDjol2mKb9s+bp1CTiAYGz6a/rmqZXrPenkwYm
 uuN03IVkNZJjrFk2QoY1Jr0i//sdvJIfrwQ=

--rNSBD2yNDVT0Vi515Z7b

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

commit 184844ccda4138402846bf4b42c28ac5f16a458a upstream.

Versioned VIN groups can appear on different sets of pins. Using the
VIN_DATA_PIN_GROUP macro now supports proper naming of said groups
through an optional 'version' argument.

Use the 'version' argument for said macro to fix naming of versioned
groups for the R-Car H3 R8A7795 SoC.

Fixes: 9942a5b52990 ("pinctrl: sh-pfc: r8a7795: Deduplicate VIN4 pin definitions")
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 68c55ec618e2..1b497c87a0a4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -4456,20 +4456,20 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(usb2),
 	SH_PFC_PIN_GROUP(usb2_ch3),
 	SH_PFC_PIN_GROUP(usb30),
-	VIN_DATA_PIN_GROUP(vin4_data_a, 8),
-	VIN_DATA_PIN_GROUP(vin4_data_a, 10),
-	VIN_DATA_PIN_GROUP(vin4_data_a, 12),
-	VIN_DATA_PIN_GROUP(vin4_data_a, 16),
+	VIN_DATA_PIN_GROUP(vin4_data, 8, _a),
+	VIN_DATA_PIN_GROUP(vin4_data, 10, _a),
+	VIN_DATA_PIN_GROUP(vin4_data, 12, _a),
+	VIN_DATA_PIN_GROUP(vin4_data, 16, _a),
 	SH_PFC_PIN_GROUP(vin4_data18_a),
-	VIN_DATA_PIN_GROUP(vin4_data_a, 20),
-	VIN_DATA_PIN_GROUP(vin4_data_a, 24),
-	VIN_DATA_PIN_GROUP(vin4_data_b, 8),
-	VIN_DATA_PIN_GROUP(vin4_data_b, 10),
-	VIN_DATA_PIN_GROUP(vin4_data_b, 12),
-	VIN_DATA_PIN_GROUP(vin4_data_b, 16),
+	VIN_DATA_PIN_GROUP(vin4_data, 20, _a),
+	VIN_DATA_PIN_GROUP(vin4_data, 24, _a),
+	VIN_DATA_PIN_GROUP(vin4_data, 8, _b),
+	VIN_DATA_PIN_GROUP(vin4_data, 10, _b),
+	VIN_DATA_PIN_GROUP(vin4_data, 12, _b),
+	VIN_DATA_PIN_GROUP(vin4_data, 16, _b),
 	SH_PFC_PIN_GROUP(vin4_data18_b),
-	VIN_DATA_PIN_GROUP(vin4_data_b, 20),
-	VIN_DATA_PIN_GROUP(vin4_data_b, 24),
+	VIN_DATA_PIN_GROUP(vin4_data, 20, _b),
+	VIN_DATA_PIN_GROUP(vin4_data, 24, _b),
 	SH_PFC_PIN_GROUP(vin4_sync),
 	SH_PFC_PIN_GROUP(vin4_field),
 	SH_PFC_PIN_GROUP(vin4_clkenb),
-- 
2.17.1


--rNSBD2yNDVT0Vi515Z7b
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5192): https://lists.cip-project.org/g/cip-dev/message=
/5192
Mute This Topic: https://lists.cip-project.org/mt/76326731/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--rNSBD2yNDVT0Vi515Z7b--
