From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Thu, 25 Apr 2019 14:23:11 +0100
Subject: [cip-dev] [PATCH 4.4.y] Increase DHCP inter-device timeout
In-Reply-To: <1556198591-5414-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1556198591-5414-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <1556198591-5414-2-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

If multiple networking devices are enabled, the current implementation
of the DHCP client is to request a DHCP address on one device, listen
for responses on that device for one second, and if no response is
received in that time, repeat on the next device.

This means if a DHCP server takes over a second to reply, the client
will not be able to process the reply.

This commit increases the inter-device timeout to 2 seconds, to give the
DHCP server more time to reply.

Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
---
 net/ipv4/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 60f564d..fbe966d 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -94,7 +94,7 @@
 /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
 #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
 #define CONF_SEND_RETRIES 	6	/* Send six requests per open */
-#define CONF_INTER_TIMEOUT	(HZ)	/* Inter-device timeout: 1 second */
+#define CONF_INTER_TIMEOUT	(HZ*2)	/* Inter-device timeout: 2 seconds */
 #define CONF_BASE_TIMEOUT	(HZ*2)	/* Initial timeout: 2 seconds */
 #define CONF_TIMEOUT_RANDOM	(HZ)	/* Maximum amount of randomization */
 #define CONF_TIMEOUT_MULT	*7/4	/* Rate of timeout growth */
-- 
2.7.4
