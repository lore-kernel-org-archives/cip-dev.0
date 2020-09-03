Return-Path: <SRS0=NdqB=CM=lists.cip-project.org=bounce+64572+5399+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DFDC43461
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AAE206EF
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ug/mbZQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AAE206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5399+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iGwfYY4521723x9oGfgLa16u; Thu, 03 Sep 2020 07:43:12 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.15614.1599144191300536595
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:43:11 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56081316"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 23:43:10 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C56B142D18DA;
	Thu,  3 Sep 2020 23:43:09 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 4/6] ARM: dts: r8a7742: Drop undocumented compatible string from scifa2 node
Date: Thu,  3 Sep 2020 15:43:01 +0100
Message-Id: <20200903144303.13275-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: C7LVEh4hhNZmLE9in2wAKJ2Xx4520388AA=
Content-Type: multipart/mixed; boundary="w1eiK8qrBoceIIjnKqgY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599144192;
 bh=lfr/tfvrMGnwPvWGy40QyV8FQxsPkUo3/3CeFTP8ZPY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ug/mbZQ1bUNtR37Lxxum1ET9zYC0qtKoMCv82Sj8jmfvuaRAB/TC+lEs1QyUT9opZWb
 kTyrhoqYbSFp9XbgD4+igxYzq7o32k5CWRIwSFCZpbgNnBL7hoBxJ/B6ZGA9mZ1nVWGkg
 aUgBP0RdiX0b5TFm8z6LxU67LtQTMTElVsU=

--w1eiK8qrBoceIIjnKqgY

"renesas,rcar-gen2-scifa" compatible string was accidentally added as
per upstream commit, fix this by dropping this string.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 2ebeccbda558..cc452e243446 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -963,7 +963,7 @@
 
 		scifa2: serial@e6c60000 {
 			compatible = "renesas,scifa-r8a7742",
-				     "renesas,rcar-gen2-scifa", "renesas,scifa";
+				     "renesas,scifa";
 			reg = <0 0xe6c60000 0 0x40>;
 			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp2_clks R8A7742_CLK_SCIFA2>;
-- 
2.17.1


--w1eiK8qrBoceIIjnKqgY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5399): https://lists.cip-project.org/g/cip-dev/message=
/5399
Mute This Topic: https://lists.cip-project.org/mt/76608371/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--w1eiK8qrBoceIIjnKqgY--
