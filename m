From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:03 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 34/83] mmc: tmio-mmc: add support for
	32bit data port
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-35-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Chris Brandt <chris.brandt@renesas.com>

commit 8185e51f358a8dd4801b67e8c66f03eb9eeaba75 upstream.

For the r7s72100 SOC, the DATA_PORT register was changed to 32-bits wide.
Therefore a new flag has been created that will allow 32-bit reads/writes
to the DATA_PORT register instead of 16-bit (because 16-bits accesses are
not supported).

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h     | 12 ++++++++++++
 drivers/mmc/host/tmio_mmc_pio.c | 30 ++++++++++++++++++++++++++++++
 include/linux/mfd/tmio.h        |  5 +++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index eafd92d..c4131d9 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -245,6 +245,12 @@ static inline u32 sd_ctrl_read16_and_16_as_32(struct tmio_mmc_host *host, int ad
 	       readw(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
 }
 
+static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr,
+		u32 *buf, int count)
+{
+	readsl(host->ctl + (addr << host->bus_shift), buf, count);
+}
+
 static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val)
 {
 	/* If there is a hook and it returns non-zero then there
@@ -267,4 +273,10 @@ static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host, int
 	writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
 }
 
+static inline void sd_ctrl_write32_rep(struct tmio_mmc_host *host, int addr,
+		const u32 *buf, int count)
+{
+	writesl(host->ctl + (addr << host->bus_shift), buf, count);
+}
+
 #endif
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index c927916..4d9e17a 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -393,6 +393,36 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
 	/*
 	 * Transfer the data
 	 */
+	if (host->pdata->flags & TMIO_MMC_32BIT_DATA_PORT) {
+		u8 data[4] = { };
+
+		if (is_read)
+			sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, (u32 *)buf,
+					   count >> 2);
+		else
+			sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, (u32 *)buf,
+					    count >> 2);
+
+		/* if count was multiple of 4 */
+		if (!(count & 0x3))
+			return;
+
+		buf8 = (u8 *)(buf + (count >> 2));
+		count %= 4;
+
+		if (is_read) {
+			sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT,
+					   (u32 *)data, 1);
+			memcpy(buf8, data, count);
+		} else {
+			memcpy(data, buf8, count);
+			sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT,
+					    (u32 *)data, 1);
+		}
+
+		return;
+	}
+
 	if (is_read)
 		sd_ctrl_read16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
 	else
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 7a26286..fba44ab 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -100,6 +100,11 @@
 #define TMIO_MMC_SDIO_STATUS_QUIRK	(1 << 8)
 
 /*
+ * Some controllers have a 32-bit wide data port register
+ */
+#define TMIO_MMC_32BIT_DATA_PORT	(1 << 9)
+
+/*
  * Some controllers allows to set SDx actual clock
  */
 #define TMIO_MMC_CLK_ACTUAL		(1 << 10)
-- 
2.7.4
