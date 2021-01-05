Return-Path: <SRS0=jwqY=GI=lists.cip-project.org=bounce+64572+6006+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C2CC433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C792073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C792073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6006+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lg48YY4521723xv4PNGsdqpP; Tue, 05 Jan 2021 05:58:08 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.5338.1609855082309757812
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:08 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="68085820"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2021 22:58:07 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D6BF64254F73;
	Tue,  5 Jan 2021 22:58:06 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 06/17] memory: renesas-rpc-if: Make rpcif_enable/disable_rpm() as static inline
Date: Tue,  5 Jan 2021 13:57:46 +0000
Message-Id: <20210105135757.11069-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ilp7GIXIvdXlYRLzuCkKCeO4x4520388AA=
Content-Type: multipart/mixed; boundary="iK1VERIwq1lFmxdztew1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855088;
 bh=lIOQSXRddK5Sx7R5f7Crn1EYhNiggTG/fnWepucCST4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ltShWttafk6c1CuYGhXzZkU/3Rs22fpNyfTyRTfgDduiXZKQNDSvnVJKO3yCR8ESOol
 QBknBzryAdyP/c1gEcB6EInJznarLwBTC8LrM6x9KmxMqqKVqDi9ecjwcCqaitYGhGdw2
 RXD7cb6KXQbv+/wtO2zGQVguoz6YLOLKQbQ=

--iK1VERIwq1lFmxdztew1

commit 7889a7da59e0131ac60b858c73a3604ef88b1d96 upstream.

Define rpcif_enable_rpm() and rpcif_disable_rpm() as static
inline in the header instead of exporting them.

Suggested-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Pavel Machek (CIP) <pavel@denx.de>
Link: https://lore.kernel.org/r/20201126191146.8753-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 13 -------------
 include/memory/renesas-rpc-if.h | 13 +++++++++++--
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 1e7b937b739a..5f650eb3e9e7 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -206,18 +205,6 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 }
 EXPORT_SYMBOL(rpcif_sw_init);
 
-void rpcif_enable_rpm(struct rpcif *rpc)
-{
-	pm_runtime_enable(rpc->dev);
-}
-EXPORT_SYMBOL(rpcif_enable_rpm);
-
-void rpcif_disable_rpm(struct rpcif *rpc)
-{
-	pm_runtime_disable(rpc->dev);
-}
-EXPORT_SYMBOL(rpcif_disable_rpm);
-
 void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
 {
 	u32 dummy;
diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
index 9ad136682c47..14cfd036268a 100644
--- a/include/memory/renesas-rpc-if.h
+++ b/include/memory/renesas-rpc-if.h
@@ -10,6 +10,7 @@
 #ifndef __RENESAS_RPC_IF_H
 #define __RENESAS_RPC_IF_H
 
+#include <linux/pm_runtime.h>
 #include <linux/types.h>
 
 enum rpcif_data_dir {
@@ -77,11 +78,19 @@ struct	rpcif {
 
 int  rpcif_sw_init(struct rpcif *rpc, struct device *dev);
 void rpcif_hw_init(struct rpcif *rpc, bool hyperflash);
-void rpcif_enable_rpm(struct rpcif *rpc);
-void rpcif_disable_rpm(struct rpcif *rpc);
 void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
 		   size_t *len);
 int rpcif_manual_xfer(struct rpcif *rpc);
 ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf);
 
+static inline void rpcif_enable_rpm(struct rpcif *rpc)
+{
+	pm_runtime_enable(rpc->dev);
+}
+
+static inline void rpcif_disable_rpm(struct rpcif *rpc)
+{
+	pm_runtime_disable(rpc->dev);
+}
+
 #endif // __RENESAS_RPC_IF_H
-- 
2.17.1


--iK1VERIwq1lFmxdztew1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6006): https://lists.cip-project.org/g/cip-dev/message=
/6006
Mute This Topic: https://lists.cip-project.org/mt/79450065/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iK1VERIwq1lFmxdztew1--
