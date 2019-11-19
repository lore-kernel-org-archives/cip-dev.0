From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:35:45 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 06/31] mmc: core: Add helper to see if a
	host can be retuned
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit c820af5f18ec248b3cb61a9a9ce47ef0f2e9ec63 upstream.

This is in preparation for restoring saved tuning parameters
when resuming the TMIO driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 include/linux/mmc/host.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8673ffe..1c483d9 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -515,4 +515,9 @@ static inline void mmc_retune_recheck(struct mmc_host *host)
 		host->retune_now = 1;
 }
 
+static inline bool mmc_can_retune(struct mmc_host *host)
+{
+	return host->can_retune == 1;
+}
+
 #endif /* LINUX_MMC_HOST_H */
-- 
2.7.4
