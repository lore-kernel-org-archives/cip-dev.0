Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CEBC4829E
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:28:05 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20166.1707222484157462118
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:28:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="196960616"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Feb 2024 21:28:03 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2F1C54005E16;
	Tue,  6 Feb 2024 21:28:01 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 13/44] of: also handle dma-noncoherent in of_dma_is_coherent()
Date: Tue,  6 Feb 2024 12:27:03 +0000
Message-Id: <20240206122734.13477-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:28:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14797

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
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/of/address.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index f686fb5011b87..557a4be011034 100644
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


