Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D63C48295
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:42:16 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.61925.1707136928406421430
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:42:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="192915841"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2024 21:42:13 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6CD6940065B6;
	Mon,  5 Feb 2024 21:42:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 17/48] of: also handle dma-noncoherent in of_dma_is_coherent()
Date: Mon,  5 Feb 2024 12:41:04 +0000
Message-Id: <20240205124135.14779-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:42:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14686

From: Heiko Stuebner <heiko@sntech.de>

commit 12b827758f51d4b614a677dd453b0e854e46aa65 upstream.

of_dma_is_coherent() currently expects the architecture to be
non-coherent and some devices being coherent getting marked
as such with the dma-coherent devicetree property.

For PowerPC CONFIG_OF_DMA_DEFAULT_COHERENT was added which currently
makes of_dma_is_coherent() always return true but doesn't handle
the case of the architecture being coherent but some devices not.

So modify the function to also check for dma-noncoherent and
set a suitable default return value. If CONFIG_OF_DMA_DEFAULT_COHERENT
is set the value starts with true and finding dma-noncoherent will
set it to false and without CONFIG_OF_DMA_DEFAULT_COHERENT, the
behaviour is reversed.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20220706231536.2041855-2-heiko@sntech.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/of/address.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index f686fb5011b8..557a4be01103 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1081,25 +1081,28 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
  *
  * It returns true if "dma-coherent" property was found
  * for this device in the DT, or if DMA is coherent by
- * default for OF devices on the current platform.
+ * default for OF devices on the current platform and no
+ * "dma-noncoherent" property was found for this device.
  */
 bool of_dma_is_coherent(struct device_node *np)
 {
 	struct device_node *node;
-
-	if (IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT))
-		return true;
+	bool is_coherent = IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT);
 
 	node = of_node_get(np);
 
 	while (node) {
 		if (of_property_read_bool(node, "dma-coherent")) {
-			of_node_put(node);
-			return true;
+			is_coherent = true;
+			break;
+		}
+		if (of_property_read_bool(node, "dma-noncoherent")) {
+			is_coherent = false;
+			break;
 		}
 		node = of_get_next_dma_parent(node);
 	}
 	of_node_put(node);
-	return false;
+	return is_coherent;
 }
 EXPORT_SYMBOL_GPL(of_dma_is_coherent);
-- 
2.34.1


