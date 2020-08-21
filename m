Return-Path: <SRS0=QR5O=B7=lists.cip-project.org=bounce+64572+5182+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C66C433E3
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3452072D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="XF2DO6jJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3452072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5182+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id n4vLYY4521723x2Ej5ipBCNi; Fri, 21 Aug 2020 03:58:32 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131155.1598003026037330255
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:47 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170330"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:47 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DDFE44232061;
	Fri, 21 Aug 2020 18:43:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 17/36] pinctrl: sh-pfc: r8a77965: Fix DU_DOTCLKIN3 drive/bias control
Date: Fri, 21 Aug 2020 10:42:53 +0100
Message-Id: <20200821094312.3249-18-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uUoUrK8hBCeAwoU2aZZ6DWSvx4520388AA=
Content-Type: multipart/mixed; boundary="EZjOQZF3pg5EoWW61Tue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007512;
 bh=VVtoQshdbtzqTr8dcJtz7B7GgY4YgamcjWMxzVSL/vY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XF2DO6jJ/AImiNzIGlP2QdDlcK0ctNdyNkovI1uq6xKv3SbrskUPsYGcCMEHWyESlAv
 Hh5XDaxMjDLWxxBwzEeLQvXhSAp67DqW+Qdvq2ue5cmi9AYgHp+aXR1W0uTciT7yPOlMW
 TxuTU5S2jl153d35TwzWR3xaELKa8ZhYQuU=

--EZjOQZF3pg5EoWW61Tue

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit a34cd9dfd03fa9ec380405969f1d638bc63b8d63 upstream.

R-Car Gen3 Hardware Manual Errata for Rev. 2.00 of October 24, 2019
changed the configuration bits for drive and bias control for the
DU_DOTCLKIN3 pin on R-Car M3-N, to match the same pin on R-Car H3.
Update the driver to reflect this.

After this, the handling of drive and bias control for the various
DU_DOTCLKINx pins is consistent across all of the R-Car H3, M3-W,
M3-W+, and M3-N SoCs.

Fixes: 86c045c2e4201e94 ("pinctrl: sh-pfc: r8a77965: Replace DU_DOTCLKIN2 by DU_DOTCLKIN3")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20191113101653.28428-1-geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index dc2c5082e317..816341230c08 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -5998,7 +5998,7 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ PIN_DU_DOTCLKIN1,    0, 2 },	/* DU_DOTCLKIN1 */
 	} },
 	{ PINMUX_DRIVE_REG("DRVCTRL12", 0xe6060330) {
-		{ PIN_DU_DOTCLKIN3,   28, 2 },	/* DU_DOTCLKIN3 */
+		{ PIN_DU_DOTCLKIN3,   24, 2 },	/* DU_DOTCLKIN3 */
 		{ PIN_FSCLKST,        20, 2 },	/* FSCLKST */
 		{ PIN_TMS,             4, 2 },	/* TMS */
 	} },
@@ -6252,8 +6252,8 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[31] = PIN_DU_DOTCLKIN1,	/* DU_DOTCLKIN1 */
 	} },
 	{ PINMUX_BIAS_REG("PUEN3", 0xe606040c, "PUD3", 0xe606044c) {
-		[ 0] = PIN_DU_DOTCLKIN3,	/* DU_DOTCLKIN3 */
-		[ 1] = SH_PFC_PIN_NONE,
+		[ 0] = SH_PFC_PIN_NONE,
+		[ 1] = PIN_DU_DOTCLKIN3,	/* DU_DOTCLKIN3 */
 		[ 2] = PIN_FSCLKST,		/* FSCLKST */
 		[ 3] = PIN_EXTALR,		/* EXTALR*/
 		[ 4] = PIN_TRST_N,		/* TRST# */
-- 
2.17.1


--EZjOQZF3pg5EoWW61Tue
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5182): https://lists.cip-project.org/g/cip-dev/message=
/5182
Mute This Topic: https://lists.cip-project.org/mt/76326721/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--EZjOQZF3pg5EoWW61Tue--
