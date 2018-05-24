From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 24 May 2018 17:05:07 +0100
Subject: [cip-dev] [RFC PATCH 4/7] usb: renesas_usbhs: set
	quirk_avoids_skb_reserve if USB-DMAC is used
In-Reply-To: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
References: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527177910-65275-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch sets the quirk_avoids_skb_reserve flag to improve performance
of a network gadget driver (e.g. f_ncm.c) if USB-DMAC is used.

For example (on r8a7795 board + f_ncm.c + iperf udp mode / receiving):
  - without this patch:  90.3 Mbits/sec
  - with    this patch: 273   Mbits/sec

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit ee5acabf5805612c72084276e0c215367a042d71)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 8647d2c..8cb3815 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1122,6 +1122,8 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 	gpriv->gadget.name		= "renesas_usbhs_udc";
 	gpriv->gadget.ops		= &usbhsg_gadget_ops;
 	gpriv->gadget.max_speed		= USB_SPEED_HIGH;
+	gpriv->gadget.quirk_avoids_skb_reserve = usbhs_get_dparam(priv,
+								has_usb_dmac);
 
 	INIT_LIST_HEAD(&gpriv->gadget.ep_list);
 
-- 
2.7.4
