Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D48C3DA4A
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:05:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.33137.1733475935173386693
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:05:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: bBqgfaacSnCxeszspCI5aA==
X-CSE-MsgGUID: h4Lan9edRlCt8ZGnWLWSgw==
X-IronPort-AV: E=Sophos;i="6.12,212,1728918000"; 
   d="scan'208";a="227108038"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2024 18:05:33 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 52860400C4D8;
	Fri,  6 Dec 2024 18:05:31 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/8] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
Date: Fri,  6 Dec 2024 09:05:19 +0000
Message-ID: <20241206090524.66639-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:05:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17337

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 0880f669436028c5499901e5acd8f4b4ea0e0c6a upstream.

Add missing MODULE_DEVICE_TABLE definition for automatic loading of the
driver when it is built as a module.

Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20240731072955.224125-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[PL: manually applied the patch]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index b71d8d8f7f50..67356c449c4e 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -205,9 +205,16 @@ static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
 #define DEV_PM_OPS	NULL
 #endif
 
+static const struct platform_device_id rpc_if_spi_id_table[] = {
+	{ .name = "rpc-if-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, rpc_if_spi_id_table);
+
 static struct platform_driver rpcif_spi_driver = {
 	.probe	= rpcif_spi_probe,
 	.remove	= rpcif_spi_remove,
+	.id_table = rpc_if_spi_id_table,
 	.driver = {
 		.name	= "rpc-if-spi",
 		.pm	= DEV_PM_OPS,
-- 
2.43.0


