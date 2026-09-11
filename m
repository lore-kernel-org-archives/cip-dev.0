Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA9C88E45
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:03:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40251.1789135396364542444
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:03:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2E16A4130D;
	Fri, 11 Sep 2026 14:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0652C1F000FF;
	Fri, 11 Sep 2026 14:03:14 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-6.12.y-cip 1/2] mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
Date: Fri, 11 Sep 2026 17:03:10 +0300
Message-ID: <20260911140311.2119765-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140311.2119765-1-claudiu.beznea@tuxon.dev>
References: <20260911140311.2119765-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:03:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24151

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5ce500d31a1625d8fe7ede950201b8df076bdd48 upstream.

The RZ/G2N (R8A774B1) SoC was previously handled via the generic
"renesas,rcar-gen3-sdhi" fallback compatible string. However, because
the SDHI IP on RZ/G2N is identical with the R-Car M3-N (R8A77965), it
requires the specific quirks and configuration defined in
`of_r8a77965_compatible` rather than the generic Gen3 data.

Add the explicit "renesas,sdhi-r8a774b1" match entry to map it correctly.
Note that the DT binding file renesas,sdhi.yaml does not need an update
as the entry for this SoC is already present.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
index 3f1bc9a41bb7..b62d81a76a74 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -278,6 +278,7 @@ static const struct renesas_sdhi_of_data_with_quirks =
of_rza2_compatible =3D {
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] =3D=
 {
 	{ .compatible =3D "renesas,sdhi-r7s9210", .data =3D &of_rza2_compatible=
, },
 	{ .compatible =3D "renesas,sdhi-mmc-r8a77470", .data =3D &of_rcar_gen3_=
compatible, },
+	{ .compatible =3D "renesas,sdhi-r8a774b1", .data =3D &of_r8a77965_compa=
tible, },
 	{ .compatible =3D "renesas,sdhi-r8a774e1", .data =3D &of_r8a7795_compat=
ible, },
 	{ .compatible =3D "renesas,sdhi-r8a7795", .data =3D &of_r8a7795_compati=
ble, },
 	{ .compatible =3D "renesas,sdhi-r8a77961", .data =3D &of_r8a77961_compa=
tible, },
--=20
2.43.0


