Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89529C88E50
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40060.1789135322296757356
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:02:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DE4343F85;
	Fri, 11 Sep 2026 14:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112941F000FF;
	Fri, 11 Sep 2026 14:02:00 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 06/14] mmc: renesas_sdhi: make 'fixed_addr_mode' a quirk
Date: Fri, 11 Sep 2026 17:01:43 +0300
Message-ID: <20260911140151.2119555-7-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24137

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c0a43968be5609c7c0f5ba0b5c72cbc7ab22ebce upstream.

After Shimoda-san's much appreciated refactoring of the quirk handling,
we can convert now the 'fixed_addr_mode' from an ugly global flag to a
regular quirk. This makes quirk handling more consistent and easier to
maintain.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220320123016.57991-6-wsa+renesas@sang-e=
ngineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea:
 - dropped of_rcar_gen3_nohs400_compatible since it's not available in
   v5.10
 - adjusted for RZ/V2M by adding of_rzv2m_compatible and using it
   accordingly in renesas_sdhi_internal_dmac_of_match array]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  1 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 30 +++++++++++--------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_s=
dhi.h
index 9a24d4ff1210..3e9014e976c4 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -38,6 +38,7 @@ struct renesas_sdhi_of_data {
 struct renesas_sdhi_quirks {
 	bool hs400_disabled;
 	bool hs400_4taps;
+	bool fixed_addr_mode;
 	u32 hs400_bad_taps;
 	const u8 (*hs400_calib_table)[SDHI_CALIB_TABLE_MAX];
 };
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
index cd328af38b15..4d496a9b7080 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -81,9 +81,6 @@ static unsigned long global_flags;
 #define SDHI_INTERNAL_DMAC_ONE_RX_ONLY	0
 #define SDHI_INTERNAL_DMAC_RX_IN_USE	1
=20
-/* RZ/A2 does not have the ADRR_MODE bit */
-#define SDHI_INTERNAL_DMAC_ADDR_MODE_FIXED_ONLY 2
-
 /* Definitions for sampling clocks */
 static struct renesas_sdhi_scc rcar_gen3_scc_taps[] =3D {
 	{
@@ -108,10 +105,6 @@ static const struct renesas_sdhi_of_data of_data_rza=
2 =3D {
 	.max_segs	=3D 1,
 };
=20
-static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible =
=3D {
-	.of_data	=3D &of_data_rza2,
-};
-
 static const struct renesas_sdhi_of_data of_data_rcar_gen3 =3D {
 	.tmio_flags	=3D TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
@@ -163,6 +156,10 @@ static const struct renesas_sdhi_quirks sdhi_quirks_=
nohs400 =3D {
 	.hs400_disabled =3D true,
 };
=20
+static const struct renesas_sdhi_quirks sdhi_quirks_fixed_addr =3D {
+	.fixed_addr_mode =3D true,
+};
+
 static const struct renesas_sdhi_quirks sdhi_quirks_bad_taps1357 =3D {
 	.hs400_bad_taps =3D BIT(1) | BIT(3) | BIT(5) | BIT(7),
 };
@@ -229,6 +226,16 @@ static const struct renesas_sdhi_of_data_with_quirks=
 of_rcar_gen3_compatible =3D {
 	.of_data =3D &of_data_rcar_gen3,
 };
=20
+static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible =
=3D {
+	.of_data	=3D &of_data_rza2,
+	.quirks		=3D &sdhi_quirks_fixed_addr,
+};
+
+static const struct renesas_sdhi_of_data_with_quirks of_rzv2m_compatible=
 =3D {
+	.of_data	=3D &of_data_rcar_gen3,
+	.quirks		=3D &sdhi_quirks_fixed_addr,
+};
+
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] =3D=
 {
 	{ .compatible =3D "renesas,sdhi-r7s9210", .data =3D &of_rza2_compatible=
, },
 	{ .compatible =3D "renesas,sdhi-mmc-r8a77470", .data =3D &of_rcar_gen3_=
compatible, },
@@ -239,7 +246,7 @@ static const struct of_device_id renesas_sdhi_interna=
l_dmac_of_match[] =3D {
 	{ .compatible =3D "renesas,sdhi-r8a77965", .data =3D &of_r8a77965_compa=
tible, },
 	{ .compatible =3D "renesas,sdhi-r8a77980", .data =3D &of_r8a77980_compa=
tible, },
 	{ .compatible =3D "renesas,sdhi-r8a77990", .data =3D &of_r8a77990_compa=
tible, },
-	{ .compatible =3D "renesas,sdhi-r9a09g011", .data =3D &of_rcar_gen3_com=
patible, },
+	{ .compatible =3D "renesas,sdhi-r9a09g011", .data =3D &of_rzv2m_compati=
ble, },
 	{ .compatible =3D "renesas,rcar-gen3-sdhi", .data =3D &of_rcar_gen3_com=
patible, },
 	{},
 };
@@ -329,10 +336,11 @@ static void
 renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 				     struct mmc_data *data)
 {
+	struct renesas_sdhi *priv =3D host_to_priv(host);
 	struct scatterlist *sg =3D host->sg_ptr;
 	u32 dtran_mode =3D DTRAN_MODE_BUS_WIDTH;
=20
-	if (!test_bit(SDHI_INTERNAL_DMAC_ADDR_MODE_FIXED_ONLY, &global_flags))
+	if (!priv->quirks->fixed_addr_mode)
 		dtran_mode |=3D DTRAN_MODE_ADDR_MODE;
=20
 	if (!renesas_sdhi_internal_dmac_map(host, data, COOKIE_MAPPED))
@@ -488,14 +496,10 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_i=
nternal_dmac_dma_ops =3D {
 };
=20
 static const struct soc_device_attribute soc_dma_quirks[] =3D {
-	{ .soc_id =3D "r7s9210",
-	  .data =3D (void *)BIT(SDHI_INTERNAL_DMAC_ADDR_MODE_FIXED_ONLY) },
 	{ .soc_id =3D "r8a7795", .revision =3D "ES1.*",
 	  .data =3D (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
 	{ .soc_id =3D "r8a7796", .revision =3D "ES1.0",
 	  .data =3D (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
-	{ .soc_id =3D "r9a09g011",
-	  .data =3D (void *)BIT(SDHI_INTERNAL_DMAC_ADDR_MODE_FIXED_ONLY) },
 	{ /* sentinel */ }
 };
=20
--=20
2.43.0


