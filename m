From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Fri,  5 Apr 2019 11:47:35 +0100
Subject: [cip-dev] [PATCH 4.4 4/5] net: ipconfig: Fix more use after free
In-Reply-To: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <1554461256-12966-5-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Thierry Reding <treding@nvidia.com>

commit d2d371ae5dd6af9a6a3d7f50b753627c42868409 upstream.

While commit 9c706a49d660 ("net: ipconfig: fix use after free") avoids
the use after free, the resulting code still ends up calling both the
ic_setup_if() and ic_setup_routes() after calling ic_close_devs(), and
access to the device is still required.

Move the call to ic_close_devs() to the very end of the function.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Patryk: cherry-picked to 4.4]
Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
---
 net/ipv4/ipconfig.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 23c9b8a..6b78590 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1556,12 +1556,14 @@ static int __init ip_auto_config(void)
 	 * Close all network devices except the device we've
 	 * autoconfigured and set up routes.
 	 */
-	ic_close_devs();
 	if (ic_setup_if() < 0 || ic_setup_routes() < 0)
-		return -1;
+		err = -1;
+	else
+		err = 0;
 
+	ic_close_devs();
 
-	return 0;
+	return err;
 }
 
 late_initcall(ip_auto_config);
-- 
2.7.4
