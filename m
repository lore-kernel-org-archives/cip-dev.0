From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 17 Sep 2019 14:07:36 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 08/32] PCI: rcar: Do not shadow the
	'irq' variable
In-Reply-To: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568725680-32730-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit a27beb5820d1a52b1e2863a4ae5545a1dd4ab35a upstream.

The sparse tool rightfully detects:
drivers/pci/controller/pcie-rcar.c:741:30: warning: symbol 'irq' shadows an earlier one

Fix it now to avoid future surprises and for good coding style.

No functional change intended.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[lorenzo.pieralisi at arm.com: commit log refactoring]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pci/controller/pcie-rcar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 6f4bad1..174be37 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -740,15 +740,15 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 
 	while (reg) {
 		unsigned int index = find_first_bit(&reg, 32);
-		unsigned int irq;
+		unsigned int msi_irq;
 
 		/* clear the interrupt */
 		rcar_pci_write_reg(pcie, 1 << index, PCIEMSIFR);
 
-		irq = irq_find_mapping(msi->domain, index);
-		if (irq) {
+		msi_irq = irq_find_mapping(msi->domain, index);
+		if (msi_irq) {
 			if (test_bit(index, msi->used))
-				generic_handle_irq(irq);
+				generic_handle_irq(msi_irq);
 			else
 				dev_info(dev, "unhandled MSI\n");
 		} else {
-- 
2.7.4
