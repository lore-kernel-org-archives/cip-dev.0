Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35073C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:15:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5135.1745583332362271398
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 05:15:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: nfl/+eq1QzqGv3TVJ87ezg==
X-CSE-MsgGUID: 2C0bdkD6Qz24My2CAhHoMg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Apr 2025 21:15:33 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 565F242D7EFB;
	Fri, 25 Apr 2025 21:15:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 21/21] clocksource/drivers/renesas-ostm: Avoid reprobe after successful early probe
Date: Fri, 25 Apr 2025 13:14:45 +0100
Message-ID: <20250425121445.62818-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 12:15:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18643

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 37385c0772a4fc6b89605b9701fa934fa2beb2cc upstream.

The Renesas OS Timer (OSTM) driver contains two probe points, of which
only one should complete:
  1. Early probe, using TIMER_OF_DECLARE(), to provide the sole
     clocksource on (arm32) RZ/A1 and RZ/A2 SoCs,
  2. Normal probe, using a platform driver, to provide additional timers
     on (arm64 + riscv) RZ/G2L and similar SoCs.

The latter is needed because using OSTM on RZ/G2L requires manipulation
of its reset signal, which is not yet available at the time of early
probe, causing early probe to fail with -EPROBE_DEFER.  It is only
enabled when building a kernel with support for the RZ/G2L family, so it
does not impact RZ/A1 and RZ/A2.  Hence only one probe method can
complete on all affected systems.

As relying on the order of initialization of subsystems inside the
kernel is fragile, set the DT node's OF_POPULATED flag after a succesful
early probe.  This makes sure the platform driver's probe is never
called after a successful early probe.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviwed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/bd027379713cbaafa21ffe9e848ebb7f475ca0e7.1710930542.git.geert+renesas@glider.be
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clocksource/renesas-ostm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 39487d05a009d..3fcbd02b24831 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -210,6 +210,7 @@ static int __init ostm_init(struct device_node *np)
 		pr_info("%pOF: used for clock events\n", np);
 	}
 
+	of_node_set_flag(np, OF_POPULATED);
 	return 0;
 
 err_cleanup:
-- 
2.43.0


