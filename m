Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D4AC4829A
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:29:16 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20190.1707222537615371048
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:29:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="196960737"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Feb 2024 21:29:07 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6FDF54005E16;
	Tue,  6 Feb 2024 21:29:05 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 43/44] riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
Date: Tue,  6 Feb 2024 12:27:33 +0000
Message-Id: <20240206122734.13477-44-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:29:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14827

commit 9e40584dc2592edbd35485731c3e9ab1291e6a13 upstream.

RZ/Five is a noncoherent SoC so to indicate this add dma-noncoherent
property to RZ/Five SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929000704.53217-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index c8d63a8f7d866..b0796015e36b1 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -43,6 +43,7 @@ cpu0_intc: interrupt-controller {
 };
 
 &soc {
+	dma-noncoherent;
 	interrupt-parent = <&plic>;
 
 	plic: interrupt-controller@12c00000 {
-- 
2.34.1


