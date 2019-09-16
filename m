From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 16 Sep 2019 16:50:19 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 05/32] PCI: rcar: Replace unsigned long
	with u32/unsigned int in register accessors
In-Reply-To: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568649046-17420-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

commit 7dc13a7939e09caa20ed3a0a8417f23b4ec4e6e2 upstream.

Replace unsigned long with u32 and unsigned int in register accessor
functions, since they access 32bit registers.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc at vger.kernel.org
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pci/controller/pcie-rcar.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 9b9c677..0665892 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -154,14 +154,13 @@ struct rcar_pcie {
 	struct			rcar_msi msi;
 };
 
-static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
-			       unsigned long reg)
+static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val,
+			       unsigned int reg)
 {
 	writel(val, pcie->base + reg);
 }
 
-static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
-				       unsigned long reg)
+static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, unsigned int reg)
 {
 	return readl(pcie->base + reg);
 }
-- 
2.7.4
