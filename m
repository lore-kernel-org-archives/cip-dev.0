Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1498.1794209972846608863
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 23:39:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=pm2T10aL;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794209963;x=1795419563;bh=rV
	oGFKAQgOkn95KYjufvVty62uXZZHjawlvT2byMZOk=;b=pm2T10aLM/ux8Tjp8xa43igGwzSp///s
	EdncNnX4StIf47AdR/zIybqNsOezhdy+XwVZyEqzJRnDhfldya7Ll8flp5QhNtS5tNhVItmONzjOG
	ibfC+JoTiyIAKffo2RnC7am/04NONh8aHcq3snNvB67xDdErHzSAVplhIh5XODnkNRNgYAw1O5F5o
	iPj1qQPdmGSZ3WXCeLmPDMiq0zPEtUBFSf0xn4wtg+s6cMmk9XOs2TyhhNGiqPXXdrd4siIhXRiHm
	9+xjAyHpkmNropk7dLmGXdfGTDXRHB3C39Xt7i1VBSwnOYt3G9+cpcysnJ5Zst9YEGpEhSM6sNHjO
	LQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6A97dNZC4163730; Mon, 9 Nov 2026 16:39:23 +0900
X-Iguazu-Qid: 2rWgGCa8xEDYbb5jej
X-Iguazu-QSIG: v=2; s=1; t=1794209962; q=2rWgGCa8xEDYbb5jej; m=2xMANkI+92XP0F+LVlZ22Nwj7b3ALNtg8lrV4VK8Wlo=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNM9j4xTXz1xnj; Mon,  9 Nov 2026 16:39:21 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org, uli@fpond.eu, biju.das.jz@bp.renesas.com,
        tommaso.merciai.xr@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 4/5] dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout
Date: Mon,  9 Nov 2026 16:39:13 +0900
X-TSB-HOP2: ON
Message-Id: <1794209954-6205-5-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 07:39:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24685
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alex Bereza <alex@bereza.email>

commit aa99c4d1d63bbc26a5fc4c667d89b2595743c19d upstream.

Currently when calling xilinx_dma_poll_timeout with delay_us=0 and a
condition that is never fulfilled, the CPU busy-waits for prolonged time
and the timeout triggers only with a massive delay causing a CPU stall.

This happens due to a huge underestimation of wall clock time in
poll_timeout_us_atomic. Commit 7349a69cf312 ("iopoll: Do not use
timekeeping in read_poll_timeout_atomic()") changed the behavior to no
longer use ktime_get at the expense of underestimation of wall clock
time which appears to be very large for delay_us=0. Instead of timing
out after approximately XILINX_DMA_LOOP_COUNT microseconds, the timeout
takes XILINX_DMA_LOOP_COUNT * 1000 * (time that the overhead of the for
loop in poll_timeout_us_atomic takes) which is in the range of several
minutes for XILINX_DMA_LOOP_COUNT=1000000. Fix this by using a non-zero
value for delay_us. Use delay_us=10 to keep the delay in the hot path of
starting DMA transfers minimal but still avoid CPU stalls in case of
unexpected hardware failures.

One-off measurement with delay_us=0 causes the cpu to busy wait around 7
minutes in the timeout case. After applying this patch with delay_us=10
the measured timeout was 1053428 microseconds which is roughly
equivalent to the expected 1000000 microseconds specified in
XILINX_DMA_LOOP_COUNT.

Add a constant XILINX_DMA_POLL_DELAY_US for delay_us value.

Fixes: 9495f2648287 ("dmaengine: xilinx_vdma: Use readl_poll_timeout instead of do while loop's")
Fixes: 7349a69cf312 ("iopoll: Do not use timekeeping in read_poll_timeout_atomic()")
Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Bereza <alex@bereza.email>
Link: https://patch.msgid.link/20260402-fix-atomic-poll-timeout-regression-v4-1-f30d6a6c13cb@bereza.email
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 5fb423261c3f..d1f83e315be7 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -164,6 +164,8 @@
 
 /* Delay loop counter to prevent hardware failure */
 #define XILINX_DMA_LOOP_COUNT		1000000
+/* Delay between polls (avoid a delay of 0 to prevent CPU stalls) */
+#define XILINX_DMA_POLL_DELAY_US	10
 
 /* AXI DMA Specific Registers/Offsets */
 #define XILINX_DMA_REG_SRCDSTADDR	0x18
@@ -1287,7 +1289,8 @@ static int xilinx_dma_stop_transfer(struct xilinx_dma_chan *chan)
 
 	/* Wait for the hardware to halt */
 	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
-				       val & XILINX_DMA_DMASR_HALTED, 0,
+				       val & XILINX_DMA_DMASR_HALTED,
+				       XILINX_DMA_POLL_DELAY_US,
 				       XILINX_DMA_LOOP_COUNT);
 }
 
@@ -1302,7 +1305,8 @@ static int xilinx_cdma_stop_transfer(struct xilinx_dma_chan *chan)
 	u32 val;
 
 	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
-				       val & XILINX_DMA_DMASR_IDLE, 0,
+				       val & XILINX_DMA_DMASR_IDLE,
+				       XILINX_DMA_POLL_DELAY_US,
 				       XILINX_DMA_LOOP_COUNT);
 }
 
@@ -1319,7 +1323,8 @@ static void xilinx_dma_start(struct xilinx_dma_chan *chan)
 
 	/* Wait for the hardware to start */
 	err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
-				      !(val & XILINX_DMA_DMASR_HALTED), 0,
+				      !(val & XILINX_DMA_DMASR_HALTED),
+				      XILINX_DMA_POLL_DELAY_US,
 				      XILINX_DMA_LOOP_COUNT);
 
 	if (err) {
@@ -1742,7 +1747,8 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
 
 	/* Wait for the hardware to finish reset */
 	err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMACR, tmp,
-				      !(tmp & XILINX_DMA_DMACR_RESET), 0,
+				      !(tmp & XILINX_DMA_DMACR_RESET),
+				      XILINX_DMA_POLL_DELAY_US,
 				      XILINX_DMA_LOOP_COUNT);
 
 	if (err) {
-- 
2.55.0


