Return-Path: <SRS0=rTPF=CL=lists.cip-project.org=bounce+64572+5367+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5582AC2D0A5
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 12:46:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB0120829
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 12:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PrFSfEZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB0120829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5367+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aJERYY4521723x3rxYxZvzGp; Wed, 02 Sep 2020 05:46:08 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.2331.1599033039663673523
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 00:50:46 -0700
X-IronPort-AV: E=Sophos;i="5.76,381,1592838000"; 
   d="scan'208";a="55947289"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Sep 2020 16:50:45 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 411A64004BA7;
	Wed,  2 Sep 2020 16:50:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 4/5] ARM: dts: r8a7742-iwg21d-q7: Enable SDHI2 controller
Date: Wed,  2 Sep 2020 08:50:34 +0100
Message-Id: <20200902075035.4445-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
References: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iqr0GRpEtRBtcTnOSg1SdVKfx4520388AA=
Content-Type: multipart/mixed; boundary="G7BCHpNZspcoWvekdtP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599050768;
 bh=ouC8wDI0lVuZopL9DGDTP0TeagH06pTY9sJYzgVhesA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PrFSfEZJv7y27AoqhU/P9jxiPfkPaI21qG23iux1KNVwBZx3j1/PwYGrAvKsx0TGSKJ
 DL35tESxDeMmZ44fIpwcbFGM370rWXNTjPJk7LYRCC9ixBZ9rknVfHvEA4BKfkD/JxBnA
 cI/ksCMpJnryOFcauASBhWcTyBRSa5zYu8U=

--G7BCHpNZspcoWvekdtP8

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b3850cd90edc0baad2ec47293f4ec3c929de6f76 upstream.

Enable the SDHI2 controller on iWave RZ/G1H carrier board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1590420129-7531-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: removed sd-uhs-sdr50 property, since voltage switching is not supported in 4.4 kernel]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
index 8ce82ad3d946..82abbb758046 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
@@ -21,6 +21,28 @@
 		bootargs = "ignore_loglevel root=/dev/mmcblk0p1 rw rootwait";
 		stdout-path = "serial2:115200n8";
 	};
+
+	vcc_sdhi2: regulator-vcc-sdhi2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI2 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio1 27 GPIO_ACTIVE_LOW>;
+	};
+
+	vccq_sdhi2: regulator-vccq-sdhi2 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI2 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>, <1800000 0>;
+	};
 };
 
 &avb {
@@ -48,6 +70,12 @@
 		groups = "scifa2_data_c";
 		function = "scifa2";
 	};
+
+	sdhi2_pins: sd2 {
+		groups = "sdhi2_data4", "sdhi2_ctrl";
+		function = "sdhi2";
+		power-source = <3300>;
+	};
 };
 
 &scifa2 {
@@ -56,3 +84,14 @@
 
 	status = "okay";
 };
+
+&sdhi2 {
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi2>;
+	vqmmc-supply = <&vccq_sdhi2>;
+	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
-- 
2.17.1


--G7BCHpNZspcoWvekdtP8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5367): https://lists.cip-project.org/g/cip-dev/message=
/5367
Mute This Topic: https://lists.cip-project.org/mt/76581048/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--G7BCHpNZspcoWvekdtP8--
