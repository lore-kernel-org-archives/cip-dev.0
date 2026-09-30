Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2D8CA5FCF
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 15:09:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15769.1790780988353555867
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2026 08:09:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=1v+x=hw=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C1CEE60008;
	Wed, 30 Sep 2026 15:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792FC1F00898;
	Wed, 30 Sep 2026 15:09:46 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 2/4] arm64: dts: renesas: r8a774b1: Add missing iommus properties
Date: Wed, 30 Sep 2026 18:09:39 +0300
Message-ID: <20260930150941.597025-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930150941.597025-1-claudiu.beznea@tuxon.dev>
References: <20260930150941.597025-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2026 15:09:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24387

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1d325f5060d4940ea28818848e3a2290b217e963 upstream.

Add missing iommus properties to all Audio-DMAC, SDHI, Serial-ATA, and
Frame Compression Processor device nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/2d6a97d2df0532c661a2be6bafc9e5061c645197.17=
20430758.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/=
dts/renesas/r8a774b1.dtsi
index d541b48c7e38..cbfdd05d1156 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -1999,6 +1999,14 @@ audma0: dma-controller@ec700000 {
 			resets =3D <&cpg 502>;
 			#dma-cells =3D <1>;
 			dma-channels =3D <16>;
+			iommus =3D <&ipmmu_mp 0>, <&ipmmu_mp 1>,
+				 <&ipmmu_mp 2>, <&ipmmu_mp 3>,
+				 <&ipmmu_mp 4>, <&ipmmu_mp 5>,
+				 <&ipmmu_mp 6>, <&ipmmu_mp 7>,
+				 <&ipmmu_mp 8>, <&ipmmu_mp 9>,
+				 <&ipmmu_mp 10>, <&ipmmu_mp 11>,
+				 <&ipmmu_mp 12>, <&ipmmu_mp 13>,
+				 <&ipmmu_mp 14>, <&ipmmu_mp 15>;
 		};
=20
 		audma1: dma-controller@ec720000 {
@@ -2033,6 +2041,14 @@ audma1: dma-controller@ec720000 {
 			resets =3D <&cpg 501>;
 			#dma-cells =3D <1>;
 			dma-channels =3D <16>;
+			iommus =3D <&ipmmu_mp 16>, <&ipmmu_mp 17>,
+				 <&ipmmu_mp 18>, <&ipmmu_mp 19>,
+				 <&ipmmu_mp 20>, <&ipmmu_mp 21>,
+				 <&ipmmu_mp 22>, <&ipmmu_mp 23>,
+				 <&ipmmu_mp 24>, <&ipmmu_mp 25>,
+				 <&ipmmu_mp 26>, <&ipmmu_mp 27>,
+				 <&ipmmu_mp 28>, <&ipmmu_mp 29>,
+				 <&ipmmu_mp 30>, <&ipmmu_mp 31>;
 		};
=20
 		xhci0: usb@ee000000 {
@@ -2140,6 +2156,7 @@ sdhi0: mmc@ee100000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 314>;
+			iommus =3D <&ipmmu_ds1 32>;
 			status =3D "disabled";
 		};
=20
@@ -2153,6 +2170,7 @@ sdhi1: mmc@ee120000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 313>;
+			iommus =3D <&ipmmu_ds1 33>;
 			status =3D "disabled";
 		};
=20
@@ -2166,6 +2184,7 @@ sdhi2: mmc@ee140000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 312>;
+			iommus =3D <&ipmmu_ds1 34>;
 			status =3D "disabled";
 		};
=20
@@ -2179,6 +2198,7 @@ sdhi3: mmc@ee160000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 311>;
+			iommus =3D <&ipmmu_ds1 35>;
 			status =3D "disabled";
 		};
=20
@@ -2206,6 +2226,7 @@ sata: sata@ee300000 {
 			clocks =3D <&cpg CPG_MOD 815>;
 			power-domains =3D <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 815>;
+			iommus =3D <&ipmmu_hc 2>;
 			status =3D "disabled";
 		};
=20
@@ -2334,6 +2355,7 @@ fcpf0: fcp@fe950000 {
 			clocks =3D <&cpg CPG_MOD 615>;
 			power-domains =3D <&sysc R8A774B1_PD_A3VP>;
 			resets =3D <&cpg 615>;
+			iommus =3D <&ipmmu_vp0 0>;
 		};
=20
 		vspb: vsp@fe960000 {
@@ -2386,6 +2408,7 @@ fcpvb0: fcp@fe96f000 {
 			clocks =3D <&cpg CPG_MOD 607>;
 			power-domains =3D <&sysc R8A774B1_PD_A3VP>;
 			resets =3D <&cpg 607>;
+			iommus =3D <&ipmmu_vp0 5>;
 		};
=20
 		fcpvd0: fcp@fea27000 {
@@ -2394,6 +2417,7 @@ fcpvd0: fcp@fea27000 {
 			clocks =3D <&cpg CPG_MOD 603>;
 			power-domains =3D <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 603>;
+			iommus =3D <&ipmmu_vi0 8>;
 		};
=20
 		fcpvd1: fcp@fea2f000 {
@@ -2402,6 +2426,7 @@ fcpvd1: fcp@fea2f000 {
 			clocks =3D <&cpg CPG_MOD 602>;
 			power-domains =3D <&sysc R8A774B1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 602>;
+			iommus =3D <&ipmmu_vi0 9>;
 		};
=20
 		fcpvi0: fcp@fe9af000 {
@@ -2410,6 +2435,7 @@ fcpvi0: fcp@fe9af000 {
 			clocks =3D <&cpg CPG_MOD 611>;
 			power-domains =3D <&sysc R8A774B1_PD_A3VP>;
 			resets =3D <&cpg 611>;
+			iommus =3D <&ipmmu_vp0 8>;
 		};
=20
 		csi20: csi2@fea80000 {
--=20
2.43.0


