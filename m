Return-Path: <SRS0=cMsI=BB=lists.cip-project.org=bounce+64572+4971+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CFEC433F1
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA84207BB
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IdvbbSra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA84207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4971+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id G9RiYY4521723xsF9HytXoVz; Wed, 22 Jul 2020 10:47:08 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.23023.1595435721535782356
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:21 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52832260"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:20 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4E50440078CA;
	Thu, 23 Jul 2020 01:35:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 15/17] arm64: dts: renesas: rzg2: Add reset control properties for display
Date: Wed, 22 Jul 2020 17:34:47 +0100
Message-Id: <20200722163449.3513-16-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nWJd2dFpcZcQ63hBYFxHZM4yx4520388AA=
Content-Type: multipart/mixed; boundary="dxMCfpZ4Lz7jYkJRqLbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440028;
 bh=B0IYVoJPN5nV+CHI21RDVz8A7jCbdBNGx0qcnS7tqYg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IdvbbSracydKqR8wTMVVGPtrTXKa+JWYtgJQkrGsf2UF8jTseLubgPGkQPQYgTTHdEX
 o/bHeyFaYGwX/v8KUAYa7zjSTnJ490I7/FiBPl2bH4qU4rmgCVzHMaMy8fmzBN+pieKUp
 f8qalhB6G27Kjs09LZfeh0lpjBP8TuY18U8=

--dxMCfpZ4Lz7jYkJRqLbG

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 721b76195b31467e56851fbab3855e700f281270 upstream.

Add reset control properties to the device nodes for the Display Units
on all supported RZ/G2 SoCs.  Note that on these SoCs, there is only a
single reset for each pair of DU channels.

Join the clocks lines while at it, to increase uniformity.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20200218133019.22299-5-geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 5 +++--
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 5 +++--
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 6 ++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 570093ce77be..86ad9b34810f 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -2278,10 +2278,11 @@
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 724>,
-				 <&cpg CPG_MOD 723>,
+			clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>,
 				 <&cpg CPG_MOD 722>;
 			clock-names = "du.0", "du.1", "du.2";
+			resets = <&cpg 724>, <&cpg 722>;
+			reset-names = "du.0", "du.2";
 			status = "disabled";
 
 			vsps = <&vspd0 &vspd1 &vspd2>;
diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 5948f782ab48..5e4768fb6842 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -2103,10 +2103,11 @@
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 724>,
-				 <&cpg CPG_MOD 723>,
+			clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>,
 				 <&cpg CPG_MOD 721>;
 			clock-names = "du.0", "du.1", "du.3";
+			resets = <&cpg 724>, <&cpg 722>;
+			reset-names = "du.0", "du.3";
 			status = "disabled";
 
 			vsps = <&vspd0 0>, <&vspd1 0>, <&vspd0 1>;
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 75d4fbd2579e..783a8cf16eaa 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1810,10 +1810,12 @@
 			reg = <0 0xfeb00000 0 0x40000>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 724>,
-				 <&cpg CPG_MOD 723>;
+			clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>;
 			clock-names = "du.0", "du.1";
+			resets = <&cpg 724>;
+			reset-names = "du.0";
 			vsps = <&vspd0 0>, <&vspd1 0>;
+
 			status = "disabled";
 
 			ports {
-- 
2.17.1


--dxMCfpZ4Lz7jYkJRqLbG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4971): https://lists.cip-project.org/g/cip-dev/message=
/4971
Mute This Topic: https://lists.cip-project.org/mt/75730033/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--dxMCfpZ4Lz7jYkJRqLbG--
