From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 24 Apr 2019 18:20:27 +0100
Subject: [cip-dev] [PATCH 4.19.y 04/17] usb: renesas_usbhs: add support for
	RZ/G2E
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556126440-27978-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 1d6e81a288e28d8d0e38e0501a324216f79bba35 upstream.

HS-USB found in RZ/G2E (a.k.a. r8a774c0) is very similar to the
one found in R-Car E3 (a.k.a. r8a77990), as it needs to release
the PLL reset by the UGCTRL register like R-Car E3, therefore add
r8a774c0 support in a similar fashion to what was done for the
r8a77990.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/renesas_usbhs/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 4310df4..b079258 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -458,6 +458,10 @@ static int usbhsc_drvcllbck_notify_hotplug(struct platform_device *pdev)
  */
 static const struct of_device_id usbhs_of_match[] = {
 	{
+		.compatible = "renesas,usbhs-r8a774c0",
+		.data = (void *)USBHS_TYPE_RCAR_GEN3_WITH_PLL,
+	},
+	{
 		.compatible = "renesas,usbhs-r8a7790",
 		.data = (void *)USBHS_TYPE_RCAR_GEN2,
 	},
-- 
2.7.4
