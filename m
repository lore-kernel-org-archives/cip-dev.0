Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438B3C27C79
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 10:47:42 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5253.1718275650054850559
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 03:47:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="211744451"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Jun 2024 19:47:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.168])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 143D8400B9F8;
	Thu, 13 Jun 2024 19:47:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 5/7] usb: renesas_usbhs: Update usbhs pipe configuration for RZ/G2L family
Date: Thu, 13 Jun 2024 11:47:24 +0100
Message-Id: <20240613104726.422783-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
References: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 10:47:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16215

commit caf8fa1120c2fd9206cc1dfd58b8b55e0817238e upstream.

The RZ/G2L family SoCs has 10 pipe buffers compared to 16 pipe buffers on
RZ/A2M. Update the pipe configuration for RZ/G2L family SoCs and use
family SoC specific compatible to handle this difference.

The pipe configuration of RZ/G2L is same as usbhsc_rzg2l_default_pipe[],
so select the default pipe configuration for RZ/G2L SoCs by setting
.has_new_pipe_configs to zero.

Add SoC specific compatible to OF table to avoid ABI breakage with old
DTB. To optimize memory usage the SoC specific compatible will be removed
later.

Based on the patch in BSP by Huy Nguyen <huy.nguyen.wh@renesas.com>

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240319105356.87287-5-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 18 +++++++++++++++++-
 drivers/usb/renesas_usbhs/rza.h    |  1 +
 drivers/usb/renesas_usbhs/rza2.c   | 13 +++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 4e0cf6b33bdb..d9470e1d64b8 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -363,7 +363,7 @@ static void usbhsc_clk_disable_unprepare(struct usbhs_priv *priv)
  *		platform default param
  */
 
-/* commonly used on old SH-Mobile SoCs */
+/* commonly used on old SH-Mobile and RZ/G2L family SoCs */
 static struct renesas_usbhs_driver_pipe_config usbhsc_default_pipe[] = {
 	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_CONTROL, 64, 0x00, false),
 	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_ISOC, 1024, 0x08, true),
@@ -565,6 +565,18 @@ static const struct of_device_id usbhs_of_match[] = {
 		.compatible = "renesas,usbhs-r8a77995",
 		.data = &usbhs_rcar_gen3_with_pll_plat_info,
 	},
+	{
+		.compatible = "renesas,usbhs-r9a07g043",
+		.data = &usbhs_rzg2l_plat_info,
+	},
+	{
+		.compatible = "renesas,usbhs-r9a07g044",
+		.data = &usbhs_rzg2l_plat_info,
+	},
+	{
+		.compatible = "renesas,usbhs-r9a07g054",
+		.data = &usbhs_rzg2l_plat_info,
+	},
 	{
 		.compatible = "renesas,rcar-gen2-usbhs",
 		.data = &usbhs_rcar_gen2_plat_info,
@@ -581,6 +593,10 @@ static const struct of_device_id usbhs_of_match[] = {
 		.compatible = "renesas,rza2-usbhs",
 		.data = &usbhs_rza2_plat_info,
 	},
+	{
+		.compatible = "renesas,rzg2l-usbhs",
+		.data = &usbhs_rzg2l_plat_info,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, usbhs_of_match);
diff --git a/drivers/usb/renesas_usbhs/rza.h b/drivers/usb/renesas_usbhs/rza.h
index a29b75fef057..8b879aa34a20 100644
--- a/drivers/usb/renesas_usbhs/rza.h
+++ b/drivers/usb/renesas_usbhs/rza.h
@@ -3,3 +3,4 @@
 
 extern const struct renesas_usbhs_platform_info usbhs_rza1_plat_info;
 extern const struct renesas_usbhs_platform_info usbhs_rza2_plat_info;
+extern const struct renesas_usbhs_platform_info usbhs_rzg2l_plat_info;
diff --git a/drivers/usb/renesas_usbhs/rza2.c b/drivers/usb/renesas_usbhs/rza2.c
index 3eed3334a17f..1ffd19faf4e8 100644
--- a/drivers/usb/renesas_usbhs/rza2.c
+++ b/drivers/usb/renesas_usbhs/rza2.c
@@ -72,3 +72,16 @@ const struct renesas_usbhs_platform_info usbhs_rza2_plat_info = {
 		.has_new_pipe_configs = 1,
 	},
 };
+
+const struct renesas_usbhs_platform_info usbhs_rzg2l_plat_info = {
+	.platform_callback = {
+		.hardware_init = usbhs_rza2_hardware_init,
+		.hardware_exit = usbhs_rza2_hardware_exit,
+		.power_ctrl = usbhs_rza2_power_ctrl,
+		.get_id = usbhs_get_id_as_gadget,
+	},
+	.driver_param = {
+		.has_cnen = 1,
+		.cfifo_byte_addr = 1,
+	},
+};
-- 
2.25.1


