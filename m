From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:05:14 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 17/23] usb: typec: add dependency for
	TYPEC_HD3SS3220
In-Reply-To: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1582034720-5249-18-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Mao Wenan <maowenan@huawei.com>

commit da4b5d18dd949abdda7c8ea76c9483b5edd49616 upstream.

If CONFIG_TYPEC_HD3SS3220=y, CONFIG_USB_ROLE_SWITCH=m, below errors
can be found:
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_remove':
hd3ss3220.c:(.text+0x64): undefined reference to `usb_role_switch_put'
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_dr_set':
hd3ss3220.c:(.text+0x154): undefined reference to `usb_role_switch_set_role'
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_set_role':
hd3ss3220.c:(.text+0x294): undefined reference to `usb_role_switch_set_role'
hd3ss3220.c:(.text+0x2f4): undefined reference to `usb_role_switch_set_role'
hd3ss3220.c:(.text+0x348): undefined reference to `usb_role_switch_set_role'
hd3ss3220.c:(.text+0x390): undefined reference to `usb_role_switch_set_role'
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_probe':
hd3ss3220.c:(.text+0x5e8): undefined reference to `fwnode_usb_role_switch_get'
hd3ss3220.c:(.text+0x8a4): undefined reference to `usb_role_switch_put'
make: *** [vmlinux] Error 1

This patch add dependency USB_ROLE_SWITCH for TYPEC_HD3SS3220.

Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/20191009014707.38716-1-maowenan at huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/usb/typec/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index fde51c5..a4bdb5c 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -95,6 +95,7 @@ source "drivers/usb/typec/ucsi/Kconfig"
 config TYPEC_HD3SS3220
 	tristate "TI HD3SS3220 Type-C DRP Port controller driver"
 	depends on I2C
+	depends on USB_ROLE_SWITCH
 	help
 	  Say Y or M here if your system has TI HD3SS3220 Type-C DRP Port
 	  controller driver.
-- 
2.7.4
