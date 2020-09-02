Return-Path: <SRS0=NaD6=CL=lists.cip-project.org=bounce+64572+5379+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF91AC2D0A6
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80732208C7
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="JuqUEEIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80732208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5379+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id t0KfYY4521723xa1EuOaQTFV; Wed, 02 Sep 2020 09:06:42 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.11290.1599062730775497221
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 09:05:38 -0700
X-IronPort-AV: E=Sophos;i="5.76,383,1592838000"; 
   d="scan'208";a="56196980"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2020 01:05:38 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9873240065AE;
	Thu,  3 Sep 2020 01:05:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 6/9] ARM: dts: r8a7742: Add CMT SoC specific support
Date: Wed,  2 Sep 2020 17:05:14 +0100
Message-Id: <20200902160517.5181-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: t35QRWwegdWRueWeiDWMfaKvx4520388AA=
Content-Type: multipart/mixed; boundary="xeLe78Dc6Yvu1AkNeFGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599062802;
 bh=Xpj8GSMG5SyUCb1+jFZaF1C+bbUVZLLpco445ADLsAQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=JuqUEEImo1hXw0tWiIUzuTEVbwdJs5+hh5pImo0NKJ4GcCKJ5XqV2xnPtXGT88PGEy+
 NRTySHAPPLHxzYUG9J+A6LFz6gQOT3tTo2i/Zq9+9MmdoVj23zrzv1ZqizeGqLGnJpa6n
 eBAuPUl07Kfi3wYqUZ79aetoaBlwISgsj+E=

--xeLe78Dc6Yvu1AkNeFGf

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5818cc37e7fc72d9f2da255d9648c5f2e1a33b22 upstream.

Add CMT[01] support to r8a7742 SoC DT.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1590614320-30160-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domain properties, removed resets property, added renesas,channel-mask property]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 97bedc13f702..ada98d3fe290 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -1073,6 +1073,42 @@
 			clock-names = "clk";
 			power-domains = <&cpg_clocks>;
 		};
+
+		cmt0: timer@ffca0000 {
+			compatible = "renesas,cmt-48-r8a7742",
+				     "renesas,cmt-48-gen2";
+			reg = <0 0xffca0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7742_CLK_CMT0>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+
+			renesas,channels-mask = <0x60>;
+
+			status = "disabled";
+		};
+
+		cmt1: timer@e6130000 {
+			compatible = "renesas,cmt-48-r8a7742",
+				     "renesas,cmt-48-gen2";
+			reg = <0 0xe6130000 0 0x1004>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_CMT1>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+
+			renesas,channels-mask = <0xff>;
+
+			status = "disabled";
+		};
 	};
 
 	thermal-zones {
-- 
2.17.1


--xeLe78Dc6Yvu1AkNeFGf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5379): https://lists.cip-project.org/g/cip-dev/message=
/5379
Mute This Topic: https://lists.cip-project.org/mt/76585846/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xeLe78Dc6Yvu1AkNeFGf--
