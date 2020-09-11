Return-Path: <SRS0=tsHu=CU=lists.cip-project.org=bounce+64572+5444+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1384BC2D0E4
	for <cip-dev@archiver.kernel.org>; Fri, 11 Sep 2020 12:40:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964C222204
	for <cip-dev@archiver.kernel.org>; Fri, 11 Sep 2020 12:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bbQH9vSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964C222204
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5444+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cxswYY4521723x5mdC5YCA5b; Fri, 11 Sep 2020 05:39:59 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.6921.1599827526358857457
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2020 05:32:09 -0700
X-IronPort-AV: E=Sophos;i="5.76,415,1592838000"; 
   d="scan'208";a="57039947"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2020 21:32:09 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.232])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EE25A4263CB6;
	Fri, 11 Sep 2020 21:32:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 3/4] ARM: dts: r8a7742-iwg21d-q7: Enable SGTL5000 audio codec
Date: Fri, 11 Sep 2020 13:32:00 +0100
Message-Id: <20200911123201.7820-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200911123201.7820-1-biju.das.jz@bp.renesas.com>
References: <20200911123201.7820-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3aDDgEvAOAd5gShza7epAjwZx4520388AA=
Content-Type: multipart/mixed; boundary="eHxNpeeyNPgUy4UYIzTs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599827999;
 bh=FIDgUAkezMoHbfeIJyjXbjP0NXDY8e4PNoTJ2ZQLgw0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bbQH9vSLrU8m3HcH2XuzsegkyAbzAfK+gifb4sj/Ll4q/RNP5phfPdj3MGOurwu3Koy
 FllJMY4opz3YBs8vbCteB4BfRz2ZyHNDT2DPC819yWj3OY+TXRSZ/HezKATnZ8blSGvmR
 fFIvuJM7KEUu338aG0NthX5t23cUHz+6BHI=

--eHxNpeeyNPgUy4UYIzTs

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 436765010f266a2afd6c9afd15233225448a3e8d upstream.

This patch enables SGTL5000 audio codec on the carrier board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1590611013-26029-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
index 1c7e58d47d73..8085e1651493 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
@@ -22,6 +22,20 @@
 		stdout-path = "serial2:115200n8";
 	};
 
+	audio_clock: audio_clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	reg_1p5v: 1p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P5V";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+
 	vcc_sdhi2: regulator-vcc-sdhi2 {
 		compatible = "regulator-fixed";
 
@@ -60,6 +74,24 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	sgtl5000: codec@a {
+		compatible = "fsl,sgtl5000";
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		clocks = <&audio_clock>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p5v>;
+	};
+};
+
 &cmt0 {
 	status = "okay";
 };
@@ -70,6 +102,11 @@
 		function = "avb";
 	};
 
+	i2c2_pins: i2c2 {
+		groups = "i2c2_b";
+		function = "i2c2";
+	};
+
 	scifa2_pins: scifa2 {
 		groups = "scifa2_data_c";
 		function = "scifa2";
-- 
2.17.1


--eHxNpeeyNPgUy4UYIzTs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5444): https://lists.cip-project.org/g/cip-dev/message=
/5444
Mute This Topic: https://lists.cip-project.org/mt/76778360/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--eHxNpeeyNPgUy4UYIzTs--
