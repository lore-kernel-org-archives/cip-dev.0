Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D661BC4332F
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:26 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.31207.1643631563602998327
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108906307"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 94FE64347FE1;
	Mon, 31 Jan 2022 21:19:24 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 15/27] memory: renesas-rpc-if: correct whitespace
Date: Mon, 31 Jan 2022 12:18:51 +0000
Message-Id: <20220131121903.8620-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7536

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

commit 8c84a7335e71de1f045247eb035d55712e13222a upstream.

Use spaces instead of tabs as word separator.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20210601160608.312446-1-krzysztof.kozlowski@canonical.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/memory/renesas-rpc-if.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 2df18b7a35fa..77c694a19149 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -19,7 +19,7 @@ enum rpcif_data_dir {
 	RPCIF_DATA_OUT,
 };
 
-struct	rpcif_op {
+struct rpcif_op {
 	struct {
 		u8 buswidth;
 		u8 opcode;
@@ -57,7 +57,7 @@ struct	rpcif_op {
 	} data;
 };
 
-struct	rpcif {
+struct rpcif {
 	struct device *dev;
 	void __iomem *base;
 	void __iomem *dirmap;
@@ -77,7 +77,7 @@ struct	rpcif {
 	u32 ddr;		/* DRDRENR or SMDRENR */
 };
 
-int  rpcif_sw_init(struct rpcif *rpc, struct device *dev);
+int rpcif_sw_init(struct rpcif *rpc, struct device *dev);
 void rpcif_hw_init(struct rpcif *rpc, bool hyperflash);
 void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
 		   size_t *len);
-- 
2.17.1


