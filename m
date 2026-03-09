Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531F8F41800
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 15:07:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16855.1773068834291413158
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 08:07:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: 1vsjCNW6QRuGZzbZrvPubQ==
X-CSE-MsgGUID: RalSX2IeTT2OkXUtoRcA1g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2026 00:07:13 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.213])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4BA02400720E;
	Tue, 10 Mar 2026 00:07:12 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v3 03/17] arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
Date: Mon,  9 Mar 2026 17:06:05 +0200
Message-ID: <20260309150619.761962-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 15:07:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22201

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit abd7c0293816a5fa5766710d2e7b576384fdec4d upstream.

Enable the Renesas RZ/V2H(P) RSPI driver for the benefit of
RZ/V2H(P) based platforms.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250624192304.338979-6-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * no changes

V2:
 * remove internal Reviewed-by tags

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index efa6efe31a9b..43ddc37d8015 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -566,6 +566,7 @@ CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_ROCKCHIP_SFC=m
 CONFIG_SPI_RPCIF=m
 CONFIG_SPI_RSPI=m
+CONFIG_SPI_RZV2H_RSPI=m
 CONFIG_SPI_RZV2M_CSI=m
 CONFIG_SPI_QCOM_QSPI=m
 CONFIG_SPI_QUP=y
-- 
2.53.0

