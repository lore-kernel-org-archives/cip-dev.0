Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF911E7717E
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:12:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.33208.1733476327997775455
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:12:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: YhHxTnEhRk+xDrtfZxddBQ==
X-CSE-MsgGUID: ChzBraizSEWcG1V/kwSxYg==
X-IronPort-AV: E=Sophos;i="6.12,213,1728918000"; 
   d="scan'208";a="231085752"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2024 18:12:07 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7EA5441F54E4;
	Fri,  6 Dec 2024 18:11:48 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 13/16] memory: renesas-rpc-if: Use Hi-Z state as the default setting for IOVF pins
Date: Fri,  6 Dec 2024 09:11:19 +0000
Message-ID: <20241206091122.67133-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:12:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17358

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 84d1078af52f6a099267fccfb1dda602ac8b66d0 upstream.

The RZ/{G2L,G2LC,V2L} SMARC EVK uses Micron MT25QU412A flash and RZ/G2UL
SMARC EVK uses Renesas AT25QL128A flash. With current pin setting for
IOVF pin, 4-bit flash write fails for AT25QL128A flash. Use Hi-Z state
as the default for IOVF pin, so that spi controller driver in linux will
be independent of flash type.

To support this, during board production, the bit 4 of the NV config
register must be cleared by the bootloader for Micron flash.

Output from u-boot after clearing bit4 of NVCR register.
=> renesas_micron_flash_nvcr
SF: Detected mt25qu512a with page size 256 Bytes, erase size 64 KiB, total 64 MiB
NVCR=0xef

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20240830203014.199326-2-biju.das.jz@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
[PL: manually applied the patch]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 58bfdf3bd767..0f9610503031 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -362,7 +362,7 @@ int rpcif_hw_init(struct rpcif *rpcif, bool hyperflash)
 		regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
 				   RPCIF_CMNCR_MOIIO(3) | RPCIF_CMNCR_IOFV(3) |
 				   RPCIF_CMNCR_BSZ(3),
-				   RPCIF_CMNCR_MOIIO(1) | RPCIF_CMNCR_IOFV(2) |
+				   RPCIF_CMNCR_MOIIO(1) | RPCIF_CMNCR_IOFV(3) |
 				   RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
 
 	/* Set RCF after BSZ update */
-- 
2.43.0


