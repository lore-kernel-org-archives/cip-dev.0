Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5920BD32D8D
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:34:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6944.1764945237663626403
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: GKcSD/DSTceBjSu5sUeG/g==
X-CSE-MsgGUID: KGNjpDYxStmybRN3DYVlow==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:57 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D2E684179CE0;
	Fri,  5 Dec 2025 23:33:55 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 32/38] arm64: dts: renesas: Refactor RZ/T2H EVK device tree
Date: Fri,  5 Dec 2025 14:32:52 +0000
Message-ID: <20251205143258.13748-33-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:34:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20946

From: Paul Barker <paul.barker.ct@bp.renesas.com>

commit 8989230e80113e2bd2f322fba6922f9a3252e9c0 upstream.

The RZ/T2H EVK and RZ/N2H EVK are very similar boards.  As there is so
much overlap between these parts, common device tree entries are moved
to the new file rzt2h-n2h-evk-common.dtsi.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250617171957.162145-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    | 17 +------------
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index 752d4c9f2cae5..486584fefeadf 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -8,24 +8,9 @@
 /dts-v1/;
 
 #include "r9a09g077m44.dtsi"
+#include "rzt2h-n2h-evk-common.dtsi"
 
 / {
 	model = "Renesas RZ/T2H EVK Board based on r9a09g077m44";
 	compatible = "renesas,rzt2h-evk", "renesas,r9a09g077m44", "renesas,r9a09g077";
-
-	aliases {
-		serial0 = &sci0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&extal_clk {
-	clock-frequency = <25000000>;
-};
-
-&sci0 {
-	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
new file mode 100644
index 0000000000000..5f17996bcd6bc
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Common Device Tree Source for the RZ/T2H and RZ/N2H EVK boards.
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/ {
+	aliases {
+		serial0 = &sci0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&extal_clk {
+	clock-frequency = <25000000>;
+};
+
+&sci0 {
+	status = "okay";
+};
-- 
2.43.0


