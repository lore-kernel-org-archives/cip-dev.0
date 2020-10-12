Return-Path: <SRS0=WNIR=DT=lists.cip-project.org=bounce+64572+5564+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231D5C433E7
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38FC20838
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Y0D6x7hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38FC20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5564+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IryqYY4521723xWMVVvMmc62; Mon, 12 Oct 2020 07:21:20 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.42187.1602512428927900524
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:42 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351979"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:41 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B671841D31C7;
	Mon, 12 Oct 2020 23:20:40 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 44/50] arm64: dts: renesas: r8a774c0: Add PCIe EP node
Date: Mon, 12 Oct 2020 15:19:27 +0100
Message-Id: <20201012141933.9652-45-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HoV8tyZ8CBRVNdjRBhCkcuPfx4520388AA=
Content-Type: multipart/mixed; boundary="bTFU0tQfjoNkzzM6BjDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512480;
 bh=swi/Ug1K3gF6QXQyO+99et98diuA7xts+YoUCw9PlBg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Y0D6x7hbjx1xWc80d2SVms1mvQYa0vSRGup7DEcOqRPEiNqhp8z8Ti4uCK3ECHTu7xI
 d/zGFG/totWmL86riO5V/CNHdsqFwJakf49BK0c9A6GB474Qbigqp2UnUoq1ST3xVl7lu
 xlWHH4OFLbi3jaeT+Af29yPde0ah9DkUc1Y=

--bTFU0tQfjoNkzzM6BjDY

commit 0c77ecdcfcd35e97c677e49a8516a0b10c1e8fb7 upstream.

Add PCIe EP node to R8A774C0 (RZ/G2E) SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20200814173037.17822-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 7ba934c32696..44d66fcb412d 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1698,6 +1698,25 @@
 			status = "disabled";
 		};
 
+		pciec0_ep: pcie-ep@fe000000 {
+			compatible = "renesas,r8a774c0-pcie-ep",
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
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		vspb0: vsp@fe960000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfe960000 0 0x8000>;
-- 
2.17.1


--bTFU0tQfjoNkzzM6BjDY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5564): https://lists.cip-project.org/g/cip-dev/message=
/5564
Mute This Topic: https://lists.cip-project.org/mt/77461729/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bTFU0tQfjoNkzzM6BjDY--
