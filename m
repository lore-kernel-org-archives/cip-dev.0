Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F6EEB64DA
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 14:06:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.8427.1689689188746596640
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 07:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="169767930"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Jul 2023 23:06:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.137])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C4CB74216805;
	Tue, 18 Jul 2023 23:06:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 13/13] arm64: defconfig: Enable Renesas MTU3a PWM config
Date: Tue, 18 Jul 2023 15:06:08 +0100
Message-Id: <20230718140608.119449-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 14:06:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12390

commit aaa08e28e0051e88c88cc14bfa0db968b977cc85 upstream.

Enable PWM config for Renesas MTU3a PWM as it is populated on
RZ/{G2L, LC, UL} and RZ/V2L SMARC EVKs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230703132706.355237-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9ab49a79ce5d..0206a35fd9d1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1001,6 +1001,7 @@ CONFIG_PWM_CROS_EC=m
 CONFIG_PWM_MESON=m
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_ROCKCHIP=y
+CONFIG_PWM_RZ_MTU3=m
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_SUN4I=m
-- 
2.25.1


