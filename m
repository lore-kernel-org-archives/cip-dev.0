From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Fri,  5 Apr 2019 11:47:32 +0100
Subject: [cip-dev] [PATCH 4.4 1/5] net: ipconfig: Support using "delayed"
	DHCP replies
In-Reply-To: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <1554461256-12966-2-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
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
[Patryk: Backported to 4.4: replaced DBG function with pr_debug]
Signed-off-by: Patryk Mungai <patryk.mungai-ndungu.kx@renesas.com>
---
 net/ipv4/ipconfig.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 60f564d..f326433 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -195,7 +195,7 @@ struct ic_device {
 };
 
 static struct ic_device *ic_first_dev __initdata;	/* List of open device */
-static struct net_device *ic_dev __initdata;		/* Selected device */
+static struct ic_device *ic_dev __initdata;		/* Selected device */
 
 static bool __init ic_is_init_dev(struct net_device *dev)
 {
@@ -314,8 +314,8 @@ static void __init ic_close_devs(void)
 	while ((d = next)) {
 		next = d->next;
 		dev = d->dev;
-		if (dev != ic_dev && !netdev_uses_dsa(dev)) {
-			DBG(("IP-Config: Downing %s\n", dev->name));
+		if (dev != ic_dev->dev && !netdev_uses_dsa(dev)) {
+			pr_debug("IP-Config: Downing %s\n", dev->name);
 			dev_change_flags(dev, d->flags);
 		}
 		kfree(d);
@@ -379,7 +379,7 @@ static int __init ic_setup_if(void)
 	int err;
 
 	memset(&ir, 0, sizeof(ir));
-	strcpy(ir.ifr_ifrn.ifrn_name, ic_dev->name);
+	strcpy(ir.ifr_ifrn.ifrn_name, ic_dev->dev->name);
 	set_sockaddr(sin, ic_myaddr, 0);
 	if ((err = ic_devinet_ioctl(SIOCSIFADDR, &ir)) < 0) {
 		pr_err("IP-Config: Unable to set interface address (%d)\n",
@@ -403,7 +403,7 @@ static int __init ic_setup_if(void)
 	 * out, we'll try to muddle along.
 	 */
 	if (ic_dev_mtu != 0) {
-		strcpy(ir.ifr_name, ic_dev->name);
+		strcpy(ir.ifr_name, ic_dev->dev->name);
 		ir.ifr_mtu = ic_dev_mtu;
 		if ((err = ic_dev_ioctl(SIOCSIFMTU, &ir)) < 0)
 			pr_err("IP-Config: Unable to set interface mtu to %d (%d)\n",
@@ -574,7 +574,7 @@ ic_rarp_recv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt
 		goto drop_unlock;
 
 	/* We have a winner! */
-	ic_dev = dev;
+	ic_dev = d;
 	if (ic_myaddr == NONE)
 		ic_myaddr = tip;
 	ic_servaddr = sip;
@@ -661,8 +661,6 @@ static struct packet_type bootp_packet_type __initdata = {
 	.func =	ic_bootp_recv,
 };
 
-static __be32 ic_dev_xid;		/* Device under configuration */
-
 /*
  *  Initialize DHCP/BOOTP extension fields in the request.
  */
@@ -1052,12 +1050,6 @@ static int __init ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, str
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
@@ -1148,7 +1140,7 @@ static int __init ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, str
 	}
 
 	/* We have a winner! */
-	ic_dev = dev;
+	ic_dev = d;
 	ic_myaddr = b->your_ip;
 	ic_servaddr = b->server_ip;
 	ic_addrservaddr = b->iph.saddr;
@@ -1243,9 +1235,6 @@ static int __init ic_dynamic(void)
 	timeout = CONF_BASE_TIMEOUT + (timeout % (unsigned int) CONF_TIMEOUT_RANDOM);
 	for (;;) {
 #ifdef IPCONFIG_BOOTP
-		/* Track the device we are configuring */
-		ic_dev_xid = d->xid;
-
 		if (do_bootp && (d->able & IC_BOOTP))
 			ic_bootp_send_if(d, jiffies - start_jiffies);
 #endif
@@ -1263,6 +1252,8 @@ static int __init ic_dynamic(void)
 		    (ic_proto_enabled & IC_USE_DHCP) &&
 		    ic_dhcp_msgtype != DHCPACK) {
 			ic_got_reply = 0;
+			/* continue on device that got the reply */
+			d = ic_dev;
 			pr_cont(",");
 			continue;
 		}
@@ -1513,7 +1504,7 @@ static int __init ip_auto_config(void)
 #endif /* IPCONFIG_DYNAMIC */
 	} else {
 		/* Device selected manually or only one device -> use it */
-		ic_dev = ic_first_dev->dev;
+		ic_dev = ic_first_dev;
 	}
 
 	addr = root_nfs_parse_addr(root_server_path);
@@ -1548,7 +1539,7 @@ static int __init ip_auto_config(void)
 	pr_info("IP-Config: Complete:\n");
 
 	pr_info("     device=%s, hwaddr=%*phC, ipaddr=%pI4, mask=%pI4, gw=%pI4\n",
-		ic_dev->name, ic_dev->addr_len, ic_dev->dev_addr,
+		ic_dev->dev->name, ic_dev->dev->addr_len, ic_dev->dev->dev_addr,
 		&ic_myaddr, &ic_netmask, &ic_gateway);
 	pr_info("     host=%s, domain=%s, nis-domain=%s\n",
 		utsname()->nodename, ic_domain, utsname()->domainname);
-- 
2.7.4
