Return-Path: <SRS0=DHsd=EP=lists.cip-project.org=bounce+64572+5777+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30791C56202
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4A52074F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="n5F72SJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4A52074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5777+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9A67YY4521723xmljSAm4fYP; Mon, 09 Nov 2020 07:50:25 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.13504.1604937019730124247
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:24 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="61913717"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:24 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 349DD40065C9;
	Tue, 10 Nov 2020 00:50:23 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 08/14] ARM: dts: r8a7742-iwg21d-q7: Add SPI NOR support
Date: Mon,  9 Nov 2020 15:50:05 +0000
Message-Id: <20201109155011.10291-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XlKXcThmS3nj4M9Bq1kZ92BVx4520388AA=
Content-Type: multipart/mixed; boundary="uNhmM7r8FtBrTAQTnfNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937025;
 bh=ZzRfsRIuzKX0bSbkFY5Yafwdnt0CU2JdDnvSRTNnbzI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=n5F72SJEShc3lN7BAR9Cw3FkQLEvts4iatb9k1hJJEIQzEcpGDyDDwNEJ7KxzlNTCtd
 oeq4s5CjdSG8aWym4VNgXOEcrbY/c7oWWJKeeMVuPcxwC0LUR7ZF14YGX2lWLOhBzKM7B
 6iNQZYnAKZxxOLmM1655nn/PAdAGMm3/pW0=

--uNhmM7r8FtBrTAQTnfNT

commit 8368ca1540f0ff5bf4cfe92b1ea7fc8045f61d50 upstream.

Add support for the SPI NOR device which is connected to MSIOF0 interface
on the iWave RainboW-G21d-q7 board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200907155541.2011-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
index 858d206514e0..728664e901fc 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
@@ -134,6 +134,32 @@
 	status = "okay";
 };
 
+&msiof0 {
+	pinctrl-0 = <&msiof0_pins>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+
+	flash1: flash@0 {
+		compatible = "sst,sst25vf016b", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "user";
+				reg = <0x00000000 0x00200000>;
+			};
+		};
+	};
+};
+
 &pcie_bus_clk {
 	clock-frequency = <100000000>;
 };
@@ -157,6 +183,11 @@
 		function = "i2c2";
 	};
 
+	msiof0_pins: msiof0 {
+		groups = "msiof0_clk", "msiof0_sync", "msiof0_tx", "msiof0_rx";
+		function = "msiof0";
+	};
+
 	scifa2_pins: scifa2 {
 		groups = "scifa2_data_c";
 		function = "scifa2";
-- 
2.17.1


--uNhmM7r8FtBrTAQTnfNT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5777): https://lists.cip-project.org/g/cip-dev/message=
/5777
Mute This Topic: https://lists.cip-project.org/mt/78138435/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uNhmM7r8FtBrTAQTnfNT--
