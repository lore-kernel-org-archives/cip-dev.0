Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7E1C3DA7F
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:44:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.12833.1722876276339708400
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:44:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="214739963"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Aug 2024 01:44:48 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A15B540213EE;
	Tue,  6 Aug 2024 01:44:46 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 30/30] arm64: defconfig: Enable RZ/G2L MIPI CSI-2 and CRU support
Date: Mon,  5 Aug 2024 17:43:23 +0100
Message-ID: <20240805164342.211857-31-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:44:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16752

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 3ad69c496d488cd1b6c3a20b2f7945b45a0f7f18 upstream.

Increase build and test coverage by enabling support for the Renesas
RZ/G2L MIPI CSI-2 Receiver and the RZ/G2L Camera Receiving Unit, as used
on the RZ/G2L SMARC EVK development board.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/32098bf6a5e78a4bcc6398ccb5db0b01f1afc9b9.1672747428.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 85fee2e933c2..6f644364b743 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -708,6 +708,8 @@ CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_VIDEO_RCAR_ISP=m
 CONFIG_VIDEO_RCAR_CSI2=m
 CONFIG_VIDEO_RCAR_VIN=m
+CONFIG_VIDEO_RZG2L_CSI2=m
+CONFIG_VIDEO_RZG2L_CRU=m
 CONFIG_VIDEO_RENESAS_FCP=m
 CONFIG_VIDEO_RENESAS_FDP1=m
 CONFIG_VIDEO_RENESAS_VSP1=m
-- 
2.43.0


