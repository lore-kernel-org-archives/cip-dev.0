Return-Path: <SRS0=ArUC=B7=lists.cip-project.org=bounce+64572+5197+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60CBC433E1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6BC207BB
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fpDywXd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6BC207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5197+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nfuqYY4521723xaGTdssfBFy; Fri, 21 Aug 2020 03:58:40 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131162.1598003046570191988
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:44:10 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170374"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:44:09 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79EAD4232061;
	Fri, 21 Aug 2020 18:44:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 29/36] pinctrl: sh-pfc: pfc-r8a7795: Fix typo in pinmux macro for SCL3
Date: Fri, 21 Aug 2020 10:43:05 +0100
Message-Id: <20200821094312.3249-30-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GokuywGP7w5BBlzbHGoEXl43x4520388AA=
Content-Type: multipart/mixed; boundary="321Yv75ppNu0XDDvFgLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007520;
 bh=b/PqKj08Vc9lgPK7P0UTmcLzZtsCXrT04wgLKbK4zcM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=fpDywXd5AnXjZRL+D+8MEkG/LwMdfT/JtYhw1a4zUwTlw1OjGA5mEpj3E6a/NDYFs7g
 W7cDE+TJGBoNvK6pZ0V2UqUBB5vqxu0MzoTfbVeM5t0V4Cw/hbivyvUN1pYalPamwgNyt
 dkFpRbaVIzsXh8keb6WouZBVryzt6xlrLns=

--321Yv75ppNu0XDDvFgLt

From: Keiya Nobuta <nobuta.keiya@fujitsu.com>

commit 772f9daf336d047ef018bf41e218cb04df4146e5 upstream.

SCL3 is assigned to GPSR2 bit7 referred by IP1_23_20 macro.

Signed-off-by: Keiya Nobuta <nobuta.keiya@fujitsu.com>
Link: https://lore.kernel.org/r/20191008060619.30237-1-nobuta.keiya@fujitsu.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 3172ef6a9b20..0a2ea9544802 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -729,7 +729,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_PHYS_MSEL(IP1_23_20, HRX3_D,		I2C_SEL_3_0,	SEL_HSCIF3_3),
 	PINMUX_IPSR_PHYS_MSEL(IP1_23_20, VI4_DATA7_B,		I2C_SEL_3_0,	SEL_VIN4_1),
 	PINMUX_IPSR_PHYS_MSEL(IP1_23_20, IERX_B,		I2C_SEL_3_0,	SEL_IEBUS_1),
-	PINMUX_IPSR_PHYS(IP0_23_20,	SCL3,			I2C_SEL_3_1),
+	PINMUX_IPSR_PHYS(IP1_23_20,	SCL3,			I2C_SEL_3_1),
 
 	PINMUX_IPSR_PHYS_MSEL(IP1_27_24, PWM2_A,		I2C_SEL_3_0,	SEL_PWM2_0),
 	PINMUX_IPSR_PHYS_MSEL(IP1_27_24, HTX3_D,		I2C_SEL_3_0,	SEL_HSCIF3_3),
-- 
2.17.1


--321Yv75ppNu0XDDvFgLt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5197): https://lists.cip-project.org/g/cip-dev/message=
/5197
Mute This Topic: https://lists.cip-project.org/mt/76326737/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--321Yv75ppNu0XDDvFgLt--
