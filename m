From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:07:59 +0100
Subject: [cip-dev] [PATCH 10/62] PCI: rcar: Remove unused pci_sys_data
	struct from pcie-rcar
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The pci_sys_data struct was previously used by pci_common_init_dev() and by
the ARM pcibios_align_resource(), but recent commits removed those uses:

  cbce7900598c ("PCI: designware: Make driver arch-agnostic")
  b3a72384fe29 ("ARM/PCI: Replace pci_sys_data->align_resource with global function pointer")

cbce7900598c removed the use of pci_common_init_dev() by DesignWare
drivers, including pcie-rcar.c, and b3a72384fe29 removed the use of struct
pci_sys_data by the ARM pcibios_align_resource().

Remove struct pci_sys_data from pcie-rcar.c.

[bhelgaas: changelog]
Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
(cherry picked from commit 049f419399e937e333bf121b7b234888d804a25e)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index ae095fc..83ba747 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -124,16 +124,7 @@ static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
 }
 
 /* Structure representing the PCIe interface */
-/*
- * ARM pcibios functions expect the ARM struct pci_sys_data as the PCI
- * sysdata.  Add pci_sys_data as the first element in struct gen_pci so
- * that when we use a gen_pci pointer as sysdata, it is also a pointer to
- * a struct pci_sys_data.
- */
 struct rcar_pcie {
-#ifdef CONFIG_ARM
-	struct pci_sys_data	sys;
-#endif
 	struct device		*dev;
 	void __iomem		*base;
 	struct list_head	resources;
-- 
2.7.4
