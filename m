Return-Path: <SRS0=v8vP=GQ=lists.cip-project.org=bounce+64572+6075+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52445C43381
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AE223406
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AE223406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6075+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NqK7YY4521723xtXMLHFSaiO; Wed, 13 Jan 2021 08:01:10 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.10141.1610553666445693623
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 08:01:10 -0800
X-IronPort-AV: E=Sophos;i="5.79,344,1602514800"; 
   d="scan'208";a="68896940"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jan 2021 01:01:09 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 905FF400C9EE;
	Thu, 14 Jan 2021 01:01:08 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 4/9] ARM: dts: r8a7742: Add DU support
Date: Wed, 13 Jan 2021 16:00:57 +0000
Message-Id: <20210113160102.16310-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HCrkPKbhwA1c3cevpRPcnlLYx4520388AA=
Content-Type: multipart/mixed; boundary="36pxLacnuYYVtrdjVl3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610553670;
 bh=3EnRZ2Y6u8kshPwhFmGFR35MXMD1352Mm5oBLnndUyo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cwph9Yfsd30n/baEes2HFiTF4wBnazbthxYxObLwCmnjLk1hiD44iII464ad4bY5+Ev
 aQxtjfy8snaeV4Ep7RpK1PdOTfMBO9Xux354ZWVt71SNOH6cfXoNlK8Heox9tTzvX0pX3
 9AtqQ45Ggou+wJ80DMKZ2bMHC1YdMsu3dRc=

--36pxLacnuYYVtrdjVl3S

commit 6a62f64305c65e78db290c0ca153759b6b9ca130 upstream.

Add a Display Unit (DU) node to r8a7742 SoC DT.
Boards that want to enable the DU need to specify the output topology.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20200807174954.14448-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: changed clocks and reg property, added reg-names property, dropped
resets, reset-names properties]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 2ad6f965ccbd..d4087bacd6f2 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -1927,6 +1927,45 @@
 			renesas,#wpf = <4>;
 		};
 
+		du: display@feb00000 {
+			compatible = "renesas,du-r8a7742";
+			reg = <0 0xfeb00000 0 0x70000>,
+			      <0 0xfeb90000 0 0x1c>,
+			      <0 0xfeb94000 0 0x1c>;
+			reg-names = "du", "lvds.0", "lvds.1";
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7742_CLK_DU0>,
+				 <&mstp7_clks R8A7742_CLK_DU1>,
+				 <&mstp7_clks R8A7742_CLK_DU2>,
+				 <&mstp7_clks R8A7742_CLK_LVDS0>,
+				 <&mstp7_clks R8A7742_CLK_LVDS1>;
+			clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+				port@1 {
+					reg = <1>;
+					du_out_lvds0: endpoint {
+					};
+				};
+				port@2 {
+					reg = <2>;
+					du_out_lvds1: endpoint {
+					};
+				};
+			};
+		};
+
 		prr: chipid@ff000044 {
 			compatible = "renesas,prr";
 			reg = <0 0xff000044 0 4>;
-- 
2.17.1


--36pxLacnuYYVtrdjVl3S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6075): https://lists.cip-project.org/g/cip-dev/message=
/6075
Mute This Topic: https://lists.cip-project.org/mt/79654002/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--36pxLacnuYYVtrdjVl3S--
