Return-Path: <SRS0=XUCh=BI=lists.cip-project.org=bounce+64572+5045+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1498C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 11:06:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112C72065E
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 11:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lJfMTlXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112C72065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5045+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kwgXYY4521723xRnSb3dGHEZ; Wed, 29 Jul 2020 04:06:52 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.3467.1596020186075330577
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 03:56:26 -0700
X-IronPort-AV: E=Sophos;i="5.75,410,1589209200"; 
   d="scan'208";a="53136167"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Jul 2020 19:56:23 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.182])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 753464004D12;
	Wed, 29 Jul 2020 19:56:22 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Date: Wed, 29 Jul 2020 11:56:21 +0100
Message-Id: <20200729105621.8242-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ptacxq7EKw9HG5nJvJypwDXMx4520388AA=
Content-Type: multipart/mixed; boundary="qEXC0eznvcEzXAm6ACdI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596020812;
 bh=67KNez7APiozHpn1couD/6j6+pp/IIc40WNJ2VvAQFY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lJfMTlXmdcYztX6HL4HtSkmKdyr1ilY2IVrhimA7O+Q5ZjjviaTwbFn1dCFb750+In1
 jjb2loVt8/kHdYBnOBLyMwnx1G+4tl8vqdfBPXFpLV2syOHU0LcSxR1gTELZRnS7rGF+E
 qmP4az7BytTdW++UCufXl82frHYnmMROeYQ=

--qEXC0eznvcEzXAm6ACdI

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 99ae78f1fc3a73c88fe726c676ae963ce722bf20 upstream.

In one of the iWave-G22D development board variants, called Generic SODIMM
Development Platform, we have an LCD with touchscreen. The resistive touch
controller, STMPE811 is on the development board and is connected through
the i2c5 of the RZ-G1E.

Additionally, this controller should generate an interrupt to the CPU and
it is connected through GPIO4,4 to the GIC.

Touch was tested with one of our iW-RainboW-G22D-SODIMM RZ/G1E development
platforms.

More details on the iWave website:
https://www.iwavesystems.com/rz-g1e-sodimm-development-kit.html

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1583336650-25848-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index 1e331d1e414b..5cd989556b60 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -149,6 +149,39 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
+	stmpe811@44 {
+		compatible = "st,stmpe811";
+		reg = <0x44>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+
+		/* 3.25 MHz ADC clock speed */
+		st,adc-freq = <1>;
+		/* ADC converstion time: 80 clocks */
+		st,sample-time = <4>;
+		/* 12-bit ADC */
+		st,mod-12b = <1>;
+		/* internal ADC reference */
+		st,ref-sel = <0>;
+
+		stmpe_touchscreen {
+			compatible = "st,stmpe-ts";
+			/* 8 sample average control */
+			st,ave-ctrl = <3>;
+			/* 7 length fractional part in z */
+			st,fraction-z = <7>;
+			/*
+			 * 50 mA typical 80 mA max touchscreen drivers
+			 * current limit value
+			 */
+			st,i-drive = <1>;
+			/* 1 ms panel driver settling time */
+			st,settling = <3>;
+			/* 5 ms touch detect interrupt delay */
+			st,touch-det-delay = <5>;
+		};
+	};
+
 	sgtl5000: codec@a {
 		compatible = "fsl,sgtl5000";
 		#sound-dai-cells = <0>;
-- 
2.17.1


--qEXC0eznvcEzXAm6ACdI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5045): https://lists.cip-project.org/g/cip-dev/message=
/5045
Mute This Topic: https://lists.cip-project.org/mt/75862490/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--qEXC0eznvcEzXAm6ACdI--
