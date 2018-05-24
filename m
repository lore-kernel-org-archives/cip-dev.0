From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 24 May 2018 17:05:08 +0100
Subject: [cip-dev] [RFC PATCH 5/7] usb: gadget: f_ncm/u_ether: Move 'SKB
	reserve' quirk setup to u_ether
In-Reply-To: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
References: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527177910-65275-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Dmitry Osipenko <digetx@gmail.com>

That quirk is required to make USB Ethernet gadget working on HW that
can't cope with unaligned DMA. For some reason only f_ncm sets up that
quirk, let's setup it directly in u_ether so other network models would
have that quirk applied as well. All network models have been tested with
ChipIdea UDC driver on NVIDIA Tegra20 SoC that require DMA to be aligned.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit 0852659ef071ccd84e85e37195e7c2f3e7c64d1f)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/usb/gadget/function/f_ncm.c   | 2 --
 drivers/usb/gadget/function/u_ether.c | 2 +-
 drivers/usb/gadget/function/u_ether.h | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 025047f..7ad798a 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -852,8 +852,6 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 			 */
 			ncm->port.is_zlp_ok =
 				gadget_is_zlp_supported(cdev->gadget);
-			ncm->port.no_skb_reserve =
-				gadget_avoids_skb_reserve(cdev->gadget);
 			ncm->port.cdc_filter = DEFAULT_FILTER;
 			DBG(cdev, "activate ncm\n");
 			net = gether_connect(&ncm->port);
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 96ec10d..be41ae5 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1067,7 +1067,7 @@ struct net_device *gether_connect(struct gether *link)
 
 	if (result == 0) {
 		dev->zlp = link->is_zlp_ok;
-		dev->no_skb_reserve = link->no_skb_reserve;
+		dev->no_skb_reserve = gadget_avoids_skb_reserve(dev->gadget);
 		DBG(dev, "qlen %d\n", qlen(dev->gadget, dev->qmult));
 
 		dev->header_len = link->header_len;
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index 81d94a7..c77145b 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -64,7 +64,6 @@ struct gether {
 	struct usb_ep			*out_ep;
 
 	bool				is_zlp_ok;
-	bool				no_skb_reserve;
 
 	u16				cdc_filter;
 
-- 
2.7.4
