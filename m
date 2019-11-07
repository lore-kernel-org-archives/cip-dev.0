From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:04 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 35/83] mmc: add define for R1 response
	without CRC
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-36-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 51b50c961676428cd356d6fa494a2e9f53dc77bf upstream.

The core uses it for polling. Give drivers a proper define handle this
case like for other response types.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 include/linux/mmc/core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 37967b6..6c2e285 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -55,6 +55,9 @@ struct mmc_command {
 #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 #define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 
+/* Can be used by core to poll after switch to MMC HS mode */
+#define MMC_RSP_R1_NO_CRC	(MMC_RSP_PRESENT|MMC_RSP_OPCODE)
+
 #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
 
 /*
-- 
2.7.4
