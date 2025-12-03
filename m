Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C89D15D9D
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:38:27 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18215.1764776292894303297
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:38:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: WBBYjn03TA6nWX8rgff51g==
X-CSE-MsgGUID: LvPGkvf7TcCF/yhQAJaTaA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Dec 2025 00:38:20 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A11294015D8A;
	Thu,  4 Dec 2025 00:38:19 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 12/12] arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and RZ/V2N EVKs
Date: Wed,  3 Dec 2025 15:37:57 +0000
Message-ID: <20251203153757.32977-13-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:38:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20825

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3d6c2bc7629c8b1bfd75416767122096bb75ba7b upstream.

Introduce device tree overlays for supporting the eMMC (RTK0EF0186B02000BJ)
and microSD (RTK0EF0186B01000BJ) sub-boards connected via the CN15
connector on the RZ/V2H and RZ/V2N evaluation kits.

These overlays enable SDHI0 with appropriate pin control settings, power
regulators, and GPIO handling. Both sub-boards are supported using shared
overlay files that can be applied to either EVK due to their identical
connector layout and interface support.

To support this, new DT overlay files are added:
- `rzv2-evk-cn15-emmc.dtso` for eMMC
- `rzv2-evk-cn15-sd.dtso` for microSD

Additionally, the base DTS files for both EVKs are updated to include a
fixed 1.8V regulator (`reg_1p8v`) needed by the eMMC sub-board and
potential future use cases such as HDMI output.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250627193742.110818-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[OP: cherry-picked missing RZ/V2N bits]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile                   | 6 ++++++
 arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 14a8255ae878..b9cb031a6eba 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -92,6 +92,12 @@ dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 dtb-$(CONFIG_ARCH_R9A09G047) += r9a09g047e57-smarc.dtb
 
 dtb-$(CONFIG_ARCH_R9A09G056) += r9a09g056n48-rzv2n-evk.dtb
+dtb-$(CONFIG_ARCH_R9A09G056) += rzv2-evk-cn15-emmc.dtbo
+r9a09g056n48-rzv2n-evk-cn15-emmc-dtbs := r9a09g056n48-rzv2n-evk.dtb rzv2-evk-cn15-emmc.dtbo
+dtb-$(CONFIG_ARCH_R9A09G056) += r9a09g056n48-rzv2n-evk-cn15-emmc.dtb
+dtb-$(CONFIG_ARCH_R9A09G056) += rzv2-evk-cn15-sd.dtbo
+r9a09g056n48-rzv2n-evk-cn15-sd-dtbs := r9a09g056n48-rzv2n-evk.dtb rzv2-evk-cn15-sd.dtbo
+dtb-$(CONFIG_ARCH_R9A09G056) += r9a09g056n48-rzv2n-evk-cn15-sd.dtb
 
 dtb-$(CONFIG_ARCH_R9A09G057) += r9a09g057h44-rzv2h-evk.dtb
 dtb-$(CONFIG_ARCH_R9A09G057) += rzv2-evk-cn15-emmc.dtbo
diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index 24343fce7f53..e27f542c0561 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -30,6 +30,15 @@ memory@48000000 {
 		reg = <0x0 0x48000000 0x1 0xf8000000>;
 	};
 
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
-- 
2.51.0


