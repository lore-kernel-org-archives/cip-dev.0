Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4530F506F9
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52447.1773673175962015446
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 8erO7K1XS7iYkTKXC1LUpw==
X-CSE-MsgGUID: vgSyRyfqQ/S+iCxBRou0dA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:54 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2AAF441B7814;
	Mon, 16 Mar 2026 23:59:52 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 21/35] net: pcs: rzn1-miic: Convert to for_each_available_child_of_node() helper
Date: Mon, 16 Mar 2026 14:58:58 +0000
Message-ID: <20260316145915.8580-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22413

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit ec7309525a37b3f34c4efa85fc2ecaa65f41830e upstream.

Simplify miic_parse_dt() by using the for_each_available_child_of_node()
helper instead of manually skipping unavailable child nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/3e394d4cf8204bcf17b184bfda474085aa8ed0dd.1738771631.git.geert+renesas@glider.be
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index a7acbed14b0a..52fb2c30fba4 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -472,13 +472,10 @@ static int miic_parse_dt(struct device *dev, u32 *mode_cfg)
 	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
 		dt_val[0] = conf;
 
-	for_each_child_of_node(np, conv) {
+	for_each_available_child_of_node(np, conv) {
 		if (of_property_read_u32(conv, "reg", &port))
 			continue;
 
-		if (!of_device_is_available(conv))
-			continue;
-
 		if (of_property_read_u32(conv, "renesas,miic-input", &conf) == 0)
 			dt_val[port] = conf;
 	}
-- 
2.43.0


