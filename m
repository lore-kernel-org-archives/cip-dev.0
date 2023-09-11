Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A59EE57DF
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 16:29:15 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1254.1694449742861762548
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 09:29:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="175711403"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Sep 2023 01:29:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 176AB401D159;
	Tue, 12 Sep 2023 01:29:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 10/14] arm64: defconfig: Enable PMIC RAA215300 and RTC ISL 1208 configs
Date: Mon, 11 Sep 2023 17:28:36 +0100
Message-Id: <20230911162840.1115401-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
References: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 16:29:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13050

commit 0bfe5475f6b9fc766aa1fabb0a90c88b882c2f70 upstream.

Enable PMIC RAA215300 and ISL 1208 configs, as it is populated
on Renesas RZ/{G2L,V2L} SMARC EVKs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230703144108.413938-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index da703606deb4..e867b2ac2384 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -678,6 +678,7 @@ CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
+CONFIG_REGULATOR_RAA215300=y
 CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_TPS65132=m
@@ -985,6 +986,7 @@ CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_HYM8563=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
+CONFIG_RTC_DRV_ISL1208=m
 CONFIG_RTC_DRV_PCF85063=m
 CONFIG_RTC_DRV_PCF85363=m
 CONFIG_RTC_DRV_M41T80=m
-- 
2.25.1


