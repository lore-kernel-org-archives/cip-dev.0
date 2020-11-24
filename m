Return-Path: <SRS0=5yKW=E6=lists.cip-project.org=bounce+64572+5849+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CB2C64E7D
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A21F20715
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="C2Ea1KnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A21F20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5849+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HGuQYY4521723xiGOnDQgjdi; Tue, 24 Nov 2020 09:11:36 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.15.1606237784446827976
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:09:51 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63522786"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Nov 2020 02:09:51 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DEECC40ABFEE;
	Wed, 25 Nov 2020 02:09:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 9/9] ARM: dts: r8a7742-iwg21d-q7: Enable HSUSB, USB2.0 and xHCI
Date: Tue, 24 Nov 2020 17:09:32 +0000
Message-Id: <20201124170932.13588-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FknaZFw4fcaaKzkpRXdvoWC8x4520388AA=
Content-Type: multipart/mixed; boundary="23DPLOotLnuOwmEI2N1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606237896;
 bh=bF1P9YnRLbQ/S91X6vXvRSCnABsAKnu1BYiY7slwh/I=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=C2Ea1KnIik168yRf37OZYJsWiV0xEz49zCjFQiKeiZt239WfK1ef57D4EWj7ogqp9sY
 cdBIUFePWMw+HHFE09MtemTjhaqeldZiLvU43V79yrFrVPnIXiV0avidX6WueMXZU6ye3
 NtrAUFAp1S5KxyORjcgkGzR+iRJTH1/N+GI=

--23DPLOotLnuOwmEI2N1k

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit eb302bb9c7ab9bbf8358b97b5f8b1c363af48239 upstream.

Enable support for HSUSB, USB2.0 and xHCI on iWave RZ/G1H carrier board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/1595005225-11519-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: sorted the nodes as per mainline]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
index 4adcf97ae7c4..958edef2004c 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
@@ -150,6 +150,12 @@
 	};
 };
 
+&hsusb {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &msiof0 {
 	pinctrl-0 = <&msiof0_pins>;
 	pinctrl-names = "default";
@@ -176,6 +182,24 @@
 	};
 };
 
+&pci0 {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+	/* Disable hsusb to enable USB2.0 host mode support on J2 */
+	/* status = "okay"; */
+};
+
+&pci1 {
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pci2 {
+	/* Disable xhci to enable USB2.0 host mode support on J23 bottom port */
+	/* status = "okay"; */
+};
+
 &pcie_bus_clk {
 	clock-frequency = <100000000>;
 };
@@ -224,6 +248,16 @@
 		groups = "ssi34_ctrl", "ssi3_data", "ssi4_data";
 		function = "ssi";
 	};
+
+	usb0_pins: usb0 {
+		groups = "usb0";
+		function = "usb0";
+	};
+
+	usb1_pins: usb1 {
+		groups = "usb1_pwen";
+		function = "usb1";
+	};
 };
 
 &rcar_sound {
@@ -268,3 +302,11 @@
 &ssi4 {
 	shared-pin;
 };
+
+&usbphy {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
-- 
2.17.1


--23DPLOotLnuOwmEI2N1k
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5849): https://lists.cip-project.org/g/cip-dev/message=
/5849
Mute This Topic: https://lists.cip-project.org/mt/78481731/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--23DPLOotLnuOwmEI2N1k--
