From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Thu, 25 Apr 2019 14:28:17 +0100
Subject: [cip-dev] [PATCH 4.4.y V2] net: ipconfig: Support using "delayed"
	DHCP replies
In-Reply-To: <1556198897-5710-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1556198897-5710-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <1556198897-5710-2-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

commit 2647cffb2bc6fbed163d377390eb7ca552c7c1cb upstream.

The dhcp code only waits 1s between sending DHCP requests on different
devices and only accepts an answer for the device that sent out the last
request. Only the timeout at the end of a loop is increased iteratively
which favours only the last device. This makes it impossible to work
with a dhcp server that takes little more than 1s connected to a device
that is not the last one.

Instead of also increasing the inter-device timeout, teach the code to
handle delayed replies.

To accomplish that, make *ic_dev track the current ic_device instead of
the current net_device and adapt all users accordingly. The relevant
change then is to reset d to ic_dev on a reply to assert that the
followup request goes through the right device.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Patryk: Backported to 4.4: replaced DBG function with pr_debug
squashed upstream commits:
e068853409aa17208e94f4ca628005cc6f51e043
9c706a49d660653625d206f6972541c1f60ea2b0
d2d371ae5dd6af9a6a3d7f50b753627c42868409
1ae292a2457cd692828da2be87cb967260993ad0]
Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
---
 net/ipv4/ipconfig.c | 61 ++++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 60f564d..ca658af 100644
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
@@ -195,7 +194,7 @@ struct ic_device {
 };
 
 static struct ic_device *ic_first_dev __initdata;	/* List of open device */
-static struct net_device *ic_dev __initdata;		/* Selected device */
+static struct ic_device *ic_dev __initdata;		/* Selected device */
 
 static bool __init ic_is_init_dev(struct net_device *dev)
 {
@@ -314,8 +313,8 @@ static void __init ic_close_devs(void)
 	while ((d = next)) {
 		next = d->next;
 		dev = d->dev;
-		if (dev != ic_dev && !netdev_uses_dsa(dev)) {
-			DBG(("IP-Config: Downing %s\n", dev->name));
+		if ((!ic_dev || dev != ic_dev->dev) && !netdev_uses_dsa(dev)) {
+			pr_debug("IP-Config: Downing %s\n", dev->name);
 			dev_change_flags(dev, d->flags);
 		}
 		kfree(d);
@@ -379,7 +378,7 @@ static int __init ic_setup_if(void)
 	int err;
 
 	memset(&ir, 0, sizeof(ir));
-	strcpy(ir.ifr_ifrn.ifrn_name, ic_dev->name);
+	strcpy(ir.ifr_ifrn.ifrn_name, ic_dev->dev->name);
 	set_sockaddr(sin, ic_myaddr, 0);
 	if ((err = ic_devinet_ioctl(SIOCSIFADDR, &ir)) < 0) {
 		pr_err("IP-Config: Unable to set interface address (%d)\n",
@@ -403,7 +402,7 @@ static int __init ic_setup_if(void)
 	 * out, we'll try to muddle along.
 	 */
 	if (ic_dev_mtu != 0) {
-		strcpy(ir.ifr_name, ic_dev->name);
+		strcpy(ir.ifr_name, ic_dev->dev->name);
 		ir.ifr_mtu = ic_dev_mtu;
 		if ((err = ic_dev_ioctl(SIOCSIFMTU, &ir)) < 0)
 			pr_err("IP-Config: Unable to set interface mtu to %d (%d)\n",
@@ -574,7 +573,7 @@ ic_rarp_recv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt
 		goto drop_unlock;
 
 	/* We have a winner! */
-	ic_dev = dev;
+	ic_dev = d;
 	if (ic_myaddr == NONE)
 		ic_myaddr = tip;
 	ic_servaddr = sip;
@@ -661,8 +660,6 @@ static struct packet_type bootp_packet_type __initdata = {
 	.func =	ic_bootp_recv,
 };
 
-static __be32 ic_dev_xid;		/* Device under configuration */
-
 /*
  *  Initialize DHCP/BOOTP extension fields in the request.
  */
@@ -1052,12 +1049,6 @@ static int __init ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, str
 		goto drop_unlock;
 	}
 
-	/* Is it a reply for the device we are configuring? */
-	if (b->xid != ic_dev_xid) {
-		net_err_ratelimited("DHCP/BOOTP: Ignoring delayed packet\n");
-		goto drop_unlock;
-	}
-
 	/* Parse extensions */
 	if (ext_len >= 4 &&
 	    !memcmp(b->exten, ic_bootp_cookie, 4)) { /* Check magic cookie */
@@ -1148,7 +1139,7 @@ static int __init ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, str
 	}
 
 	/* We have a winner! */
-	ic_dev = dev;
+	ic_dev = d;
 	ic_myaddr = b->your_ip;
 	ic_servaddr = b->server_ip;
 	ic_addrservaddr = b->iph.saddr;
@@ -1243,9 +1234,6 @@ static int __init ic_dynamic(void)
 	timeout = CONF_BASE_TIMEOUT + (timeout % (unsigned int) CONF_TIMEOUT_RANDOM);
 	for (;;) {
 #ifdef IPCONFIG_BOOTP
-		/* Track the device we are configuring */
-		ic_dev_xid = d->xid;
-
 		if (do_bootp && (d->able & IC_BOOTP))
 			ic_bootp_send_if(d, jiffies - start_jiffies);
 #endif
@@ -1254,15 +1242,19 @@ static int __init ic_dynamic(void)
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
 		    (ic_proto_enabled & IC_USE_DHCP) &&
 		    ic_dhcp_msgtype != DHCPACK) {
 			ic_got_reply = 0;
+			/* continue on device that got the reply */
+			d = ic_dev;
 			pr_cont(",");
 			continue;
 		}
@@ -1513,7 +1505,7 @@ static int __init ip_auto_config(void)
 #endif /* IPCONFIG_DYNAMIC */
 	} else {
 		/* Device selected manually or only one device -> use it */
-		ic_dev = ic_first_dev->dev;
+		ic_dev = ic_first_dev;
 	}
 
 	addr = root_nfs_parse_addr(root_server_path);
@@ -1527,14 +1519,6 @@ static int __init ip_auto_config(void)
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
@@ -1548,7 +1532,7 @@ static int __init ip_auto_config(void)
 	pr_info("IP-Config: Complete:\n");
 
 	pr_info("     device=%s, hwaddr=%*phC, ipaddr=%pI4, mask=%pI4, gw=%pI4\n",
-		ic_dev->name, ic_dev->addr_len, ic_dev->dev_addr,
+		ic_dev->dev->name, ic_dev->dev->addr_len, ic_dev->dev->dev_addr,
 		&ic_myaddr, &ic_netmask, &ic_gateway);
 	pr_info("     host=%s, domain=%s, nis-domain=%s\n",
 		utsname()->nodename, ic_domain, utsname()->domainname);
@@ -1568,7 +1552,18 @@ static int __init ip_auto_config(void)
 	pr_cont("\n");
 #endif /* !SILENT */
 
-	return 0;
+	/*
+	 * Close all network devices except the device we've
+	 * autoconfigured and set up routes.
+	 */
+	if (ic_setup_if() < 0 || ic_setup_routes() < 0)
+		err = -1;
+	else
+		err = 0;
+
+	ic_close_devs();
+
+	return err;
 }
 
 late_initcall(ip_auto_config);
-- 
2.7.4
