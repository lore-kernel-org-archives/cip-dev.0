From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 16 Nov 2017 13:06:00 +0100
Subject: [cip-dev] [PATCH] spi: pxa2xx-pci: fix ACPI-based enumeration of
	SPI devices
Message-ID: <f901fec0-86ea-ab4c-5130-1b10b4b0c065@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit b70cd2de0ea85f5ab51a1d01893cba6415011b9d upstream.

Slave devices are not enumerated by ACPI data because the ACPI handle for the
core driver is NULL if it was enumerated by PCI.

Propagate firmware node handle of the PCI device to the platform device.

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Required for our IOT2000 devices to work properly.

 drivers/spi/spi-pxa2xx-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index d19d7f28aecb..ac0658ead1b9 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -167,6 +167,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		return PTR_ERR(ssp->clk);
 
 	memset(&pi, 0, sizeof(pi));
+	pi.fwnode = dev->dev.fwnode;
 	pi.parent = &dev->dev;
 	pi.name = "pxa2xx-spi";
 	pi.id = ssp->port_id;
