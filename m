Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62589E7717B
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:05:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.32981.1733475934872725095
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:05:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: zA7/jwkJQZWPzNL1hwMTlw==
X-CSE-MsgGUID: tNbIz+dmThe1xLVuLp+9lw==
X-IronPort-AV: E=Sophos;i="6.12,212,1728918000"; 
   d="scan'208";a="227108031"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2024 18:05:33 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 62BD6400C4DD;
	Fri,  6 Dec 2024 18:05:29 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/8] spi: rpc-if: differentiate between unsupported and invalid requests
Date: Fri,  6 Dec 2024 09:05:18 +0000
Message-ID: <20241206090524.66639-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:05:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17336

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 615725a9a8c8aa0976a1469b88a1e5d696e25eb0 upstream.

If the request is out of range, returning -EINVAL seems a better pick
than -ENOTSUPP.

>From a caller (and reviewer) point of view, distinguising between the
two may be helpful because somehow one can be "fixed" while the other
will always be refused no matter how hard we try.

As part of a wider work to bring spi-nand continuous reads, it was
useful to easily catch the upper limit direct mapping boundaries for
each controller, with the idea of enlarging this area from a page to an
eraseblock, without risking too many regressions.

In all other cases, as part of a wider work towards using -EOPNOTSUP
rather than -ENOTSUPP (which is not a SUSV4 code), let's change the
error code to be uniform across spi-mem controller drivers.

Finally, reword a little bit the conditions to clarify what is intended
(ie. checking for the presence of a direct mapping, and also ensuring we
create a dirmap only on DATA_IN flows).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://msgid.link/r/20240522145255.995778-4-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 0f8096d7d7b0..b71d8d8f7f50 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -95,16 +95,16 @@ static int rpcif_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
 		spi_controller_get_devdata(desc->mem->spi->controller);
 
 	if (desc->info.offset + desc->info.length > U32_MAX)
-		return -ENOTSUPP;
+		return -EINVAL;
 
 	if (!rpcif_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
-	if (!rpc->dirmap && desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
-		return -ENOTSUPP;
+	if (!rpc->dirmap)
+		return -EOPNOTSUPP;
 
-	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
-		return -ENOTSUPP;
+	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+		return -EOPNOTSUPP;
 
 	return 0;
 }
-- 
2.43.0


