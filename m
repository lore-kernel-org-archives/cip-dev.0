From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 24 Apr 2019 18:20:37 +0100
Subject: [cip-dev] [PATCH 4.19.y 14/17] usb: gadget: udc: renesas_usb3: add
	support for r8a774c0
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556126440-27978-15-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 546970fdab1da5fead4f0f5c8cbf4b1c68213707 upstream.

RZ/G2E USB 3.0 implementation is like the one found on R-Car E3,
therefore add the same quirk.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 6e34f95..7dc2485 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2630,6 +2630,10 @@ MODULE_DEVICE_TABLE(of, usb3_of_match);
 
 static const struct soc_device_attribute renesas_usb3_quirks_match[] = {
 	{
+		.soc_id = "r8a774c0",
+		.data = &renesas_usb3_priv_r8a77990,
+	},
+	{
 		.soc_id = "r8a7795", .revision = "ES1.*",
 		.data = &renesas_usb3_priv_r8a7795_es1,
 	},
-- 
2.7.4
