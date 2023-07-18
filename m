Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28F3EB64DA
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 14:11:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.8682.1689689506829253600
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 07:11:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="173413983"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Jul 2023 23:11:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.137])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A228D400F736;
	Tue, 18 Jul 2023 23:11:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 6/6] arm64: defconfig: Enable Renesas MTU3a PWM config
Date: Tue, 18 Jul 2023 15:11:29 +0100
Message-Id: <20230718141129.119809-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
References: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 14:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12397

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
index 3164657aa297..b8174d962370 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1211,6 +1211,7 @@ CONFIG_PWM_MEDIATEK=m
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_RENESAS_TPU=m
 CONFIG_PWM_ROCKCHIP=y
+CONFIG_PWM_RZ_MTU3=m
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_SUN4I=m
-- 
2.25.1


