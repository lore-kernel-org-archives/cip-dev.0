From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 17 Sep 2019 14:07:34 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 06/32] PCI: rcar: Replace various
	variable types with unsigned ones for register values
In-Reply-To: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568725680-32730-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

commit d8fa26609b91394f9f2d17ae6956a2c3e3632fbb upstream.

Replace various variable types with u32 or unsigned int type for
variables holding register values, since the registers are 32bit.
Note that rcar_pcie_msi_irq() still uses various variable types
because both find_first_bit() and __fls() require various variable
types as an argument.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc at vger.kernel.org
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pci/controller/pcie-rcar.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 0665892..f602c0d 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -172,7 +172,7 @@ enum {
 
 static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 {
-	int shift = 8 * (where & 3);
+	unsigned int shift = 8 * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	val &= ~(mask << shift);
@@ -182,7 +182,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
-	int shift = 8 * (where & 3);
+	unsigned int shift = 8 * (where & 3);
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	return val >> shift;
@@ -193,7 +193,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 		unsigned char access_type, struct pci_bus *bus,
 		unsigned int devfn, int where, u32 *data)
 {
-	int dev, func, reg, index;
+	unsigned int dev, func, reg, index;
 
 	dev = PCI_SLOT(devfn);
 	func = PCI_FUNC(devfn);
@@ -297,8 +297,9 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 val)
 {
 	struct rcar_pcie *pcie = bus->sysdata;
-	int shift, ret;
+	unsigned int shift;
 	u32 data;
+	int ret;
 
 	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, &data);
@@ -508,10 +509,10 @@ static int phy_wait_for_ack(struct rcar_pcie *pcie)
 }
 
 static void phy_write_reg(struct rcar_pcie *pcie,
-				 unsigned int rate, unsigned int addr,
-				 unsigned int lane, unsigned int data)
+			  unsigned int rate, u32 addr,
+			  unsigned int lane, u32 data)
 {
-	unsigned long phyaddr;
+	u32 phyaddr;
 
 	phyaddr = WRITE_CMD |
 		((rate & 1) << RATE_POS) |
@@ -1123,7 +1124,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rcar_pcie *pcie;
-	unsigned int data;
+	u32 data;
 	int err;
 	int (*phy_init_fn)(struct rcar_pcie *);
 	struct pci_host_bridge *bridge;
-- 
2.7.4
