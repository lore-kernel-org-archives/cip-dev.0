Return-Path: <SRS0=mnox=CL=lists.cip-project.org=bounce+64572+5366+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B505C433E7
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 12:46:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1F0207D3
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 12:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="l/8CY/cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1F0207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5366+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TbdOYY4521723xOgMXwrRGQK; Wed, 02 Sep 2020 05:46:06 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.2368.1599033042858896831
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 00:50:44 -0700
X-IronPort-AV: E=Sophos;i="5.76,381,1592838000"; 
   d="scan'208";a="56163765"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2020 16:50:43 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7040A4004BA7;
	Wed,  2 Sep 2020 16:50:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 3/5] ARM: dts: r8a7742: Add MMC0 node
Date: Wed,  2 Sep 2020 08:50:33 +0100
Message-Id: <20200902075035.4445-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
References: <20200902075035.4445-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: J3Ko7sIQGWlIypJ6QXN9RQFmx4520388AA=
Content-Type: multipart/mixed; boundary="Us58z6bUaX3dQnbTqR7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599050766;
 bh=tkhhApdA1xGoV81CrzBvAc7D7QnxSbXU+BKKSjNwoUc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=l/8CY/csv1RShCSko7+qVJ+bh2hck13gNYPJCWuSdxD4BbKAYReWWVSvmnqy4G6Nh+U
 qpak1rZtyaVcPlxXoeAAyhN03cC3V4IWbFSGsMaQA4bIV7I+Geua5MKU7zdX+6ShRMCTz
 eiN3LjJwLCyFsJ15WaLeQTWkmgbauRVGS7s=

--Us58z6bUaX3dQnbTqR7L

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9493c8c34cb4b683917a0d2e82cc5df859b1e5a4 upstream.

Describe MMC0 device node in the R8A7742 device tree.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1589555337-5498-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domains properties, removed resets property]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 70dcd59b36ca..f4d571b4a4db 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -1011,6 +1011,21 @@
 			status = "disabled";
 		};
 
+		mmcif0: mmc@ee200000 {
+			compatible = "renesas,mmcif-r8a7742",
+				     "renesas,sh-mmcif";
+			reg = <0 0xee200000 0 0x80>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_MMCIF0>;
+			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			reg-io-width = <4>;
+			status = "disabled";
+			max-frequency = <97500000>;
+		};
+
 		mmcif1: mmc@ee220000 {
 			compatible = "renesas,mmcif-r8a7742",
 				     "renesas,sh-mmcif";
-- 
2.17.1


--Us58z6bUaX3dQnbTqR7L
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5366): https://lists.cip-project.org/g/cip-dev/message=
/5366
Mute This Topic: https://lists.cip-project.org/mt/76581047/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Us58z6bUaX3dQnbTqR7L--
