Return-Path: <SRS0=koZ/=EP=lists.cip-project.org=bounce+64572+5771+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A7FC4741F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A117206C0
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IM08UkvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A117206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5771+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2sBNYY4521723xjxQxC0r02Q; Mon, 09 Nov 2020 07:50:18 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.13504.1604937015956466828
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:16 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="62129269"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:16 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5FE0240065C9;
	Tue, 10 Nov 2020 00:50:15 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 02/14] ARM: dts: r8a7742-iwg21m: Add RTC support
Date: Mon,  9 Nov 2020 15:49:59 +0000
Message-Id: <20201109155011.10291-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qblcPJmLTIGteVh11ljvnuDgx4520388AA=
Content-Type: multipart/mixed; boundary="C0Vb6zKw3Kv2LHvYqc3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937018;
 bh=B4Qn8v6qhntnu3jbCuFPyko0WKeBanD9TTjR6fy2vaU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IM08UkvFErrHnWuTy3/XN5PwagVwMPtGNwRgaTvpkWKraceictehiGwlOE/cQFTlZ2V
 ZDgoN4aZOP6Z4PBj6th6HfCQ0K9y+zqwH1nszTGIWpBDfmj2o6Hv+dp0Gz70l2x9eqPkP
 zzl+TX7qgFDCiXUpx34AZKuWnU4oJ0AEwvc=

--C0Vb6zKw3Kv2LHvYqc3o

commit c0ed2ee793f1f5c15d88c0dd458504b7b2aa9d6a upstream.

Enable BQ32000 RTC which is connected to I2C0 on the iWave RainboW-G21M-q7
SOM.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200816193316.7641-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
index 6e8df79bea94..0f26807f92b8 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
+++ b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
@@ -35,6 +35,21 @@
 	clock-frequency = <20000000>;
 };
 
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	rtc@68 {
+		compatible = "ti,bq32000";
+		reg = <0x68>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
 &mmcif1 {
 	pinctrl-0 = <&mmc1_pins>;
 	pinctrl-names = "default";
@@ -46,6 +61,11 @@
 };
 
 &pfc {
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
 	mmc1_pins: mmc1 {
 		groups = "mmc1_data4", "mmc1_ctrl";
 		function = "mmc1";
-- 
2.17.1


--C0Vb6zKw3Kv2LHvYqc3o
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5771): https://lists.cip-project.org/g/cip-dev/message=
/5771
Mute This Topic: https://lists.cip-project.org/mt/78138426/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--C0Vb6zKw3Kv2LHvYqc3o--
