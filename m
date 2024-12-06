Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A99E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:11:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.33196.1733476295380879987
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:11:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: DchrC2RgSb217NH2BTJUrQ==
X-CSE-MsgGUID: WknxSANvS7Cgyq4ECICXow==
X-IronPort-AV: E=Sophos;i="6.12,213,1728918000"; 
   d="scan'208";a="231085668"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2024 18:11:34 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 88EE941F4DE1;
	Fri,  6 Dec 2024 18:11:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 05/16] mtd: spi-nor: add generic flash driver
Date: Fri,  6 Dec 2024 09:11:11 +0000
Message-ID: <20241206091122.67133-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:11:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17345

From: Michael Walle <michael@walle.cc>

commit 773bbe10449731c9525457873e0c2342e5cf883b upstream.

Our SFDP parsing is everything we need to support all basic operations
of a flash device. If the flash isn't found in our in-kernel flash
database, gracefully fall back to a driver described solely by its SFDP
tables.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Tested-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Link: https://lore.kernel.org/r/20220810220654.1297699-7-michael@walle.cc
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mtd/spi-nor/core.c | 26 ++++++++++++++++++++++++--
 drivers/mtd/spi-nor/core.h |  1 +
 drivers/mtd/spi-nor/sfdp.c | 27 +++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4dba8dc989b5..02d5362f6878 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1636,6 +1636,16 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_xmc,
 };
 
+static const struct flash_info spi_nor_generic_flash = {
+	.name = "spi-nor-generic",
+	/*
+	 * JESD216 rev A doesn't specify the page size, therefore we need a
+	 * sane default.
+	 */
+	.page_size = 256,
+	.parse_sfdp = true,
+};
+
 static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
 						 const u8 *id)
 {
@@ -1674,6 +1684,14 @@ static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
 		return ERR_PTR(-ENOMEM);
 
 	info = spi_nor_match_id(nor, id);
+
+	/* Fallback to a generic flash described only by its SFDP data. */
+	if (!info) {
+		ret = spi_nor_check_sfdp_signature(nor);
+		if (!ret)
+			info = &spi_nor_generic_flash;
+	}
+
 	if (!info) {
 		dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
 			SPI_NOR_MAX_ID_LEN, id);
@@ -2110,8 +2128,12 @@ static int spi_nor_select_pp(struct spi_nor *nor,
  * spi_nor_select_uniform_erase() - select optimum uniform erase type
  * @map:		the erase map of the SPI NOR
  * @wanted_size:	the erase type size to search for. Contains the value of
- *			info->sector_size or of the "small sector" size in case
- *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined.
+ *			info->sector_size, the "small sector" size in case
+ *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined or 0 if
+ *			there is no information about the sector size. The
+ *			latter is the case if the flash parameters are parsed
+ *			solely by SFDP, then the largest supported erase type
+ *			is selected.
  *
  * Once the optimum uniform sector erase command is found, disable all the
  * other.
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index b688dc3637a4..75ec2e560424 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -708,6 +708,7 @@ int spi_nor_controller_ops_read_reg(struct spi_nor *nor, u8 opcode,
 int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
 				     const u8 *buf, size_t len);
 
+int spi_nor_check_sfdp_signature(struct spi_nor *nor);
 int spi_nor_parse_sfdp(struct spi_nor *nor);
 
 static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 78110387be0b..024615fcfec4 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1249,6 +1249,33 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor)
 		nor->info->fixups->post_sfdp(nor);
 }
 
+/**
+ * spi_nor_check_sfdp_signature() - check for a valid SFDP signature
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * Used to detect if the flash supports the RDSFDP command as well as the
+ * presence of a valid SFDP table.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_check_sfdp_signature(struct spi_nor *nor)
+{
+	u32 signature;
+	int err;
+
+	/* Get the SFDP header. */
+	err = spi_nor_read_sfdp_dma_unsafe(nor, 0, sizeof(signature),
+					   &signature);
+	if (err < 0)
+		return err;
+
+	/* Check the SFDP signature. */
+	if (le32_to_cpu(signature) != SFDP_SIGNATURE)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
-- 
2.43.0


