Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B898EEB565
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:01:03 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88804.1767200431635644184
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: DLcx53L6RlWnngrRT7i28w==
X-CSE-MsgGUID: Z6u+uKLfQlieFh7BjLnNdw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:58 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3E5D0402412E;
	Thu,  1 Jan 2026 02:00:57 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/17] arm64: dts: renesas: rzt2h-n2h-evk-common: Enable WDT2
Date: Wed, 31 Dec 2025 17:00:26 +0000
Message-ID: <20251231170026.17006-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:01:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21296

commit da23f1bdce81712096601d9e5e59cfe071aa1c92 upstream.

Enable watchdog (WDT2) on RZ/T2H and RZ/N2H EVKs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250821161946.1096033-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 8b9d04dce8ae0..91068042bec05 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -217,3 +217,8 @@ &sdhi1 {
 	status = "okay";
 };
 #endif
+
+&wdt2 {
+	status = "okay";
+	timeout-sec = <60>;
+};
-- 
2.43.0


