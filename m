Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F4BE7717D
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 18:02:53 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.108630.1733767370178735300
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Dec 2024 10:02:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: Isz2e82SQfCXqKRlc3Gddg==
X-CSE-MsgGUID: tK9AiH/xSCu5LmUAZHC/SQ==
X-IronPort-AV: E=Sophos;i="6.12,220,1728918000"; 
   d="scan'208";a="231326314"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Dec 2024 03:02:49 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.34])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 170F04005E0B;
	Tue, 10 Dec 2024 03:02:36 +0900 (JST)
From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg2l-smarc-som: Enable 4-bit tx support
Date: Mon,  9 Dec 2024 18:02:35 +0000
Message-ID: <20241209180235.20418-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Dec 2024 18:02:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17385

From: Biju Das <biju.das.jz@bp.renesas.com>

commit ce3adea16612a677dd50bdad6861f37f5dc878c3 upstream.

Enable 4-bit tx support for sbc node.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231108172232.259301-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index c1f290b53b56..e4d0ac6fe702 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -312,6 +312,7 @@ flash@0 {
 		m25p,fast-read;
 		spi-max-frequency = <50000000>;
 		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.43.0


