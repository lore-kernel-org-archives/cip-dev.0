Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5176.1795724196619484589
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 12:16:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 55D1F60D15;
	Thu, 26 Nov 2026 20:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B241F00898;
	Thu, 26 Nov 2026 20:16:33 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip] arm64: dts: renesas: r9a07g044: Add DMA properties to serial nodes
Date: Thu, 26 Nov 2026 22:16:32 +0200
Message-ID: <20261126201632.1459403-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 20:16:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25225
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d61a35b0a3e43ea91781c41e02046b7d73fb3f1e upstream.

Add DMA properties to the serial nodes on the RZ/G2L SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260520132315.944117-1-claudiu.beznea@ker=
nel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Please note that this should be applied on top of series:
https://lore.kernel.org/all/20261126155321.3834347-1-tommaso.merciai.xr@b=
p.renesas.com

 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot=
/dts/renesas/r9a07g044.dtsi
index 324764bcce30..1c1f7f1c1743 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -389,6 +389,8 @@ scif0: serial@1004b800 {
 					  "bri", "dri", "tei";
 			clocks =3D <&cpg CPG_MOD R9A07G044_SCIF0_CLK_PCK>;
 			clock-names =3D "fck";
+			dmas =3D <&dmac 0x4e79>, <&dmac 0x4e7a>;
+			dma-names =3D "tx", "rx";
 			power-domains =3D <&cpg>;
 			resets =3D <&cpg R9A07G044_SCIF0_RST_SYSTEM_N>;
 			status =3D "disabled";
@@ -407,6 +409,8 @@ scif1: serial@1004bc00 {
 					  "bri", "dri", "tei";
 			clocks =3D <&cpg CPG_MOD R9A07G044_SCIF1_CLK_PCK>;
 			clock-names =3D "fck";
+			dmas =3D <&dmac 0x4e7d>, <&dmac 0x4e7e>;
+			dma-names =3D "tx", "rx";
 			power-domains =3D <&cpg>;
 			resets =3D <&cpg R9A07G044_SCIF1_RST_SYSTEM_N>;
 			status =3D "disabled";
@@ -425,6 +429,8 @@ scif2: serial@1004c000 {
 					  "bri", "dri", "tei";
 			clocks =3D <&cpg CPG_MOD R9A07G044_SCIF2_CLK_PCK>;
 			clock-names =3D "fck";
+			dmas =3D <&dmac 0x4e81>, <&dmac 0x4e82>;
+			dma-names =3D "tx", "rx";
 			power-domains =3D <&cpg>;
 			resets =3D <&cpg R9A07G044_SCIF2_RST_SYSTEM_N>;
 			status =3D "disabled";
@@ -443,6 +449,8 @@ scif3: serial@1004c400 {
 					  "bri", "dri", "tei";
 			clocks =3D <&cpg CPG_MOD R9A07G044_SCIF3_CLK_PCK>;
 			clock-names =3D "fck";
+			dmas =3D <&dmac 0x4e85>, <&dmac 0x4e86>;
+			dma-names =3D "tx", "rx";
 			power-domains =3D <&cpg>;
 			resets =3D <&cpg R9A07G044_SCIF3_RST_SYSTEM_N>;
 			status =3D "disabled";
@@ -461,6 +469,8 @@ scif4: serial@1004c800 {
 					  "bri", "dri", "tei";
 			clocks =3D <&cpg CPG_MOD R9A07G044_SCIF4_CLK_PCK>;
 			clock-names =3D "fck";
+			dmas =3D <&dmac 0x4e89>, <&dmac 0x4e8a>;
+			dma-names =3D "tx", "rx";
 			power-domains =3D <&cpg>;
 			resets =3D <&cpg R9A07G044_SCIF4_RST_SYSTEM_N>;
 			status =3D "disabled";
--=20
2.43.0

