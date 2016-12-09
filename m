From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:36:43 +0000
Subject: [cip-dev] [PATCH 4.4-cip 15/23] mmc: dw_mmc: remove UBSAN warning
 in dw_mci_setup_bus()
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243803.1860.171.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Seung-Woo Kim <sw0312.kim@samsung.com>

commit 65257a0deed5aee66b4e3708944f0be62a64cabc upstream.

This patch removes following UBSAN warnings in dw_mci_setup_bus().

  UBSAN: Undefined behaviour in drivers/mmc/host/dw_mmc.c:1102:14
  shift exponent 250 is too large for 32-bit type 'unsigned int'
  Call trace:
  [<ffffff90080908a8>] dump_backtrace+0x0/0x380
  [<ffffff9008090c3c>] show_stack+0x14/0x20
  [<ffffff90087457b8>] dump_stack+0xe0/0x120
  [<ffffff90087b1360>] ubsan_epilogue+0x18/0x68
  [<ffffff90087b1a94>] __ubsan_handle_shift_out_of_bounds+0x18c/0x1bc
  [<ffffff9008d89cb8>] dw_mci_setup_bus+0x3a0/0x438
  [...]

  UBSAN: Undefined behaviour in drivers/mmc/host/dw_mmc.c:1132:27
  shift exponent 250 is too large for 32-bit type 'unsigned int'
  Call trace:
  [<ffffff90080908a8>] dump_backtrace+0x0/0x380
  [<ffffff9008090c3c>] show_stack+0x14/0x20
  [<ffffff90087457b8>] dump_stack+0xe0/0x120
  [<ffffff90087b1360>] ubsan_epilogue+0x18/0x68
  [<ffffff90087b1a94>] __ubsan_handle_shift_out_of_bounds+0x18c/0x1bc
  [<ffffff9008d89c9c>] dw_mci_setup_bus+0x384/0x438
  [...]

The warnings are caused because of bit shift which is used to
filter spamming message for CONFIG_MMC_CLKGATE, but the config is
already removed. So this patch just removes the shift.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/mmc/host/dw_mmc.c | 14 +++++---------
 drivers/mmc/host/dw_mmc.h |  4 ----
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index fb204ee6ff89..0b38014ad315 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1102,12 +1102,11 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
 
-		if ((clock << div) != slot->__clk_old || force_clkinit)
-			dev_info(&slot->mmc->class_dev,
-				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
-				 slot->id, host->bus_hz, clock,
-				 div ? ((host->bus_hz / div) >> 1) :
-				 host->bus_hz, div);
+		dev_info(&slot->mmc->class_dev,
+			 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
+			 slot->id, host->bus_hz, clock,
+			 div ? ((host->bus_hz / div) >> 1) :
+			 host->bus_hz, div);
 
 		/* disable clock */
 		mci_writel(host, CLKENA, 0);
@@ -1130,9 +1129,6 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		/* inform CIU */
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
-
-		/* keep the clock with reflecting clock dividor */
-		slot->__clk_old = clock << div;
 	}
 
 	host->current_speed = clock;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index f695b58f0613..18fb8f5aaa34 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -242,9 +242,6 @@ extern int dw_mci_resume(struct dw_mci *host);
  * @queue_node: List node for placing this node in the @queue list of
  *	&struct dw_mci.
  * @clock: Clock rate configured by set_ios(). Protected by host->lock.
- * @__clk_old: The last updated clock with reflecting clock divider.
- *	Keeping track of this helps us to avoid spamming the console
- *	with CONFIG_MMC_CLKGATE.
  * @flags: Random state bits associated with the slot.
  * @id: Number of this slot.
  * @sdio_id: Number of this slot in the SDIO interrupt registers.
@@ -259,7 +256,6 @@ struct dw_mci_slot {
 	struct list_head	queue_node;
 
 	unsigned int		clock;
-	unsigned int		__clk_old;
 
 	unsigned long		flags;
 #define DW_MMC_CARD_PRESENT	0
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
