Return-Path: <SRS0=9uGG=CL=lists.cip-project.org=bounce+64572+5365+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890D3C2BC0E
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 12:46:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9EBC207D3
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 12:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Uw3BuYmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EBC207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5365+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id f36aYY4521723xhQqwcUoobq; Wed, 02 Sep 2020 05:46:08 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.2368.1599033042858896831
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 00:50:43 -0700
X-IronPort-AV: E=Sophos;i="5.76,381,1592838000"; 
   d="scan'208";a="56163762"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2020 16:50:42 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 968994004BA7;
	Wed,  2 Sep 2020 16:50:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 2/5] ARM: dts: r8a7742: Add SDHI nodes
Date: Wed,  2 Sep 2020 08:50:32 +0100
Message-Id: <20200902075035.4445-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
References: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LZ3EbM9pkUlT3LZeP0amc7zAx4520388AA=
Content-Type: multipart/mixed; boundary="IzrQp0T7M5pLwrhpRQAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599050768;
 bh=zacsoknfsUZlAQl9j262qppi3OgRzq5Lx9rAx0T3YGk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Uw3BuYmKNxrA5Lw29+7oDEoV5T6LhxJE5vVcDqwx8PQcFjAeNz8waI9zBO46feLysqJ
 x0tWrGYe9/s0MjJnzYJgV7gkSnLuoqEQTi6YXuRWqifkw8aM5GAyanLS8rGt1jtD3R/VQ
 7OJDDC4xJOh6xmPRFHmf/70JoYU4UogEdFk=

--IzrQp0T7M5pLwrhpRQAt

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3ab2ea5fd1ce3c61d67d7b737c361bec2ec6441f upstream.

Add the SDHI device nodes to the R8A7742 device tree.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1589555337-5498-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domains properties, removed resets property]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 56 ++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 1db3682a1deb..70dcd59b36ca 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -955,6 +955,62 @@
 			status = "disabled";
 		};
 
+		sdhi0: sd@ee100000 {
+			compatible = "renesas,sdhi-r8a7742",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_SDHI0>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <195000000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		sdhi1: sd@ee120000 {
+			compatible = "renesas,sdhi-r8a7742",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee120000 0 0x328>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_SDHI1>;
+			dmas = <&dmac0 0xc9>, <&dmac0 0xca>,
+			       <&dmac1 0xc9>, <&dmac1 0xca>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <195000000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		sdhi2: sd@ee140000 {
+			compatible = "renesas,sdhi-r8a7742",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee140000 0 0x100>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_SDHI2>;
+			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+			       <&dmac1 0xc1>, <&dmac1 0xc2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		sdhi3: sd@ee160000 {
+			compatible = "renesas,sdhi-r8a7742",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee160000 0 0x100>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_SDHI3>;
+			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+			       <&dmac1 0xd3>, <&dmac1 0xd4>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		mmcif1: mmc@ee220000 {
 			compatible = "renesas,mmcif-r8a7742",
 				     "renesas,sh-mmcif";
-- 
2.17.1


--IzrQp0T7M5pLwrhpRQAt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5365): https://lists.cip-project.org/g/cip-dev/message=
/5365
Mute This Topic: https://lists.cip-project.org/mt/76581046/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--IzrQp0T7M5pLwrhpRQAt--
