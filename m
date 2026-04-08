Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BBE105D9B5
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 09:40:12 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.102550.1775641196244975563
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 02:40:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: EXHmOtKXSCapSTSHYCVSwg==
X-CSE-MsgGUID: 52FPp2HaQ/ad+ESk2JtqlA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Apr 2026 18:40:03 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C00A340116D0;
	Wed,  8 Apr 2026 18:40:02 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 6/7] arm64: dts: renesas: r9a09g056: Use syscon compatible for the system controller
Date: Wed,  8 Apr 2026 09:39:49 +0000
Message-ID: <20260408093951.66884-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
References: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 09:40:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22642

The Renesas RZ/V2N TSU driver needs the system controller syscon
to be able to retrieve calibration data. For this, it uses
syscon_regmap_lookup_by_phandle_args(). But, in v6.1 CIP,
syscon_regmap_lookup_by_phandle_args() returns ERR_PTR(-EINVAL) if
the node for which it is called doesn't have the syscon compatible.

Therefore, add syscon compatible for the system controller.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index a08d10950651..0d60d4cdb257 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -292,7 +292,7 @@ cpg: clock-controller@10420000 {
 		};
 
 		sys: system-controller@10430000 {
-			compatible = "renesas,r9a09g056-sys";
+			compatible = "renesas,r9a09g056-sys", "syscon";
 			reg = <0 0x10430000 0 0x10000>;
 			clocks = <&cpg CPG_CORE R9A09G056_SYS_0_PCLK>;
 			resets = <&cpg 0x30>;
-- 
2.51.0


