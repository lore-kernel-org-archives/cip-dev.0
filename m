Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C6AC88E58
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40210.1789135323732606087
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8817E43FE0;
	Fri, 11 Sep 2026 14:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856D91F000FF;
	Fri, 11 Sep 2026 14:02:02 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 07/14] mmc: renesas_sdhi: make 'dmac_only_one_rx' a quirk
Date: Fri, 11 Sep 2026 17:01:44 +0300
Message-ID: <20260911140151.2119555-8-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24139

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit bcfa7f15eb1657ec16a9c2cf8d93c5aef8e8e39f upstream.

After Shimoda-san's much appreciated refactoring of the quirk handling,
we can convert now 'dmac_only_one_rx' from an ugly global flag to a
regular quirk. This makes quirk handling more consistent and easier to
maintain. After this patch, soc_dma_quirks is completely gone, hooray!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20220320123016.57991-7-wsa+renesas@sang-e=
ngineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  1 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 28 ++++++++-----------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_s=
dhi.h
index 3e9014e976c4..7fc95206e4fd 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -39,6 +39,7 @@ struct renesas_sdhi_quirks {
 	bool hs400_disabled;
 	bool hs400_4taps;
 	bool fixed_addr_mode;
+	bool dma_one_rx_only;
 	u32 hs400_bad_taps;
 	const u8 (*hs400_calib_table)[SDHI_CALIB_TABLE_MAX];
 };
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
index 4d496a9b7080..2f37b6f1f1c1 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -78,8 +78,7 @@ static unsigned long global_flags;
  * stored into the system memory even if the DMAC interrupt happened.
  * So, this driver then uses one RX DMAC channel only.
  */
-#define SDHI_INTERNAL_DMAC_ONE_RX_ONLY	0
-#define SDHI_INTERNAL_DMAC_RX_IN_USE	1
+#define SDHI_INTERNAL_DMAC_RX_IN_USE	0
=20
 /* Definitions for sampling clocks */
 static struct renesas_sdhi_scc rcar_gen3_scc_taps[] =3D {
@@ -147,6 +146,12 @@ static const struct renesas_sdhi_quirks sdhi_quirks_=
4tap_nohs400 =3D {
 	.hs400_4taps =3D true,
 };
=20
+static const struct renesas_sdhi_quirks sdhi_quirks_4tap_nohs400_one_rx =
=3D {
+	.hs400_disabled =3D true,
+	.hs400_4taps =3D true,
+	.dma_one_rx_only =3D true,
+};
+
 static const struct renesas_sdhi_quirks sdhi_quirks_4tap =3D {
 	.hs400_4taps =3D true,
 	.hs400_bad_taps =3D BIT(2) | BIT(3) | BIT(6) | BIT(7),
@@ -190,9 +195,10 @@ static const struct renesas_sdhi_quirks sdhi_quirks_=
r8a77990 =3D {
  */
 static const struct soc_device_attribute sdhi_quirks_match[]  =3D {
 	{ .soc_id =3D "r8a774a1", .revision =3D "ES1.[012]", .data =3D &sdhi_qu=
irks_4tap_nohs400 },
-	{ .soc_id =3D "r8a7795", .revision =3D "ES1.*", .data =3D &sdhi_quirks_=
4tap_nohs400 },
+	{ .soc_id =3D "r8a7795", .revision =3D "ES1.*", .data =3D &sdhi_quirks_=
4tap_nohs400_one_rx },
 	{ .soc_id =3D "r8a7795", .revision =3D "ES2.0", .data =3D &sdhi_quirks_=
4tap },
-	{ .soc_id =3D "r8a7796", .revision =3D "ES1.[012]", .data =3D &sdhi_qui=
rks_4tap_nohs400 },
+	{ .soc_id =3D "r8a7796", .revision =3D "ES1.0", .data =3D &sdhi_quirks_=
4tap_nohs400_one_rx },
+	{ .soc_id =3D "r8a7796", .revision =3D "ES1.[12]", .data =3D &sdhi_quir=
ks_4tap_nohs400 },
 	{ .soc_id =3D "r8a7796", .revision =3D "ES1.*", .data =3D &sdhi_quirks_=
r8a7796_es13 },
 	{ /* Sentinel. */ },
 };
@@ -348,7 +354,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_=
host *host,
=20
 	if (data->flags & MMC_DATA_READ) {
 		dtran_mode |=3D DTRAN_MODE_CH_NUM_CH1;
-		if (test_bit(SDHI_INTERNAL_DMAC_ONE_RX_ONLY, &global_flags) &&
+		if (priv->quirks->dma_one_rx_only &&
 		    test_and_set_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags))
 			goto force_pio_with_unmap;
 	} else {
@@ -495,14 +501,6 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_in=
ternal_dmac_dma_ops =3D {
 	.end =3D renesas_sdhi_internal_dmac_end_dma,
 };
=20
-static const struct soc_device_attribute soc_dma_quirks[] =3D {
-	{ .soc_id =3D "r8a7795", .revision =3D "ES1.*",
-	  .data =3D (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
-	{ .soc_id =3D "r8a7796", .revision =3D "ES1.0",
-	  .data =3D (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
-	{ /* sentinel */ }
-};
-
 static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev=
)
 {
 	const struct soc_device_attribute *attr;
@@ -513,10 +511,6 @@ static int renesas_sdhi_internal_dmac_probe(struct p=
latform_device *pdev)
 	of_data_quirks =3D of_device_get_match_data(&pdev->dev);
 	quirks =3D of_data_quirks->quirks;
=20
-	attr =3D soc_device_match(soc_dma_quirks);
-	if (attr)
-		global_flags |=3D (unsigned long)attr->data;
-
 	attr =3D soc_device_match(sdhi_quirks_match);
 	if (attr)
 		quirks =3D attr->data;
--=20
2.43.0


