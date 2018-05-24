From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 24 May 2018 17:05:04 +0100
Subject: [cip-dev] [RFC PATCH 1/7] usb: gadget: add a new quirk to avoid
	skb_reserve in u_ether.c
In-Reply-To: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
References: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527177910-65275-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Some platforms (e.g. USB-DMAC on R-Car SoCs) has memory alignment
restriction. If memory alignment is not match, the usb peripheral
driver decides not to use the DMA controller. Then, the performance
is not good.

In the case of u_ether.c, since it calls skb_reserve() in rx_submit(),
it is possible to cause memory alignment mismatch.

So, this patch adds a new quirk "quirk_avoids_skb_reserve" to avoid
skb_reserve() calling in u_ether.c to improve performance.

A peripheral driver will set this flag and network gadget drivers
(e.g. f_ncm.c) will reference the flag via gadget_avoids_skb_reserve().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit 60e7396f820fa67a007f2a2eb5d97d3e77a74881)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 include/linux/usb/gadget.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 3d583a1..2ba866f 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -594,6 +594,8 @@ struct usb_gadget_ops {
  *	enabled HNP support.
  * @quirk_ep_out_aligned_size: epout requires buffer size to be aligned to
  *	MaxPacketSize.
+ * @quirk_avoids_skb_reserve: udc/platform wants to avoid skb_reserve() in
+ *	u_ether.c to improve performance.
  * @is_selfpowered: if the gadget is self-powered.
  * @deactivated: True if gadget is deactivated - in deactivated state it cannot
  *	be connected.
@@ -643,6 +645,7 @@ struct usb_gadget {
 	unsigned			quirk_altset_not_supp:1;
 	unsigned			quirk_stall_not_supp:1;
 	unsigned			quirk_zlp_not_supp:1;
+	unsigned			quirk_avoids_skb_reserve:1;
 	unsigned			is_selfpowered:1;
 	unsigned			deactivated:1;
 	unsigned			connected:1;
@@ -708,6 +711,16 @@ static inline int gadget_is_zlp_supported(struct usb_gadget *g)
 }
 
 /**
+ * gadget_avoids_skb_reserve - return true iff the hardware would like to avoid
+ *	skb_reserve to improve performance.
+ * @g: controller to check for quirk
+ */
+static inline int gadget_avoids_skb_reserve(struct usb_gadget *g)
+{
+	return g->quirk_avoids_skb_reserve;
+}
+
+/**
  * gadget_is_dualspeed - return true iff the hardware handles high speed
  * @g: controller that might support both high and full speeds
  */
-- 
2.7.4
