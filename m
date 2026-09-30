Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4163CA5FCD
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 15:09:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15772.1790780991085057835
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2026 08:09:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=1v+x=hw=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7A01660258;
	Wed, 30 Sep 2026 15:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5299F1F00899;
	Wed, 30 Sep 2026 15:09:49 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 4/4] arm64: dts: renesas: r8a774e1: Add missing iommus properties
Date: Wed, 30 Sep 2026 18:09:41 +0300
Message-ID: <20260930150941.597025-5-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930150941.597025-1-claudiu.beznea@tuxon.dev>
References: <20260930150941.597025-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2026 15:09:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24389

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 3d7de696a10924f26c2b9df7db2f741acd138a66 upstream.

Add missing iommus properties to all Frame Compression Processor device
nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/b2a1a5fd41c78c881e6e410b720e5e12572e2668.17=
20430758.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/=
dts/renesas/r8a774e1.dtsi
index c5a0e7866b2f..d9caedf37516 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -2643,6 +2643,7 @@ fcpf0: fcp@fe950000 {
 			clocks =3D <&cpg CPG_MOD 615>;
 			power-domains =3D <&sysc R8A774E1_PD_A3VP>;
 			resets =3D <&cpg 615>;
+			iommus =3D <&ipmmu_vp0 0>;
 		};
=20
 		fcpf1: fcp@fe951000 {
@@ -2651,6 +2652,7 @@ fcpf1: fcp@fe951000 {
 			clocks =3D <&cpg CPG_MOD 614>;
 			power-domains =3D <&sysc R8A774E1_PD_A3VP>;
 			resets =3D <&cpg 614>;
+			iommus =3D <&ipmmu_vp1 1>;
 		};
=20
 		fcpvb0: fcp@fe96f000 {
@@ -2659,6 +2661,7 @@ fcpvb0: fcp@fe96f000 {
 			clocks =3D <&cpg CPG_MOD 607>;
 			power-domains =3D <&sysc R8A774E1_PD_A3VP>;
 			resets =3D <&cpg 607>;
+			iommus =3D <&ipmmu_vp0 5>;
 		};
=20
 		fcpvb1: fcp@fe92f000 {
@@ -2667,6 +2670,7 @@ fcpvb1: fcp@fe92f000 {
 			clocks =3D <&cpg CPG_MOD 606>;
 			power-domains =3D <&sysc R8A774E1_PD_A3VP>;
 			resets =3D <&cpg 606>;
+			iommus =3D <&ipmmu_vp1 7>;
 		};
=20
 		fcpvi0: fcp@fe9af000 {
@@ -2675,6 +2679,7 @@ fcpvi0: fcp@fe9af000 {
 			clocks =3D <&cpg CPG_MOD 611>;
 			power-domains =3D <&sysc R8A774E1_PD_A3VP>;
 			resets =3D <&cpg 611>;
+			iommus =3D <&ipmmu_vp0 8>;
 		};
=20
 		fcpvi1: fcp@fe9bf000 {
@@ -2683,6 +2688,7 @@ fcpvi1: fcp@fe9bf000 {
 			clocks =3D <&cpg CPG_MOD 610>;
 			power-domains =3D <&sysc R8A774E1_PD_A3VP>;
 			resets =3D <&cpg 610>;
+			iommus =3D <&ipmmu_vp1 9>;
 		};
=20
 		fcpvd0: fcp@fea27000 {
@@ -2691,6 +2697,7 @@ fcpvd0: fcp@fea27000 {
 			clocks =3D <&cpg CPG_MOD 603>;
 			power-domains =3D <&sysc R8A774E1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 603>;
+			iommus =3D <&ipmmu_vi0 8>;
 		};
=20
 		fcpvd1: fcp@fea2f000 {
@@ -2699,6 +2706,7 @@ fcpvd1: fcp@fea2f000 {
 			clocks =3D <&cpg CPG_MOD 602>;
 			power-domains =3D <&sysc R8A774E1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 602>;
+			iommus =3D <&ipmmu_vi0 9>;
 		};
=20
 		csi20: csi2@fea80000 {
--=20
2.43.0


