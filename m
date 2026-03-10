Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FE3FD4F02
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 16:01:11 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43710.1773158455808667489
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 09:01:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: ACkTD/8uT46lCT3QHYgPQg==
X-CSE-MsgGUID: 4UG00mYuSAWYfvdXksD55w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Mar 2026 01:01:02 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C04A34019133;
	Wed, 11 Mar 2026 01:01:00 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 5/5] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add NMI wakeup button support
Date: Tue, 10 Mar 2026 16:00:50 +0000
Message-ID: <20260310160050.40977-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
References: <20260310160050.40977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 16:01:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22240

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 41e60d92c88c0085511b38077dad2939bf63ddfc upstream.

Add support for the NMI connected user pushbutton on the RZ/V2N EVK.
The button is wired to the SoC NMI input and can be used to wake the
system from low-power states.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251125224533.294235-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index 2846a1b23cd7..e7bb4334ca47 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "r9a09g056.dtsi"
 
 / {
@@ -44,6 +45,18 @@ hdmi_con_out: endpoint {
 		};
 	};
 
+	keys: keys {
+		compatible = "gpio-keys";
+
+		key-wakeup {
+			interrupts-extended = <&icu 0 IRQ_TYPE_EDGE_FALLING>;
+			linux,code = <KEY_WAKEUP>;
+			label = "NMI_SW";
+			debounce-interval = <20>;
+			wakeup-source;
+		};
+	};
+
 	memory@48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
-- 
2.51.0


