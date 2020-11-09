Return-Path: <SRS0=E83U=EP=lists.cip-project.org=bounce+64572+5782+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D797C63697
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36F22083B
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KweBLNO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36F22083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5782+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vlwmYY4521723xu5hdmIScqt; Mon, 09 Nov 2020 07:50:31 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.13504.1604937015956466828
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:31 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="62129291"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:30 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A994940065C9;
	Tue, 10 Nov 2020 00:50:29 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 13/14] ARM: dts: r8a7742-iwg21d-q7-dbcm-ca: Add can0 support to camera DB
Date: Mon,  9 Nov 2020 15:50:10 +0000
Message-Id: <20201109155011.10291-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DkvevyexCcVXg48zJYXH5Ht5x4520388AA=
Content-Type: multipart/mixed; boundary="7gokovmff3lppUZPTUbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937031;
 bh=QPwBYdWhFpR5PWGbA0O8UG7pgg6+A49LpmZQqeLUooM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KweBLNO64IRNYeakUytbjwtPwVDsL1ulQwceNWt4Uh9v/9x0ufloiL3Cm5PTz0btXiB
 1/6Ezy2GhEE2fFZKf8t9mqsTWCvCdtdDsRytgGgQ8lzjVvsged18ZNDsRq+2FWFd14cLv
 bZ8EK0GT+FczZzr8sR5ncVubUeMlp0wzINc=

--7gokovmff3lppUZPTUbd

commit 9d8827b27b758ecb4fda3da812c77c316b3a5548 upstream.

This patch enables CAN0 interface exposed through connector J4 on the
camera DB.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200911083615.17377-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
index 951820dfdf1c..629fa0819111 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
@@ -26,6 +26,12 @@
 	status = "disabled";
 };
 
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &ether {
 	pinctrl-0 = <&ether_pins>;
 	pinctrl-names = "default";
@@ -48,6 +54,11 @@
 };
 
 &pfc {
+	can0_pins: can0 {
+		groups = "can0_data_d";
+		function = "can0";
+	};
+
 	ether_pins: ether {
 		groups = "eth_mdio", "eth_rmii";
 		function = "eth";
-- 
2.17.1


--7gokovmff3lppUZPTUbd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5782): https://lists.cip-project.org/g/cip-dev/message=
/5782
Mute This Topic: https://lists.cip-project.org/mt/78138440/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7gokovmff3lppUZPTUbd--
