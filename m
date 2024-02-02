Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BF0C48291
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 12:23:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.21394.1706876625767381363
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 04:23:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,238,1701097200"; 
   d="scan'208";a="192661181"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Feb 2024 21:23:43 +0900
Received: from localhost.localdomain (unknown [10.226.93.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4433742182F1;
	Fri,  2 Feb 2024 21:23:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/6] arm64: defconfig: Enable Renesas VersaClock 3 clock generator config
Date: Fri,  2 Feb 2024 12:23:33 +0000
Message-Id: <20240202122338.309435-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202122338.309435-1-biju.das.jz@bp.renesas.com>
References: <20240202122338.309435-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 12:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14629

commit ac2453d06c768b0604e231d6effabc1c405bd802 upstream.

Enable the config for the Renesas VersaClock 3 programmable clock
generator, as it is populated on RZ/{G2L,G2LC} and RZ/V2L SMARC EVKs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230824083006.88944-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a392b7873c3e..df95beab319b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -887,6 +887,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_VC3=y
 CONFIG_COMMON_CLK_VC5=y
 CONFIG_COMMON_CLK_BD718XX=m
 CONFIG_CLK_RASPBERRYPI=m
-- 
2.25.1


