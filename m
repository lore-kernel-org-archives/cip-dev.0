Return-Path: <SRS0=1jOn=FA=lists.cip-project.org=bounce+64572+5883+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CF7C56202
	for <cip-dev@archiver.kernel.org>; Thu, 26 Nov 2020 11:37:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5218920658
	for <cip-dev@archiver.kernel.org>; Thu, 26 Nov 2020 11:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nPrIgRsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5218920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5883+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wbIYYY4521723xyt0nXTTeEs; Thu, 26 Nov 2020 03:37:19 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.3801.1606390638134602267
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2020 03:37:18 -0800
X-IronPort-AV: E=Sophos;i="5.78,371,1599490800"; 
   d="scan'208";a="63980183"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Nov 2020 20:37:13 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1F5704361483;
	Thu, 26 Nov 2020 20:37:11 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip] arm64: dts: renesas: r8a774c0: Fix MSIOF1 DMA channels
Date: Thu, 26 Nov 2020 11:37:11 +0000
Message-Id: <20201126113711.5176-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Eda6IsJniWho5oLg1TByFfiDx4520388AA=
Content-Type: multipart/mixed; boundary="KiS5WsY3YSujZhrQtCf5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606390639;
 bh=0Qdt1bBArZXLawE72Xkc0qZs/UflVzsc74L4ox8B2gU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nPrIgRsQicqGm5+Gc0xVIYOvGG0PI1lhJfdxNiz36/xbc3st1XqZZw5F4nvZYdrOTJT
 B6/2nNSdLP/lo7YvVFNmgvbsl+xjs0REx1FusxhzxNUBRSbs1f4s/psd92xCQvx4/+GpU
 EZacAr4wUQKzU0jKJNvWSTUJiQQMjPK7mew=

--KiS5WsY3YSujZhrQtCf5

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c91dfc9818df5f43c10c727f1cecaebdb5e2fa92 upstream.

According to Technical Update TN-RCT-S0352A/E, MSIOF1 DMA can only be
used with SYS-DMAC0 on R-Car E3.

Fixes: 62c0056f1c3eb15d ("arm64: dts: renesas: r8a774c0: Add MSIOF nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200917132117.8515-3-geert+renesas@glider.be
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Patch has been cherry picked from v5.10-rc5.
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 44d66fcb412d..4785c486b336 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1214,9 +1214,8 @@
 			reg = <0 0xe6ea0000 0 0x0064>;
 			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 210>;
-			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
-			       <&dmac2 0x43>, <&dmac2 0x42>;
-			dma-names = "tx", "rx", "tx", "rx";
+			dmas = <&dmac0 0x43>, <&dmac0 0x42>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 210>;
 			#address-cells = <1>;
-- 
2.17.1


--KiS5WsY3YSujZhrQtCf5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5883): https://lists.cip-project.org/g/cip-dev/message=
/5883
Mute This Topic: https://lists.cip-project.org/mt/78527519/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KiS5WsY3YSujZhrQtCf5--
