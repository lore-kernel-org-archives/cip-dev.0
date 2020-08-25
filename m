Return-Path: <SRS0=Pejj=CD=lists.cip-project.org=bounce+64572+5247+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E9C433E5
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:41:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07B420786
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="E1hi00Pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07B420786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5247+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id G3pMYY4521723x25KjXUiZoK; Tue, 25 Aug 2020 06:41:59 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.13479.1598361721660454951
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 06:22:12 -0700
X-IronPort-AV: E=Sophos;i="5.76,352,1592838000"; 
   d="scan'208";a="55486206"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Aug 2020 22:22:12 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D0EAD4008C59;
	Tue, 25 Aug 2020 22:22:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 07/10] arm64: dts: renesas: r8a774e1: Add CMT device nodes
Date: Tue, 25 Aug 2020 14:21:53 +0100
Message-Id: <20200825132156.7839-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: W4DJVZVsy0Z4887KKSbIr6Yhx4520388AA=
Content-Type: multipart/mixed; boundary="GhpFGQE6CQeWWvbPEPOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598362919;
 bh=9nPJmI9s41BiXWUjgOlEXEIo+xHuwQxC3oaSACiQN0g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=E1hi00Pz2LbHiwKWsjXwAFwtN0pEECGhtibIt1qkotr5XqKVJpq/zdn4k8HyVJi+XST
 nnsL10kuG1X9nSTYWDMw8RHnlTUATkSl+3dp/D2IFgbvomS94bWBL3dUUdeQgj2TbRiqk
 XG5gZiwb8m6bY9uJWZdUjYD+0DBQwOTljgk=

--GhpFGQE6CQeWWvbPEPOc

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit c6c4b7defd391da84da0ac640df0da2a13680a9e upstream.

This patch adds the CMT[0123] device tree nodes to the
r8a774e1 SoC specific DT.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594811350-14066-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 70c5e28e201e..264f3b7e3c11 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -421,6 +421,76 @@
 			reg = <0 0xe6060000 0 0x50c>;
 		};
 
+		cmt0: timer@e60f0000 {
+			compatible = "renesas,r8a774e1-cmt0",
+				     "renesas,rcar-gen3-cmt0";
+			reg = <0 0xe60f0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 303>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 303>;
+			status = "disabled";
+		};
+
+		cmt1: timer@e6130000 {
+			compatible = "renesas,r8a774e1-cmt1",
+				     "renesas,rcar-gen3-cmt1";
+			reg = <0 0xe6130000 0 0x1004>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 302>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 302>;
+			status = "disabled";
+		};
+
+		cmt2: timer@e6140000 {
+			compatible = "renesas,r8a774e1-cmt1",
+				     "renesas,rcar-gen3-cmt1";
+			reg = <0 0xe6140000 0 0x1004>;
+			interrupts = <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 301>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 301>;
+			status = "disabled";
+		};
+
+		cmt3: timer@e6148000 {
+			compatible = "renesas,r8a774e1-cmt1",
+				     "renesas,rcar-gen3-cmt1";
+			reg = <0 0xe6148000 0 0x1004>;
+			interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 477 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 300>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 300>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@e6150000 {
 			compatible = "renesas,r8a774e1-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.17.1


--GhpFGQE6CQeWWvbPEPOc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5247): https://lists.cip-project.org/g/cip-dev/message=
/5247
Mute This Topic: https://lists.cip-project.org/mt/76406711/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GhpFGQE6CQeWWvbPEPOc--
