From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 24 May 2018 17:05:05 +0100
Subject: [cip-dev] [RFC PATCH 2/7] usb: gadget: u_ether: add a flag to avoid
	skb_reserve() calling
In-Reply-To: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
References: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527177910-65275-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds a flag "no_skb_reserve" in struct eth_dev.
So, if a peripheral driver sets the quirk_avoids_skb_reserve flag,
upper network gadget drivers (e.g. f_ncm.c) can avoid skb_reserve()
calling using the flag as well.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit 05f6b0ff68429bb7c6b84b35e71b522c3bae76ae)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/usb/gadget/function/u_ether.c | 5 ++++-
 drivers/usb/gadget/function/u_ether.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 7413f89..96ec10d 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -82,6 +82,7 @@ struct eth_dev {
 #define	WORK_RX_MEMORY		0
 
 	bool			zlp;
+	bool			no_skb_reserve;
 	u8			host_mac[ETH_ALEN];
 	u8			dev_mac[ETH_ALEN];
 };
@@ -243,7 +244,8 @@ rx_submit(struct eth_dev *dev, struct usb_request *req, gfp_t gfp_flags)
 	 * but on at least one, checksumming fails otherwise.  Note:
 	 * RNDIS headers involve variable numbers of LE32 values.
 	 */
-	skb_reserve(skb, NET_IP_ALIGN);
+	if (likely(!dev->no_skb_reserve))
+		skb_reserve(skb, NET_IP_ALIGN);
 
 	req->buf = skb->data;
 	req->length = size;
@@ -1065,6 +1067,7 @@ struct net_device *gether_connect(struct gether *link)
 
 	if (result == 0) {
 		dev->zlp = link->is_zlp_ok;
+		dev->no_skb_reserve = link->no_skb_reserve;
 		DBG(dev, "qlen %d\n", qlen(dev->gadget, dev->qmult));
 
 		dev->header_len = link->header_len;
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index c77145b..81d94a7 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -64,6 +64,7 @@ struct gether {
 	struct usb_ep			*out_ep;
 
 	bool				is_zlp_ok;
+	bool				no_skb_reserve;
 
 	u16				cdc_filter;
 
-- 
2.7.4
