Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32B7CA5FC7
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 15:09:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15759.1790780974087727431
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2026 08:09:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=1v+x=hw=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B0F2601DE;
	Wed, 30 Sep 2026 15:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5EC1F00898;
	Wed, 30 Sep 2026 15:09:32 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 1/4] arm64: dts: renesas: r8a774a1: Add missing iommus properties
Date: Wed, 30 Sep 2026 18:09:26 +0300
Message-ID: <20260930150929.597001-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930150929.597001-1-claudiu.beznea@tuxon.dev>
References: <20260930150929.597001-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2026 15:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24381

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit e8b655803da2cc0f27834c5ec931521dba831b95 upstream.

Add missing iommus properties to SDHI and Frame Compression Processor
device nodes that still lack them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/114e9915356670e59dae412c1054afad4ce4c964.17=
20430758.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/=
dts/renesas/r8a774a1.dtsi
index 2e427f21130d..2686e54cef46 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -2279,6 +2279,7 @@ sdhi0: mmc@ee100000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 314>;
+			iommus =3D <&ipmmu_ds1 32>;
 			status =3D "disabled";
 		};
=20
@@ -2291,6 +2292,7 @@ sdhi1: mmc@ee120000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 313>;
+			iommus =3D <&ipmmu_ds1 33>;
 			status =3D "disabled";
 		};
=20
@@ -2303,6 +2305,7 @@ sdhi2: mmc@ee140000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 312>;
+			iommus =3D <&ipmmu_ds1 34>;
 			status =3D "disabled";
 		};
=20
@@ -2315,6 +2318,7 @@ sdhi3: mmc@ee160000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets =3D <&cpg 311>;
+			iommus =3D <&ipmmu_ds1 35>;
 			status =3D "disabled";
 		};
=20
@@ -2460,6 +2464,7 @@ fcpf0: fcp@fe950000 {
 			clocks =3D <&cpg CPG_MOD 615>;
 			power-domains =3D <&sysc R8A774A1_PD_A3VC>;
 			resets =3D <&cpg 615>;
+			iommus =3D <&ipmmu_vc0 16>;
 		};
=20
 		fcpvb0: fcp@fe96f000 {
@@ -2468,6 +2473,7 @@ fcpvb0: fcp@fe96f000 {
 			clocks =3D <&cpg CPG_MOD 607>;
 			power-domains =3D <&sysc R8A774A1_PD_A3VC>;
 			resets =3D <&cpg 607>;
+			iommus =3D <&ipmmu_vi0 5>;
 		};
=20
 		fcpvd0: fcp@fea27000 {
--=20
2.43.0


