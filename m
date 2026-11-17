Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15961.1794916026311802440
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 21AB3437EA;
	Tue, 17 Nov 2026 11:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2A41F000C4;
	Tue, 17 Nov 2026 11:47:04 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 43/69] arm64: dts: renesas: r9a08g045: Add missing hypervisor virtual timer IRQ
Date: Tue, 17 Nov 2026 13:45:27 +0200
Message-ID: <20261117114553.1484215-44-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24884
Content-Type: text/plain; charset="utf-8"

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 10f9badc473d43ebfddd1ddedbcb8eb3f8f3fdd9 upstream.

Add the missing fifth interrupt to the device node that represents the
ARM architected timer.  While at it, add an interrupt-names property for
clarity,

Fixes: e20396d65b959a65 ("arm64: dts: renesas: Add initial DTSI for RZ/G3=
S SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/884c683fb6c1d1bf7d0d383a8df8f65a0a424dc7.17=
18890849.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot=
/dts/renesas/r9a08g045.dtsi
index 18457dc19cd7..3914d3476426 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -940,7 +940,10 @@ timer {
 		interrupts-extended =3D <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
 				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names =3D "sec-phys", "phys", "virt", "hyp-phys",
+				  "hyp-virt";
 	};
=20
 	thermal-zones {
--=20
2.43.0

