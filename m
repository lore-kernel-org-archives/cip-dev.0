Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840FACA5FCB
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 15:09:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15771.1790780989798271015
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2026 08:09:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=1v+x=hw=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2DB7E601DE;
	Wed, 30 Sep 2026 15:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66C11F00898;
	Wed, 30 Sep 2026 15:09:47 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 3/4] arm64: dts: renesas: r8a774c0: Add missing iommus properties
Date: Wed, 30 Sep 2026 18:09:40 +0300
Message-ID: <20260930150941.597025-4-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930150941.597025-1-claudiu.beznea@tuxon.dev>
References: <20260930150941.597025-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2026 15:09:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24388

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit b4bcb7792f3a04320c6290d3d0e4f9f4d1251b4b upstream.

Add missing iommus properties to all SDHI device nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/299b47bf40d4d2d44beff46b3323c471915c714d.17=
20430758.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/=
dts/renesas/r8a774c0.dtsi
index ec7c7851519f..50b8e44802b7 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1630,6 +1630,7 @@ sdhi0: mmc@ee100000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets =3D <&cpg 314>;
+			iommus =3D <&ipmmu_ds1 32>;
 			status =3D "disabled";
 		};
=20
@@ -1643,6 +1644,7 @@ sdhi1: mmc@ee120000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets =3D <&cpg 313>;
+			iommus =3D <&ipmmu_ds1 33>;
 			status =3D "disabled";
 		};
=20
@@ -1656,6 +1658,7 @@ sdhi3: mmc@ee160000 {
 			max-frequency =3D <200000000>;
 			power-domains =3D <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets =3D <&cpg 311>;
+			iommus =3D <&ipmmu_ds1 35>;
 			status =3D "disabled";
 		};
=20
--=20
2.43.0


