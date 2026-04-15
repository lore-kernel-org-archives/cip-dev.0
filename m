Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EB1F419B3
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 13:19:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18770.1776259168517855894
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 06:19:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: HnJx0d3URhOrAa8vD2bD0w==
X-CSE-MsgGUID: xcv0dZ3/THuRw7tspsOU5A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2026 22:19:27 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.18])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4DD6E400A113;
	Wed, 15 Apr 2026 22:19:26 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 3/8] arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
Date: Wed, 15 Apr 2026 13:19:14 +0000
Message-ID: <20260415131919.95486-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415131919.95486-1-ovidiu.panait.rb@renesas.com>
References: <20260415131919.95486-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 13:19:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22708

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit abd7c0293816a5fa5766710d2e7b576384fdec4d upstream.

Enable the Renesas RZ/V2H(P) RSPI driver for the benefit of
RZ/V2H(P) based platforms.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250624192304.338979-6-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[OP: fixed minor context difference]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d4c693c419b..3f52a05c82d3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -513,6 +513,7 @@ CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_RPCIF=m
 CONFIG_SPI_RSPI=m
+CONFIG_SPI_RZV2H_RSPI=m
 CONFIG_SPI_QCOM_QSPI=m
 CONFIG_SPI_QUP=y
 CONFIG_SPI_QCOM_GENI=m
-- 
2.34.1


