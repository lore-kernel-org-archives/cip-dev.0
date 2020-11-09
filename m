Return-Path: <SRS0=mI8I=EP=lists.cip-project.org=bounce+64572+5770+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A89C388F7
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003E22074F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="k2uWfdeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003E22074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5770+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id f5JQYY4521723x3TxTBKgU0a; Mon, 09 Nov 2020 07:50:17 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.13318.1604937016394322645
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:16 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="62129266"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:15 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 14A6840065C9;
	Tue, 10 Nov 2020 00:50:13 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 01/14] ARM: dts: r8a7742-iwg21m: Sort the nodes alphabetically
Date: Mon,  9 Nov 2020 15:49:58 +0000
Message-Id: <20201109155011.10291-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4tWXwU8Ehydye435OQNdpAZMx4520388AA=
Content-Type: multipart/mixed; boundary="Ijb3QuujKzvERldObyeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937017;
 bh=+e+rzt4TvU2M8LS/Gj6XLh4cwV5eTPW7d0DuWsQ7ewc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=k2uWfdeOYNl9rbvhzHxAm13v+yM7pv+wBhf778h3REVwgZPpJrSGLibvwBvTDNCawGn
 ljjYXphLnAG038rIm6H/+odvaewtCJXobz2kOdcn3T1wWfWwj8AmWR1s23rqUV1XIiVHJ
 HtdLJCzf+cKeTCUniDg+m12tAWdN5Z4l8kw=

--Ijb3QuujKzvERldObyeV

commit be571bec2cfdb7aaa096d547aa8a1559a0c0cc90 upstream.

Sort the DT nodes alphabetically so that its easier to maintain.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200816193316.7641-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
index 85aff429d408..6e8df79bea94 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
+++ b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
@@ -35,13 +35,6 @@
 	clock-frequency = <20000000>;
 };
 
-&pfc {
-	mmc1_pins: mmc1 {
-		groups = "mmc1_data4", "mmc1_ctrl";
-		function = "mmc1";
-	};
-};
-
 &mmcif1 {
 	pinctrl-0 = <&mmc1_pins>;
 	pinctrl-names = "default";
@@ -51,3 +44,10 @@
 	non-removable;
 	status = "okay";
 };
+
+&pfc {
+	mmc1_pins: mmc1 {
+		groups = "mmc1_data4", "mmc1_ctrl";
+		function = "mmc1";
+	};
+};
-- 
2.17.1


--Ijb3QuujKzvERldObyeV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5770): https://lists.cip-project.org/g/cip-dev/message=
/5770
Mute This Topic: https://lists.cip-project.org/mt/78138425/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Ijb3QuujKzvERldObyeV--
