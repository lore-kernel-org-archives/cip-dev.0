Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20870C77B7A
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 12:50:15 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.7833.1684932604682297324
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 05:50:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,189,1681138800"; 
   d="scan'208";a="160644193"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 May 2023 21:50:06 +0900
Received: from localhost.localdomain (unknown [10.226.93.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 96D874000AA0;
	Wed, 24 May 2023 21:50:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip v2 10/10] arm64: defconfig: Enable additional support for Renesas platforms
Date: Wed, 24 May 2023 13:49:37 +0100
Message-Id: <20230524124937.160355-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
References: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 12:50:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11644

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit eb970f3eb909a8da5f7bc1c2f83a1eac4adac838 upstream.

Increase build and test coverage by enabling support for more hardware
present on Renesas SoCs and boards:
  - Renesas RZ/V2M I2C,
  - Renesas Universal Flash Storage Controller on R-Car S4, as used on
    the Spider board.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/bd863fdd098be394d57b9dc15f8bb0f6b1f2d78a.1661162345.git.geert+renesas@glider.be
[biju]: Removed CONFIG_SCSI_UFS_RENESAS as it is not supported in 5.10.y-cip
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8d8c56c7fb77..b0cda12bd208 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -446,6 +446,7 @@ CONFIG_I2C_QCOM_GENI=m
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RIIC=y
 CONFIG_I2C_RK3X=y
+CONFIG_I2C_RZV2M=m
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_TEGRA=y
 CONFIG_I2C_UNIPHIER_F=y
-- 
2.25.1


