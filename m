Return-Path: <SRS0=JYME=DT=lists.cip-project.org=bounce+64572+5566+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB1EC43457
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664252087E
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="U2aoosqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664252087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5566+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id x1jZYY4521723x66Ds60UALZ; Mon, 12 Oct 2020 07:21:21 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.42187.1602512428927900524
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:45 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351982"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:44 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B0CFA41D31C7;
	Mon, 12 Oct 2020 23:20:43 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 46/50] arm64: dts: renesas: r8a774b1: Add PCIe EP nodes
Date: Mon, 12 Oct 2020 15:19:29 +0100
Message-Id: <20201012141933.9652-47-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: F1IsJ0xqdveIciuinXgTKXG9x4520388AA=
Content-Type: multipart/mixed; boundary="WRegqm3YZHoGYQNHOUpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512481;
 bh=QyL5p4sJwl1tP1/iY/ebPV7Gs1oqgw0rPIRclCuGcYg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=U2aoosqABy6TosMgdV5kOz6GOLLc6COg2GDoIgsZlTndnNSfEFnlaVhoRSxDHu8VA3K
 Qrv9A0pPSXjO2s9igT/Et+zV9wxQtJ3UMBiCC+lRqMTmwDK8ZVUgMOnx7Yzy/xck5A+Ok
 aVg9uz3C7zqvfCdfsnKPjWBHiKF8if8P1Ag=

--WRegqm3YZHoGYQNHOUpX

commit d12d16205f7993da195002eea24b7467deb9ac8c upstream.

Add PCIe EP nodes to R8A774B1 (RZ/G2N) SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20200814173037.17822-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 62d011107cc5..b48bf2aed612 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -1973,6 +1973,44 @@
 			status = "disabled";
 		};
 
+		pciec0_ep: pcie-ep@fe000000 {
+			compatible = "renesas,r8a774b1-pcie-ep",
+				     "renesas,rcar-gen3-pcie-ep";
+			reg = <0x0 0xfe000000 0 0x80000>,
+			      <0x0 0xfe100000 0 0x100000>,
+			      <0x0 0xfe200000 0 0x200000>,
+			      <0x0 0x30000000 0 0x8000000>,
+			      <0x0 0x38000000 0 0x8000000>;
+			reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 319>;
+			clock-names = "pcie";
+			resets = <&cpg 319>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pciec1_ep: pcie-ep@ee800000 {
+			compatible = "renesas,r8a774b1-pcie-ep",
+				     "renesas,rcar-gen3-pcie-ep";
+			reg = <0x0 0xee800000 0 0x80000>,
+			      <0x0 0xee900000 0 0x100000>,
+			      <0x0 0xeea00000 0 0x200000>,
+			      <0x0 0xc0000000 0 0x8000000>,
+			      <0x0 0xc8000000 0 0x8000000>;
+			reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 318>;
+			clock-names = "pcie";
+			resets = <&cpg 318>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		fdp1@fe940000 {
 			compatible = "renesas,fdp1";
 			reg = <0 0xfe940000 0 0x2400>;
-- 
2.17.1


--WRegqm3YZHoGYQNHOUpX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5566): https://lists.cip-project.org/g/cip-dev/message=
/5566
Mute This Topic: https://lists.cip-project.org/mt/77461732/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WRegqm3YZHoGYQNHOUpX--
