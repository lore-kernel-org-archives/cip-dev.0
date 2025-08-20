Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665FECA0EFD
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:39:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.15351.1755679146753582501
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:39:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: FNjk3W7KRmqffMgrhSMtGA==
X-CSE-MsgGUID: pCaPmfVxSaCjmea9ItzquQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:39:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 98169415F3DE;
	Wed, 20 Aug 2025 17:39:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 14/22] memory: renesas-rpc-if: Use devm_reset_control_array_get_exclusive()
Date: Wed, 20 Aug 2025 09:38:22 +0100
Message-ID: <20250820083855.6337-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
References: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:39:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19783

commit c66fce831d0669dc809f90bcefd80ae979e35431 upstream.

Replace devm_*_get_exclusive()->devm_*_array_get_exclusive() to support
existing SoCs along with RZ/G3E as RZ/G3E has 2 resets.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250424090000.136804-4-biju.das.jz@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 000d2367eefc..bc4270768856 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -604,7 +604,7 @@ static int rpcif_probe(struct platform_device *pdev)
 
 	rpc->size = resource_size(res);
 	rpc->info = of_device_get_match_data(dev);
-	rpc->rstc = devm_reset_control_get_exclusive(dev, NULL);
+	rpc->rstc = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(rpc->rstc))
 		return PTR_ERR(rpc->rstc);
 
-- 
2.43.0


