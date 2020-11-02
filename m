Return-Path: <SRS0=CStr=EI=lists.cip-project.org=bounce+64572+5707+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33067C00A89
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4CB21D91
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Sy5bJNei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4CB21D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5707+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7YEGYY4521723xZSo4LYoAOU; Mon, 02 Nov 2020 01:24:54 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.28823.1604309092548565826
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2020 01:24:53 -0800
X-IronPort-AV: E=Sophos;i="5.77,444,1596466800"; 
   d="scan'208";a="61246987"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Nov 2020 18:24:53 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 62CE24006CCF;
	Mon,  2 Nov 2020 18:24:52 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 6/6] arm64: dts: renesas: r8a774e1-hihope-rzg2h-ex: Enable sata
Date: Mon,  2 Nov 2020 09:24:43 +0000
Message-Id: <20201102092443.4142-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9dFs0KJiIblAy1Yfxh36Obzyx4520388AA=
Content-Type: multipart/mixed; boundary="KPagQySCahKMKBAUWyMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604309094;
 bh=0QXTWYTlwMoXl6XJPLmN0CRMDSjHF2hZWQBscRGalqc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Sy5bJNei6kRBd6Z4mFp+IXg1qSqpujQuhrsy2ci9GxH4TRRXF45q7eSyHbS2vq/i47O
 NKiT6WXfi/2eiBM9ZdruIaWk3wklGL8DNBkayOJbtsuChpVqeMBYVIQefJ4OSWLn+W5J8
 eDxFfPhIigOkvm1z5RDHT6cdpK5iBF2WhIc=

--KPagQySCahKMKBAUWyMq

commit 7345e5c1853d7173bf06923c29f93c0308ac89e5 upstream.

Enable sata interface on HiHope RZ/G2H board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20200907073214.13929-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts
index 265355e0de5f..812995939841 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts
@@ -13,3 +13,8 @@
 	compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2h",
 		     "renesas,r8a774e1";
 };
+
+/* Set SW43 = ON and SW1001[7] = OFF for SATA port to be activated */
+&sata {
+	status = "okay";
+};
-- 
2.17.1


--KPagQySCahKMKBAUWyMq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5707): https://lists.cip-project.org/g/cip-dev/message=
/5707
Mute This Topic: https://lists.cip-project.org/mt/77977475/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KPagQySCahKMKBAUWyMq--
