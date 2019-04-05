From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Fri,  5 Apr 2019 11:47:33 +0100
Subject: [cip-dev] [PATCH 4.4 2/5] net: ipconfig: drop inter-device timeout
In-Reply-To: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <1554461256-12966-3-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

commit e068853409aa17208e94f4ca628005cc6f51e043 upstream.

Now that ipconfig learned to handle "delayed replies" in the previous
commit, there is no reason any more to delay sending a first request per
device.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Patryk: cherry-picked to 4.4]
Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
---
 net/ipv4/ipconfig.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index f326433..35c8b35 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -94,7 +94,6 @@
 /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
 #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
 #define CONF_SEND_RETRIES 	6	/* Send six requests per open */
-#define CONF_INTER_TIMEOUT	(HZ)	/* Inter-device timeout: 1 second */
 #define CONF_BASE_TIMEOUT	(HZ*2)	/* Initial timeout: 2 seconds */
 #define CONF_TIMEOUT_RANDOM	(HZ)	/* Maximum amount of randomization */
 #define CONF_TIMEOUT_MULT	*7/4	/* Rate of timeout growth */
@@ -1243,9 +1242,11 @@ static int __init ic_dynamic(void)
 			ic_rarp_send_if(d);
 #endif
 
-		jiff = jiffies + (d->next ? CONF_INTER_TIMEOUT : timeout);
-		while (time_before(jiffies, jiff) && !ic_got_reply)
-			schedule_timeout_uninterruptible(1);
+		if (!d->next) {
+			jiff = jiffies + timeout;
+			while (time_before(jiffies, jiff) && !ic_got_reply)
+				schedule_timeout_uninterruptible(1);
+		}
 #ifdef IPCONFIG_DHCP
 		/* DHCP isn't done until we get a DHCPACK. */
 		if ((ic_got_reply & IC_BOOTP) &&
-- 
2.7.4
