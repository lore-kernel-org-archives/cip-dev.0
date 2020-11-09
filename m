Return-Path: <SRS0=Do9w=EP=lists.cip-project.org=bounce+64572+5783+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE79C4741F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BF4206C0
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qIQ1w7AG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BF4206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5783+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id G2kIYY4521723xplKUXjrCGr; Mon, 09 Nov 2020 07:50:32 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.13504.1604937019730124247
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:32 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="61913729"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:31 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F30A340078A1;
	Tue, 10 Nov 2020 00:50:30 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 14/14] ARM: dts: r8a7742: Add IPMMU DT nodes
Date: Mon,  9 Nov 2020 15:50:11 +0000
Message-Id: <20201109155011.10291-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3PcazEJvaPocmsbBFvtW553Dx4520388AA=
Content-Type: multipart/mixed; boundary="7F9fww20UmPEy26hEKf8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937032;
 bh=Td7Qh0G9GpjNDRzG4ATFn8ETqrpgAgK2gI5b3rwHiiA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qIQ1w7AGpP1fhBSKnUnZT8yagos7pMRBthZFUhyQ1mdMahBw3MceIjzKnRC7VLm0wO2
 w3oXMUUe1WqaCK0Ew7Px/CQtd022GdgKQgaRO03VTVa0AEtngrLfTHWy+O2oNB/pitXt7
 0rP3UR2esEiwtTKs16I/l25D37Hxz0EzWk0=

--7F9fww20UmPEy26hEKf8

commit 78aa219022f636f2adda9eb12be0a04b6907a4e0 upstream.

Add the five IPMMU instances found in the r8a7742 to DT with a disabled
status.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200825141805.27105-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
[PL: Dropped SoC specific compatible string]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index af6888521595..d326602bee3f 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -782,6 +782,49 @@
 			#thermal-sensor-cells = <0>;
 		};
 
+		ipmmu_sy0: iommu@e6280000 {
+			compatible = "renesas,ipmmu-vmsa";
+			reg = <0 0xe6280000 0 0x1000>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_sy1: iommu@e6290000 {
+			compatible = "renesas,ipmmu-vmsa";
+			reg = <0 0xe6290000 0 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_ds: iommu@e6740000 {
+			compatible = "renesas,ipmmu-vmsa";
+			reg = <0 0xe6740000 0 0x1000>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mp: iommu@ec680000 {
+			compatible = "renesas,ipmmu-vmsa";
+			reg = <0 0xec680000 0 0x1000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mx: iommu@fe951000 {
+			compatible = "renesas,ipmmu-vmsa";
+			reg = <0 0xfe951000 0 0x1000>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
 		icram0: sram@e63a0000 {
 			compatible = "mmio-sram";
 			reg = <0 0xe63a0000 0 0x12000>;
-- 
2.17.1


--7F9fww20UmPEy26hEKf8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5783): https://lists.cip-project.org/g/cip-dev/message=
/5783
Mute This Topic: https://lists.cip-project.org/mt/78138441/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7F9fww20UmPEy26hEKf8--
