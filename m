Return-Path: <SRS0=qS3a=EP=lists.cip-project.org=bounce+64572+5774+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D44C56202
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD691206C0
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dg+C5kwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD691206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5774+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9nCkYY4521723xcoybzxi5JI; Mon, 09 Nov 2020 07:50:21 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.13504.1604937019730124247
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:20 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="61913710"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:20 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 496B84004BAE;
	Tue, 10 Nov 2020 00:50:19 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 05/14] ARM: dts: r8a7742-iwg21m: Add SPI NOR support
Date: Mon,  9 Nov 2020 15:50:02 +0000
Message-Id: <20201109155011.10291-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: F0GtlcjqJ4yWSEN7ulev65jjx4520388AA=
Content-Type: multipart/mixed; boundary="U3Ig9IfVSjRWhLC3Ustu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937021;
 bh=9BBL2igrDNTGfdOdBZG1dfUfPJsN8Tp7JRFkZ0d1goc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dg+C5kwvLIitMNusgvQswrbueecAyfwDP1UkQdUCc+tVAsqAV5wGmaIk7gyYHPvnFlH
 +ot1nS0krvwfrSPOFY1+TToUkMjpARh91PKPhIQIYHpiMbedp3bTUDiSIMeiqN+/hLx77
 6WfkGQyL/tbD2tmM9B2pVTkBIEpTVzJkGag=

--U3Ig9IfVSjRWhLC3Ustu

commit fc7f54fb13b807c556770a69468188947981a400 upstream.

Add support for the SPI NOR device used to boot up the system
to the System on Module DT.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200825085435.8744-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
index 0f26807f92b8..5621c9ed698f 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
+++ b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
@@ -35,6 +35,16 @@
 	clock-frequency = <20000000>;
 };
 
+&gpio0 {
+	/* GP0_18 set low to select QSPI. Doing so will disable VIN2 */
+	qspi_en {
+		gpio-hog;
+		gpios = <18 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "QSPI_EN";
+	};
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -70,4 +80,45 @@
 		groups = "mmc1_data4", "mmc1_ctrl";
 		function = "mmc1";
 	};
+
+	qspi_pins: qspi {
+		groups = "qspi_ctrl", "qspi_data2";
+		function = "qspi";
+	};
+};
+
+&qspi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash: flash@0 {
+		compatible = "sst,sst25vf016b", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "bootloader";
+				reg = <0x00000000 0x000c0000>;
+				read-only;
+			};
+			partition@c0000 {
+				label = "env";
+				reg = <0x000c0000 0x00002000>;
+			};
+			partition@c2000 {
+				label = "user";
+				reg = <0x000c2000 0x0013e000>;
+			};
+		};
+	};
 };
-- 
2.17.1


--U3Ig9IfVSjRWhLC3Ustu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5774): https://lists.cip-project.org/g/cip-dev/message=
/5774
Mute This Topic: https://lists.cip-project.org/mt/78138432/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--U3Ig9IfVSjRWhLC3Ustu--
