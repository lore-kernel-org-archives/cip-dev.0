Return-Path: <SRS0=5qTz=CG=lists.cip-project.org=bounce+64572+5310+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17991C2BBDA
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D277320872
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="iVIDP5qC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D277320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5310+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gtjdYY4521723xjH6j78E8Wi; Fri, 28 Aug 2020 09:07:52 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.45771.1598629350683270340
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:40 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804744"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:40 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B24DC400C9FD;
	Sat, 29 Aug 2020 00:42:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 20/30] pinctrl: sh-pfc: r8a7790: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
Date: Fri, 28 Aug 2020 16:41:45 +0100
Message-Id: <20200828154155.5827-21-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TiQmJVJojk7CUY8xBI4cwbrQx4520388AA=
Content-Type: multipart/mixed; boundary="dWFohcrDw6jXESwZqp6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630872;
 bh=0Y1SdStkweAUcyrQF+tgnqx0adp+Km2aM4leCCfQ65E=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=iVIDP5qCBZfckBfXvVeewh4VK7ZBpNKSmt6tPXji4JGzoh0wMkbnC8n6qCFfhUlhkZk
 YRwg3LJpvYBdx07X0c8IkK5IhN+QU1Lws1DJJ5RPMWLvw7VWeC6J+6mUEtDzWOnc1ttY/
 ZfeiCvDh81ItB24+/Z8XfD8OgzrPT5w3RKg=

--dWFohcrDw6jXESwZqp6S

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 01af9ecbd7bd7d688c54d73a7fa8f7e10ab29d8c upstream.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index d9924b0d53b7..1acad99d6466 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -806,15 +806,15 @@ enum {
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
-	PINMUX_DATA(VI1_DATA7_VI1_B7_MARK, FN_VI1_DATA7_VI1_B7),
-	PINMUX_DATA(USB0_PWEN_MARK, FN_USB0_PWEN),
-	PINMUX_DATA(USB0_OVC_VBUS_MARK, FN_USB0_OVC_VBUS),
-	PINMUX_DATA(USB2_PWEN_MARK, FN_USB2_PWEN),
-	PINMUX_DATA(USB2_OVC_MARK, FN_USB2_OVC),
-	PINMUX_DATA(AVS1_MARK, FN_AVS1),
-	PINMUX_DATA(AVS2_MARK, FN_AVS2),
-	PINMUX_DATA(DU_DOTCLKIN0_MARK, FN_DU_DOTCLKIN0),
-	PINMUX_DATA(DU_DOTCLKIN2_MARK, FN_DU_DOTCLKIN2),
+	PINMUX_SINGLE(VI1_DATA7_VI1_B7),
+	PINMUX_SINGLE(USB0_PWEN),
+	PINMUX_SINGLE(USB0_OVC_VBUS),
+	PINMUX_SINGLE(USB2_PWEN),
+	PINMUX_SINGLE(USB2_OVC),
+	PINMUX_SINGLE(AVS1),
+	PINMUX_SINGLE(AVS2),
+	PINMUX_SINGLE(DU_DOTCLKIN0),
+	PINMUX_SINGLE(DU_DOTCLKIN2),
 
 	PINMUX_IPSR_DATA(IP0_2_0, D0),
 	PINMUX_IPSR_MSEL(IP0_2_0, MSIOF3_SCK_B, SEL_SOF3_1),
-- 
2.17.1


--dWFohcrDw6jXESwZqp6S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5310): https://lists.cip-project.org/g/cip-dev/message=
/5310
Mute This Topic: https://lists.cip-project.org/mt/76477098/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--dWFohcrDw6jXESwZqp6S--
