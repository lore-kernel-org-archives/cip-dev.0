Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A433C88E5A
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40053.1789135318092512316
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:01:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DF45143EAB;
	Fri, 11 Sep 2026 14:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7B11F000FF;
	Fri, 11 Sep 2026 14:01:56 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 03/14] mmc: renesas_sdhi: Refactor renesas_sdhi_probe()
Date: Fri, 11 Sep 2026 17:01:40 +0300
Message-ID: <20260911140151.2119555-4-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24135

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 71b7597c63d2ddf6d7e5eb01319f9611af437a7b upstream.

Refactor renesas_sdhi_probe() to avoid increasing numbers of
sdhi_quirks_match[] entry when we add other stable SoCs like
r8a779m*.

Note that the sdhi_quirks_match[] is only needed on
renesas_sdhi_internal_dmac.c so that of_data of
renesas_sdhi_sys_dmac.c keeps as-is.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20210729103234.480743-1-yoshihiro.shimoda=
.uh@renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea:
- in renesas_sdhi_core: fixed conflict by keeping the code from the
  backported commit along with the renesas_sdhi_reset_assert() function
- renesas_sdhi_internal: fixed conflict by keeping the code from the
  backported commit
- kept renesas,sdhi-r8a774e1 and renesas,sdhi-r9a09g011 in
  renesas_sdhi_internal_dmac_of_match[] array; for renesas,sdhi-r8a774e1
  instantiate the of_device_id::data member with of_r8a7795_compatible
  as it is already in upstream, since this is now available]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |   9 +-
 drivers/mmc/host/renesas_sdhi_core.c          |  92 +-----------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 137 +++++++++++++++++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |   3 +-
 4 files changed, 142 insertions(+), 99 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_s=
dhi.h
index 15e9d62a2b0e..9a24d4ff1210 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -42,6 +42,11 @@ struct renesas_sdhi_quirks {
 	const u8 (*hs400_calib_table)[SDHI_CALIB_TABLE_MAX];
 };
=20
+struct renesas_sdhi_of_data_with_quirks {
+	const struct renesas_sdhi_of_data *of_data;
+	const struct renesas_sdhi_quirks *quirks;
+};
+
 struct tmio_mmc_dma {
 	enum dma_slave_buswidth dma_buswidth;
 	bool (*filter)(struct dma_chan *chan, void *arg);
@@ -78,7 +83,9 @@ struct renesas_sdhi {
 	container_of((host)->pdata, struct renesas_sdhi, mmc_data)
=20
 int renesas_sdhi_probe(struct platform_device *pdev,
-		       const struct tmio_mmc_dma_ops *dma_ops);
+		       const struct tmio_mmc_dma_ops *dma_ops,
+		       const struct renesas_sdhi_of_data *of_data,
+		       const struct renesas_sdhi_quirks *quirks);
 int renesas_sdhi_remove(struct platform_device *pdev);
 #ifdef CONFIG_PM_SLEEP
 int renesas_sdhi_suspend(struct device *dev);
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/rene=
sas_sdhi_core.c
index a62ba05b9e5f..0b47198edb3f 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -322,27 +322,6 @@ static int renesas_sdhi_start_signal_voltage_switch(=
struct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
=20
-static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] =3D {
-	{ 3,  3,  3,  3,  3,  3,  3,  4,  4,  5,  6,  7,  8,  9, 10, 15,
-	 16, 16, 16, 16, 16, 16, 17, 18, 18, 19, 20, 21, 22, 23, 24, 25 },
-	{ 5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  6,  7,  8, 11,
-	 12, 17, 18, 18, 18, 18, 18, 18, 18, 19, 20, 21, 22, 23, 25, 25 }
-};
-
-static const u8 r8a77965_calib_table[2][SDHI_CALIB_TABLE_MAX] =3D {
-	{ 1,  2,  6,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 15, 15, 16,
-	 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 26, 27, 28, 29, 30, 31 },
-	{ 2,  3,  4,  4,  5,  6,  7,  9, 10, 11, 12, 13, 14, 15, 16, 17,
-	 17, 17, 20, 21, 22, 23, 24, 25, 27, 28, 29, 30, 31, 31, 31, 31 }
-};
-
-static const u8 r8a77990_calib_table[2][SDHI_CALIB_TABLE_MAX] =3D {
-	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 },
-	{ 0,  0,  0,  1,  2,  3,  3,  4,  4,  4,  5,  5,  6,  8,  9, 10,
-	 11, 12, 13, 15, 16, 17, 17, 18, 18, 19, 20, 22, 24, 25, 26, 26 }
-};
-
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
 {
@@ -919,76 +898,17 @@ static void renesas_sdhi_enable_dma(struct tmio_mmc=
_host *host, bool enable)
 	renesas_sdhi_sdbuf_width(host, enable ? width : 16);
 }
=20
-static const struct renesas_sdhi_quirks sdhi_quirks_4tap_nohs400 =3D {
-	.hs400_disabled =3D true,
-	.hs400_4taps =3D true,
-};
-
-static const struct renesas_sdhi_quirks sdhi_quirks_4tap =3D {
-	.hs400_4taps =3D true,
-	.hs400_bad_taps =3D BIT(2) | BIT(3) | BIT(6) | BIT(7),
-};
-
-static const struct renesas_sdhi_quirks sdhi_quirks_nohs400 =3D {
-	.hs400_disabled =3D true,
-};
-
-static const struct renesas_sdhi_quirks sdhi_quirks_bad_taps1357 =3D {
-	.hs400_bad_taps =3D BIT(1) | BIT(3) | BIT(5) | BIT(7),
-};
-
-static const struct renesas_sdhi_quirks sdhi_quirks_bad_taps2367 =3D {
-	.hs400_bad_taps =3D BIT(2) | BIT(3) | BIT(6) | BIT(7),
-};
-
-static const struct renesas_sdhi_quirks sdhi_quirks_r8a7796_es13 =3D {
-	.hs400_4taps =3D true,
-	.hs400_bad_taps =3D BIT(2) | BIT(3) | BIT(6) | BIT(7),
-	.hs400_calib_table =3D r8a7796_es13_calib_table,
-};
-
-static const struct renesas_sdhi_quirks sdhi_quirks_r8a77965 =3D {
-	.hs400_bad_taps =3D BIT(2) | BIT(3) | BIT(6) | BIT(7),
-	.hs400_calib_table =3D r8a77965_calib_table,
-};
-
-static const struct renesas_sdhi_quirks sdhi_quirks_r8a77990 =3D {
-	.hs400_calib_table =3D r8a77990_calib_table,
-};
-
-/*
- * Note for r8a7796 / r8a774a1: we can't distinguish ES1.1 and 1.2 as of=
 now.
- * So, we want to treat them equally and only have a match for ES1.2 to =
enforce
- * this if there ever will be a way to distinguish ES1.2.
- */
-static const struct soc_device_attribute sdhi_quirks_match[]  =3D {
-	{ .soc_id =3D "r8a774a1", .revision =3D "ES1.[012]", .data =3D &sdhi_qu=
irks_4tap_nohs400 },
-	{ .soc_id =3D "r8a774e1", .revision =3D "ES3.*", .data =3D &sdhi_quirks=
_bad_taps2367 },
-	{ .soc_id =3D "r8a7795", .revision =3D "ES1.*", .data =3D &sdhi_quirks_=
4tap_nohs400 },
-	{ .soc_id =3D "r8a7795", .revision =3D "ES2.0", .data =3D &sdhi_quirks_=
4tap },
-	{ .soc_id =3D "r8a7795", .revision =3D "ES3.*", .data =3D &sdhi_quirks_=
bad_taps2367 },
-	{ .soc_id =3D "r8a7796", .revision =3D "ES1.[012]", .data =3D &sdhi_qui=
rks_4tap_nohs400 },
-	{ .soc_id =3D "r8a7796", .revision =3D "ES1.*", .data =3D &sdhi_quirks_=
r8a7796_es13 },
-	{ .soc_id =3D "r8a77961", .data =3D &sdhi_quirks_bad_taps1357 },
-	{ .soc_id =3D "r8a77965", .data =3D &sdhi_quirks_r8a77965 },
-	{ .soc_id =3D "r8a77980", .data =3D &sdhi_quirks_nohs400 },
-	{ .soc_id =3D "r8a77990", .data =3D &sdhi_quirks_r8a77990 },
-	{ .soc_id =3D "r9a09g011", .data =3D &sdhi_quirks_nohs400 },
-	{ /* Sentinel. */ },
-};
-
 static void renesas_sdhi_reset_assert(void *data)
 {
 	reset_control_assert(data);
 }
=20
 int renesas_sdhi_probe(struct platform_device *pdev,
-		       const struct tmio_mmc_dma_ops *dma_ops)
+		       const struct tmio_mmc_dma_ops *dma_ops,
+		       const struct renesas_sdhi_of_data *of_data,
+		       const struct renesas_sdhi_quirks *quirks)
 {
 	struct tmio_mmc_data *mmd =3D pdev->dev.platform_data;
-	const struct renesas_sdhi_quirks *quirks =3D NULL;
-	const struct renesas_sdhi_of_data *of_data;
-	const struct soc_device_attribute *attr;
 	struct tmio_mmc_data *mmc_data;
 	struct tmio_mmc_dma *dma_priv;
 	struct tmio_mmc_host *host;
@@ -997,12 +917,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	struct resource *res;
 	u16 ver;
=20
-	of_data =3D of_device_get_match_data(&pdev->dev);
-
-	attr =3D soc_device_match(sdhi_quirks_match);
-	if (attr)
-		quirks =3D attr->data;
-
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -EINVAL;
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
index 359ce4703e4d..1e176e0b98ed 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -15,6 +15,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
 #include <linux/sys_soc.h>
@@ -92,7 +93,7 @@ static struct renesas_sdhi_scc rcar_gen3_scc_taps[] =3D=
 {
 	},
 };
=20
-static const struct renesas_sdhi_of_data of_rza2_compatible =3D {
+static const struct renesas_sdhi_of_data of_data_rza2 =3D {
 	.tmio_flags	=3D TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY,
 	.tmio_ocr_mask	=3D MMC_VDD_32_33,
@@ -107,7 +108,11 @@ static const struct renesas_sdhi_of_data of_rza2_com=
patible =3D {
 	.max_segs	=3D 1,
 };
=20
-static const struct renesas_sdhi_of_data of_rcar_gen3_compatible =3D {
+static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible =
=3D {
+	.of_data	=3D &of_data_rza2,
+};
+
+static const struct renesas_sdhi_of_data of_data_rcar_gen3 =3D {
 	.tmio_flags	=3D TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
 			  TMIO_MMC_64BIT_DATA_PORT,
@@ -123,12 +128,117 @@ static const struct renesas_sdhi_of_data of_rcar_g=
en3_compatible =3D {
 	.max_segs	=3D 1,
 };
=20
+static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] =3D {
+	{ 3,  3,  3,  3,  3,  3,  3,  4,  4,  5,  6,  7,  8,  9, 10, 15,
+	 16, 16, 16, 16, 16, 16, 17, 18, 18, 19, 20, 21, 22, 23, 24, 25 },
+	{ 5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  5,  6,  7,  8, 11,
+	 12, 17, 18, 18, 18, 18, 18, 18, 18, 19, 20, 21, 22, 23, 25, 25 }
+};
+
+static const u8 r8a77965_calib_table[2][SDHI_CALIB_TABLE_MAX] =3D {
+	{ 1,  2,  6,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 15, 15, 16,
+	 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 26, 27, 28, 29, 30, 31 },
+	{ 2,  3,  4,  4,  5,  6,  7,  9, 10, 11, 12, 13, 14, 15, 16, 17,
+	 17, 17, 20, 21, 22, 23, 24, 25, 27, 28, 29, 30, 31, 31, 31, 31 }
+};
+
+static const u8 r8a77990_calib_table[2][SDHI_CALIB_TABLE_MAX] =3D {
+	{ 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
+	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 },
+	{ 0,  0,  0,  1,  2,  3,  3,  4,  4,  4,  5,  5,  6,  8,  9, 10,
+	 11, 12, 13, 15, 16, 17, 17, 18, 18, 19, 20, 22, 24, 25, 26, 26 }
+};
+
+static const struct renesas_sdhi_quirks sdhi_quirks_4tap_nohs400 =3D {
+	.hs400_disabled =3D true,
+	.hs400_4taps =3D true,
+};
+
+static const struct renesas_sdhi_quirks sdhi_quirks_4tap =3D {
+	.hs400_4taps =3D true,
+	.hs400_bad_taps =3D BIT(2) | BIT(3) | BIT(6) | BIT(7),
+};
+
+static const struct renesas_sdhi_quirks sdhi_quirks_nohs400 =3D {
+	.hs400_disabled =3D true,
+};
+
+static const struct renesas_sdhi_quirks sdhi_quirks_bad_taps1357 =3D {
+	.hs400_bad_taps =3D BIT(1) | BIT(3) | BIT(5) | BIT(7),
+};
+
+static const struct renesas_sdhi_quirks sdhi_quirks_bad_taps2367 =3D {
+	.hs400_bad_taps =3D BIT(2) | BIT(3) | BIT(6) | BIT(7),
+};
+
+static const struct renesas_sdhi_quirks sdhi_quirks_r8a7796_es13 =3D {
+	.hs400_4taps =3D true,
+	.hs400_bad_taps =3D BIT(2) | BIT(3) | BIT(6) | BIT(7),
+	.hs400_calib_table =3D r8a7796_es13_calib_table,
+};
+
+static const struct renesas_sdhi_quirks sdhi_quirks_r8a77965 =3D {
+	.hs400_bad_taps =3D BIT(2) | BIT(3) | BIT(6) | BIT(7),
+	.hs400_calib_table =3D r8a77965_calib_table,
+};
+
+static const struct renesas_sdhi_quirks sdhi_quirks_r8a77990 =3D {
+	.hs400_calib_table =3D r8a77990_calib_table,
+};
+
+/*
+ * Note for r8a7796 / r8a774a1: we can't distinguish ES1.1 and 1.2 as of=
 now.
+ * So, we want to treat them equally and only have a match for ES1.2 to =
enforce
+ * this if there ever will be a way to distinguish ES1.2.
+ */
+static const struct soc_device_attribute sdhi_quirks_match[]  =3D {
+	{ .soc_id =3D "r8a774a1", .revision =3D "ES1.[012]", .data =3D &sdhi_qu=
irks_4tap_nohs400 },
+	{ .soc_id =3D "r8a7795", .revision =3D "ES1.*", .data =3D &sdhi_quirks_=
4tap_nohs400 },
+	{ .soc_id =3D "r8a7795", .revision =3D "ES2.0", .data =3D &sdhi_quirks_=
4tap },
+	{ .soc_id =3D "r8a7796", .revision =3D "ES1.[012]", .data =3D &sdhi_qui=
rks_4tap_nohs400 },
+	{ .soc_id =3D "r8a7796", .revision =3D "ES1.*", .data =3D &sdhi_quirks_=
r8a7796_es13 },
+	{ /* Sentinel. */ },
+};
+
+static const struct renesas_sdhi_of_data_with_quirks of_r8a7795_compatib=
le =3D {
+	.of_data =3D &of_data_rcar_gen3,
+	.quirks =3D &sdhi_quirks_bad_taps2367,
+};
+
+static const struct renesas_sdhi_of_data_with_quirks of_r8a77961_compati=
ble =3D {
+	.of_data =3D &of_data_rcar_gen3,
+	.quirks =3D &sdhi_quirks_bad_taps1357,
+};
+
+static const struct renesas_sdhi_of_data_with_quirks of_r8a77965_compati=
ble =3D {
+	.of_data =3D &of_data_rcar_gen3,
+	.quirks =3D &sdhi_quirks_r8a77965,
+};
+
+static const struct renesas_sdhi_of_data_with_quirks of_r8a77980_compati=
ble =3D {
+	.of_data =3D &of_data_rcar_gen3,
+	.quirks =3D &sdhi_quirks_nohs400,
+};
+
+static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compati=
ble =3D {
+	.of_data =3D &of_data_rcar_gen3,
+	.quirks =3D &sdhi_quirks_r8a77990,
+};
+
+static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compat=
ible =3D {
+	.of_data =3D &of_data_rcar_gen3,
+};
+
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] =3D=
 {
 	{ .compatible =3D "renesas,sdhi-r7s9210", .data =3D &of_rza2_compatible=
, },
 	{ .compatible =3D "renesas,sdhi-mmc-r8a77470", .data =3D &of_rcar_gen3_=
compatible, },
-	{ .compatible =3D "renesas,sdhi-r8a774e1", .data =3D &of_rcar_gen3_comp=
atible, },
-	{ .compatible =3D "renesas,sdhi-r8a7795", .data =3D &of_rcar_gen3_compa=
tible, },
+	{ .compatible =3D "renesas,sdhi-r8a774e1", .data =3D &of_r8a7795_compat=
ible, },
+	{ .compatible =3D "renesas,sdhi-r8a7795", .data =3D &of_r8a7795_compati=
ble, },
 	{ .compatible =3D "renesas,sdhi-r8a7796", .data =3D &of_rcar_gen3_compa=
tible, },
+	{ .compatible =3D "renesas,sdhi-r8a77961", .data =3D &of_r8a77961_compa=
tible, },
+	{ .compatible =3D "renesas,sdhi-r8a77965", .data =3D &of_r8a77965_compa=
tible, },
+	{ .compatible =3D "renesas,sdhi-r8a77980", .data =3D &of_r8a77980_compa=
tible, },
+	{ .compatible =3D "renesas,sdhi-r8a77990", .data =3D &of_r8a77990_compa=
tible, },
 	{ .compatible =3D "renesas,sdhi-r9a09g011", .data =3D &of_rcar_gen3_com=
patible, },
 	{ .compatible =3D "renesas,rcar-gen3-sdhi", .data =3D &of_rcar_gen3_com=
patible, },
 	{},
@@ -395,16 +505,27 @@ static const struct soc_device_attribute soc_dma_qu=
irks[] =3D {
=20
 static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev=
)
 {
-	const struct soc_device_attribute *soc =3D soc_device_match(soc_dma_qui=
rks);
+	const struct soc_device_attribute *attr;
+	const struct renesas_sdhi_of_data_with_quirks *of_data_quirks;
+	const struct renesas_sdhi_quirks *quirks;
 	struct device *dev =3D &pdev->dev;
=20
-	if (soc)
-		global_flags |=3D (unsigned long)soc->data;
+	of_data_quirks =3D of_device_get_match_data(&pdev->dev);
+	quirks =3D of_data_quirks->quirks;
+
+	attr =3D soc_device_match(soc_dma_quirks);
+	if (attr)
+		global_flags |=3D (unsigned long)attr->data;
+
+	attr =3D soc_device_match(sdhi_quirks_match);
+	if (attr)
+		quirks =3D attr->data;
=20
 	/* value is max of SD_SECCNT. Confirmed by HW engineers */
 	dma_set_max_seg_size(dev, 0xffffffff);
=20
-	return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops);
+	return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops,
+				  of_data_quirks->of_data, quirks);
 }
=20
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops =3D=
 {
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/=
renesas_sdhi_sys_dmac.c
index c5f789675302..5db018a50119 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -449,7 +449,8 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_sys=
_dmac_dma_ops =3D {
=20
 static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
 {
-	return renesas_sdhi_probe(pdev, &renesas_sdhi_sys_dmac_dma_ops);
+	return renesas_sdhi_probe(pdev, &renesas_sdhi_sys_dmac_dma_ops,
+				  of_device_get_match_data(&pdev->dev), NULL);
 }
=20
 static const struct dev_pm_ops renesas_sdhi_sys_dmac_dev_pm_ops =3D {
--=20
2.43.0


