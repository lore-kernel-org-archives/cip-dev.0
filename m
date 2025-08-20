Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF25CA0EFE
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.15483.1755679656199304806
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: LEuGosgaSRmFA09RPG61AQ==
X-CSE-MsgGUID: GLw4xcV6RFmInOFzzQOZgQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3DC3240138ED;
	Wed, 20 Aug 2025 17:47:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 21/23] arm64: dts: renesas: r9a09g047: Add SYS node
Date: Wed, 20 Aug 2025 09:46:07 +0100
Message-ID: <20250820084645.6988-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19816

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit 13e9b03263dcdc760aa65c4298271746b180f113 upstream.

Add a node for the System Controller to the RZ/G3E (R9A09G047) SoC DTSI,
as it is also required for SoC identification.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250123170508.13578-9-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index bfdb03e69540b..876f70fed433f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -273,6 +273,13 @@ cpg: clock-controller@10420000 {
 			#power-domain-cells = <0>;
 		};
 
+		sys: system-controller@10430000 {
+			compatible = "renesas,r9a09g047-sys";
+			reg = <0 0x10430000 0 0x10000>;
+			clocks = <&cpg CPG_CORE R9A09G047_SYS_0_PCLK>;
+			resets = <&cpg 0x30>;
+		};
+
 		scif0: serial@11c01400 {
 			compatible = "renesas,scif-r9a09g047", "renesas,scif-r9a09g057";
 			reg = <0 0x11c01400 0 0x400>;
-- 
2.43.0


