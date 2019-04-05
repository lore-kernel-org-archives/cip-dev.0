From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Fri,  5 Apr 2019 11:47:34 +0100
Subject: [cip-dev] [PATCH 4.4 3/5] net: ipconfig: fix use after free
In-Reply-To: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <1554461256-12966-4-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

commit 9c706a49d660653625d206f6972541c1f60ea2b0 upstream.

ic_close_devs() calls kfree() for all devices's ic_device. Since commit
2647cffb2bc6 ("net: ipconfig: Support using "delayed" DHCP replies")
the active device's ic_device is still used however to print the
ipconfig summary which results in an oops if the memory is already
changed. So delay freeing until after the autoconfig results are
reported.

Fixes: 2647cffb2bc6 ("net: ipconfig: Support using "delayed" DHCP replies")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Patryk: cherry-picked to 4.4]
Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
---
 net/ipv4/ipconfig.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 35c8b35..23c9b8a 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1519,14 +1519,6 @@ static int __init ip_auto_config(void)
 		return -1;
 
 	/*
-	 * Close all network devices except the device we've
-	 * autoconfigured and set up routes.
-	 */
-	ic_close_devs();
-	if (ic_setup_if() < 0 || ic_setup_routes() < 0)
-		return -1;
-
-	/*
 	 * Record which protocol was actually used.
 	 */
 #ifdef IPCONFIG_DYNAMIC
@@ -1560,6 +1552,15 @@ static int __init ip_auto_config(void)
 	pr_cont("\n");
 #endif /* !SILENT */
 
+	/*
+	 * Close all network devices except the device we've
+	 * autoconfigured and set up routes.
+	 */
+	ic_close_devs();
+	if (ic_setup_if() < 0 || ic_setup_routes() < 0)
+		return -1;
+
+
 	return 0;
 }
 
-- 
2.7.4
