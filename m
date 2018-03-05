From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:39:06 +0000
Subject: [cip-dev] [PATCH 02/10] PCI: rcar-gen2: Use gen2 fallback
	compatibility last
In-Reply-To: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520249954-29357-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

Improve readability by listing fallback compatibility strings after the
more-specific compatibility strings they provide a fallback for.

This does not affect run-time behaviour as it is the order in the DTB that
determines which compatibility string is used.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
(cherry picked from commit 7b99d94277ba49f401b7a5c1ad8a9084cc6c34a6)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pci/host/pci-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 5683e70..acefff7 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -360,10 +360,10 @@ static int rcar_pci_probe(struct platform_device *pdev)
 }
 
 static struct of_device_id rcar_pci_of_match[] = {
-	{ .compatible = "renesas,pci-rcar-gen2", },
 	{ .compatible = "renesas,pci-r8a7790", },
 	{ .compatible = "renesas,pci-r8a7791", },
 	{ .compatible = "renesas,pci-r8a7794", },
+	{ .compatible = "renesas,pci-rcar-gen2", },
 	{ },
 };
 
-- 
2.7.4
