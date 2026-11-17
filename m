Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15824.1794916029934881547
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DE1B6344B;
	Tue, 17 Nov 2026 11:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063F61F000C4;
	Tue, 17 Nov 2026 11:47:07 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 45/69] arm64: dts: renesas: r9a08g045: Move max-frequency to SoC dtsi
Date: Tue, 17 Nov 2026 13:45:29 +0200
Message-ID: <20261117114553.1484215-46-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24886
Content-Type: text/plain; charset="utf-8"

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 28efe119bdc6d3fc78e96b29d56e5d071eccfe38 upstream.

Move the max-frequency property for SDHI0/1/2 from the board-level
SMARC dtsi files into the r9a08g045.dtsi SoC file, since these
values reflect controller/SoC limitations rather than board-specific.

This removes the duplicated max-frequency =3D <125000000> entries for
SDHI0 (both SD and eMMC variants) and SDHI1 in rzg3s-smarc-som.dtsi
and rzg3s-smarc.dtsi, and the max-frequency =3D <50000000> entry for
SDHI2, consolidating them as defaults in r9a08g045.dtsi instead.

Boards needing a different limit can still override max-frequency
locally.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260619075621.126961-1-biju.das.jz@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi       | 3 +++
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 3 ---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi     | 1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot=
/dts/renesas/r9a08g045.dtsi
index fef84ed05e80..15d8081292dd 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -654,6 +654,7 @@ sdhi0: mmc@11c00000  {
 				 <&cpg CPG_MOD R9A08G045_SDHI0_IMCLK2>,
 				 <&cpg CPG_MOD R9A08G045_SDHI0_ACLK>;
 			clock-names =3D "core", "clkh", "cd", "aclk";
+			max-frequency =3D <125000000>;
 			resets =3D <&cpg R9A08G045_SDHI0_IXRST>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
@@ -669,6 +670,7 @@ sdhi1: mmc@11c10000 {
 				 <&cpg CPG_MOD R9A08G045_SDHI1_IMCLK2>,
 				 <&cpg CPG_MOD R9A08G045_SDHI1_ACLK>;
 			clock-names =3D "core", "clkh", "cd", "aclk";
+			max-frequency =3D <125000000>;
 			resets =3D <&cpg R9A08G045_SDHI1_IXRST>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
@@ -684,6 +686,7 @@ sdhi2: mmc@11c20000 {
 				 <&cpg CPG_MOD R9A08G045_SDHI2_IMCLK2>,
 				 <&cpg CPG_MOD R9A08G045_SDHI2_ACLK>;
 			clock-names =3D "core", "clkh", "cd", "aclk";
+			max-frequency =3D <50000000>;
 			resets =3D <&cpg R9A08G045_SDHI2_IXRST>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm6=
4/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 990adea09799..e2a9b56df762 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -186,7 +186,6 @@ &sdhi0 {
 	bus-width =3D <4>;
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
-	max-frequency =3D <125000000>;
 	status =3D "okay";
 };
 #else
@@ -201,7 +200,6 @@ &sdhi0 {
 	mmc-hs200-1_8v;
 	non-removable;
 	fixed-emmc-driver-type =3D <1>;
-	max-frequency =3D <125000000>;
 	status =3D "okay";
 };
 #endif
@@ -212,7 +210,6 @@ &sdhi2 {
 	pinctrl-names =3D "default";
 	vmmc-supply =3D <&vcc_sdhi2>;
 	bus-width =3D <4>;
-	max-frequency =3D <50000000>;
 	status =3D "okay";
 };
 #endif
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/bo=
ot/dts/renesas/rzg3s-smarc.dtsi
index 6fc795a51ebb..051baebe3d17 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -276,7 +276,6 @@ &sdhi1 {
 	bus-width =3D <4>;
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
-	max-frequency =3D <125000000>;
 	status =3D "okay";
 };
=20
--=20
2.43.0

