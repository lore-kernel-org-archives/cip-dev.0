Return-Path: <SRS0=WFP3=EP=lists.cip-project.org=bounce+64572+5781+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEDBC4741F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53D0206C0
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="C1f+dsHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53D0206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5781+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rfM0YY4521723xeNcQIgNaEA; Mon, 09 Nov 2020 07:50:30 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.13504.1604937019730124247
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:29 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="61913725"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:29 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6140340065C9;
	Tue, 10 Nov 2020 00:50:28 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 12/14] ARM: dts: r8a7742-iwg21d-q7: Add can1 support to carrier board
Date: Mon,  9 Nov 2020 15:50:09 +0000
Message-Id: <20201109155011.10291-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ttqQhWe0TYLq01sm2vrifIQPx4520388AA=
Content-Type: multipart/mixed; boundary="qP1rKj0ZsOK0e8ugcyOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937030;
 bh=kZEL4AOrnMwm4S+5JfBgdJkZdiNspq3CWLgbDPZZ9CU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=C1f+dsHaz8yc77e4oOpDC+oY3PVgftBxjAQPqjxfF9T6bfaaGyuckGjIq3ExrYW2W8M
 +TY71yd+dpTij+kQpR44wxQq8LpgD9up+mSWPAfVi3YDYd2W1YXDqCfrDwP3tnzmh2BK5
 aZ4nl1a7WOi5VQQSFs5QltKVxG0/t/lWpws=

--qP1rKj0ZsOK0e8ugcyOk

commit 68ee7720a01cf20e1de20a2e770b6568db18c253 upstream.

This patch enables CAN1 interface exposed through connector J20 on the
carrier board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200907155541.2011-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
index 728664e901fc..4adcf97ae7c4 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
@@ -130,10 +130,26 @@
 	};
 };
 
+&can1 {
+	pinctrl-0 = <&can1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &cmt0 {
 	status = "okay";
 };
 
+&gpio1 {
+	can-trx-en-gpio{
+		gpio-hog;
+		gpios = <28 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "can-trx-en-gpio";
+	};
+};
+
 &msiof0 {
 	pinctrl-0 = <&msiof0_pins>;
 	pinctrl-names = "default";
@@ -178,6 +194,11 @@
 		function = "avb";
 	};
 
+	can1_pins: can1 {
+		groups = "can1_data_b";
+		function = "can1";
+	};
+
 	i2c2_pins: i2c2 {
 		groups = "i2c2_b";
 		function = "i2c2";
-- 
2.17.1


--qP1rKj0ZsOK0e8ugcyOk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5781): https://lists.cip-project.org/g/cip-dev/message=
/5781
Mute This Topic: https://lists.cip-project.org/mt/78138439/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qP1rKj0ZsOK0e8ugcyOk--
