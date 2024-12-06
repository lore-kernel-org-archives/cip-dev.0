Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73858E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:05:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.33137.1733475935173386693
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:05:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: WGPo9p0pRZGv/e/Axgeq1g==
X-CSE-MsgGUID: CPL5NazxRtSUkH8n5Kt3DA==
X-IronPort-AV: E=Sophos;i="6.12,212,1728918000"; 
   d="scan'208";a="227108027"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2024 18:05:33 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 76CD0400C4D5;
	Fri,  6 Dec 2024 18:05:27 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/8] mtd: spi-nor: atmel: Add support for AT25QL128A serial NOR flash
Date: Fri,  6 Dec 2024 09:05:17 +0000
Message-ID: <20241206090524.66639-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:05:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17335

In the upstream kernel, the generic SPI-NOR driver parses the SFDP
information to detect flash chips. However, this functionality is missing
in the 5.10-cip kernel. To enable detection of the AT25QL128A serial NOR
flash on 5.10-cip, this patch adds an entry for the chip in the driver.

Link for the AT25QL128A serial NOR flash datasheet:
https://www.renesas.com/en/document/dst/at25ql128a-datasheet?r=1608586

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mtd/spi-nor/atmel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index deacf87a68a0..c3e539562c28 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -70,6 +70,7 @@ static const struct flash_info atmel_parts[] = {
 	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 
+	{ "at25ql128a", INFO(0x1f4218, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
 	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K | SPI_NOR_HAS_LOCK) },
-- 
2.43.0


