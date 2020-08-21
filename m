Return-Path: <SRS0=rvjO=B7=lists.cip-project.org=bounce+64572+5215+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C274C433E3
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976F9207C3
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TNGqHy6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976F9207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5215+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9xu0YY4521723xzU2ADOHI8Q; Fri, 21 Aug 2020 07:17:58 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.135294.1598019426613685109
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 07:17:11 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54969233"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 23:17:10 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 163A0400752E;
	Fri, 21 Aug 2020 23:17:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 3/7] arm64: dts: renesas: r8a774e1: Add IPMMU device nodes
Date: Fri, 21 Aug 2020 15:16:58 +0100
Message-Id: <20200821141702.3977-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
References: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jRLilKVgElovCIeNmg8NpHwTx4520388AA=
Content-Type: multipart/mixed; boundary="ODiEshsYM7mZGZVgwqAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598019478;
 bh=syswOgsK17rLJ4rBBM5y4tQlRauN/6gh43drTHltGpI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TNGqHy6yJwEbtVAEhAt9GyhrZbLY6EFADD8DbT09I2nb+d2/i/eIHhuplb0AdoFPPZs
 aDcHplwoQVzqSJc8GLBfdjhhLwSBzHi6qqk0WQt2bVyJmQj9sf9ZV6/LesDX2MrHJvg0+
 TWXJ9CkGacDhGehp0WuPuvu8mX4e8BKTlAU=

--ODiEshsYM7mZGZVgwqAW

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 615d1a9ebcfb90d5ddbfd887d42eda5dc8b03303 upstream.

Add RZ/G2H (R8A774E1) IPMMU nodes.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594676120-5862-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 121 ++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index eb7226e8e892..a50902c8173d 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -408,6 +408,127 @@
 			/* placeholder */
 		};
 
+		ipmmu_ds0: iommu@e6740000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xe6740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_ds1: iommu@e7740000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xe7740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 1>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_hc: iommu@e6570000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xe6570000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 2>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_mm: iommu@e67b0000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_mp0: iommu@ec670000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xec670000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 4>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv0: iommu@fd800000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfd800000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 6>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv1: iommu@fd950000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfd950000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 7>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv2: iommu@fd960000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfd960000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 8>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv3: iommu@fd970000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfd970000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 9>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vc0: iommu@fe6b0000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfe6b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 12>;
+			power-domains = <&sysc R8A774E1_PD_A3VC>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vc1: iommu@fe6f0000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfe6f0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 13>;
+			power-domains = <&sysc R8A774E1_PD_A3VC>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vi0: iommu@febd0000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfebd0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 14>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vi1: iommu@febe0000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfebe0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 15>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vp0: iommu@fe990000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfe990000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 16>;
+			power-domains = <&sysc R8A774E1_PD_A3VP>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vp1: iommu@fe980000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfe980000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 17>;
+			power-domains = <&sysc R8A774E1_PD_A3VP>;
+			#iommu-cells = <1>;
+		};
+
 		avb: ethernet@e6800000 {
 			reg = <0 0xe6800000 0 0x800>;
 			#address-cells = <1>;
-- 
2.17.1


--ODiEshsYM7mZGZVgwqAW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5215): https://lists.cip-project.org/g/cip-dev/message=
/5215
Mute This Topic: https://lists.cip-project.org/mt/76329798/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ODiEshsYM7mZGZVgwqAW--
