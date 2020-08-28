Return-Path: <SRS0=mPzB=CG=lists.cip-project.org=bounce+64572+5316+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74265C2BBD9
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E516207DF
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="SIU+SCAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E516207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5316+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6awpYY4521723xUjjoq8gL0Z; Fri, 28 Aug 2020 09:07:53 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.45506.1598629371850471017
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:54 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587899"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:53 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CD9EA400C4F0;
	Sat, 29 Aug 2020 00:42:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 26/30] ARM: dts: r8a7742: Add GPIO nodes
Date: Fri, 28 Aug 2020 16:41:51 +0100
Message-Id: <20200828154155.5827-27-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fs3ttINlNTYNlzG7vMEwWmKPx4520388AA=
Content-Type: multipart/mixed; boundary="xtGZ0tdxpCQBTcraI6Mt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630873;
 bh=tb3HNhCzNrhTP22eLj5UHXjxvAfWzuX4VHjlvCSRZGE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=SIU+SCAGDkN2V+dx5jKQskbXgFhyfAfwNRl3DICnS3ofpbvgSTOKXyNSbVjmjsl/5xg
 XL/FipEENPO1Y1Zb3tfekDuUOiPiFuaIsZmITlEpt6wTIxfuq80ycDq25AlgysEASgYYa
 jctgRyNiEyM3EV+i7x6OxKgHNA57P0npmBE=

--xtGZ0tdxpCQBTcraI6Mt

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7fc3b53a7bd6ebfffd22a75f57175b80fa3df834

Describe GPIO blocks in the R8A7742 device tree.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1588794695-27852-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: removed resets and updated clocks, power-domain properties]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 84 ++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index af2ea73f9557..9e26313e09e1 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -606,6 +606,90 @@
 		#size-cells = <2>;
 		ranges;
 
+		gpio0: gpio@e6050000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 0 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7742_CLK_GPIO0>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio1: gpio@e6051000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 32 30>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7742_CLK_GPIO1>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio2: gpio@e6052000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 64 30>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7742_CLK_GPIO2>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio3: gpio@e6053000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 96 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7742_CLK_GPIO3>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio4: gpio@e6054000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 128 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7742_CLK_GPIO4>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio5: gpio@e6055000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 160 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7742_CLK_GPIO5>;
+			power-domains = <&cpg_clocks>;
+		};
+
 		pfc: pin-controller@e6060000 {
 			compatible = "renesas,pfc-r8a7742";
 			reg = <0 0xe6060000 0 0x250>;
-- 
2.17.1


--xtGZ0tdxpCQBTcraI6Mt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5316): https://lists.cip-project.org/g/cip-dev/message=
/5316
Mute This Topic: https://lists.cip-project.org/mt/76477105/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xtGZ0tdxpCQBTcraI6Mt--
