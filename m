Return-Path: <SRS0=G3h9=EP=lists.cip-project.org=bounce+64572+5773+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74851C2D0A3
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C261A206C0
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="xKJnwSsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C261A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5773+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6XKJYY4521723xEuBktYpqlq; Mon, 09 Nov 2020 07:50:20 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.13504.1604937019730124247
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:20 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="61913706"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:18 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F374340065C9;
	Tue, 10 Nov 2020 00:50:17 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 04/14] ARM: dts: r8a7742: Add QSPI support
Date: Mon,  9 Nov 2020 15:50:01 +0000
Message-Id: <20201109155011.10291-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xNA38C4jnmxH95tOr7MqC08mx4520388AA=
Content-Type: multipart/mixed; boundary="JzT3LJ4Lw5nXpiIMoBRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937020;
 bh=N5A3iuCCo8H12OllmZaL4VbheaMIUnUyaSpk2ojpmhU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=xKJnwSsl1xCo/4A6WsTz4mDp4C8h5vZ4NdF007uDf8ubiA6gu7GZO3F5fPXP0M7Nyo3
 EvZJjqzUkmUpWl97QBFCKljOr0zs8GTiUVD4B/QHCwEZwOIK1DyKoaGgf4O+rBhjRuvu9
 UBNJN3GnHiGd9nwU9iZx/Zs7/yAmdh3HI+0=

--JzT3LJ4Lw5nXpiIMoBRD

commit afdac0bfbd49e46f7046c7f4bad6daa4a3ebf6fc upstream.

Add QSPI DT node to R8A7742 SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200812150048.27721-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: changed clocks and power-domain properties, removed resets property]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index eff54f7ed812..a8ce139e9fc5 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -989,6 +989,21 @@
 			status = "disabled";
 		};
 
+		qspi: spi@e6b10000 {
+			compatible = "renesas,qspi-r8a7742", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7742_CLK_QSPI_MOD>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		scifa0: serial@e6c40000 {
 			compatible = "renesas,scifa-r8a7742",
 				     "renesas,scifa";
-- 
2.17.1


--JzT3LJ4Lw5nXpiIMoBRD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5773): https://lists.cip-project.org/g/cip-dev/message=
/5773
Mute This Topic: https://lists.cip-project.org/mt/78138430/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--JzT3LJ4Lw5nXpiIMoBRD--
