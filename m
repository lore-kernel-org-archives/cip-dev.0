Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.989.1795020156482810547
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:42:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4BD794099A;
	Wed, 18 Nov 2026 16:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0C31F000C4;
	Wed, 18 Nov 2026 16:42:35 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.12.y-cip 34/35] arm64: dts: renesas: r9a08g045: Move max-frequency to SoC dtsi
Date: Wed, 18 Nov 2026 18:41:45 +0200
Message-ID: <20261118164146.3040784-35-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
References: <20261118164146.3040784-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:42:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24997
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
index 3a69bb246bab..ae92d45ede38 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -655,6 +655,7 @@ sdhi0: mmc@11c00000  {
 				 <&cpg CPG_MOD R9A08G045_SDHI0_IMCLK2>,
 				 <&cpg CPG_MOD R9A08G045_SDHI0_ACLK>;
 			clock-names =3D "core", "clkh", "cd", "aclk";
+			max-frequency =3D <125000000>;
 			resets =3D <&cpg R9A08G045_SDHI0_IXRST>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
@@ -670,6 +671,7 @@ sdhi1: mmc@11c10000 {
 				 <&cpg CPG_MOD R9A08G045_SDHI1_IMCLK2>,
 				 <&cpg CPG_MOD R9A08G045_SDHI1_ACLK>;
 			clock-names =3D "core", "clkh", "cd", "aclk";
+			max-frequency =3D <125000000>;
 			resets =3D <&cpg R9A08G045_SDHI1_IXRST>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
@@ -685,6 +687,7 @@ sdhi2: mmc@11c20000 {
 				 <&cpg CPG_MOD R9A08G045_SDHI2_IMCLK2>,
 				 <&cpg CPG_MOD R9A08G045_SDHI2_ACLK>;
 			clock-names =3D "core", "clkh", "cd", "aclk";
+			max-frequency =3D <50000000>;
 			resets =3D <&cpg R9A08G045_SDHI2_IXRST>;
 			power-domains =3D <&cpg>;
 			status =3D "disabled";
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm6=
4/boot/dts/renesas/rzg3s-smarc-som.dtsi
index b45acfe6288a..9039a927bc46 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -184,7 +184,6 @@ &sdhi0 {
 	bus-width =3D <4>;
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
-	max-frequency =3D <125000000>;
 	status =3D "okay";
 };
 #else
@@ -199,7 +198,6 @@ &sdhi0 {
 	mmc-hs200-1_8v;
 	non-removable;
 	fixed-emmc-driver-type =3D <1>;
-	max-frequency =3D <125000000>;
 	status =3D "okay";
 };
 #endif
@@ -210,7 +208,6 @@ &sdhi2 {
 	pinctrl-names =3D "default";
 	vmmc-supply =3D <&vcc_sdhi2>;
 	bus-width =3D <4>;
-	max-frequency =3D <50000000>;
 	status =3D "okay";
 };
 #endif
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/bo=
ot/dts/renesas/rzg3s-smarc.dtsi
index 071da86ed3dc..b5389cd6da09 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -275,7 +275,6 @@ &sdhi1 {
 	bus-width =3D <4>;
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
-	max-frequency =3D <125000000>;
 	status =3D "okay";
 };
=20
--=20
2.43.0

