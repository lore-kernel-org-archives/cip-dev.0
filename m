Return-Path: <SRS0=1lXH=CM=lists.cip-project.org=bounce+64572+5398+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1469FC433E2
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A0A206EF
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OxU4nmwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A0A206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5398+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XM64YY4521723xoGSi0CcLHF; Thu, 03 Sep 2020 07:43:10 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.15543.1599144189993895350
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:43:10 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56081313"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 23:43:09 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7C7FE42697BA;
	Thu,  3 Sep 2020 23:43:08 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 3/6] ARM: dts: r8a7742: Add Ether support
Date: Thu,  3 Sep 2020 15:43:00 +0100
Message-Id: <20200903144303.13275-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: YAUZOlo4SonHpAmHoyvTIbnSx4520388AA=
Content-Type: multipart/mixed; boundary="lO47pdqFwiYSXwzl7W9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599144190;
 bh=ZS94Ewuz4p+UopSn6Gs6YfhFWbusWmC/zodvInqkcvQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=OxU4nmwHYClCY9rdHsoFtAeJLaGzJrzG6bR1RD0CKBo28yAYumure7Mutn5xHAh3BZ8
 fZxjwdHZ/ApY8JADbg75sgD8Zkm4BI81etHndZMIGryJWLQYxzHGQe27uvdrttYKEzv9U
 Jq370TOf2XHyCBlunCSuz9+696PQApQPl8Q=

--lO47pdqFwiYSXwzl7W9M

commit 8cbef867e1c56ce57b942b751a033585f70b0547 upstream.

Define the generic R8A7742 part of the Ether device node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1589555337-5498-14-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: changed clocks and power-domains properties, removed resets property,
     dropped renesas,rcar-gen2-ether]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 694b20354575..2ebeccbda558 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -1121,6 +1121,18 @@
 			max-frequency = <97500000>;
 		};
 
+		ether: ethernet@ee700000 {
+			compatible = "renesas,ether-r8a7742";
+			reg = <0 0xee700000 0 0x400>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R8A7742_CLK_ETHER>;
+			power-domains = <&cpg_clocks>;
+			phy-mode = "rmii";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@f1001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.17.1


--lO47pdqFwiYSXwzl7W9M
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5398): https://lists.cip-project.org/g/cip-dev/message=
/5398
Mute This Topic: https://lists.cip-project.org/mt/76608370/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--lO47pdqFwiYSXwzl7W9M--
