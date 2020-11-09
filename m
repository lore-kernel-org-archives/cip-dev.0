Return-Path: <SRS0=EjI7=EP=lists.cip-project.org=bounce+64572+5780+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144C3C5517A
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8DC206C0
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rPMjI97d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8DC206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5780+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vbqAYY4521723xG9a3W07vlk; Mon, 09 Nov 2020 07:50:29 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.13504.1604937015956466828
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:28 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="62129287"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:28 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 18A7B40078A1;
	Tue, 10 Nov 2020 00:50:26 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 11/14] ARM: dts: r8a7742: Add CAN support
Date: Mon,  9 Nov 2020 15:50:08 +0000
Message-Id: <20201109155011.10291-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GjTXtN6hXVhf0OJ7rlaZHLg1x4520388AA=
Content-Type: multipart/mixed; boundary="dYwnfzVnhM7l6zomlNyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937029;
 bh=m9LjOuvRrbNMyfMd7h3iZn8/iWUQzefn12QLpK6wgxI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rPMjI97dtVAsyfewNqdXeCn6xrmMyFC+KGqJpHtS4UrjrUmmkE/gbrKjUt6ISvNn5Yg
 0IURbNQ3ztoTL65GJUW68fPfb+i7gWB67DIeAU1Y/dt6gkUjLlp7zr//BB5PgwM42If4g
 ZTBfYj0JAP1v6g/9cV+4b/UH9vVNxNIthTY=

--dYwnfzVnhM7l6zomlNyX

commit 5a81ade1dd284a25c25b7582e94e33e5690c3da5 upstream.

Add the definitions for can0 and can1 to the r8a7742 SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200816190732.6905-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: dropped resets property. changed clocks and power-domains properties.]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index a8ce139e9fc5..af6888521595 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -35,6 +35,14 @@
 		clock-frequency = <0>;
 	};
 
+	/* External CAN clock */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -1106,6 +1114,30 @@
 			status = "disabled";
 		};
 
+		can0: can@e6e80000 {
+			compatible = "renesas,can-r8a7742",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e80000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7742_CLK_RCAN0>,
+				  <&cpg_clocks R8A7742_CLK_RCAN>, <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		can1: can@e6e88000 {
+			compatible = "renesas,can-r8a7742",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e88000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7742_CLK_RCAN1>,
+				 <&cpg_clocks R8A7742_CLK_RCAN>, <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		scifb0: serial@e6c20000 {
 			compatible = "renesas,scifb-r8a7742",
 				     "renesas,scifb";
-- 
2.17.1


--dYwnfzVnhM7l6zomlNyX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5780): https://lists.cip-project.org/g/cip-dev/message=
/5780
Mute This Topic: https://lists.cip-project.org/mt/78138438/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dYwnfzVnhM7l6zomlNyX--
