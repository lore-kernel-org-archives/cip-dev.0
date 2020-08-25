Return-Path: <SRS0=DoaH=CD=lists.cip-project.org=bounce+64572+5241+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7BAC433E4
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:41:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06372076C
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CNylt1jQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06372076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5241+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3weXYY4521723xotgCZGsmsA; Tue, 25 Aug 2020 06:41:59 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.13479.1598361721660454951
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 06:22:02 -0700
X-IronPort-AV: E=Sophos;i="5.76,352,1592838000"; 
   d="scan'208";a="55486173"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Aug 2020 22:22:01 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A39E0400517E;
	Tue, 25 Aug 2020 22:21:59 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 01/10] arm64: dts: renesas: r8a774e1: Add operating points
Date: Tue, 25 Aug 2020 14:21:47 +0100
Message-Id: <20200825132156.7839-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XFNSAqANEiNxGUxTvEajpmYyx4520388AA=
Content-Type: multipart/mixed; boundary="BFT9V2oTwusCcbb6B2rq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598362919;
 bh=+Mtwvj9w4QIT7fLPWoHCAA/M3yoKS80XyORjQJEDn/I=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=CNylt1jQ/Jx8f5+QxO6g42hQQt36zDF4nMNdPGE7A5rD0X5VOw6xZsfKiaxB0KglYTb
 OFPgyG31fiytzK52jo+VPnOfwO7u5VJJS4Nm2ZOlwF6RCx8kuLURg92/WJ+ZNC2cnoEYy
 Fnl6XvmdUtyiRs3dX9edOx4mWw0q3R6vLH4=

--BFT9V2oTwusCcbb6B2rq

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit d18dbce4e8c02634866dc80c7873e6121fcae970 upstream.

The RZ/G2H (r8a774e1) comes with two clusters of processors, similarly to
the r8a774a1. The first cluster is made of A57s, the second cluster is made
of A53s.

The operating points for the cluster with the A57s are:

Frequency | Voltage
----------|---------
500 MHz   | 0.82V
1.0 GHz   | 0.82V
1.5 GHz   | 0.82V

The operating points for the cluster with the A53s are:

Frequency | Voltage
----------|---------
800 MHz   | 0.82V
1.0 GHz   | 0.82V
1.2 GHz   | 0.82V

This patch adds the definitions for the operating points to the SoC
specific DT.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594811350-14066-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 51 +++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index d76aec73aa28..3a3490adc8a0 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -34,6 +34,49 @@
 		clock-frequency = <0>;
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -79,6 +122,7 @@
 			enable-method = "psci";
 			dynamic-power-coefficient = <854>;
 			clocks = <&cpg CPG_CORE R8A774E1_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 			capacity-dmips-mhz = <1024>;
 			#cooling-cells = <2>;
 		};
@@ -91,6 +135,7 @@
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774E1_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 			capacity-dmips-mhz = <1024>;
 			#cooling-cells = <2>;
 		};
@@ -103,6 +148,7 @@
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774E1_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 			capacity-dmips-mhz = <1024>;
 			#cooling-cells = <2>;
 		};
@@ -115,6 +161,7 @@
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774E1_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 			capacity-dmips-mhz = <1024>;
 			#cooling-cells = <2>;
 		};
@@ -129,6 +176,7 @@
 			#cooling-cells = <2>;
 			dynamic-power-coefficient = <277>;
 			clocks = <&cpg CPG_CORE R8A774E1_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 			capacity-dmips-mhz = <535>;
 		};
 
@@ -140,6 +188,7 @@
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774E1_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 			capacity-dmips-mhz = <535>;
 		};
 
@@ -151,6 +200,7 @@
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774E1_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 			capacity-dmips-mhz = <535>;
 		};
 
@@ -162,6 +212,7 @@
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774E1_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 			capacity-dmips-mhz = <535>;
 		};
 
-- 
2.17.1


--BFT9V2oTwusCcbb6B2rq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5241): https://lists.cip-project.org/g/cip-dev/message=
/5241
Mute This Topic: https://lists.cip-project.org/mt/76406705/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BFT9V2oTwusCcbb6B2rq--
