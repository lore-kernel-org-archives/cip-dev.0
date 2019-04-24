From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 24 Apr 2019 18:20:35 +0100
Subject: [cip-dev] [PATCH 4.19.y 12/17] usb: gadget: udc: renesas_usb3: add
	support for r8a77990
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556126440-27978-13-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 30025efa8b5e75f545e38a592158c34b3169423b upstream.

Since r8a77990 (R-Car E3) doesn't have VBUS detect pin and
number of ramif is 4, this patch adds a new renesas_usb3_priv
variable for the SoC.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 67d8a50..cdffbd1 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2603,6 +2603,13 @@ static const struct renesas_usb3_priv renesas_usb3_priv_gen3 = {
 	.ramsize_per_pipe = SZ_4K,
 };
 
+static const struct renesas_usb3_priv renesas_usb3_priv_r8a77990 = {
+	.ramsize_per_ramif = SZ_16K,
+	.num_ramif = 4,
+	.ramsize_per_pipe = SZ_4K,
+	.workaround_for_vbus = true,
+};
+
 static const struct of_device_id usb3_of_match[] = {
 	{
 		.compatible = "renesas,r8a7795-usb3-peri",
@@ -2621,6 +2628,10 @@ static const struct soc_device_attribute renesas_usb3_quirks_match[] = {
 		.soc_id = "r8a7795", .revision = "ES1.*",
 		.data = &renesas_usb3_priv_r8a7795_es1,
 	},
+	{
+		.soc_id = "r8a77990",
+		.data = &renesas_usb3_priv_r8a77990,
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.7.4
