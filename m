From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 24 May 2018 17:05:06 +0100
Subject: [cip-dev] [RFC PATCH 3/7] usb: gadget: f_ncm: add support for
	no_skb_reserve
In-Reply-To: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
References: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527177910-65275-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds to support no_skb_reserve function to improve
performance for some platforms. About the detail, please refer to
the commit log of "quirk_avoids_skb_reserve" in
include/linux/usb/gadget.h.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit c4824f11fe07835c63209fb035f03f8f82e12827)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/usb/gadget/function/f_ncm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 7ad798a..025047f 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -852,6 +852,8 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 			 */
 			ncm->port.is_zlp_ok =
 				gadget_is_zlp_supported(cdev->gadget);
+			ncm->port.no_skb_reserve =
+				gadget_avoids_skb_reserve(cdev->gadget);
 			ncm->port.cdc_filter = DEFAULT_FILTER;
 			DBG(cdev, "activate ncm\n");
 			net = gether_connect(&ncm->port);
-- 
2.7.4
