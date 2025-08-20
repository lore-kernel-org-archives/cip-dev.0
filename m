Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC11CA0EFD
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.15343.1755679641016086371
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: +Jdiz2U/QtafR1vBhtYF6w==
X-CSE-MsgGUID: 5TOGULTzS/2Di9zIfSyyyQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 84E9440138ED;
	Wed, 20 Aug 2025 17:47:27 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 16/23] memory: renesas-rpc-if: Add regmap to struct rpcif_info
Date: Wed, 20 Aug 2025 09:46:02 +0100
Message-ID: <20250820084645.6988-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19811

commit 198158a8f64cf150325f68044274e21ab0aa69c8 upstream.

The RZ/G3E XSPI has different regmap compared to RPC-IF. Add regmap to
struct rpcif_info in order to support RZ/G3E XSPI.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250424090000.136804-5-biju.das.jz@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index d818c91b7055d..63aec3e67ee41 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -32,6 +32,7 @@ static const struct regmap_access_table rpcif_volatile_table = {
 };
 
 struct rpcif_info {
+	const struct regmap_config *regmap_config;
 	enum rpcif_type type;
 	u8 strtim;
 };
@@ -588,8 +589,8 @@ static int rpcif_probe(struct platform_device *pdev)
 	rpc->base = devm_platform_ioremap_resource_byname(pdev, "regs");
 	if (IS_ERR(rpc->base))
 		return PTR_ERR(rpc->base);
-
-	rpc->regmap = devm_regmap_init(dev, NULL, rpc, &rpcif_regmap_config);
+	rpc->info = of_device_get_match_data(dev);
+	rpc->regmap = devm_regmap_init(dev, NULL, rpc, rpc->info->regmap_config);
 	if (IS_ERR(rpc->regmap)) {
 		dev_err(dev, "failed to init regmap for rpcif, error %ld\n",
 			PTR_ERR(rpc->regmap));
@@ -602,7 +603,6 @@ static int rpcif_probe(struct platform_device *pdev)
 		return PTR_ERR(rpc->dirmap);
 
 	rpc->size = resource_size(res);
-	rpc->info = of_device_get_match_data(dev);
 	rpc->rstc = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(rpc->rstc))
 		return PTR_ERR(rpc->rstc);
@@ -633,21 +633,25 @@ static void rpcif_remove(struct platform_device *pdev)
 }
 
 static const struct rpcif_info rpcif_info_r8a7796 = {
+	.regmap_config = &rpcif_regmap_config,
 	.type = RPCIF_RCAR_GEN3,
 	.strtim = 6,
 };
 
 static const struct rpcif_info rpcif_info_gen3 = {
+	.regmap_config = &rpcif_regmap_config,
 	.type = RPCIF_RCAR_GEN3,
 	.strtim = 7,
 };
 
 static const struct rpcif_info rpcif_info_rz_g2l = {
+	.regmap_config = &rpcif_regmap_config,
 	.type = RPCIF_RZ_G2L,
 	.strtim = 7,
 };
 
 static const struct rpcif_info rpcif_info_gen4 = {
+	.regmap_config = &rpcif_regmap_config,
 	.type = RPCIF_RCAR_GEN4,
 	.strtim = 15,
 };
-- 
2.43.0


