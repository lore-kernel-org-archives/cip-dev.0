From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:06 +0200
Subject: [cip-dev] [PATCH 09/25] serial: 8250_EXAR: fix duplicate Kconfig
	text and add missing help text
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <f68578f71bba1a0b5ff743eeda329f921a24adb7.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

commit 49e1590c2ead870f4ae5568816241c4cb9bc1606 upstream.

In commit d0aeaa83f0b0f7a92615bbdd6b1f96812f7dcfd2 ("serial: exar:
split out the exar code from 8250_pci") the exar driver got its own
Kconfig.  However the text for the new option was never changed from
the original 8250_PCI text, and hence it appears confusing when you
get asked the same question twice:

  8250/16550 PCI device support (SERIAL_8250_PCI) [Y/n/m/?] (NEW)
    8250/16550 PCI device support (SERIAL_8250_EXAR) [Y/n/m] (NEW)

Adding to the confusion, is that there is no help text for this new
option to indicate it is specific to a certain family of cards.

Fix both issues at the same time, as well as the space vs. tab issues
introduced in the same commit.

Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial at vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f69b0905468f..bf7b5b5f2868 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -117,9 +117,13 @@ config SERIAL_8250_PCI
 	  by the parport_serial driver, enabled with CONFIG_PARPORT_SERIAL.
 
 config SERIAL_8250_EXAR
-        tristate "8250/16550 PCI device support"
-        depends on SERIAL_8250_PCI
+	tristate "8250/16550 Exar/Commtech PCI/PCIe device support"
+	depends on SERIAL_8250_PCI
 	default SERIAL_8250
+	help
+	  This builds support for XR17C1xx, XR17V3xx and some Commtech
+	  422x PCIe serial cards that are not covered by the more generic
+	  SERIAL_8250_PCI option.
 
 config SERIAL_8250_HP300
 	tristate
-- 
2.12.3
