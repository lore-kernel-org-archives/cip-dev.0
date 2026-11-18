Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.262.1795018413984859647
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 08:13:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=4qsa=jh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6560E62735;
	Wed, 18 Nov 2026 16:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0A71F000C7;
	Wed, 18 Nov 2026 16:13:31 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.1.y-cip 32/34] arm64: dts: renesas: r9a08g045: Move interrupt-parent to root node
Date: Wed, 18 Nov 2026 18:13:19 +0200
Message-ID: <20261118161321.3032517-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118161321.3032517-1-claudiu.beznea@tuxon.dev>
References: <18E8D2BE9419961D.1262307@lists.cip-project.org>
 <20261118161321.3032517-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 16:13:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24959
Content-Type: text/plain; charset="utf-8"

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 1342f314c4cf3d4e68dca6771f63f79901ee4690 upstream.

Move the "interrupt-parent =3D <&gic>" property from the soc node to the
root node, and simplify "interrupts-extended =3D <&gic ...>" to
"interrupts =3D <...>".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/87jz1o8o8o.wl-kuninori.morimoto.gx@renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot=
/dts/renesas/r9a08g045.dtsi
index 2fe5f3a65932..a3b48d94de7f 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -13,6 +13,7 @@ / {
 	compatible =3D "renesas,r9a08g045";
 	#address-cells =3D <2>;
 	#size-cells =3D <2>;
+	interrupt-parent =3D <&gic>;
=20
 	audio_clk1: audio1-clk {
 		compatible =3D "fixed-clock";
@@ -92,7 +93,6 @@ psci {
=20
 	soc: soc {
 		compatible =3D "simple-bus";
-		interrupt-parent =3D <&gic>;
 		#address-cells =3D <2>;
 		#size-cells =3D <2>;
 		ranges;
@@ -937,11 +937,11 @@ wdt0: watchdog@12800800 {
=20
 	timer {
 		compatible =3D "arm,armv8-timer";
-		interrupts-extended =3D <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names =3D "sec-phys", "phys", "virt", "hyp-phys",
 				  "hyp-virt";
 	};
--=20
2.43.0

