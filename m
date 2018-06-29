From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:03 +0100
Subject: [cip-dev] [PATCH 02/86] dt: Add of_device_compatible_match()
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This provides an equivalent of of_fdt_match() for non-flat trees.

This is more practical than matching an array of of_device_id structs
when converting a bunch of existing users of of_fdt_match().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
(cherry picked from commit b9c13fe32faaa71c4e4f8a426d79f8c93495e9f9)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/of/base.c  | 22 ++++++++++++++++++++++
 include/linux/of.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3134129..c8b01c9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -498,6 +498,28 @@ int of_device_is_compatible(const struct device_node *device,
 }
 EXPORT_SYMBOL(of_device_is_compatible);
 
+/** Checks if the device is compatible with any of the entries in
+ *  a NULL terminated array of strings. Returns the best match
+ *  score or 0.
+ */
+int of_device_compatible_match(struct device_node *device,
+			       const char *const *compat)
+{
+	unsigned int tmp, score = 0;
+
+	if (!compat)
+		return 0;
+
+	while (*compat) {
+		tmp = of_device_is_compatible(device, *compat);
+		if (tmp > score)
+			score = tmp;
+		compat++;
+	}
+
+	return score;
+}
+
 /**
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
diff --git a/include/linux/of.h b/include/linux/of.h
index dd10626..4954287 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -307,6 +307,8 @@ extern int of_property_read_string_helper(struct device_node *np,
 					      const char **out_strs, size_t sz, int index);
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
+extern int of_device_compatible_match(struct device_node *device,
+				      const char *const *compat);
 extern bool of_device_is_available(const struct device_node *device);
 extern bool of_device_is_big_endian(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
-- 
2.7.4
