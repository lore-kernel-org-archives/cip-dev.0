Return-Path: <SRS0=O7xG=CG=lists.cip-project.org=bounce+64572+5312+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFBDC2BBD1
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB2E208C9
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BxLXvC/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB2E208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5312+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5AdXYY4521723x5CfFbG9VyX; Fri, 28 Aug 2020 09:07:52 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.45502.1598629362920331040
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:44 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587888"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:44 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C0CFF400C9FD;
	Sat, 29 Aug 2020 00:42:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 22/30] pinctrl: sh-pfc: r8a7790: Add missing TX_ER pin to avb_mii group
Date: Fri, 28 Aug 2020 16:41:47 +0100
Message-Id: <20200828154155.5827-23-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: eEbdcCZJR6MkheM9odRatnvyx4520388AA=
Content-Type: multipart/mixed; boundary="aqSnTbpR6mwK4k90T6gw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630872;
 bh=A0SId4GDSHj4CU/o7pJnQdvjkbMr73n9VT8at8KDkw4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BxLXvC/p13HsLWS0HQB63F9TVmzOCv2snSohd7pRUenUc1EtlvuWoGLQzbI+OKcFaOS
 LdFWIwvH/pgKu7hlb2i4WGtvu8hXVfnLZvdCcodI15OU+UrA/b+m2kIvePm653msW6+sa
 VvWOCgvQED5jB9uehNwc5J9A8yXZ2mo+mBY=

--aqSnTbpR6mwK4k90T6gw

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 66e9fe1ec73929a9f7326856699d262bab8e9fb0 upstream.

The pin controller drivers for all R-Car Gen2 SoCs have entries for the
EtherAVB TX_ER pins in their EtherAVB MII groups, except on R-Car H2.

Add the missing pin to restore consistency.

Note that technically TX_ER is an optional signal in the MII bus, and
thus could have its own group, but this is currently not supported by
any R-Car Gen2 pin controller driver.

Fixes: 19ef697d1eb7be06 ("sh-pfc: r8a7790: add EtherAVB pin groups")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 0602ae4ec039..a790e913e6bb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -1848,8 +1848,8 @@ static const unsigned int avb_mii_pins[] = {
 	RCAR_GP_PIN(2, 2),
 
 	RCAR_GP_PIN(2, 7), RCAR_GP_PIN(2, 8), RCAR_GP_PIN(2, 9),
-	RCAR_GP_PIN(2, 10), RCAR_GP_PIN(3, 8), RCAR_GP_PIN(3, 10),
-	RCAR_GP_PIN(3, 12),
+	RCAR_GP_PIN(2, 10), RCAR_GP_PIN(3, 8), RCAR_GP_PIN(3, 9),
+	RCAR_GP_PIN(3, 10), RCAR_GP_PIN(3, 12),
 };
 static const unsigned int avb_mii_mux[] = {
 	AVB_TXD0_MARK, AVB_TXD1_MARK, AVB_TXD2_MARK,
@@ -1859,8 +1859,8 @@ static const unsigned int avb_mii_mux[] = {
 	AVB_RXD3_MARK,
 
 	AVB_RX_ER_MARK, AVB_RX_CLK_MARK, AVB_RX_DV_MARK,
-	AVB_CRS_MARK, AVB_TX_EN_MARK, AVB_TX_CLK_MARK,
-	AVB_COL_MARK,
+	AVB_CRS_MARK, AVB_TX_EN_MARK, AVB_TX_ER_MARK,
+	AVB_TX_CLK_MARK, AVB_COL_MARK,
 };
 static const unsigned int avb_gmii_pins[] = {
 	RCAR_GP_PIN(0, 8), RCAR_GP_PIN(0, 9), RCAR_GP_PIN(0, 10),
-- 
2.17.1


--aqSnTbpR6mwK4k90T6gw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5312): https://lists.cip-project.org/g/cip-dev/message=
/5312
Mute This Topic: https://lists.cip-project.org/mt/76477100/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--aqSnTbpR6mwK4k90T6gw--
