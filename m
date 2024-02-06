Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45021C4829D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:29:06 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.20191.1707222541337688931
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:29:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="193048832"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Feb 2024 21:29:00 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 563824005E16;
	Tue,  6 Feb 2024 21:28:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 40/44] riscv: dts: renesas: rzfive-smarc-som: Drop PHY interrupt support for ETH{0,1}
Date: Tue,  6 Feb 2024 12:27:30 +0000
Message-Id: <20240206122734.13477-41-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:29:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14823

commit 7dd48e96d0cda9af79a2fee85e9135b4781f9ee1 upstream.

IRQC support for RZ/Five is still missing so drop the interrupts and
interrupt-parent properties from the PHY nodes of ETH{0,1}.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230102222708.274369-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index 73941a5f844d9..d6f18754eb5d7 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -24,10 +24,20 @@ &dmac {
 
 &eth0 {
 	status = "disabled";
+
+	phy0: ethernet-phy@7 {
+		/delete-property/ interrupt-parent;
+		/delete-property/ interrupts;
+	};
 };
 
 &eth1 {
 	status = "disabled";
+
+	phy1: ethernet-phy@7 {
+		/delete-property/ interrupt-parent;
+		/delete-property/ interrupts;
+	};
 };
 
 &sdhi0 {
-- 
2.34.1


