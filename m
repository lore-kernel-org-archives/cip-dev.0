Return-Path: <SRS0=xc6M=EI=lists.cip-project.org=bounce+64572+5705+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A82FC388F2
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84A921D91
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rwFDuR2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84A921D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5705+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 22gOYY4521723xz0JDuPzR0g; Mon, 02 Nov 2020 01:24:51 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.28759.1604309087918325827
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2020 01:24:51 -0800
X-IronPort-AV: E=Sophos;i="5.77,444,1596466800"; 
   d="scan'208";a="61463280"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Nov 2020 18:24:50 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BAB384005E2A;
	Mon,  2 Nov 2020 18:24:49 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 4/6] arm64: dts: renesas: r8a774e1: Add PCIe EP nodes
Date: Mon,  2 Nov 2020 09:24:41 +0000
Message-Id: <20201102092443.4142-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DMSncNKXYWYzuk6WCuVrY5FOx4520388AA=
Content-Type: multipart/mixed; boundary="RwK3Rd7oPDb9nFNvDFl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604309091;
 bh=j0xYKk9/STf74LLzGudthH8h4kKBKC5nKXInqRhhqOY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rwFDuR2dYtFUOa0c+H/1TARQgC4znetIegczRi5+Jja39o8CYIY9Ug1yleBSUcL06FM
 y6ABx2OUCfJsLJ4wovpuS4hVQHDrPVUm2M3IfQkb+mFq8P2VgDdxT2/i9O2v3PFSA4wK9
 yqEtdwaeDAloy5w801QHRPAe0D4dEEycOaI=

--RwK3Rd7oPDb9nFNvDFl2

commit b7ecb51b2d9bd12c80c24d2fd1cadedd35e7cb7e upstream.

Add PCIe EP nodes for R8A774E1 Soc dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20200904103851.3946-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 832abe712e6c..8e9292d46cc4 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -1582,6 +1582,44 @@
 			status = "disabled";
 		};
 
+		pciec0_ep: pcie-ep@fe000000 {
+			compatible = "renesas,r8a774e1-pcie-ep",
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
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pciec1_ep: pcie-ep@ee800000 {
+			compatible = "renesas,r8a774e1-pcie-ep",
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
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		hdmi0: hdmi@fead0000 {
 			reg = <0 0xfead0000 0 0x10000>;
 			status = "disabled";
-- 
2.17.1


--RwK3Rd7oPDb9nFNvDFl2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5705): https://lists.cip-project.org/g/cip-dev/message=
/5705
Mute This Topic: https://lists.cip-project.org/mt/77977473/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RwK3Rd7oPDb9nFNvDFl2--
