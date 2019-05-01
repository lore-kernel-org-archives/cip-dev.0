From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:21:56 +0100
Subject: [cip-dev] [PATCH 4.19.y 02/29] iommu/ipmmu-vmsa: Modify
	ipmmu_slave_whitelist() to check SoC revisions
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit b7ee92c6ff0e023a473b2500d771f6bf504fcc1a upstream.

Some R-Car Gen3 SoCs has hardware restrictions on the IPMMU. So,
to check whether this R-Car Gen3 SoC can use the IPMMU correctly,
this patch modifies the ipmmu_slave_whitelist().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/iommu/ipmmu-vmsa.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index b3bffd7..acb46cc 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -757,12 +757,6 @@ static int ipmmu_init_platform_device(struct device *dev,
 	return 0;
 }
 
-static bool ipmmu_slave_whitelist(struct device *dev)
-{
-	/* By default, do not allow use of IPMMU */
-	return false;
-}
-
 static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a774a1", },
 	{ .soc_id = "r8a7795", },
@@ -773,11 +767,35 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ /* sentinel */ }
 };
 
+static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
+	{ .soc_id = "r8a7795", .revision = "ES3.*" },
+	{ .soc_id = "r8a77965", },
+	{ .soc_id = "r8a77990", },
+	{ .soc_id = "r8a77995", },
+	{ /* sentinel */ }
+};
+
+static bool ipmmu_slave_whitelist(struct device *dev)
+{
+	/*
+	 * For R-Car Gen3 use a white list to opt-in slave devices.
+	 * For Other SoCs, this returns true anyway.
+	 */
+	if (!soc_device_match(soc_rcar_gen3))
+		return true;
+
+	/* Check whether this R-Car Gen3 can use the IPMMU correctly or not */
+	if (!soc_device_match(soc_rcar_gen3_whitelist))
+		return false;
+
+	/* By default, do not allow use of IPMMU */
+	return false;
+}
+
 static int ipmmu_of_xlate(struct device *dev,
 			  struct of_phandle_args *spec)
 {
-	/* For R-Car Gen3 use a white list to opt-in slave devices */
-	if (soc_device_match(soc_rcar_gen3) && !ipmmu_slave_whitelist(dev))
+	if (!ipmmu_slave_whitelist(dev))
 		return -ENODEV;
 
 	iommu_fwspec_add_ids(dev, spec->args, 1);
-- 
2.7.4
