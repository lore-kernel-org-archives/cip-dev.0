Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DDED25B63
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:25:32 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12765.1769606726333152485
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 05:25:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: sYBzFKDQTvGHqRbmgC2wyg==
X-CSE-MsgGUID: Uzlee0s4TKKjqMVjGbnmlA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Jan 2026 22:25:28 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.43])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B49824172F16;
	Wed, 28 Jan 2026 22:25:27 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 02/11] soc: renesas: r9a09g056-sys: Populate max_register
Date: Wed, 28 Jan 2026 13:25:11 +0000
Message-ID: <20260128132522.6902-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
References: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 13:25:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21739

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 4ff787433ba6d564b00334b4bfd6350f5b6f4bb3 upstream.

Populate max_register to avoid external aborts.

Fixes: 2da2740fb9c8 ("soc: renesas: rz-sysc: Add syscon/regmap support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251105070526.264445-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/soc/renesas/r9a09g056-sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/r9a09g056-sys.c b/drivers/soc/renesas/r9a09g056-sys.c
index 3ad1422eba36..16b4e433c337 100644
--- a/drivers/soc/renesas/r9a09g056-sys.c
+++ b/drivers/soc/renesas/r9a09g056-sys.c
@@ -72,4 +72,5 @@ static const struct rz_sysc_soc_id_init_data rzv2n_sys_soc_id_init_data __initco
 
 const struct rz_sysc_init_data rzv2n_sys_init_data = {
 	.soc_id_init_data = &rzv2n_sys_soc_id_init_data,
+	.max_register = 0x170c,
 };
-- 
2.51.0


