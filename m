Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C6E7717D
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:11:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.33050.1733476291732809043
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:11:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: vd0w+aQ5So+obcmJISm+/A==
X-CSE-MsgGUID: 9etC0GUcQUyPUV3dlO2LUA==
X-IronPort-AV: E=Sophos;i="6.12,212,1728918000"; 
   d="scan'208";a="227108869"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2024 18:11:36 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6C93F41F54F6;
	Fri,  6 Dec 2024 18:11:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/16] mtd: spi-nor: sysfs: print JEDEC ID for generic flash driver
Date: Fri,  6 Dec 2024 09:11:12 +0000
Message-ID: <20241206091122.67133-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:11:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17346

From: Michael Walle <michael@walle.cc>

commit 0a92de16b61b5d7a52d2910f81325f0506b2fc3b upstream.

We don't have a database entry for the generic SPI-NOR flash driver and
thus we don't have a JEDEC ID to print. Print the (cached) JEDEC ID
instead.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Link: https://lore.kernel.org/r/20220810220654.1297699-8-michael@walle.cc
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mtd/spi-nor/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
index 20563c1926f4..c09bb832b3b9 100644
--- a/drivers/mtd/spi-nor/sysfs.c
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -35,8 +35,10 @@ static ssize_t jedec_id_show(struct device *dev,
 	struct spi_device *spi = to_spi_device(dev);
 	struct spi_mem *spimem = spi_get_drvdata(spi);
 	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+	const u8 *id = nor->info->id_len ? nor->info->id : nor->id;
+	u8 id_len = nor->info->id_len ?: SPI_NOR_MAX_ID_LEN;
 
-	return sysfs_emit(buf, "%*phN\n", nor->info->id_len, nor->info->id);
+	return sysfs_emit(buf, "%*phN\n", id_len, id);
 }
 static DEVICE_ATTR_RO(jedec_id);
 
@@ -76,7 +78,7 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
 
 	if (attr == &dev_attr_manufacturer.attr && !nor->manufacturer)
 		return 0;
-	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len)
+	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len && !nor->id)
 		return 0;
 
 	return 0444;
-- 
2.43.0


