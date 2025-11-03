Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44A3CCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:39:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18502.1762169936683185880
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:38:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: 1gzk9HPCTt2Bzq/opOkHGA==
X-CSE-MsgGUID: Mffgyj4dSBS/RT8x5MkrOQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Nov 2025 20:38:58 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AECC1419FC18;
	Mon,  3 Nov 2025 20:38:56 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.12.y-cip 22/22] arm64: dts: renesas: r9a09g047: Enable Tx coe support
Date: Mon,  3 Nov 2025 12:38:06 +0100
Message-ID: <20251103113817.36331-23-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20340

[ Upstream commit da7326322d31eb60fea27be30ca013d1e9b0a86c ]

The GBETH IPs found on RZ/G3E SoC family are compatible with the stmmac
driver.  They have a MAC HW feature register used by this driver to
enable respective features.  While the register advertises Tx coe
support, it was not enabled by the driver due to the
'snps,force_thresh_dma_mode' dtsi property.

Switch from 'snps,force_thresh_dma_mode' to 'snps,force_sf_dma_mode' to
enable Tx checksum offload support on both GBETH IPs.  While at it, also
switch from 'snps,fixed-burst' to 'snps,mixed-burst' and remove
'snps,no-pbl-x8' for optimal DMA configuration.  This improvement
results in a measurable TCP Tx performance gain, increasing throughput
by 20Mbps.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250814153456.268208-1-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index e4fac7e0d764..b55b113d1f11 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -722,9 +722,8 @@ eth0: ethernet@15c30000 {
 			snps,perfect-filter-entries = <128>;
 			rx-fifo-depth = <8192>;
 			tx-fifo-depth = <8192>;
-			snps,fixed-burst;
-			snps,no-pbl-x8;
-			snps,force_thresh_dma_mode;
+			snps,mixed-burst;
+			snps,force_sf_dma_mode;
 			snps,axi-config = <&stmmac_axi_setup>;
 			snps,mtl-rx-config = <&mtl_rx_setup0>;
 			snps,mtl-tx-config = <&mtl_tx_setup0>;
@@ -823,9 +822,8 @@ eth1: ethernet@15c40000 {
 			snps,perfect-filter-entries = <128>;
 			rx-fifo-depth = <8192>;
 			tx-fifo-depth = <8192>;
-			snps,fixed-burst;
-			snps,no-pbl-x8;
-			snps,force_thresh_dma_mode;
+			snps,mixed-burst;
+			snps,force_sf_dma_mode;
 			snps,axi-config = <&stmmac_axi_setup>;
 			snps,mtl-rx-config = <&mtl_rx_setup1>;
 			snps,mtl-tx-config = <&mtl_tx_setup1>;
-- 
2.25.1


