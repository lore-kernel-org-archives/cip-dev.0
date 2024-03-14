Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F5FC54E60
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 19:30:12 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.1789.1710444599362286876
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 12:30:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.07,126,1708354800"; 
   d="scan'208";a="201703519"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Mar 2024 04:30:06 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 22F0B4001B5F;
	Fri, 15 Mar 2024 04:30:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 4.19.y-cip 7/9] memory: renesas-rpc-if: Remove redundant division of dummy
Date: Thu, 14 Mar 2024 19:29:48 +0000
Message-Id: <20240314192950.27343-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 19:30:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15315

From: Cong Dang <cong.dang.xn@renesas.com>

commit 637581ce60403a27712c657453a210c8fd17cc66 upstream.

The dummy cycles value was wrongly calculated if dummy.buswidth > 1,
which affects QSPI, OSPI, HyperFlash on various SoCs. We're lucky in
Single SPI case since its dummy.buswidth equals to 1, so the result of
the division is unchanged

This issue can be reproduced using something like the following commands
A. QSPI mode: Mount device with jffs2 format
    jffs2: CLEANMARKER node found at 0x00000004, not first node in block (0x00000000)

B. QSPI mode: Write data to mtd10, where mtd10 is a parition on SPI Flash
storage, defined properly in a device tree

[Correct fragment, read from SPI Flash]

  root@v3x:~# echo "hello" > /dev/mtd10
  root@v3x:~# hexdump -C -n100 /dev/mtd10
  00000000  68 65 6c 6c 6f 0a ff ff  ff ff ff ff ff ff ff ff  |hello...........|
  00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|

[Incorrect read of the same fragment: see the difference at offsets 0-3]

  root@v3x:~# echo "hello" > /dev/mtd10
  root@v3x:~# hexdump -C -n100 /dev/mtd10
  00000000  00 00 00 00 68 65 6c 6c  6f 0a ff ff ff ff ff ff  |....hello.......|
  00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|

As seen from the result, 4 NULL bytes were inserted before the test data.
Wrong calculation in rpcif_prepare() led to miss of some dummy cycle. A
division by bus width is redundant because it had been performed already
in spi-rpc-if.c::rpcif_spi_mem_prepare()

Fix this by removing the redundant division.

Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20230112090655.43367-1-wsa+renesas@sang-engineering.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230207173051.449151-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 2a58e95861ab..5d4d00d07d4f 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -397,8 +397,7 @@ void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
 
 	if (op->dummy.buswidth) {
 		rpc->enable |= RPCIF_SMENR_DME;
-		rpc->dummy = RPCIF_SMDMCR_DMCYC(op->dummy.ncycles /
-						op->dummy.buswidth);
+		rpc->dummy = RPCIF_SMDMCR_DMCYC(op->dummy.ncycles);
 	}
 
 	if (op->option.buswidth) {
-- 
2.34.1


