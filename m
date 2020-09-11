Return-Path: <SRS0=+Yqe=CU=lists.cip-project.org=bounce+64572+5445+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B120DC43461
	for <cip-dev@archiver.kernel.org>; Fri, 11 Sep 2020 12:39:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC1C22206
	for <cip-dev@archiver.kernel.org>; Fri, 11 Sep 2020 12:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bZrDOZKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC1C22206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5445+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id c8bFYY4521723xIpAYFYieBk; Fri, 11 Sep 2020 05:39:57 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.6921.1599827526358857457
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2020 05:32:11 -0700
X-IronPort-AV: E=Sophos;i="5.76,415,1592838000"; 
   d="scan'208";a="57039950"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2020 21:32:11 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.232])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BEA534263CB6;
	Fri, 11 Sep 2020 21:32:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 4/4] ARM: dts: r8a7742-iwg21d-q7: Sound DMA support via DVC on DTS
Date: Fri, 11 Sep 2020 13:32:01 +0100
Message-Id: <20200911123201.7820-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200911123201.7820-1-biju.das.jz@bp.renesas.com>
References: <20200911123201.7820-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sKNx8v18lfMiYKzJA7pp1znox4520388AA=
Content-Type: multipart/mixed; boundary="D2S9EF2wFUQFV9TU827E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599827997;
 bh=hDw9oTY3ZqQPz2uNP1oEgHL02RLlH/CEDigkSM7JHpY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bZrDOZKBjCRgD74EXKmWwgpBmta0OYGaEc6ceKxHJbVOEPf/fHEAdh52vllafKeqJZg
 kjBTnFFIKkRExxFh96ZUbg9ncBDw+aVwaPeRnuC06eYEY/k4psyr/xcuDKSIM7cwl3rP0
 rfP6LF4JaF2L0L5ZDhBgxgz2WV1Pw3bG7HM=

--D2S9EF2wFUQFV9TU827E

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fc3a1b2763d44ed471169e1dff2c8ce0fb352c1c upstream.

Enable sound with DMA support on carrier board.

DMA transfer uses DVC

     DMA               DMApp
[MEM] -> [SRC] -> [DVC] -> [SSIU] -> [SSI]

     DMA               DMApp
[MEM] <- [DVC] <- [SRC] <- [SSIU] <- [SSI]

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1590611013-26029-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 63 +++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
index 8085e1651493..428c494d88a3 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
@@ -5,6 +5,29 @@
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
+/*
+ * SSI-SGTL5000
+ *
+ * This command is required when Playback/Capture
+ *
+ *      amixer set "DVC Out" 100%
+ *      amixer set "DVC In" 100%
+ *
+ * You can use Mute
+ *
+ *      amixer set "DVC Out Mute" on
+ *      amixer set "DVC In Mute" on
+ *
+ * You can use Volume Ramp
+ *
+ *      amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
+ *      amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
+ *      amixer set "DVC Out Ramp" on
+ *      aplay xxx.wav &
+ *      amixer set "DVC Out"  80%  // Volume Down
+ *      amixer set "DVC Out" 100%  // Volume Up
+ */
+
 /dts-v1/;
 #include "r8a7742-iwg21m.dtsi"
 
@@ -36,6 +59,21 @@
 		regulator-always-on;
 	};
 
+	rsnd_sgtl5000: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sndcodec>;
+		simple-audio-card,frame-master = <&sndcodec>;
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
+	};
+
 	vcc_sdhi2: regulator-vcc-sdhi2 {
 		compatible = "regulator-fixed";
 
@@ -117,6 +155,27 @@
 		function = "sdhi2";
 		power-source = <3300>;
 	};
+
+	sound_pins: sound {
+		groups = "ssi34_ctrl", "ssi3_data", "ssi4_data";
+		function = "ssi";
+	};
+};
+
+&rcar_sound {
+	pinctrl-0 = <&sound_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	rcar_sound,dai {
+		dai0 {
+			playback = <&ssi4 &src4 &dvc1>;
+			capture = <&ssi3 &src3 &dvc0>;
+		};
+	};
 };
 
 &rwdt {
@@ -141,3 +200,7 @@
 	wp-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
+
+&ssi4 {
+	shared-pin;
+};
-- 
2.17.1


--D2S9EF2wFUQFV9TU827E
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5445): https://lists.cip-project.org/g/cip-dev/message=
/5445
Mute This Topic: https://lists.cip-project.org/mt/76778361/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--D2S9EF2wFUQFV9TU827E--
