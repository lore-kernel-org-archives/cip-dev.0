From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Fri,  5 Apr 2019 11:47:36 +0100
Subject: [cip-dev] [PATCH 4.4 5/5] net: ipconfig: Fix NULL pointer
	dereference on RARP/BOOTP/DHCP timeout
In-Reply-To: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <1554461256-12966-6-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1ae292a2457cd692828da2be87cb967260993ad0 upstream.

If no RARP, BOOTP, or DHCP response is received, ic_dev is never set,
causing a NULL pointer dereference in ic_close_devs():

    Sending DHCP requests ...... timed out!
    Unable to handle kernel NULL pointer dereference at virtual address 00000004

To fix this, add a check to avoid dereferencing ic_dev if it is still
NULL.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 2647cffb2bc6fbed ("net: ipconfig: Support using "delayed" DHCP replies")
Signed-off-by: David S. Miller <davem@davemloft.net>
[Patryk: cherry-picked to 4.4]
Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
---
 net/ipv4/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 6b78590..ca658af 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -313,7 +313,7 @@ static void __init ic_close_devs(void)
 	while ((d = next)) {
 		next = d->next;
 		dev = d->dev;
-		if (dev != ic_dev->dev && !netdev_uses_dsa(dev)) {
+		if ((!ic_dev || dev != ic_dev->dev) && !netdev_uses_dsa(dev)) {
 			pr_debug("IP-Config: Downing %s\n", dev->name);
 			dev_change_flags(dev, d->flags);
 		}
-- 
2.7.4
