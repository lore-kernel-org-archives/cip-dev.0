Return-Path: <SRS0=j2n2=LP=lists.cip-project.org=bounce+64572+6558+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F2DC4743C
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B686460E0B
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B686460E0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6558+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id K3pYYY4521723xP0PLr1dTjC; Mon, 21 Jun 2021 10:09:52 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.50318.1624295388440408484
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 10:09:50 -0700
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="84957100"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jun 2021 02:09:45 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4A0CD400754A;
	Tue, 22 Jun 2021 02:09:44 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 5.10.y-cip 13/16] memory: renesas-rpc-if: Make rpcif_enable/disable_rpm() as static inline
Date: Mon, 21 Jun 2021 18:09:22 +0100
Message-Id: <20210621170925.11328-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SctXmNJzxboPcr1Cow8hlSn1x4520388AA=
Content-Type: multipart/mixed; boundary="UY2gURenckX1sJIi9cbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624295392;
 bh=lCh/Cizn237jHhJJgySEYZIqxQvo6kHi+aBXbvnWdc4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=L9V+CNtDLGTf5jrW4w0dRsLZ1PWWUXqi5IHQo2rpuIDWs745YnW9d0rZxZC2tD+XvSX
 lPqLW3q8nBtgJ7q+wDTzx7l10rL/FiZql+bD8EEagBlX8iIsXLIWyX1UjJSfsv9aBjSdL
 AOLLKuEymOVqb6WyhVqq05Uo74SYe4khvoU=

--UY2gURenckX1sJIi9cbk

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
index da0fdb4c7595..8d36e221def1 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -204,18 +203,6 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
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


--UY2gURenckX1sJIi9cbk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6558): https://lists.cip-project.org/g/cip-dev/message=
/6558
Mute This Topic: https://lists.cip-project.org/mt/83693889/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UY2gURenckX1sJIi9cbk--
