Return-Path: <SRS0=SJoV=E6=lists.cip-project.org=bounce+64572+5847+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7705FC64E7C
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DC320857
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Vt3Lm6sY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DC320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5847+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aF1dYY4521723xO4RoOZVBFG; Tue, 24 Nov 2020 09:11:36 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.15.1606237784446827976
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:09:48 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63522783"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Nov 2020 02:09:47 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1C6F540AC3B2;
	Wed, 25 Nov 2020 02:09:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 7/9] ARM: dts: r8a7742: Add XHCI support
Date: Tue, 24 Nov 2020 17:09:30 +0000
Message-Id: <20201124170932.13588-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WlNeG5VvRHtuLj2t0bOpbFL8x4520388AA=
Content-Type: multipart/mixed; boundary="iztTBNwPnKgFjWa0YnA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606237896;
 bh=VJL/X7doULzGznbE9gnFc66l76hw6pWqBql/o9ovt3Y=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Vt3Lm6sYwfuFtVpKD8m5yYm0W7M7LwI8ZHWBGBrHg2NlpBBB7WiDfz+2OdgJiKyIEnW
 PYqvq5niL9rJjQ5O3MNxdP7vlYuON9p+TpEJCcwVSwGO/GqLr2kBsCbvl075Ytf3/Aftp
 j+kUIJu55793ExJQihQ6NMEBlgT/se+q3+A=

--iztTBNwPnKgFjWa0YnA0

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ab586be87ed2cc94701b1ae70956ae1fad6ae992 upstream.

Add XHCI support to R8A7742 SoC DT.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1590356277-19993-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domain properties, removed resets property]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 5c516e17ca54..0da46a2edddd 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -1612,6 +1612,18 @@
 			dma-channels = <13>;
 		};
 
+		xhci: usb@ee000000 {
+			compatible = "renesas,xhci-r8a7742",
+				     "renesas,rcar-gen2-xhci";
+			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_SSUSB>;
+			power-domains = <&cpg_clocks>;
+			phys = <&usb2 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		pci0: pci@ee090000 {
 			compatible = "renesas,pci-r8a7742",
 				     "renesas,pci-rcar-gen2";
-- 
2.17.1


--iztTBNwPnKgFjWa0YnA0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5847): https://lists.cip-project.org/g/cip-dev/message=
/5847
Mute This Topic: https://lists.cip-project.org/mt/78481729/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iztTBNwPnKgFjWa0YnA0--
