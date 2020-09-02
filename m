Return-Path: <SRS0=W2tW=CL=lists.cip-project.org=bounce+64572+5372+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BEFC433E7
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A48E20C56
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oDQt8TBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A48E20C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5372+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BsGJYY4521723xZ6K40uvLIA; Wed, 02 Sep 2020 09:06:40 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.11147.1599062725125566061
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 09:05:25 -0700
X-IronPort-AV: E=Sophos;i="5.76,383,1592838000"; 
   d="scan'208";a="55980479"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 01:05:24 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E2A3340065AE;
	Thu,  3 Sep 2020 01:05:22 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 2/9] ARM: dts: r8a7742: Add RWDT node
Date: Wed,  2 Sep 2020 17:05:07 +0100
Message-Id: <20200902160517.5181-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: h8yK6U5k5UjvIvMk35ymQqpOx4520388AA=
Content-Type: multipart/mixed; boundary="3KsryMdKUt0dzvnaR0Cw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599062800;
 bh=B7dvJ1EHosVthTvuOx9RNb88VMDpv5Yk7C/qSS7aL+U=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=oDQt8TBm5+acrMGY4tySgL+UhTj5TS+GMSlbHV942g9fRtEKBKlBLXk9Az5783Xg9EH
 YONLMQnpJtiPFRkyo4a3xQQwIkY1oSaF8vaTpFRyjChIYSDpKsEOj7VKcHnFqJAM5Ay0F
 JHofMcj4nn6dmD4dqgPvFI83zrhDvKIymmc=

--3KsryMdKUt0dzvnaR0Cw

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 72d1a34e3cedbb48513db50bb651c5ccf53e5a27 upstream.

Add a device node for the Watchdog Timer (RWDT) controller on the Renesas
RZ/G1H (r8a7742) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1590172641-1556-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domain properties, removed resets property]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index fd4da0d6269e..50f70b358bce 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -607,6 +607,16 @@
 		#size-cells = <2>;
 		ranges;
 
+		rwdt: watchdog@e6020000 {
+			compatible = "renesas,r8a7742-wdt",
+				     "renesas,rcar-gen2-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R8A7742_CLK_RWDT>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		gpio0: gpio@e6050000 {
 			compatible = "renesas,gpio-r8a7742",
 				     "renesas,rcar-gen2-gpio";
-- 
2.17.1


--3KsryMdKUt0dzvnaR0Cw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5372): https://lists.cip-project.org/g/cip-dev/message=
/5372
Mute This Topic: https://lists.cip-project.org/mt/76585839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--3KsryMdKUt0dzvnaR0Cw--
